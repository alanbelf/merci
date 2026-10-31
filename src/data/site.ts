const whatsapp = '97466997487';
const whatsappMessage = "Hello Merci Concierge! I'd like to enquire about your services.";
const phone = '+974 6699 7487';

export const site = {
  name: 'Merci Concierge',
  tagline: 'Your life in Qatar, made effortless.',
  intro: 'A personal concierge service helping you discover Qatar, settle in with confidence, and enjoy more of what matters.',
  phone,
  phoneLink: `tel:${phone.replaceAll(' ', '')}`,
  whatsapp,
  whatsappMessage,
  whatsappUrl: `https://wa.me/${whatsapp}?text=${encodeURIComponent(whatsappMessage).replaceAll("'", '%27')}`,
  location: 'Doha, Qatar',
};

export const tourismServices = [
  {
    title: 'Discover Qatar',
    description: 'Thoughtfully planned experiences to discover the culture, places and hidden gems of Qatar.'
  },
  {
    title: 'Tailor-made itineraries',
    description: 'Personalised plans shaped around your interests, pace and the kind of experience you want.'
  },
  {
    title: 'Restaurant & experience bookings',
    description: 'Recommendations and booking assistance for memorable moments during your stay.'
  },
  {
    title: 'Personal assistance',
    description: 'Practical support and local insight to make your time in Qatar smoother.'
  }
];

export const expatServices = [
  {
    title: 'Relocation guidance',
    description: 'A helping hand as you prepare for your move and get oriented in Qatar.'
  },
  {
    title: 'Finding your bearings',
    description: 'Useful local recommendations for neighbourhoods, services and everyday life.'
  },
  {
    title: 'Family support',
    description: 'Guidance to help families navigate their new environment and settle in.'
  },
  {
    title: 'Your local contact',
    description: 'A friendly point of contact for practical questions and personalised assistance.'
  }
];

// Genuine review wording and reviewer details must come from the owner-supplied brief.
export const testimonials: { quote: string; author: string; url?: string }[] = [];

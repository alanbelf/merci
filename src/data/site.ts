const whatsappMessage = "Hello Merci Concierge! I'd like to enquire about your services.";
const phone = '+974 7072 2800';
const whatsapp = phone.replaceAll(' ', '').replace('+', '');

export const site = {
  name: 'Merci Concierge',
  tagline: 'Your private access to Doha’s luxury lifestyle',
  intro: 'I help you discover Qatar, settle in with confidence, and enjoy more of what matters to you.',
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
    description: 'Explore Qatar’s culture, places and hidden gems through experiences planned around your interests.'
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
    description: 'Guidance for families as they get to know their new surroundings and settle in.'
  },
  {
    title: 'Your local contact',
    description: 'A friendly point of contact for practical questions and personalised assistance.'
  }
];

export const testimonials: { quote: string; author: string; url?: string }[] = [
  {
    quote: 'I realized a désert safari with this company!it was my 3rd Time in the désert, already done twice in Dubaï, but this one was the best so far!! The expérience was just amazing! The driver was very talented! The driver stopped at very good spots and took very nice pictures of us!! You Will definitely have an unforgettable expérience for the Dune Bashing!  I highly recommand!',
    author: 'Guillaume Calvarin',
    url: 'https://www.google.com/maps/contrib/106026482117455466123/reviews?hl=en-GB'
  },
  {
    quote: 'Excellent service, Naseem is very polite and knowledgeable, we enjoyed our tour with him and appreciate the guidance he have us on what else to visit in Doha',
    author: 'Elena Shvarts',
    url: 'https://www.google.com/maps/contrib/109294610843180075646/reviews?hl=en-GB'
  },
  {
    quote: 'Absolutely excellent. Nassim is lovely and incredibly helpful in facilitating a stay in Qatar. He thinks of everything down to the smallest detail and is very attentive. A truly wonderful experience. I highly recommend him. Thank you and all the best!',
    author: 'Margot Dumont'
  },
  {
    quote: 'We had the pleasure of being accompanied by Nassim during our stay in Doha, and we would like to highly recommend him. Very professional, caring and always available, he made our experience even more enriching thanks to his valuable advice and his great kindness. Thank you for your support and your availability. An exceptional guide, +++++',
    author: 'A&G ZEGGOU',
    url: 'https://www.google.com/maps/contrib/109370993786136245471/reviews?hl=en-GB'
  },
  {
    quote: 'We had an incredible experience with Merci Concierge. Everything was perfectly organized, from the hotel pickup to the evening drop-off. The trip to the Qatari desert will remain etched in our memories: breathtaking landscapes, between sand dunes and the sea, thrills, and unforgettable moments of relaxation. Nassim is incredibly kind and attentive to detail. He remains available for any other requests without asking for anything in return. He is truly professional, which is what made the experience even more enjoyable. I highly recommend him!',
    author: 'Ouaatman'
  },
  {
    quote: 'Fantastic experience! We were able to visit Katara village, the Corniche, and the souk, an authentic Al Waqif, and finally, the icing on the cake: a desert excursion that leads directly to the sea. Highly recommended; the guide was excellent.',
    author: 'Baptoste Ramdane Hassani'
  },
  {
    quote: 'Impeccable concierge service! Nassim is professional and attentive and was able to respond to all my requests efficiently despite the distance. I recommend without hesitation to anyone looking for a reliable and quality service. Thank you Nassim',
    author: 'Khadigé Akhdar',
    url: 'https://www.google.com/maps/contrib/115110736923648151332/reviews?hl=en-GB'
  },
  {
    quote: 'You can go there with your eyes closed! Nassim is an expert in his field. He knows everything about Qatar and took great care of us throughout our stay, from cultural history to leisure activities. We were able to discover so many places.',
    author: 'malik KABACHE',
    url: 'https://www.google.com/maps/contrib/106512842997100868842/reviews?hl=en-GB'
  },
  {
    quote: 'A huge thank you to Nassim for his professionalism and exceptional availability during our stay in Qatar. Thanks to his valuable advice and recommendations, we were able to discover magnificent places and have a memorable experience. His warm welcome and attention to detail truly made our vacation even more special. We will never forget his kindness and dedication. Many thanks again!',
    author: 'loic hucher',
    url: 'https://www.google.com/maps/contrib/107322725098739265895/reviews?hl=en-GB'
  }
];

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34732 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334Ab3K2RCz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2013 12:02:55 -0500
From: Marek Vasut <marex@denx.de>
To: =?iso-8859-1?q?Bj=F8rn_Erik_Nilsen?= <ben@datarespons.no>
Subject: Re: [PATCH v5 1/2] PCI: designware: Fix crash in dw_msi_teardown_irq
Date: Fri, 29 Nov 2013 18:02:53 +0100
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kishon@ti.com" <kishon@ti.com>,
	"Mohit.KUMAR@st.com" <Mohit.KUMAR@st.com>,
	"ajay.khandelwal@st.com" <ajay.khandelwal@st.com>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	"Eric.Nelson@boundarydevices.com" <Eric.Nelson@boundarydevices.com>,
	"troy.kisky@boundarydevices.com" <troy.kisky@boundarydevices.com>
References: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com> <201311291636.53641.marex@denx.de> <cmu-lmtpd-32360-1385742114-0@frontend1.mail.m-online.net>
In-Reply-To: <cmu-lmtpd-32360-1385742114-0@frontend1.mail.m-online.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201311291802.53655.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjørn Erik Nilsen,

> Dear Marek Vasut,
> 
> On Fri, 2013-11-29 at 16:36 +0100, Marek Vasut wrote:
> > Dear Bjørn Erik Nilsen,
> > [...]
> > 
> > > > Won't simple
> > > > 
> > > > for (i = 0; i < nvec; i++) {
> > > > 
> > > > do here?
> > > 
> > > Yes.
> > > 
> > > The very same syntax ('while i < nvec') is used in assign_irq. That is
> > > why I wanted to keep it like that to avoid adding too much confusion,
> > > or at least make it easy to recognize the same pattern.
> > > 
> > > You still want me to change it?
> > 
> > Your loop does exactly what a for() loop would do, there's no need to
> > emulate it with a while() loop. If you can fix the other one, fix the
> > other one as well please.
> 
> Yes, it is syntax sugar indeed and I did it purely for readability as
> explained. You don't seem to agree with me on the readability argument,
> so I can make the new code use a for-loop. And then in an unrelated
> commit (which would look awfully silly) I can change the other
> while-loop too.

Either way is fine with me, I'm just more inclined to the for loop ;-) Let's 
wait for what the others have to say, they can judge this argument.

> > > As for the other nitpick, I don't agree with you.
> > > 
> > > In fact, dw_msi_teardown_irq has no return value itself. Moreover, if
> > > setting the msi desc to NULL fails, then it simply means there is no
> > > irq desc and there is nothing to unwind. Also, skipping the other
> > > unwind operations just because that single operation failed would
> > > leave the driver in a much worse state. At least in my opinion.
> > > 
> > > What's your opinion on that?
> > 
> > I see this:
> > 
> > $ git grep irq_set_msi_desc_off include/
> > include/linux/irq.h:extern int irq_set_msi_desc_off(unsigned int
> > irq_base, unsigned int irq_offset,
> > 
> > So it has a return value which needs to be handled. Sorry if I wasn't
> > clear on the first try.
> 
> I agree that return values should be checked.
> 
> However based on my reasoning there is absolutely nothing to do with the
> return value in this particular case, and in fact bailing out will leave
> the driver in a much worse state (as other unwind operations will be
> skipped).
> 
> That is what I kindly asked you to comment on.

How come you cannot unwind what you did thus far and bail out ? That means the 
design here is seriously broken, don't you think ?

> > > Now, if you want me to make another patch do you prefer a standalone
> > > patch on top of the other patches, or a completely new patchset?
> > 
> > Let's keep iterating :) But please wait for more feedback first.
> 
> OK. I will wait for more feedback then.

ACK, thanks ;-)

Best regards,
Marek Vasut

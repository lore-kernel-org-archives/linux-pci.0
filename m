Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41580 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab3JIKiQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Oct 2013 06:38:16 -0400
Message-ID: <1381315068.4330.1.camel@pasglop>
Subject: Re: [RFC] Architecture independent pcibios?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <monstr@monstr.eu>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date: Wed, 09 Oct 2013 21:37:48 +1100
In-Reply-To: <20131009090923.GE25606@e102652-lin.cambridge.arm.com>
References: <20131008144211.GA25231@e102652-lin.cambridge.arm.com>
	 <CAErSpo5=sUJDZGm+zHw+b1h_a1YYbaGBshAutAoPBZYUCRbYkw@mail.gmail.com>
	 <525438F6.3090600@gmail.com> <1381264135.645.230.camel@pasglop>
	 <20131009090923.GE25606@e102652-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-10-09 at 10:09 +0100, Liviu Dudau wrote:
> On Tue, Oct 08, 2013 at 09:28:55PM +0100, Benjamin Herrenschmidt wrote:
> > On Tue, 2013-10-08 at 11:55 -0500, Rob Herring wrote:
> >
> > > > I wonder if pci_process_bridge_OF_ranges() would fit somewhere in
> > > > drivers/of?  The implementations I looked at are mostly concerned with
> > > > parsing OF resources, and they don't have much to do with PCI
> > > > directly.
> > >
> > > This was being done until Ben weighed in:
> > >
> > > https://lkml.org/lkml/2013/5/4/103
> >
> > Well, I proposed an alternative (better) approach which I of course had
> > no time to actually implement yet :-)
> 
> In order to avoid any confusion, could you please point me again to the
> relevant message(s) where you proposed your approach?

The one pointed to by the above URL ?

> > I have done the changes I needed to do to powerpc
> > pci_process_bridge_OF_ranges so it would be possible to move that now to
> > a generic place, but I still think it's not a great idea. It means the
> > pci_controller structure with its resources will have to become generic
> > which somewhat overlaps with the pci_host_bridge that Bjorn introduced,
> > so that's really not great.
> >
> > I still think an arch with DT and simpler PCI code that powerpc could
> > start looking at the transition to a better model that I hinted at...
> 
> As tempting as it is to start anew and with a cleaner code, I am wary
> that porting the existing platforms to the new code will take longer
> that way. My intentions are to make the (probably infrequent) task of
> adding a new architecture to the PCI infrastructure a simple and
> straighforward task. But adding code for my platform is no guarantee
> that new ones will have an easier job.

It still makes little sense to generalize a pci_controller with
resources & offset on top of the generic pci_host_bridge with apertures.

Ben.

> Best regards,
> Liviu
> 
> >
> > Cheers,
> > Ben.
> >
> >
> >
> 
> --
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
> 
> -- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
> 
> ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
> ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782



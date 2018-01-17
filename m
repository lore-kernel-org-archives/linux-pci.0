Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750816AbeAQTMO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 14:12:14 -0500
Date: Wed, 17 Jan 2018 12:12:13 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: KarimAllah Ahmed <karahmed@amazon.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        "Jan H . =?UTF-8?B?U2Now7ZuaGVycg==?=" <jschoenh@amazon.de>
Subject: Re: [PATCH] pci: Do not read INTx PIN and LINE registers for
 virtual functions
Message-ID: <20180117121213.53b3bebe@w520.home>
In-Reply-To: <afe21e82-b75a-107c-05d4-b4037dfd22b7@amazon.com>
References: <1516213829-14844-1-git-send-email-karahmed@amazon.de>
        <20180117114944.4835c296@w520.home>
        <afe21e82-b75a-107c-05d4-b4037dfd22b7@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 17 Jan 2018 20:02:44 +0100
KarimAllah Ahmed <karahmed@amazon.com> wrote:

> On 01/17/2018 07:49 PM, Alex Williamson wrote:
> > On Wed, 17 Jan 2018 19:30:29 +0100
> > KarimAllah Ahmed <karahmed@amazon.de> wrote:
> >  
> >> ... since INTx is not supported by-spec for virtual functions.  
> > But the spec also states that VFs must implement the interrupt pin
> > register as read-only zero, so either this is redundant or it's a
> > workaround for VFs that aren't quite compliant?  Thanks,  
> 
> The end goal for me is just to NOT do the read across the PCI bus for no 
> good reason. We have devices with thousands of virtual functions and 
> this read is simply not useful in this case and can be optimized as I 
> did. So from a functionality point of view probably the patch does not 
> add any value as you mentioned, but it is really useful as a 
> micro-optimization.

Thanks for the clarification, it's helpful to understand the motivation
for a patch that otherwise seems unnecessary.

Alex

> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: linux-pci@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> >> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
> >> ---
> >>   drivers/pci/probe.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 65099d0..61002fb 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -1232,6 +1232,13 @@ static void pci_read_irq(struct pci_dev *dev)
> >>   {
> >>   	unsigned char irq;
> >>   
> >> +	/* Virtual functions do not have INTx support */
> >> +	if (dev->is_virtfn) {
> >> +		dev->pin = 0;
> >> +		dev->irq = 0;
> >> +		return;
> >> +	}
> >> +
> >>   	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
> >>   	dev->pin = irq;
> >>   	if (irq)  
> >  
> 
> Amazon Development Center Germany GmbH
> Berlin - Dresden - Aachen
> main office: Krausenstr. 38, 10117 Berlin
> Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
> Ust-ID: DE289237879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64551 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101Ab2CED7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 Mar 2012 22:59:38 -0500
Received: by wejx9 with SMTP id x9so2074484wej.19
        for <linux-pci@vger.kernel.org>; Sun, 04 Mar 2012 19:59:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120305035451.GB32675@quad.lixom.net>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
	<20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com>
	<1329946899.20389.9.camel@pasglop>
	<20120305035451.GB32675@quad.lixom.net>
Date: Sun, 4 Mar 2012 19:59:36 -0800
Message-ID: <CAOesGMipY2fTcNOSKwtCmkcQBzc0OFZrrWEWk8D7vkfNdRTf9g@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] powerpc/PCI: replace pci_probe_only with pci_flags
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 4, 2012 at 7:54 PM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Feb 23, 2012 at 08:41:39AM +1100, Benjamin Herrenschmidt wrote:
>> On Wed, 2012-02-22 at 11:19 -0700, Bjorn Helgaas wrote:
>> >  int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
>> > diff --git a/arch/powerpc/platforms/pasemi/pci.c
>> > b/arch/powerpc/platforms/pasemi/pci.c
>> > index b6a0ec4..b27d886 100644
>> > --- a/arch/powerpc/platforms/pasemi/pci.c
>> > +++ b/arch/powerpc/platforms/pasemi/pci.c
>> > @@ -231,7 +231,7 @@ void __init pas_pci_init(void)
>> >         pci_devs_phb_init();
>> >
>> >         /* Use the common resource allocation mechanism */
>> > -       pci_probe_only = 1;
>> > +       pci_add_flags(PCI_PROBE_ONLY);
>> >  }
>>
>> Olof, do you remember why you used to set that on pasemi ?
>
> Oops, going through email backlog. Sorry for the slow response.
>
>> I would have expected it to be clear, so the kernel can re-assign things
>> if needed. We really only want it set for pseries because of the
>> hypervisor being a PITA :-)
>
> Well, we did have some hypervisor work done at PA Semi too, and chances
> are it's from there. But it's unlikely since I think we booted pseries
> (PAPR) kernels under rHype.
>
> I suspect we just went with it for whatever legacy reasons and didn't
> revisit later -- since our firmware enumerated busses reliably there
> was no reason to redo it from the kernel.
>
> I've booted a system with pci_probe_only off here, and it seems happy
> enough. I'll send you a patch.
>
> Bjorn, that means you can drop this chunk of the patch, I suppose.

Sorry to comment to myself so quickly but since I just noticed that
the patch is in -next, don't worry about rebasing your work -- we'll
take out the flag use later.


-Olof

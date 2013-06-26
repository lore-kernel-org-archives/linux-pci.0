Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:60118 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab3FZTLY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2013 15:11:24 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so13776429obq.35
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2013 12:11:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372272358.30572.560.camel@ul30vt.home>
References: <20130528183527.3318.5365.stgit@bling.home> <20130528184020.3318.7800.stgit@bling.home>
 <20130620135914.GS2575@8bytes.org> <1371743091.32709.52.camel@ul30vt.home>
 <20130620161538.GH3589@8bytes.org> <CAErSpo5_P9tPdmpq2XO-X-d5NUWFG8Nbm_byKOkd5d4b8UMcMQ@mail.gmail.com>
 <1372272358.30572.560.camel@ul30vt.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 26 Jun 2013 13:11:03 -0600
Message-ID: <CAErSpo43uAcMdsTSbf6CNf_N2M9g9nQFOVBmr0=9Wnd+59KNvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search function
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 26, 2013 at 12:45 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Tue, 2013-06-25 at 22:20 -0600, Bjorn Helgaas wrote:
>> On Thu, Jun 20, 2013 at 10:15 AM, Joerg Roedel <joro@8bytes.org> wrote:
>> > On Thu, Jun 20, 2013 at 09:44:51AM -0600, Alex Williamson wrote:
>> >> On Thu, 2013-06-20 at 15:59 +0200, Joerg Roedel wrote:
>> >> > On Tue, May 28, 2013 at 12:40:20PM -0600, Alex Williamson wrote:
>> >> > > + if (!pci_is_root_bus(pdev->bus)) {
>> >> > > +         struct pci_dev *parent = pdev->bus->self;
>> >> > > +
>> >> > > +         if (pci_is_pcie(parent) &&
>> >> > > +             pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
>> >> > > +                 return true;
>> >> > > + }
>> >> >
>> >> > Hmm, that looks a bit dangerous.
>> >>
>> >> How so?  The algorithm seems pretty simple and logical.
>> >
>> > It is simple, but it is still a heuristic that may fail at some point,
>> > no?
>> >
>> >> Actually, I believe Bjorn rejected the idea of a fixed list because this
>> >> problem is detectable.  He also doesn't want me messing with quirks to
>> >> pci_is_pcie() in PCI because he wants a 1:1 relation between that and
>> >> having a PCIe capability.  So, I'm stuck and this is where it's ended
>> >> up.  Thanks,
>> >
>> > I think implementing such a list is much safer.
>> >
>> > Bjorn, why didn't you like that idea?
>>
>> Sorry, I can't remember, and I haven't been able to find the
>> discussion where I said that.  I think the current patches are all in
>> drivers/iommu, and if a list makes sense there, it's fine with me.
>
> Here's the comment I remember
>
> https://bugzilla.kernel.org/show_bug.cgi?id=44881#c7
>
>         Comment #7 From Bjorn Helgaas 2012-08-23 15:58:39
>         [snip]
>         I doubt the upstream device is at fault.  More likely the
>         downstream device is really a PCIe device (a PCIe-to-PCI bridge)
>         but just fails to report a PCIe capability.  I think this
>         situation is likely too common to deal with via quirks, so we'll
>         have to figure out a way to just make this work.

OK, I remember that now.  So the question is whether you want a list
or a set of quirks that may be an ongoing maintenance burden, or
whether you want an algorithm that may be risky but possibly less
maintenance.  I preferred the latter.  I think a failure in the
algorithm will most likely result in a device that just doesn't work
(because we derived a DMA source ID that doesn't match what the IOMMU
sees), so at least the impact is relatively minor, and no worse than a
missing entry in the list of exception devices.

Bjorn

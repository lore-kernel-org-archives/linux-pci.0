Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:36324 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbELTU4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2015 15:20:56 -0400
Received: by qcbgy10 with SMTP id gy10so10283190qcb.3
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2015 12:20:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150512163412.GD16079@red-moon>
References: <1430791333-26013-1-git-send-email-jchandra@broadcom.com>
 <20150505155346.GJ1550@arm.com> <20150506141859.GC26028@red-moon>
 <CAErSpo7z_Sf5QvMa8MBY0f7DQOmwhcpUnCFG=ZsmHuwT2HouQw@mail.gmail.com>
 <554ADCE0.8020603@amd.com> <20150512133431.GA2898@google.com> <20150512163412.GD16079@red-moon>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 12 May 2015 14:20:35 -0500
Message-ID: <CAErSpo5zjbZaYsGBdt9C2MaBCa-4X9Ws+WGLCz+Pxmd6wTi1Mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: generic: remove dependency on hw_pci
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Ming Lei <ming.lei@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 12, 2015 at 11:34 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, May 12, 2015 at 02:34:31PM +0100, Bjorn Helgaas wrote:
>
> [...]
>
>> > +void pci_claim_one_bus(struct pci_bus *b)
>> > +{
>> > +   struct pci_dev *pdev;
>> > +   struct pci_bus *child_bus;
>> > +
>> > +   list_for_each_entry(pdev, &b->devices, bus_list) {
>> > +           int i;
>> > +
>> > +           for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>> > +                   struct resource *r = &pdev->resource[i];
>> > +
>> > +                   if (r->parent || !r->start || !r->flags)
>> > +                           continue;
>> > +
>> > +                   if (pci_has_flag(PCI_PROBE_ONLY) ||
>> > +                       (r->flags & IORESOURCE_PCI_FIXED)) {
>> > +                           if (pci_claim_resource(pdev, i) == 0)
>> > +                                   continue;
>> > +
>> > +                           pci_claim_bridge_resource(pdev, i);
>> > +                   }
>> > +           }
>> > +   }
>> > +
>> > +   list_for_each_entry(child_bus, &b->children, node) {
>> > +           pci_claim_one_bus(child_bus);
>> > +   }
>> > +}
>> > +EXPORT_SYMBOL(pci_claim_one_bus);
>>
>> I'm not a fan of pci_claim_one_bus(), on the philosophical grounds that
>> claiming resources is a per-device thing, and I don't want to encourage
>> people to do it on a per-bus level.
>>
>> I'd rather claim them somewhere in the pci_device_add() path, as s390 does
>> in pcibios_add_device().  In fact, I'd *like* to do it even earlier, when
>> we read each BAR, so we could identify invalid or unassigned BARs
>> immediately.
>
> You mean claiming the resources in __pci_read_base (and unset the resource
> if claiming it fails ?) regardless of PCI_PROBE_ONLY ?

That's what I'm thinking, but only in the long term.  I doubt we're
ready to go that far yet.  I was thinking more along the lines of just
getting it uniformly into the core first, maybe even incrementally,
and only after that moving it around inside the core.

I don't think it would work right now because I think we read device
BARs before we read the apertures of the upstream bridge.

> We could claim the resources in pcibios_add_device on arm64, but this
> means arm code should be patched too since I am not happy at all to let
> arm and arm64 diverge even more.

I agree, it'd be nice to have arm and arm64 be similar, but from my
point of view, they wouldn't have to be changed at the same time.  To
me, they just look like two different arches.

Bjorn

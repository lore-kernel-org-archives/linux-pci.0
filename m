Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [207.46.100.124] ([207.46.100.124]:48304 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751954AbaKLLh3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 12 Nov 2014 06:37:29 -0500
Message-ID: <54634665.5030003@amd.com>
Date: Wed, 12 Nov 2014 18:37:09 +0700
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
To: Srikanth Thokala <sriku.linux@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <liviu.dudau@arm.com>,
	<lorenzo.pieralisi@arm.com>, <will.deacon@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] PCI: generic: Add msi_parent DT binding
References: <1415733454-24322-1-git-send-email-suravee.suthikulpanit@amd.com>
	<1415733454-24322-3-git-send-email-suravee.suthikulpanit@amd.com>
	<CA+mB=1LEEtPCixB9Ej74L03yPPH7D6YvfpkZyJgsHCm97-GvKg@mail.gmail.com>
 <CA+mB=1LKghLd9CuyLgDE9WGG5+VrUJF8r4DEbR7CiZojjoRdvQ@mail.gmail.com>
In-Reply-To: <CA+mB=1LKghLd9CuyLgDE9WGG5+VrUJF8r4DEbR7CiZojjoRdvQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/12/14 14:09, Srikanth Thokala wrote:
>>> @@ -122,9 +123,19 @@ static int gen_pci_config_write(struct pci_bus *bus, unsigned int devfn,
>>> >>         return PCIBIOS_SUCCESSFUL;
>>> >>  }
>>> >>
>>> >>+static int gen_pci_set_msi_parent(struct pci_bus *bus)
>>> >>+{
>>> >>+       struct gen_pci *pci = bus_to_gen_pci(bus);
>>> >>+
>>> >>+       bus->msi = pci->mchip;
>>> >>+
>>> >>+       return PCIBIOS_SUCCESSFUL;
>>> >>+}
>>> >>+
>>> >>  static struct pci_ops gen_pci_ops = {
>>> >>         .read   = gen_pci_config_read,
>>> >>         .write  = gen_pci_config_write,
>>> >>+       .set_msi_parent = gen_pci_set_msi_parent,
>> >
>> >We assign the msi chip through add_bus() call, do we still need this?
>> >
> There are series of patches from Yijing Wang around this.  You may have
> to go through them.
>
> Srikanth
>

Hm.. I was not aware of this patch. Thanks for the pointer. I'll check 
them out.

Suravee

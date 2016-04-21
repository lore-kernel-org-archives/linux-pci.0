Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:54242 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcDUJiT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2016 05:38:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Jayachandran C <jchandra@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	Jon Masters <jcm@redhat.com>, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, Wangyijing <wangyijing@huawei.com>,
	Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic ECAM API
Date: Thu, 21 Apr 2016 11:36:53 +0200
Message-ID: <8950494.UV8UrWiFbx@wuerfel>
In-Reply-To: <57189D2F.9070802@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com> <3830999.dF71UWYsBP@wuerfel> <57189D2F.9070802@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 21 April 2016 11:28:15 Tomasz Nowicki wrote:
> On 19.04.2016 15:06, Arnd Bergmann wrote:
> > On Monday 18 April 2016 21:31:54 Tomasz Nowicki wrote:
> >>
> >> Basically the whole content of pci-thunder-ecam.c and pci-thunder-pem.c.
> >>
> >> pci-thunder-ecam.c contains config space accessors. Similar for
> >> pci-thunder-pem.c but it also has extra init call (it is now called
> >> thunder_pem_init) which finds and maps related registers.
> >
> > They seem to do much more than just override the accessors, they actually
> > change the contents of the config space as well. Is that really necessary
> > on ACPI based systems as well?
> 
> Yes, the pci-thunder-ecam.c accessors are meant to emulate config space 
> capabilities. They are necessary to synthesize EA capabilities (fixed 
> PCI BARs), it wont work without this, for ACPI boot as well.

Why is that? I thought the BARs never get reassigned when using ACPI,
so I'm surprised it's actually needed. Maybe I misunderstood what
you mean by fixed PCI BARs.

> > Another idea: how about moving all of this logic into ACPI and calling
> > some AML method to access the config space if the devices are that
> > far out of spec.
> 
> Do you mean Linux specific way to call non-standard config space 
> accessors? Then non-standard accessors are going to AML methods which 
> are called from common code which handles quirks via unified API ?

What I really meant was a standardized way to do handle hardware that
is in some way or another not compliant with PNP0A08: We could have
a different hardware ID for this and let all the first-generation
ARM servers and also anything else using ACPI with nonstandard PCI
use the same method across operating systems.

	Arnd

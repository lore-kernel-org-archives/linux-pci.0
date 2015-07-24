Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59874 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbbGXDGd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 23:06:33 -0400
Message-ID: <55B1ABA9.90207@roeck-us.net>
Date: Thu, 23 Jul 2015 20:06:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Simon Horman <horms@verge.net.au>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [RFT PATCH v3] PCI: move pci_read_bridge_bases to the generic
 PCI layer
References: <1436439557-21075-1-git-send-email-lorenzo.pieralisi@arm.com> <20150723161257.GZ21967@google.com> <55B11AB0.7050002@roeck-us.net> <20150723175258.GC23324@red-moon>
In-Reply-To: <20150723175258.GC23324@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/23/2015 10:52 AM, Lorenzo Pieralisi wrote:
>>
>> For alpha, PCI_PROBE_ONLY is set for two platforms, marvel and titan,
>> out of ~20. mips sets the flag for 6 platforms out of >25.
>> Unlikely that those are the only relevant ones.
>>
>> I could try to run some qemu tests for both architectures, but I have
>> no idea what to look out for. Ideas, anyone ?
>
> As I replied to Bjorn, I would not expect pci_read_bridge_bases() to
> be a disruptive operation on !PCI_PROBE_ONLY systems, I will check
> again alpha and mips code but it is really hard to say, I will
> inspect the code again to try to figure it out.
>

I finally got around to apply the patch to our system (ppc and x86).
I also applied it on top of Linus' tree and ran it through my test
farm. No problems found, works fine as far as I can see.

Guenter


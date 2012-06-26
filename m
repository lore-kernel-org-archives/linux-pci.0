Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43050 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758621Ab2FZRWg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jun 2012 13:22:36 -0400
Message-ID: <4FE9EFD8.6010608@wwwdotorg.org>
Date: Tue, 26 Jun 2012 11:22:32 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
References: <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de> <4FDA40A0.4030206@wwwdotorg.org> <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de> <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de> <4FE0EFBB.6090206@firmworks.com> <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de> <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com> <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de> <4FE4A4B3.9010200@wwwdotorg.org> <4FE4AB2F.8090402@wwwdotorg.org> <20120625063456.GB11469@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20120625063456.GB11469@avionic-0098.adnet.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/25/2012 12:34 AM, Thierry Reding wrote:
> On Fri, Jun 22, 2012 at 11:28:15AM -0600, Stephen Warren wrote:
>> On 06/22/2012 11:00 AM, Stephen Warren wrote:
>>> On 06/22/2012 05:00 AM, Thierry Reding wrote: ...
>>>> Stephen: can you try to find out whether the Tegra PCIe
>>>> controller indeed implements ECAM, or if this scheme is
>>>> actually just a proprietary variant?
>>> 
>>> Sure. I have added this request to the bug I filed requesting
>>> more complete PCIe host documentation.
>> 
>> I've received unofficial confirmation that we do indeed implement
>> a non-standard/non-ECAM mapping, and what's in our driver matches
>> our HW.
> 
> What I don't quite see yet is how the extended configuration space
> is supposed to work with the current driver. The PCIE_CONF_* macros
> don't provide for registers >= 256. Passing a value higher than
> that will mess with the device function field.

The current downstream driver is incorrect for that case. We should be
updating it (at least, I filed a bug to do this).

Here's how the HW works (I believe this information should be in some
future version of the TRM):

There are 3 address spaces:

* The CPU bus.

* An internal (to the PCIe controller) 40-bit address space.
Apparently the layout is HyperTransport-based. Whether HT defines
this, or whether our HW engineers are referring to our particular
implementation of HT, I'm not sure.

* The PCIe external bus.

Accesses from the CPU to the PCIe controller's 1GB aperture are mapped
into the 40-bit bus using the BAR configurations in the PCIe
controller; I believe this is what tegra_pcie_setup_translations() is
configuring in our downstream driver.

Accesses are then mapped from this 40-bit bus to the external 32-bit
bus, I believe using a hard-coded mapping, which I believe may be
inherited from (our implementation of?) HyperTransport

For config and extended config accesses the mapping from the internal
to external bus is as follows:

In the case of PCICFG space,
addr[39:28]=12'hFDF,
addr[27:24]=4'hE means type 0 and addr[27:24]=4'hF means type 1,
addr[23:16]=bus number
addr[15:11]=device number
addr[10:8]=function number
addr[7:0]=register number

In the case of EXTCFG space,
addr[39:32]=8'hFE,
addr[31:28]=4'h0 means type 0 and addr[31:28]=4'h1 means type 1,
addr[27:24]=upper register number (i.e. register number[11:8])
addr[23:16]=bus number
addr[15:11]=device number
addr[10:8]=function number
addr[7:0]=register number (i.e. register number[7:0])

(in actual fact, the HW matches the top 16 or 12 bits to determine
config/ext-config and transaction type, so the top two fields in the
lists above should really be considered merged)

I hope this helps!

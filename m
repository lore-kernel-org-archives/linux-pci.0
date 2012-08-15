Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54803 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873Ab2HOULX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 16:11:23 -0400
Message-ID: <502C025E.6000009@wwwdotorg.org>
Date: Wed, 15 Aug 2012 14:11:10 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
References: <50201E1D.5060200@wwwdotorg.org> <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de> <50294BCA.1070807@wwwdotorg.org> <CAErSpo7og1XgOSv_mFCQ=hP7pq0j3gXWh2QFL2wBJjz7kcAq=g@mail.gmail.com> <502AA96B.2050709@wwwdotorg.org> <20120814195834.GA10431@avionic-0098.mockup.avionic-design.de> <CAErSpo4Bm_Ryx=OK+svjqAwD4N8v0vrheLVdc-N1ijx8i_-N3w@mail.gmail.com> <502AD82F.3080702@wwwdotorg.org> <502AE485.8060307@wwwdotorg.org> <502BF2B4.9030401@wwwdotorg.org> <20120815200905.GD12870@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120815200905.GD12870@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/15/2012 02:09 PM, Thierry Reding wrote:
> On Wed, Aug 15, 2012 at 01:04:20PM -0600, Stephen Warren wrote:
>> On 08/14/2012 05:51 PM, Stephen Warren wrote:
>>> On 08/14/2012 04:58 PM, Stephen Warren wrote:
>> ...
>>>> Can't we make the call to pci_bus_add_devices() optional in 
>>>> pci_scan_root_bus() somehow; one of:
>>> 
>>> Sigh, that turns out not to work correctly; it solves at least
>>> this part of the problem when booting using device tree, but
>>> when booting using a board file, it causes the IRQ number
>>> passed to the PCIe device to be bogus:-(
>>> 
>>> I give up for now.
>> 
>> I think the appropriate workaround for Tegra in 3.6 is to simply
>> make any drivers for PCIe-based devices be modules instead of
>> built-in, as Thierry hinted at much earlier in the thread. I've
>> validated that the Ethernet works just fine on TrimSlice with
>> that change, booting v3.6-rc1 using either board files or device
>> tree.
> 
> That's certainly the easiest and least error-prone solution.
> 
>> For 3.7, we should continue the discussion about a real fix; I'll
>> look into the change Bjorn requested and see if it works,
>> although given that hacking pci_scan_root_bus as described
>> immediately previously in this thread caused a regression when
>> booting using a board file, and the fact that board files are no
>> longer supported on Tegra, I'm not too confident in the
>> outcome...
> 
> I don't understand this last part. If the problem is there when
> booting from board files and the board files are removed, doesn't
> that remove the problem as well? =)

It does for ARM SoCs/CPUs exclusively using device tree, but not all
ARM systems are converting to device tree, so the fact that Tegra has
makes it harder for me not to break anything else.

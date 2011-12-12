Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:40472 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754002Ab1LLVYQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2011 16:24:16 -0500
Message-ID: <4EE670F8.1020100@gmx.de>
Date: Mon, 12 Dec 2011 22:24:08 +0100
From: Helge Deller <deller@gmx.de>
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: linux-pci@vger.kernel.org
Subject: Re: pci_is_pcie() returns true for PCI-cards?
References: <4EE5220B.1090207@gmx.de> <20111211225342.GA20129@parisc-linux.org>
In-Reply-To: <20111211225342.GA20129@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/11/2011 11:53 PM, Matthew Wilcox wrote:
> On Sun, Dec 11, 2011 at 10:35:07PM +0100, Helge Deller wrote:
>> In my machine I'm running two dual-DVI PCI video cards (NVidia GeForce 7300 LE PCI, ATI FireMV 2200 PCI).
>> Both are PCI and not PCI-Express cards.
>>
>> Somewhere after kernel 2.6.34 the nouveau and the radeon DRM drivers switched their
>> initialization code to set the GART/aperture size to 64MB (for PCI) or 512MB (for PCIE),
>> and the pci_is_pcie() function is used to determine if the graphics card is PCI or PCIE.
>>
>> Now my question:
>> My assumption is, that pci_is_pcie() should return true for PCI-E cards only.
>> PCI-only cards should return false. Is this assumption correct?
>
> Yes.
>
>> If yes, there is probably a bug somewhere and maybe someone here has an idea what I could test to fix this bug?
>> If not, then the nouveau and radeon drivers should not use pci_is_pcie() to determine if this is a PCI or PCI-E card...
>>
>> I did some testing with kernel 3.1.5.
>> For the nVidia card (PCI 01:00.0) I got:
>> - pci_is_pcie(dev->pdev) = 1
>> - pci_find_capability(dev->pdev, PCI_CAP_ID_EXP) = 120
>>
>> lspci output:
>> 00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controller (rev 03)
>> 00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express Root Port (rev 03)
>> 00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition Audio Controller (rev 01)
>> 00:1c.0 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 1 (rev 01)
>> 00:1c.1 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 2 (rev 01)
>> 00:1d.0 USB Controller: Intel Corporation N10/ICH7 Family USB UHCI Controller #1 (rev 01)
>> 00:1d.1 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #2 (rev 01)
>> 00:1d.2 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #3 (rev 01)
>> 00:1d.3 USB Controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #4 (rev 01)
>> 00:1d.7 USB Controller: Intel Corporation N10/ICH 7 Family USB2 EHCI Controller (rev 01)
>> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
>> 00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
>> 00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
>> 00:1f.2 IDE interface: Intel Corporation N10/ICH7 Family SATA IDE Controller (rev 01)
>> 01:00.0 VGA compatible controller: nVidia Corporation G72 [GeForce 7300 LE] (rev a1)
>> 02:00.0 Ethernet controller: Atheros Communications AR8121/AR8113/AR8114 Gigabit or Fast Ethernet (rev b0)
>> 04:01.0 VGA compatible controller: ATI Technologies Inc RV280 [FireMV 2200 PCI] (rev 01)
>> 04:01.1 Display controller: ATI Technologies Inc RV280 [FireMV 2200 PCI] (secondary) (rev 01)
>
> Can you send
> lspci -xxxxs01:00.0
> lspci -xxxxs04:01.0
> lspci -xxxxs04:01.1

Hi Matthew,
Thanks for your offer to help!

I noticed that my mail was bogus - the NVidia card is in fact a PCI-E card.
So, the pci code and the pci_is_pcie() function works correctly.

I'm probably running into the issue that both drivers in newer kernels
want to set up 512MB aperture each (sum 1GB), while in older kernels the
nouveau driver wanted 64MB (sum: 576MB). This higher value now doesn't seem
to fit into the 64MB IO TLB of the SWIOTLB implementation?
I will continue testing (e.g. swiotlb=<pages> and radeon.gartsize=128 boot options)
as soon as I can reboot the server.

Thanks again,
Helge

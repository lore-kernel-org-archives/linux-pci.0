Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:51396 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab2LJQFR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2012 11:05:17 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so2050557lag.19
        for <linux-pci@vger.kernel.org>; Mon, 10 Dec 2012 08:05:16 -0800 (PST)
Message-ID: <50C60839.70603@monstr.eu>
Date: Mon, 10 Dec 2012 17:05:13 +0100
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
CC: Rob Herring <robherring2@gmail.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: pci and pcie device-tree binding - range No cells
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com> <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com> <50C601B6.2080107@monstr.eu> <AE90C24D6B3A694183C094C60CF0A2F6026B70E7@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B70E7@saturn3.aculab.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/10/2012 04:52 PM, David Laight wrote:
>> Does it mean that pci is supposed be always 64 bit wide?
>> And there is no option to have just 32bit values.
>
> I certainly believe that all PCIe (not PCI) transfers are
> nominally multiples of 64bit data.

And PCI? That powerpc/pci-common code was designed for PCI
and microblaze also used it for PCI.

CC: Thomas: I think it will be interesting to see this discussion
because you are using size-cell/address-cells equal 1.
http://www.spinics.net/lists/arm-kernel/msg211839.html

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57760 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbaIIVwq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Sep 2014 17:52:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	bhelgaas@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: keystone: update to support multiple pci ports
Date: Tue, 09 Sep 2014 23:52:34 +0200
Message-ID: <3967092.l9bxcqMaSa@wuerfel>
In-Reply-To: <540F75DF.5050904@ti.com>
References: <1410293835-13050-1-git-send-email-m-karicheri2@ti.com> <9042477.aRbAhpkfQ5@wuerfel> <540F75DF.5050904@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 09 September 2014 17:49:19 Murali Karicheri wrote:
> Actually this is an inteded. The vendor ID is in a register indicated by
> reg offset and as per the device spec, it needs to be read and updated 
> by the software. Now since multiple instances of PCI device needs to be 
> read the same register, the reading happens in the probe() and same is 
> unmapped after that.
> 
> +       ks_pcie->device_id = readl(reg_p) >> 16;
> +       devm_iounmap(dev, reg_p);
> +       devm_release_mem_region(dev, res->start, resource_size(res));
> 
> Afetr that in ks_pcie_host_init(), it update the device_id in the RC's 
> config space.

I'm not sure I understand the purpose of this. Do you mean you read
the vendor/device ID of whichever device happens to get probed first
and then program the same ID into all other devices as well?

What if the order changes between two boots? Why does the vendor/device
ID of the host bridge even matter at all?

	Arnd

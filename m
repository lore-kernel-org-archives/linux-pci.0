Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:27019 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752228AbbKXMS7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2015 07:18:59 -0500
Date: Tue, 24 Nov 2015 20:14:11 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <james.morse@arm.com>,
	<gabriel.fernandez@st.com>, <Minghuan.Lian@freescale.com>,
	<wangzhou1@hisilicon.com>, <gabriele.paoloni@huawei.com>,
	<arnd@arndb.de>, <bhelgaas@google.com>, <pratyush.anand@gmail.com>,
	"Nori, Sekhar" <nsekhar@ti.com>, <jingoohan1@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: PCIe regression with DRA7xx in 4.4-rc1
Message-ID: <20151124201411.33463709@xhacker>
In-Reply-To: <56545183.8000507@ti.com>
References: <56545183.8000507@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tue, 24 Nov 2015 17:31:07 +0530
Kishon Vijay Abraham I wrote:

> Hi,
> 
> I'm seeing a regression with <d1b9cf31252e905ad563b9e863fd4470f6c3dd1c>("PCI:
> designware: Make driver arch-agnostic").
> 
> Logs using a SATA PCIe card [1]. The PCIe card enumerates fine but after that I
> observe "ata3.00: qc timeout (cmd 0xec), ata3.00: failed to IDENTIFY (I/O
> error, err_mask=0x4)"
> 
> Logs using a Ethenet PCIe card [2]. Again here the PCIe card enumerates fine
> but when I give ifconfig up, it fails.
> 
> If I just revert commit <d1b9cf31252e905ad563b9e863fd4470f6c3dd1c>, the PCIe
> cards starts to work fine again

FYI, maybe the patch can fix the regression.
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/387362.html

> 
> Logs using a SATA PCIe card [3]. Here the KINGSTON SSD gets detected fine.
> Logs using a Ethernet PCIe card [4]. I'm able to do ping tests now.
> 
> Actually I'm not able to find any obvious problems with the patch and the irq
> number and the memory resource also looks fine. Any idea what could be the problem?
> 
> [1] -> http://pastebin.ubuntu.com/13491456/
> [2] -> http://pastebin.ubuntu.com/13491526/
> 
> [3] -> http://pastebin.ubuntu.com/13491658/
> [4] -> http://pastebin.ubuntu.com/13491593/
> 
> Thanks
> Kishon
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


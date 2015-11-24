Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: PCIe regression with DRA7xx in 4.4-rc1
To: <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <james.morse@arm.com>,
	<gabriel.fernandez@st.com>, <Minghuan.Lian@freescale.com>,
	<wangzhou1@hisilicon.com>, <gabriele.paoloni@huawei.com>,
	<arnd@arndb.de>, <bhelgaas@google.com>, <pratyush.anand@gmail.com>,
	"Nori, Sekhar" <nsekhar@ti.com>, <jingoohan1@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>
Message-ID: <56545183.8000507@ti.com>
Date: Tue, 24 Nov 2015 17:31:07 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I'm seeing a regression with <d1b9cf31252e905ad563b9e863fd4470f6c3dd1c>("PCI:
designware: Make driver arch-agnostic").

Logs using a SATA PCIe card [1]. The PCIe card enumerates fine but after that I
observe "ata3.00: qc timeout (cmd 0xec), ata3.00: failed to IDENTIFY (I/O
error, err_mask=0x4)"

Logs using a Ethenet PCIe card [2]. Again here the PCIe card enumerates fine
but when I give ifconfig up, it fails.

If I just revert commit <d1b9cf31252e905ad563b9e863fd4470f6c3dd1c>, the PCIe
cards starts to work fine again

Logs using a SATA PCIe card [3]. Here the KINGSTON SSD gets detected fine.
Logs using a Ethernet PCIe card [4]. I'm able to do ping tests now.

Actually I'm not able to find any obvious problems with the patch and the irq
number and the memory resource also looks fine. Any idea what could be the problem?

[1] -> http://pastebin.ubuntu.com/13491456/
[2] -> http://pastebin.ubuntu.com/13491526/

[3] -> http://pastebin.ubuntu.com/13491658/
[4] -> http://pastebin.ubuntu.com/13491593/

Thanks
Kishon

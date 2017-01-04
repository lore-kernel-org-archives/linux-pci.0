Return-Path: <SRS0=IKS2=YS=gmail.com=valmikibow@kernel.org>
Return-Path: <SRS0=IKS2=YS=gmail.com=valmikibow@kernel.org>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
From: valmiki <valmikibow@gmail.com>
Subject: Need clarity on PCIe MSI interrupt in device tree
Cc: helgaas@kernel.org, marc.zyngier@arm.com, arnd@arndb.de,
 mark.rutland@arm.com
Message-ID: <2fea5a0c-7410-97fd-91d1-ae6a06ab1a52@gmail.com>
Date: Wed, 4 Jan 2017 08:47:43 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have confusion on MSI interrupt flags in PCIe documetation.

MSI interrupts are edge triggered, but i see some controllers use 
Ex:tegra <0 99 0x4>, here interrupt flags show 0x4 which means level 
sensitive as per include/dt-bindings/interrupt-controller/irq.h.

May i know why is it like this, why MSI depicted as level sensitive in 
device tree.

Regards,
valmiki

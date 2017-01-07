Return-Path: <SRS0=Ps8X=YV=gmail.com=valmikibow@kernel.org>
Return-Path: <SRS0=Ps8X=YV=gmail.com=valmikibow@kernel.org>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Marc Zyngier <marc.zyngier@arm.com>, helgaas@kernel.org, arnd@arndb.de
From: valmiki <valmikibow@gmail.com>
Subject: Need clarity on legacy RC interrupt handling
Message-ID: <fc6ec56f-77a4-aec6-debb-ab5f1fde9ffa@gmail.com>
Date: Sat, 7 Jan 2017 07:54:40 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi,

Legacy interrupts are level triggered, but i see some RC drivers use 
flow handler "handle_simple_irq" instead why they are not using 
"handle_level_irq" ?

Why they are registering dummy_irq_chip with "handle_simple_irq", if 
they use this chip how the irq type is set for this virtual irq (level 
or edge).

Regards,
vamiki

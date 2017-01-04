Return-Path: <SRS0=IKS2=YS=gmail.com=valmikibow@kernel.org>
Return-Path: <SRS0=IKS2=YS=gmail.com=valmikibow@kernel.org>
Subject: Need clarity on MSI handling in RC driver
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <2fea5a0c-7410-97fd-91d1-ae6a06ab1a52@gmail.com>
Cc: helgaas@kernel.org, marc.zyngier@arm.com, arnd@arndb.de,
 mark.rutland@arm.com
From: valmiki <valmikibow@gmail.com>
Message-ID: <307e8512-7e14-39a2-c225-6db44e443aea@gmail.com>
Date: Wed, 4 Jan 2017 23:09:06 +0530
MIME-Version: 1.0
In-Reply-To: <2fea5a0c-7410-97fd-91d1-ae6a06ab1a52@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi All,

I have a doubt, the MSI domains are handled differently in different RC 
drivers.

Some drivers use irq_domain_add_linear alone, and some use 
pci_msi_create_irq_domain also to handle MSI.

In most of the 32-bit architectures only irq_domain_add_linear is used 
and in 64 bit drivers both pci_msi_create_irq_domain and 
irq_domain_add_linear are used.

So is this because of architecture difference between ARM and ARM64 ?

Thanks & Regards,
valmiki

Return-Path: <SRS0=OCDN=24=gmail.com=valmikibow@kernel.org>
Return-Path: <SRS0=OCDN=24=gmail.com=valmikibow@kernel.org>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, marc.zyngier@arm.com, arnd@arndb.de
From: valmiki <valmikibow@gmail.com>
Subject: Purpose of PCI address in ranges property
Message-ID: <26e69b06-dde2-2ed5-0288-ee5d58676d7e@gmail.com>
Date: Sun, 19 Mar 2017 19:44:48 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi,

When ranges property is being parsed using 
of_pci_get_host_bridge_resources, the pci address is being used for
calculating the offset for pci_add_resource_offset.

What is this offset for ?

So the cpu address is being used for programming memory base and limit 
registers ?

Thanks & Regards,
Valmiki

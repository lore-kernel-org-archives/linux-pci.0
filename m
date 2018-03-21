Return-Path: <SRS0=/BSl=GL=gmail.com=valmikibow@kernel.org>
Return-Path: <SRS0=/BSl=GL=gmail.com=valmikibow@kernel.org>
To: linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
From: valmiki <valmikibow@gmail.com>
Subject: Why two irq chips for MSI
Message-ID: <81eb7191-1c5c-ad27-2714-9563e4ef7c68@gmail.com>
Date: Wed, 21 Mar 2018 22:42:36 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi,

In most of the RP drivers, why two irq chips are being used for MSI ?

One at irq_domain_set_info (which uses irq_compose_msi_msg and 
irq_set_affinity methods) and another being registered with struct 
msi_domain_info (which uses irq_mask/irq_unmask methods).

When will each chip be used w.r.t to virq ?

Thanks,
Valmiki

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

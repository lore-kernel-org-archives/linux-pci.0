Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:37030 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbbCGTa0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Mar 2015 14:30:26 -0500
Received: by qgdz107 with SMTP id z107so20273046qgd.4
        for <linux-pci@vger.kernel.org>; Sat, 07 Mar 2015 11:30:26 -0800 (PST)
Received: from [192.168.1.153] (host-64-47-22-57.masergy.com. [64.47.22.57])
        by mx.google.com with ESMTPSA id e14sm7156291qka.31.2015.03.07.11.30.25
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 11:30:25 -0800 (PST)
Message-ID: <54FB51D0.9040504@gmail.com>
Date: Sat, 07 Mar 2015 14:30:24 -0500
From: Karandeep Chahal <karandeepchahal@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: MSI IRQ affinity question
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

I am working on a kernel module for a PCI chip. The module registers
several PCI MSI interrupts. After a certain while, during the course of
using the PCI chip, the kernel module fails to receive interrupts (IRQ
handler routine is not called), or receives them very sporadically
(after every 2 seconds or so). However, if I change the irq affinity to
CPU 16 from
the default (CPU 10), everything seems to work fine (mostly). Further,
if I change the IRQ affinity to CPU 0, I receive even fewer (almost no)
interrupts, and the chip become unusable.

Considering the fact that the CPU's are idle (no one uses CPU 10 for IRQ
handling), why does changing the IRQ affinity from CPU 10 to CPU 16
makes things better? And changing it to CPU 0 or CPU 1 makes it so much
worse. I understand there will be some performace penatly if a certain
CPU is handling interrupts from multiple devices, but that does not seem
to be the case here.

Please advise.

Thanks,
kchahal


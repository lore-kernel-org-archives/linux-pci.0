Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from m12-13.163.com ([220.181.12.13]:56639 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbdJHMdG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 8 Oct 2017 08:33:06 -0400
From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: [BUG] gma500: Possible sleep-in-atomic bugs in gma_resume_pci
To: patrik.r.jakobsson@gmail.com, airlied@linux.ie, bhelgaas@google.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Message-ID: <9d3163c8-fd8d-e464-d99d-50064757848f@163.com>
Date: Sun, 8 Oct 2017 20:31:27 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The driver may sleep under a spinlock, and the function call paths are:
gma_power_begin (acquire the spinlock)
   gma_resume_pci
     pci_set_power_state
       __pci_start_power_transition (drivers/pci/pci.c)
         msleep --> may sleep

gma_power_begin (acquire the spinlock)
   gma_resume_pci
     pci_enable_device
       pci_enable_device_flags (drivers/pci/pci.c)
         do_pci_enable_device
           pci_set_power_state
             __pci_start_power_transition
               msleep --> may sleep

A possible fix is to replace msleep with mdelay in 
__pci_start_power_transition in drivers/pci/pci.c.

These bugs are found by my static analysis tool and my code review.


Thanks,
Jia-Ju Bai

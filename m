Return-Path: <linux-kernel-owner@vger.kernel.org>
To: forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        simon@nikanor.nu, tvboxspy@gmail.com, scott@matheina.com,
        dan.a.cashman@gmail.com, golubev.mikhail@gmail.com,
        bhelgaas@google.com
Cc: devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
From: Jia-Ju Bai <baijiaju1990@163.com>
Subject: [BUG] vt6655: A possible sleep-in-atomic bug in vt6655_suspend
Message-ID: <f3f4b129-471e-6ccd-a2fa-6ffd915bcb7f@163.com>
Date: Mon, 9 Oct 2017 09:10:28 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to device_main.c, the driver may sleep under a spinlock,
and the function call path is:
vt6655_suspend (acquire the spinlock)
   pci_set_power_state
     __pci_start_power_transition (drivers/pci/pci.c)
       msleep --> may sleep

A possible fix is to replace msleep with mdelay in 
__pci_start_power_transition in drivers/pci/pci.c.

This bug is found by my static analysis tool and my code review.


Thanks,
Jia-Ju Bai

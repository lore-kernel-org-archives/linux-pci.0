Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35525 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeBFTCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Feb 2018 14:02:50 -0500
Received: by mail-qk0-f176.google.com with SMTP id 69so3691552qkz.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2018 11:02:50 -0800 (PST)
MIME-Version: 1.0
From: Ran Shalit <ranshalit@gmail.com>
Date: Tue, 6 Feb 2018 21:02:49 +0200
Message-ID: <CAJ2oMhKJ5ECtr5-F1M_PjO+ev_8-UfpLu+jT9hG7XEwoDV0A_Q@mail.gmail.com>
Subject: understanding DMA in PCI drivers
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I write a pci linux driver, and after reviewing some examples in
kernel, there is issue I am not sure about:
DMA seems to follow the following steps in PCI:
1.  driver allocate dma buffers and map them to BAR.
2. driver initialize device to be familiar with dma addresses.
3. tx from cpu to device: driver trigger dma, by writing into device BARs.
4. rx from device to cpu: device is responsible for triggering DMA
(driver does not do anything here)
5. tx/rx completion: interrupt from DMA (in cpu)
6. interrupt handler of section 5 above checks that device finished tx/rx.

Is the above understanding correct ?
1. As to 6, I am not sure about, is it that device knows that
transaction is finished (DMA is in soc , not device) ?
2. How does device triggers DMA from device to cpu, is it by simply
writing to BAR ?
3. How does device triggers DMA from cpu to device, is it by simply
reading from BAR ?

Thank you,
Ran

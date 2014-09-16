Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f196.google.com ([74.125.82.196]:56573 "EHLO
	mail-we0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbaIPXxO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Sep 2014 19:53:14 -0400
Received: by mail-we0-f196.google.com with SMTP id p10so158665wes.11
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2014 16:53:13 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 17 Sep 2014 07:53:13 +0800
Message-ID: <CANybWhpt7L2JwKBjn2iU_J1sz-GAgN4Ge4jBM_2ry5srbun0hw@mail.gmail.com>
Subject: [HELP] PCI error recovery driver routine not called
From: Alvin Abitria <abitria.alvin@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I have a question regarding PCIe error recovery, because in my
implementation it's not working.  I've simply implemented and
registered pcie error handler methods to my driver in order to handle
error events.  Whenever I trigger an error in my PCIe device that
causes its PCIe core to reset (and most likely to disconnect).  The
I/O drops to zero after that and it is expected.  However, I am not
notified by the err_detected method under the error handlers. Does
this means the system was unable to detect the error?  Instead I ended
up with the following console message:

irq 16: nobody cared
handlers:
...
...
Disabling IRQ # 16

What baffles me more is that the injected PCI error seemed to brought
down that IRQ 16 device as well - which is definitely not the irq # of
my driver/device.  Why is this message posting, and is it expected?
Is there anything I could possibly missed during registration of error
handler methods?

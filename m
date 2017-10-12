Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:54563 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755086AbdJLIoB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2017 04:44:01 -0400
Received: by mail-it0-f67.google.com with SMTP id 72so5993119itk.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Oct 2017 01:44:01 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Rados=C5=82aw_Piliszek?= <radoslaw.piliszek@gmail.com>
Date: Thu, 12 Oct 2017 10:44:00 +0200
Message-ID: <CAB6MLKOh3BhVWLk650hJ76O_ys+J1OjezhiSPOkWGVkcVPLdFw@mail.gmail.com>
Subject: ASPM not supported, yet ASPM L1 Enabled
To: linux-pci@vger.kernel.org
Cc: mj@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

First of all - I hope this is the right place to post this question.
Please forgive me if it is not.

And now onto the problem:

I have a device which reports that ASPM is not supported yet reports
ASPM L1 Enabled. This is PCIe switch's downstream port.

I used lspci -vvvnn in version 3.5.5 to obtain:
LnkCap: Port #16, Speed 8GT/s, Width x16, ASPM not supported
LnkCtl: ASPM L1 Enabled; Disabled- CommClk-
LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk- DLActive+
BWMgmt- ABWMgmt-

The same downstream port before the first use of the device after
reboot reports:
LnkCap: Port #16, Speed 8GT/s, Width x16, ASPM not supported
LnkCtl: ASPM Disabled; Disabled- CommClk-
LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk- DLActive+
BWMgmt+ ABWMgmt+

(The 2 bottom lines differ).

Is this normal behavior?

Regards,
Rados=C5=82aw Piliszek

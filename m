Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42370 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754396AbeFVUm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2018 16:42:58 -0400
Received: by mail-lf0-f65.google.com with SMTP id z207-v6so9993990lff.9
        for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2018 13:42:57 -0700 (PDT)
MIME-Version: 1.0
From: Ran Shalit <ranshalit@gmail.com>
Date: Fri, 22 Jun 2018 23:42:55 +0300
Message-ID: <CAJ2oMhLTQwJpfvPUtctygHLNuAny9X5hbOX6AfFM_k_M5SF42g@mail.gmail.com>
Subject: Issue on replacement of celeron with amd
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I hope someone can help with the following interesting issue:
We have done a simple replacement in board of celeron chip with amd
geode, and expected everything to work the same. No other change been
made (exactly the same image including kernel and filesystem )

With the new chip (amd geode), which has the pcmcai issues,  the
following messages seems to indicate that something is wrong:


PCI: Using IRQ router default [1022/2090] at 00:0f.0
apm: BIOS not found. <<<-- although few lines above it shows "PCI: PCI
BIOS revision 2.10"
...
PCI: Guessed IRQ 14 for device 00:08.0
.....
PCI: Guessed IRQ 5 for device 00:0e.0

I have also tried to compare the 2 dmesg files side by side.

Is it a bios issue (the "apm: BIOS not found" seems to indicate
something wrong in bios?) ?

Should I just upgrade the kernel and see if this issues is resolved in
later kernel (this is 2.4.20 kernel, yes I know that it is very old ,
but it is a legacy system)

Thanks for any hint on how to resolve this issue.
ranran

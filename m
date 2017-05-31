Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36899 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdEaVA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2017 17:00:58 -0400
Received: by mail-wm0-f46.google.com with SMTP id d127so35326803wmf.0
        for <linux-pci@vger.kernel.org>; Wed, 31 May 2017 14:00:57 -0700 (PDT)
MIME-Version: 1.0
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date: Wed, 31 May 2017 23:00:16 +0200
Message-ID: <CAHKzcENL1px=zS8QspSX3WZ_z1PWjWBEcNBKTb00cfVushd9XQ@mail.gmail.com>
Subject: How to trace down if PCIe link went into L1 state
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am not really familiar with pci subsystem but I need to check if the
pcie link went into L1 state after suspend.

I use a wifi card with M2 connector with pcie interface. I suspend the
system and would like to verify if the link state went really into
L1/L2 as I see quite a big current on the power lines when it's in a
suspend.

Thanks,
/Waldek

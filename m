Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf1-f41.google.com ([209.85.167.41]:39200 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeHYSiY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Aug 2018 14:38:24 -0400
Received: by mail-lf1-f41.google.com with SMTP id j201-v6so8755479lfg.6
        for <linux-pci@vger.kernel.org>; Sat, 25 Aug 2018 07:59:10 -0700 (PDT)
MIME-Version: 1.0
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Sat, 25 Aug 2018 22:58:57 +0800
Message-ID: <CAKwiv-gK1wxw57TVK7GXe3bfkr=0eCS9zn7F_mZRYUL+2Ovr9w@mail.gmail.com>
Subject: Peer bridge fixup issue under multiple pci domain
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I'm trying to use multiple pci domain in qemu q35, but I find there
might be some issues in peer bridge fixup.

In short, pcibios_fixup_peer_bridges function assumes only one pci
domain (0) by default. This is OK when as qemu by default uses only
one pci domain too. However, if I add another host bridge which is
put into pci domain 1 by using _SEG, and a pcie_pci_bridge is attached
to the bus 1 under this new pci domain 1 rather than domain 0, the
kernel will recognize the bus 01 differently.

More specifically, pcibios_fixup_peer_bridges only reads all the buses
under domain 0 but it can read the pci bus 01 in pci domain 1 and treat
it as a peer bus of 0000:00. The consequence is this 01 bus is recognized
as 0000:01, but it should have been recognized as 0001:01.

The host bus 0001:00 can be recognized so I guess pcibios_fixup_peer_bridges
needs updating to take care of multiple domains? Or is it just an bios issue?
I'm not quite sure and I'm open to any suggestions.

Thanks,
Ziahn

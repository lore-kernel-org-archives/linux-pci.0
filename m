Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:52679 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754906AbdJJD7C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2017 23:59:02 -0400
Received: by mail-oi0-f49.google.com with SMTP id p126so43087812oih.9
        for <linux-pci@vger.kernel.org>; Mon, 09 Oct 2017 20:59:02 -0700 (PDT)
To: bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Jon Mason <jon.mason@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: pci_bus warnings about adjacent RW1C bits w/ iproc-pci
Message-ID: <fbda4c0b-8db7-bc93-3bc7-6bac577c4f07@gmail.com>
Date: Mon, 9 Oct 2017 20:58:59 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

With 4.14-rc3 on a BCM5301x device I am seeing the following PCI core
warnings using pcie_iproc; is this something to be worried about?

[    2.626059] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00



[    2.632358] pci_bus 0000:00: root bus resource [mem
0x08000000-0x0fffffff]


[    2.639207] pci_bus 0000:00: No busn resource found for root bus,
will use [bus 00-ff]


[    2.647188] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits


[    2.656838] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits


[    2.666565] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4c may corrupt adjacent RW1C bits


[    2.676524] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x3e may corrupt adjacent RW1C bits


[    2.686270] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits


[    2.695903] pci_bus 0000:00: 1-byte config write to 0000:00:00.0
offset 0xc may corrupt adjacent RW1C bits


[    2.705531] PCI: bus0: Fast back to back transfers disabled



[    2.711086] pci 0000:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring


[    2.719076] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x3e may corrupt adjacent RW1C bits


[    2.728796] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0xc8 may corrupt adjacent RW1C bits


[    2.738513] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x3e may corrupt adjacent RW1C bits


[    2.748225] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x3e may corrupt adjacent RW1C bits


[    2.758262] pci 0000:01:00.0: enabling Extended Tags



[    2.763577] PCI: bus1: Fast back to back transfers disabled



[    2.769205] pci 0000:00:00.0: BAR 8: assigned [mem
0x08000000-0x080fffff]


[    2.776017] pci 0000:01:00.0: BAR 0: assigned [mem
0x08000000-0x08003fff 64bit]


[    2.783338] pci 0000:00:00.0: PCI bridge to [bus 01]



[    2.788293] pci 0000:00:00.0:   bridge window [mem
0x08000000-0x080fffff]


[    2.911536] pcie_iproc_bcma bcma0:8: link: UP



[    2.916052] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00



[    2.922349] pci_bus 0001:00: root bus resource [mem
0x40000000-0x47ffffff]


[    2.929200] pci_bus 0001:00: No busn resource found for root bus,
will use [bus 00-ff]


[    2.937482] PCI: bus0: Fast back to back transfers disabled



[    2.943075] pci 0001:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring


[    2.951713] PCI: bus1: Fast back to back transfers disabled



[    2.957354] pci 0001:00:00.0: BAR 8: assigned [mem
0x40000000-0x400fffff]


[    2.964166] pci 0001:01:00.0: BAR 0: assigned [mem
0x40000000-0x40007fff 64bit]


[    2.971461] pci 0001:00:00.0: PCI bridge to [bus 01]



[    2.976434] pci 0001:00:00.0:   bridge window [mem
0x40000000-0x400fffff]
-- 
Florian

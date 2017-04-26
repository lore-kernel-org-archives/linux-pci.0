Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35071 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032204AbdDZW4K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2017 18:56:10 -0400
Received: by mail-oi0-f50.google.com with SMTP id j201so18771670oih.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Apr 2017 15:56:10 -0700 (PDT)
MIME-Version: 1.0
From: Kyle Gale <kylewgale@gmail.com>
Date: Wed, 26 Apr 2017 15:56:09 -0700
Message-ID: <CAEhpy_c96xmviS8fE4rMDeK9dPiSLhTrW_MQNtdkKXkwoU8PEg@mail.gmail.com>
Subject: PCI Rescan Question
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,



Can someone help me understand why I need to remove my stale PCI
device files from the tree if I want to properly get my device
re-initialized after unplugging and reinserting?



For example, I turn on my system with my PCI device plugged in. All is
fine. I unplug it, plug it back in, and rescan (echo 1 >
/sys/bus/pci/devices/rescan) and end up in this state where my BAR0 is
not set, and other things are not entirely correct.



But if I do a remove (echo 1 > /sys/bus/pci/devices/xxxx/xx.x/remove)
of the port, it then properly re-initializes my device when I do a
rescan.



Why does it not suffice to simply do a rescan? Does the rescan skip
some step if it finds that the device is already in the PCI tree? It's
not as if the rescan completely skips the device if I don't do a
remove, it just doesn't do all of the initialization.



Thanks,

Kyle Gale

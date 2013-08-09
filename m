Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:45918 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab3HIRTN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 13:19:13 -0400
Received: by mail-ie0-f171.google.com with SMTP id 10so4520600ied.2
        for <linux-pci@vger.kernel.org>; Fri, 09 Aug 2013 10:19:12 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 9 Aug 2013 11:18:51 -0600
Message-ID: <CAErSpo53L3-feEw0qZvBTmRrY+SXpGrGU6oxZg3wVjH1M8JDXg@mail.gmail.com>
Subject: 3.11-rc4 ixgbevf: endless "Last Request of type 00 to PF Nacked" messages
To: "e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When I enable VFs via sysfs on an Intel X540-AT, I see an endless stream of

    ixgbevf 0000:08:10.2: Last Request of type 03 to PF Nacked

messages.  This on an HP z420 with the Intel X540-AT in external Magma
PCIe expansion chassis.  No cable is attached to the X540-AT.

ixgbe is built as a module and is auto-loaded during boot, with no VFs
enabled.  The "Last request Nacked" messages start when I enable VFs
with:

    # echo -n 8 > /sys/bus/pci/devices/0000:08:00.0/sriov_numvfs
    ixgbe 0000:08:00.0 eth1: SR-IOV enabled with 8 VFs
    pci 0000:08:10.0: [8086:1515] type 00 class 0x020000
    pci 0000:08:10.2: [8086:1515] type 00 class 0x020000
    ...
    ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network
Driver - version 2.7.12-k
    ...
    ixgbevf 0000:08:10.2: Last Request of type 03 to PF Nacked
    ...

This happens with v3.11-rc4, v3.10, and v3.9, which is as far back as
I checked.  Complete console log and lspci output are here:

    http://helgaas.com/linux/ixgbe/z420.log
    http://helgaas.com/linux/ixgbe/lspci

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35025 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdA1L21 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jan 2017 06:28:27 -0500
Received: by mail-yw0-f175.google.com with SMTP id l19so206193497ywc.2
        for <linux-pci@vger.kernel.org>; Sat, 28 Jan 2017 03:28:26 -0800 (PST)
MIME-Version: 1.0
From: Kevin Wilson <wkevils@gmail.com>
Date: Sat, 28 Jan 2017 13:28:25 +0200
Message-ID: <CAGXs5wVy0CPQB_NCsM+sSny4wj61p-gRAsTVbdSi_6drmz6TGg@mail.gmail.com>
Subject: Virtual functions numbering (SRIOV) - why odd numbers are not used ?
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,
I had noticed that whenever I create virtual function on Nic devices,
the numbering scheme is the same:
the the last digit of first VF is .0, of the second one is .2, the
third is .4, and so on; and no odd number are used.

For example, with Intel IXGBE nic, we have:


echo 4 > /sys/bus/pci/devices/0000:06:00.0/sriov_numvfs

lspci | grep "Virtual Function"
06:10.0 Ethernet controller: Intel Corporation 82599 Ethernet
Controller Virtual Function (rev 01)
06:10.2 Ethernet controller: Intel Corporation 82599 Ethernet
Controller Virtual Function (rev 01)
06:10.4 Ethernet controller: Intel Corporation 82599 Ethernet
Controller Virtual Function (rev 01)
06:10.6 Ethernet controller: Intel Corporation 82599 Ethernet
Controller Virtual Function (rev 01)

Does anybody know what is the reason that odd numbers are not used ?
are they kept for something else ?
For example, why don't we get : 06:10.0,06:10.1,06:10.2,06:10.3 in this case ?

Regards,
Kevin

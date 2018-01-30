Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41829 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeA3Ic5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 03:32:57 -0500
Received: from mail-pg0-f69.google.com ([74.125.83.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1egRLc-00073d-9h
        for linux-pci@vger.kernel.org; Tue, 30 Jan 2018 08:32:56 +0000
Received: by mail-pg0-f69.google.com with SMTP id o11so7123273pgp.14
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2018 00:32:56 -0800 (PST)
From: Kai Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Thunderbolt PCIe card doesn't get enumerated at cold boot
Message-Id: <8831781F-8027-4875-AF82-835FBE40F5F0@canonical.com>
Date: Tue, 30 Jan 2018 16:32:51 +0800
Cc: linux-pci@vger.kernel.org, Ethan Hsieh <ethan.hsieh@canonical.com>
To: Mika Westerberg <mika.westerberg@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika,

Bother you again because you are the only TBT expert that I know of ;)

We are enabling a new CFL desktop with TBT card.
The TBT card in question doesn’t get enumerated at cold boot, so the card isn’t listed under `lspci`.
Anything that does a PCI scan (# echo 1 > /sys/bus/pci/rescan, S3, warmboot) can make the card gets detected correctly.

The same TBT card doesn’t have the issue on a KBL desktop, so I not sure if it’s a driver issue though.

Also, is there a more appropriate mailing list for TBT discussion?

Kai-Heng

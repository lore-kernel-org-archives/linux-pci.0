Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr1-f43.google.com ([209.85.221.43]:34362 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeHBUF2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2018 16:05:28 -0400
Received: by mail-wr1-f43.google.com with SMTP id c13-v6so3055833wrt.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Aug 2018 11:13:14 -0700 (PDT)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Problem with 4cec16861a40 ("PCI/ASPM: Convert to use match_string()
 helper")
Message-ID: <56e85d14-786d-02b9-b816-7e8c6cecc254@gmail.com>
Date: Thu, 2 Aug 2018 20:13:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I wondered why my system gets warmer than usual and eventually found that
every write to /sys/module/pcie_aspm/parameters/policy returns EINVAL.

Reason is mentioned change, using match_string() is wrong when used with
sysfs because sysfs strings have a trailing newline. Seems like the patch
wasn't tested.
__sysfs_match_string() has to be used instead. I checked and this fixes
the issue. 

Rgds, Heiner

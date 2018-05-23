Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:43430 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933144AbeEWRsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 13:48:23 -0400
Received: by mail-pf0-f181.google.com with SMTP id j20-v6so10861737pff.10
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2018 10:48:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: bhelgaas@google.com, kys@microsoft.com, haiyangz@microsoft.com,
        lorenzo.pieralisi@arm.com
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH 0/3] PCI: hv: cleanup patches
Date: Wed, 23 May 2018 10:11:11 -0700
Message-Id: <20180523171114.5136-1-sthemmin@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are minor code cleanups found while reviewing and implementing
other things in Hyper-V PCI host driver.

Stephen Hemminger (3):
  PCI: hv: remove unused reason for refcount handler
  PCI: hv: convert remove_lock to refcount
  PCI: hv: use list_for_each_entry

 drivers/pci/host/pci-hyperv.c | 105 ++++++++++++----------------------
 1 file changed, 37 insertions(+), 68 deletions(-)

-- 
2.17.0

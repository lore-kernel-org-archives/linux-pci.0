Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:49358 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbaANRPQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 12:15:16 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so747975iec.13
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 09:15:15 -0800 (PST)
Received: from localhost ([172.29.122.186])
        by mx.google.com with ESMTPSA id ft2sm2087388igb.5.2014.01.14.09.15.14
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jan 2014 09:15:15 -0800 (PST)
Subject: [PATCH 0/2] Trivial cleanups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 14 Jan 2014 10:15:14 -0700
Message-ID: <20140114171308.9148.47907.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change in these.  One is just whitespace (this accounts
for all the line deletions), and the other changes "#ifndef ... #else ...
#endif" to the positive form "#ifdef ... #else ... #endif".

I plan these for v3.14 unless there are objections.

---

Bjorn Helgaas (2):
      PCI: Reorder so actual code comes before stubs
      PCI: Cleanup pci.h whitespace


 drivers/pci/pci-label.c |   57 ++++------
 include/linux/pci.h     |  266 ++++++++++++-----------------------------------
 2 files changed, 93 insertions(+), 230 deletions(-)

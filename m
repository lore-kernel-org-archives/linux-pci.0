Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:39194 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab2FUAQe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 20:16:34 -0400
Received: by yenl3 with SMTP id l3so9487yen.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:34 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id E6AAC1E0043
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:33 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 9D624180181
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:33 -0700 (PDT)
Subject: [PATCH 0/6] Coverity and trivial fixes
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 20 Jun 2012 18:16:33 -0600
Message-ID: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These fix a few issues reported by the Coverity checker and a trivial
style issue (__weak).

Only two should have interesting effects:

  - The OBFF/LTR enable functions should panic without this fix, so
    I don't think they've ever been tested.

  - The P2P bridge I/O window fix doesn't affect x86, which never uses
    32-bit I/O decoding.  But other architectures might notice because
    we incorrectly sign-extended I/O port addresses of 0x80000000 and
    above.

I'll wait for comments before putting them in "next" (targeted for 3.6).
---

Bjorn Helgaas (6):
      PCI: use __weak consistently
      PCI: fix upstream P2P bridge checks when enabling OBFF and LTR
      PCI: fix P2P bridge I/O port window sign extension
      PCI: shpchp: remove dead code
      PCI: acpiphp: check whether _ADR evaluation succeeded
      PCI: remove useless pcix_set_mmrbc() dev->bus check


 drivers/pci/hotplug/acpiphp_glue.c |   13 +++++++++----
 drivers/pci/hotplug/shpchp_ctrl.c  |    3 ---
 drivers/pci/pci-sysfs.c            |    2 +-
 drivers/pci/pci.c                  |   15 +++++++--------
 drivers/pci/probe.c                |   18 ++++++++++--------
 5 files changed, 27 insertions(+), 24 deletions(-)

-- 
Bjorn

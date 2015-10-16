Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36475 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbbJPTHv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2015 15:07:51 -0400
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Markus Elfring <elfring@users.sourceforge.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
	CYGNUS/IPROC ARM ARCHITECTURE),
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM CYGNUS/IPROC
	ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: iproc: Fix company name
Date: Fri, 16 Oct 2015 12:04:04 -0700
Message-Id: <1445022248-12203-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The header of pcie-iproc.c contains an obvious typo on Broadcom
Corporation, fix that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/host/pcie-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index fe2efb141a9b..6c3d4b54858c 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2014 Hauke Mehrtens <hauke@hauke-m.de>
- * Copyright (C) 2015 Broadcom Corporatcommon ion
+ * Copyright (C) 2015 Broadcom Corporation
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
-- 
2.1.0


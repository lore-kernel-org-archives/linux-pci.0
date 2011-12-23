Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59910 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab1LWAd6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Dec 2011 19:33:58 -0500
Received: by qadc12 with SMTP id c12so4696863qad.19
        for <linux-pci@vger.kernel.org>; Thu, 22 Dec 2011 16:33:58 -0800 (PST)
Message-ID: <4EF3CC64.40705@gmail.com>
Date: Fri, 23 Dec 2011 01:33:40 +0100
From: Christian Inci <chris.pcguy.inci@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: [PATCH] fix for a bash issue regarding a variable in update-pciids
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From f9d728aa77fc53189f750286b327361a707f0533 Mon Sep 17 00:00:00 2001
From: Christian Inci <chris.pcguy.inci@gmail.com>
Date: Fri, 23 Dec 2011 01:13:16 +0100
Subject: [PATCH] fix for a bash issue regarding a variable in update-pciids
 At least some bash versions can and will complain about an
 empty PCI_COMPRESSED_IDS variable, when it get used in the
 'if'-statement.

e.g. with a message like:
  "/usr/sbin/update-pciids: line 18: [: : integer expression expected"

Signed-off-by: Christian Inci <chris.pcguy.inci@gmail.com>
---
 update-pciids.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/update-pciids.sh b/update-pciids.sh
index 5e77109..708e3b3 100755
--- a/update-pciids.sh
+++ b/update-pciids.sh
@@ -5,7 +5,7 @@
 set -e
 SRC="http://pciids.sourceforge.net/v2.2/pci.ids"
 DEST=pci.ids
-PCI_COMPRESSED_IDS=
+PCI_COMPRESSED_IDS=0
 GREP=grep
 
 # if pci.ids is read-only (because the filesystem is read-only),
-- 
1.7.7.4

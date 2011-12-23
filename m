Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39562 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab1LWRN5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Dec 2011 12:13:57 -0500
Received: by qcqz2 with SMTP id z2so5677190qcq.19
        for <linux-pci@vger.kernel.org>; Fri, 23 Dec 2011 09:13:56 -0800 (PST)
Message-ID: <4EF4B6C9.3090803@gmail.com>
Date: Fri, 23 Dec 2011 18:13:45 +0100
From: Christian Inci <chris.pcguy.inci@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: [PATCH]: fix for a bash issue regarding a variable in update-pciids
 (try 2)
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From ced082632d496645736f245b6a6482bdbf267579 Mon Sep 17 00:00:00 2001
From: Christian Inci <chris.pcguy.inci@gmail.com>
Date: Fri, 23 Dec 2011 17:24:56 +0100
Subject: [PATCH]: fix for a bash issue regarding a variable ... (try 2)
 in update-pciids At least some bash versions can and
 will complain about an  empty PCI_COMPRESSED_IDS variable,
 when it get used in the  'if'-statement.

Try 2: change the comparison operand instead of the value.
 Many thanks to Martin Mares <mj@ucw.cz> for the hint.

Signed-off-by: Christian Inci <chris.pcguy.inci@gmail.com>
---
 update-pciids.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/update-pciids.sh b/update-pciids.sh
index 5e77109..51397f1 100755
--- a/update-pciids.sh
+++ b/update-pciids.sh
@@ -15,7 +15,7 @@ if ! touch ${DEST} >/dev/null 2>&1 ; then
 	exit 1
 fi
 
-if [ "$PCI_COMPRESSED_IDS" -eq 1 ] ; then
+if [ "$PCI_COMPRESSED_IDS" == 1 ] ; then
 	DECOMP="cat"
 	SRC="$SRC.gz"
 	GREP=zgrep
-- 
1.7.7.4

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:60422 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbcFTEVq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 00:21:46 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] configure: use simpler/more portable echo_n
Date: Mon, 20 Jun 2016 00:21:38 -0400
Message-Id: <1466396498-17870-1-git-send-email-vapier@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The `echo -n` behavior is not in POSIX and not all shells support it.
Use the portable `printf` func as defined by POSIX.
---
 lib/configure | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/configure b/lib/configure
index 7d4cec85fd2c..363f5b486c07 100755
--- a/lib/configure
+++ b/lib/configure
@@ -6,12 +6,7 @@ LC_ALL=C
 export LC_ALL
 
 echo_n() {
-	if [ -n "$BASH" ]
-	then
-		echo -n "$*"
-	else
-		echo "$*\c"
-	fi
+	printf '%s' "$*"
 }
 
 if [ -z "$VERSION" -o -z "$IDSDIR" ] ; then
-- 
2.8.2


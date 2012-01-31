Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53795 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340Ab2AaPul (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 31 Jan 2012 10:50:41 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org, Marek Cruz <programatorfreez@gmail.com>
Subject: [PATCH] lib/configure: match all freebsd os's
Date: Tue, 31 Jan 2012 10:50:47 -0500
Message-Id: <1328025047-6811-1-git-send-email-vapier@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Marek Cruz <programatorfreez@gmail.com>

When using targets like "i686-pc-freebsd7.1", the configure script fails
to match for the freebsd target because it only expects "freebsd".  Add
a glob to match all freebsd targets.
---
 lib/configure |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/configure b/lib/configure
index 4ae20d4..ec8eca3 100755
--- a/lib/configure
+++ b/lib/configure
@@ -86,7 +86,7 @@ case $sys in
 		esac
 		echo >>$c '#define PCI_HAVE_STDINT_H'
 		;;
-	freebsd)
+	freebsd*)
 		echo_n " fbsd-device"
 		echo >>$c '#define PCI_HAVE_PM_FBSD_DEVICE'
 		echo >>$c '#define PCI_PATH_FBSD_DEVICE "/dev/pci"'
-- 
1.7.8.4


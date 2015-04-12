Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:34485 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbbDLHSj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 12 Apr 2015 03:18:39 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id A132525AF53D
	for <linux-pci@vger.kernel.org>; Sun, 12 Apr 2015 09:18:37 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lPkvd26M1z5vMw
	for <linux-pci@vger.kernel.org>; Sun, 12 Apr 2015 09:18:36 +0200 (CEST)
Date: Sun, 12 Apr 2015 09:16:28 +0200
From: Felix Janda <felix.janda@posteo.de>
To: linux-pci@vger.kernel.org
Subject: [PATCH pciutils] lib/configure: Also accept host tuples without
 vendor string
Message-ID: <20150412071628.GA2166@euler>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Based on patch from
https://bugs.gentoo.org/show_bug.cgi?id=425022
---
 lib/configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/configure b/lib/configure
index 3783f57..7d4cec8 100755
--- a/lib/configure
+++ b/lib/configure
@@ -44,7 +44,7 @@ if [ -z "$HOST" ] ; then
 fi
 [ -n "$RELEASE" ] && rel="${RELEASE}"
 # CAVEAT: tr on Solaris is a bit weird and the extra [] is otherwise harmless.
-host=`echo $HOST | sed -e 's/^\([^-]*\)-\([^-]*\)-\([^-]*\)-\([^-]*\)$/\1-\3/' -e 's/^\([^-]*\)-\([^-]*\)$/\1--\2/' | tr '[A-Z]' '[a-z]'`
+host=`echo $HOST | sed -e 's/^\([^-]*\)-\([^-]*\)-\([^-]*\)-\([^-]*\)$/\1-\3/' -e 's/^\([^-]*\)-\([^-]*\)-\([^-]*\)$/\1-\2/' -e 's/^\([^-]*\)-\([^-]*\)$/\1--\2/' | tr '[A-Z]' '[a-z]'`
 cpu=`echo $host | sed 's/^\([^-]*\)-\([^-]*\)-\(.*\)$/\1/'`
 sys=`echo $host | sed 's/^\([^-]*\)-\([^-]*\)-\(.*\)$/\3/'`
 echo " $host $rel $cpu $sys"
-- 
2.0.5

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33615 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbbE1S6X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2015 14:58:23 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: corbet@lwn.net, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
	gnomes@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org,
	jkosina@suse.cz, bhelgaas@google.com, linux-pci@vger.kernel.org,
	xen-devel@lists.xenproject.org, bp@suse.de,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH] Documentation: extend use case for EXPORT_SYMBOL_GPL()
Date: Thu, 28 May 2015 11:56:01 -0700
Message-Id: <1432839361-10308-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Current documentation over use case for EXPORT_SYMBOL_GPL()
only acknowledges functions which are "an internal implementation
issue, and not really an interface". In practice these days
though we have some maintainers taking on preferences to require
all new functionality go in with EXPORT_SYMBOL_GPL().

A maintainer asking developers to use EXPORT_SYMBOL_GPL()
for new functionality tends to be a well accepted and understood
position that maintainers can take and typically requires the
maintainers educating contributing developers on their own
positions and requirements.

Developers who submit code to maintainers not familiar with
these preferences as optional for new functionality need explicit
guidence though as existing documentation does not acknowledge
this as a valid possibility. Without this being documented some
maintainers are reluctant to accept new functionality with
EXPORT_SYMBOL_GPL().

This extends the use case documentation for EXPORT_SYMBOL_GPL()
to acknowledge acceptance for new functionality.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 Documentation/DocBook/kernel-hacking.tmpl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/DocBook/kernel-hacking.tmpl b/Documentation/DocBook/kernel-hacking.tmpl
index e84f094..19e0c88 100644
--- a/Documentation/DocBook/kernel-hacking.tmpl
+++ b/Documentation/DocBook/kernel-hacking.tmpl
@@ -954,6 +954,8 @@ printk(KERN_INFO "my ip: %pI4\n", &amp;ipaddress);
     <function>MODULE_LICENSE()</function> that specifies a GPL
     compatible license.  It implies that the function is considered
     an internal implementation issue, and not really an interface.
+    Some maintainers and developers may however have a preference to
+    require EXPORT_SYMBOL_GPL() when adding any new APIs or functionality.
    </para>
   </sect1>
  </chapter>
-- 
2.3.2.209.gd67f9d5.dirty


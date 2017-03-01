Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:16647 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750725AbdCAKDr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2017 05:03:47 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>
Subject: [PATCH] pcieaer doc: update the link
Date: Wed, 1 Mar 2017 17:05:28 +0800
Message-ID: <1488359128-7917-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The original link is empty, replace it.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
The new link is the only one I can find in kernel.org.

 Documentation/PCI/pcieaer-howto.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
index ea8cafba255c..acd0dddd6bb8 100644
--- a/Documentation/PCI/pcieaer-howto.txt
+++ b/Documentation/PCI/pcieaer-howto.txt
@@ -256,7 +256,7 @@ After reboot with new kernel or insert the module, a device file named
 
 Then, you need a user space tool named aer-inject, which can be gotten
 from:
-    http://www.kernel.org/pub/linux/utils/pci/aer-inject/
+    https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
 
 More information about aer-inject can be found in the document comes
 with its source code.
-- 
2.1.0

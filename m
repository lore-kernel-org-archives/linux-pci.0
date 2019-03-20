Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63720C4360F
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4240721873
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfCTSuS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:50:18 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.250]:48851 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727490AbfCTSuP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2019 14:50:15 -0400
X-Greylist: delayed 1357 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 14:50:15 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 9EF271693F1
        for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2019 13:27:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 6fw8hBBzF2qH76fw8hcEYy; Wed, 20 Mar 2019 13:27:36 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.39] (port=59010 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h6fvo-002lYt-Gh; Wed, 20 Mar 2019 13:27:35 -0500
Date:   Wed, 20 Mar 2019 13:27:15 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] PCI: Mark expected switch fall-throughs
Message-ID: <20190320182715.GA9406@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.104.39
X-Source-L: No
X-Exim-ID: 1h6fvo-002lYt-Gh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.39]:59010
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/pci/proc.c: In function ‘proc_bus_pci_ioctl’:
drivers/pci/proc.c:216:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (arch_can_pci_mmap_wc()) {
      ^
drivers/pci/proc.c:225:2: note: here
  default:
  ^~~~~~~

drivers/pci/xen-pcifront.c: In function ‘pcifront_backend_changed’:
drivers/pci/xen-pcifront.c:1105:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (xdev->state == XenbusStateClosed)
      ^
drivers/pci/xen-pcifront.c:1108:2: note: here
  case XenbusStateClosing:
  ^~~~

Notice that, in this particular case, the /* fall through */
comment is placed at the very bottom of the case statement,
which is what GCC is expecting to find.

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pci/proc.c         | 1 +
 drivers/pci/xen-pcifront.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 6fa1627ce08d..445b51db75b0 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -222,6 +222,7 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 		}
 		/* If arch decided it can't, fall through... */
 #endif /* HAVE_PCI_MMAP */
+		/* fall through */
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index eba6e33147a2..14cf0f41ecf0 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -1104,7 +1104,7 @@ static void __ref pcifront_backend_changed(struct xenbus_device *xdev,
 	case XenbusStateClosed:
 		if (xdev->state == XenbusStateClosed)
 			break;
-		/* Missed the backend's CLOSING state -- fallthrough */
+		/* fall through - Missed the backend's CLOSING state. */
 	case XenbusStateClosing:
 		dev_warn(&xdev->dev, "backend going away!\n");
 		pcifront_try_disconnect(pdev);
-- 
2.21.0


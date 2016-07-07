Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:51540 "EHLO
	prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030411AbcGGIKA convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:6:1>);
	Thu, 7 Jul 2016 04:10:00 -0400
Message-Id: <577E2A7702000078000FBF78@prv-mh.provo.novell.com>
Date: Thu, 07 Jul 2016 02:09:59 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: <david.vrabel@citrix.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
	<boris.ostrovsky@oracle.com>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
	"Juergen Gross" <JGross@suse.com>
Cc: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH] xen-pcifront: prefer xenbus_write() over
 xenbus_printf() where possible
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

... as being the simpler variant.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 drivers/pci/xen-pcifront.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 4.7-rc6-prefer-xenbus_write.orig/drivers/pci/xen-pcifront.c
+++ 4.7-rc6-prefer-xenbus_write/drivers/pci/xen-pcifront.c
@@ -822,8 +822,8 @@ do_publish:
 		err = xenbus_printf(trans, pdev->xdev->nodename,
 				    "event-channel", "%u", pdev->evtchn);
 	if (!err)
-		err = xenbus_printf(trans, pdev->xdev->nodename,
-				    "magic", XEN_PCI_MAGIC);
+		err = xenbus_write(trans, pdev->xdev->nodename,
+				   "magic", XEN_PCI_MAGIC);
 
 	if (err) {
 		xenbus_transaction_end(trans, 1);




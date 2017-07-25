Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:36607 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbdGYU6D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jul 2017 16:58:03 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 25 Jul 2017 14:57:42 -0600
Message-Id: <20170725205753.4735-6-logang@deltatee.com>
In-Reply-To: <20170725205753.4735-1-logang@deltatee.com>
References: <20170725205753.4735-1-logang@deltatee.com>
Subject: [PATCH v3 05/16] ntb: ntb_test: ensure the link is up before trying to configure the mws
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After the link tests, there is a race on one side of the test for
the link coming up. It's possible, in some cases, for the test script
to write to the 'peer_trans' files before the link has come up.

To fix this, we simply use the link event file to ensure both sides
see the link as up before continuning.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tools/testing/selftests/ntb/ntb_test.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index 1c12b5855e4f..5fc7ad359e21 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -333,6 +333,10 @@ function ntb_tool_tests()
 	link_test $LOCAL_TOOL $REMOTE_TOOL
 	link_test $REMOTE_TOOL $LOCAL_TOOL
 
+	#Ensure the link is up on both sides before continuing
+	write_file Y $LOCAL_TOOL/link_event
+	write_file Y $REMOTE_TOOL/link_event
+
 	for PEER_TRANS in $(ls $LOCAL_TOOL/peer_trans*); do
 		PT=$(basename $PEER_TRANS)
 		write_file $MW_SIZE $LOCAL_TOOL/$PT
-- 
2.11.0

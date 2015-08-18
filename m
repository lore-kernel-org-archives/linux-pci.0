Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12958 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbbHRTTJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 15:19:09 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	"Mark Hounschell" <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	"Will Davis" <wdavis@nvidia.com>
Subject: [PATCH v5 01/13] lib/Kconfig: add HAS_DMA_P2P for peer-to-peer support
Date: Tue, 18 Aug 2015 14:03:57 -0500
Message-ID: <1439924649-29698-2-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
References: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This option is dependent on HAS_DMA, and indicates whether or not the DMA
API should include the peer resource (P2P) interfaces.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 lib/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 3a2ef67..0b670ab 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -392,6 +392,11 @@ config HAS_DMA
 	depends on !NO_DMA
 	default y
 
+config HAS_DMA_P2P
+	bool
+	depends on HAS_DMA
+	default n
+
 config CHECK_SIGNATURE
 	bool
 
-- 
2.5.0


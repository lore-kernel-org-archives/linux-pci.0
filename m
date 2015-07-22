Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13550 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbGVVyB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2015 17:54:01 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>
CC: <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v4 01/12] lib/Kconfig: add HAS_DMA_P2P for peer-to-peer support
Date: Wed, 22 Jul 2015 16:39:46 -0500
Message-ID: <1437601197-6481-2-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
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
2.4.6


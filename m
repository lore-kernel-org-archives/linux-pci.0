Return-Path: <SRS0=ccIc=3B=linuxonhyperv.com=kys@kernel.org>
Return-Path: <SRS0=ccIc=3B=linuxonhyperv.com=kys@kernel.org>
From: kys@exchange.microsoft.com
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] pci-hyperv: Fix an atomic bug
Date: Fri, 24 Mar 2017 11:07:22 -0700
Message-Id: <1490378842-26950-3-git-send-email-kys@exchange.microsoft.com>
In-Reply-To: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
References: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
List-ID: <linux-pci.vger.kernel.org>

From: K. Y. Srinivasan <kys@microsoft.com>

The memory allocation here needs to be non-blocking.
Fix the issue.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/host/pci-hyperv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 32a16fb..85088a1 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -877,7 +877,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		hv_int_desc_free(hpdev, int_desc);
 	}
 
-	int_desc = kzalloc(sizeof(*int_desc), GFP_KERNEL);
+	int_desc = kzalloc(sizeof(*int_desc), GFP_ATOMIC);
 	if (!int_desc)
 		goto drop_reference;
 
-- 
1.7.1

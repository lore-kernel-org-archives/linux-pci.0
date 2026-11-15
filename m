Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733959;
	b=rWm7PFJ0TQGmrR/GIdNwnQugRb91F+xoSSp/olRP3YP0rOAWsauCSrLDvPtCfn0bcdnS
	 reSkcmPNGg2BL9JHky0GshWzeWFpsRjZy2ZeZOjhz6ONK4yfMHQjTm4NebzAPO2oAmjta
	 3CxqGR1dQaCk8wsNcFi+7lgWiaLh+/g2MnswI+SSnZVLCmxW/jkcK0S3bOthim5XTdhOJ
	 sAo5WU/zhPfLzisFNVAb7TWEHYSkOJTfuXHFplBKItQsMbPwZu0m1cCRnrcX97C4I1GB4
	 0SS/71xvqy/jA+gexbJR6K1GhwSnfietYblUOJ7WtYOjTTC1iXX+OLf5h7rJuPuaxVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733959;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=Ao1Pq8b1OaSUrXO5PkfeeiPu9V0SdH67hwkSQ67tD2M=;
	b=cB4sSw16QFW6uUjwbpPtF9JZgUgFywnlx5fxTw6+VsOuzsaUPUxwd96OP/bX0+6G9Nst
	 asKLhCESeH5HcIHYVQaivNHFSen00aem8enBoyGhJHLDrJklSXWeikt/5PU0vz+7S5K9C
	 GeOMlU6y9A5ZN3LtsG3iKauPFTqXwYulg3PmOxduHQpFaiZLLUyZG70BpSM9k37fgYMsJ
	 Qfg2WfrgIzwn0p1qohmLZvsrR6Xv6D1I1gG2rRwEsw9rY/X03ISVNtkAGG2iiQJbQkOv0
	 YTqkHLMXH4N0pTaw0EAgLgd3n5/bj8GBLGBr/grEnplyjqXYE0uEQgbDCCU4FnaBxPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=aPI5i9lQ;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E5C49606A31D;
	Sun, 15 Nov 2026 09:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C49606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=aPI5i9lQ
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v2] PCI/ACPI: Check the found handle in acpi_get_rc_resources()
Date: Sun, 15 Nov 2026 17:12:21 +0800
Message-ID: <20261115091221.2217-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc9.internal.baidu.com (172.31.50.19) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794733953;
	bh=Ao1Pq8b1OaSUrXO5PkfeeiPu9V0SdH67hwkSQ67tD2M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=aPI5i9lQMUrdGogMepPFA+7l2aojQR0L1HVWPN0heIpnu6BiV3Pm5y0czZjWrHFTn
	 6v1pdny1xwv+HNW6XVpTxlJbtyitDOnHWRxSjtTR8QvvqNtfAwpC9n+/DD90zXsFCa
	 xRf0BkNHwk0T1cBjgQSd84teOYHov8n0657uHaWHzAlqX0RfZVWBwQMe8NdH9p5psb
	 k0/uavGDFU2swtn7VomGQbWA6fNURD5oOjsLG2EiAXfK8VJ4RAt/9XuKLH5VMB+iHS
	 XKdFPdu/DcYO3Qy3NpRA5yIsABUJgUlFqTXyfypeAZuUn6jokcf3aMwuVYFJHNL5vH
	 heVGig3cuQJfA==

From: Li RongQing <lirongqing@baidu.com>

acpi_get_devices() returns AE_OK even when the namespace walk finishes
without a match, in which case the return_value argument is not written.
The caller passes an uninitialized acpi_handle and hands it to
acpi_fetch_acpi_dev(), which dereferences it as an ACPI node.

Initialize the handle and reject a missing match.

Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: add fixes tag

 drivers/pci/pci-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e260089..e90e749 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -82,7 +82,7 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 {
 	struct acpi_device *adev;
 	acpi_status status;
-	acpi_handle handle;
+	acpi_handle handle = NULL;
 	int ret;
 
 	status = acpi_get_devices(hid, acpi_match_rc, &segment, &handle);
@@ -92,6 +92,9 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 		return -ENODEV;
 	}
 
+	if (!handle)
+		return -ENODEV;
+
 	adev = acpi_fetch_acpi_dev(handle);
 	if (!adev)
 		return -ENODEV;
-- 
2.9.4


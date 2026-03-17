Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20E1ACEDE;
	Tue, 17 Mar 2026 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768532; cv=none; b=qGseT2U8Ec8YqLgts495fgd8PMSu9sYwRshOJSm/fTXgyjKzxBQZem0F+3GSfd/hWTV9anPYqGAjwX67X89Yl7E7nIKt6yUtbllk5IsV0MtWUFObwaInEk7c3fHddZviZRZImWDV6lWdPlX/6uObsmqnIApeiTFBCnT2eRnzzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768532; c=relaxed/simple;
	bh=h9d7/bPawQNwcHu/xABN4/PaO1ZC0/NLwiWbIa7pyh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PtQZ9L1mlr9sdYb53i9t74Z8lSGPHI/AQpiTBOPwao/ZKsNLMkaS26QMUY+N7Cm7FwBZaPuUl3CsiCHETRSsuYHFy04OmT1lKB0cyhuiz7mP9qAyhDWhalOD5ScHhzX5NQa/XgEmkFhVyHhv7HOowMpD4GKorPpsv8wG1LnbmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=DyeCBypJ; arc=none smtp.client-ip=173.38.203.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="DyeCBypJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1247; q=dns/txt;
  s=iport01; t=1773768530; x=1774978130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pOzfPu3gs4fBrf0jjNACVZNCLlgJaYe4hgDw2XPHz7U=;
  b=DyeCBypJhNvJHuUlkRj/e8YUmJIm3gHUeUC3tFHn47d2pueTamwRyAL1
   4kQ+uf8cOOE8q7LEAV9Et1HMFI+vscVolIHFzRsRsU9WsQK49a+y+frhc
   wIBiqclVlIz/ksXoQDYWa2+0YdlKW+ojolJm6u8kXQ3lrQAQ4wNRVSa9j
   lw9sn3WedB05DsbD7Ghw+TKWZcW/lrY9DctelHYEcWb7zVgYx2gE8zZV3
   kEZlGYanXbGA6HWKN4Ir0sJ6Rb0xO4DSntX96QYtWy5M5wmUHbDkBKUhT
   3zo7BmLKXqgubPDiYmiAZ11KsKAbEn8m2kh9GjJdbLP2m+5k8n45xsW+m
   w==;
X-CSE-ConnectionGUID: BsracFNLQCOwCTwhKCy5gg==
X-CSE-MsgGUID: uQNFbYaUTNC+b7RGlopKUw==
X-IPAS-Result: =?us-ascii?q?A0DwBgDDjblp/8xK/pBaHgEBCxIMgWsQDwuCRA+BUEJJt?=
 =?us-ascii?q?GiBfw8BAQEPUQQBAYUHjSQCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQEKA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4Zchl0rCwFGgUgIgwKCdAO6UoF5M4EBhHyzJIFkAQsUA?=
 =?us-ascii?q?YE4jVWFbicVBn2BEIQHdoUQhXcEgzCTCkiBHgNZLAFVEw0KCwcFgWYDNRIqF?=
 =?us-ascii?q?W4yHYEjPheBCxsHBYQkD4htdG2BE4NzAwsYDUgRLDcUGwQ+bgeNVzyCNHsTl?=
 =?us-ascii?q?iGSKJ5NgkSEJqFYGjOqagEuh1wvkE2kWYRogWg8gVlNIxWDIlIZD9hJOzU9A?=
 =?us-ascii?q?gcCBw0DC5NlAQE?=
IronPort-Data: A9a23:Ct/I5KM2GVvtFP/vrR3ClsFynXyQoLVcMsEvi/4bfWQNrUp21TAOy
 GVMUWiFaa6IYWLye41yOtizoU4A7Z/SyYNjHXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeap1yFjmH+E3F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVjlV
 e/a+ZWFZgf+gmEsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQrl58R7PSq
 07rldlVz0uBl/sfIorNfoXTLiXmdoXv0T2m0RK6bUQNbi9q/UTe2o5jXBYVhNw+Zz+hx7idw
 /0V3XC8pJtA0qDkwIwgvxdk/y5WF7Zc8bTpB1yGmuuM5HHZc1jH0qhhAxRjVWEY0r4f7WBm/
 PECbTRIZReZiqfum/SwS/JngYIoK8yD0IE34y08i2uEUbB5HdaZG/miCdxwhF/cguhHEffPa
 swWYBJkbQ/LZFtEPVJ/5JcWwb7z3yCiKWEwRFS9uJMRzWLixTFN9pOuOoXvVdiNXeZogRPNz
 o7B1yGjav0AD/SVyTeB/XulncfAmiT0XI9UH7q9ntZugVuO1ikQBQcQWF+Tv/a0kAi9VshZJ
 khS/TAhxYA29Uq2XpzlVByQvnGJpFgfVsBWHul87xuCopc4+C6QC3JBSntKb8Yr8ZdtAzcrz
 VSO2djuAFSDrYGodJ5UzZ/MxRvaBMTfBTZqifMsJefd3+TenQ==
IronPort-HdrOrdr: A9a23:l39FDaN9CurSbcBcTsijsMiBIKoaSvp037Dk7SxMoHtuA66lfq
 +V8sjzuSWftN9zYgBCpTn/Asi9qBrnnPYf3WB7B9iftWfd1VdAVLsD0WMnqAeQfxEXMYVmpM
 JdT5Q=
X-Talos-CUID: 9a23:/RTgmm+Bcw3ZsHQRoYeVv2QPAMkuXFv59Vz3PGSEFmZKY6zIRlDFrQ==
X-Talos-MUID: 9a23:daU/GQb4Ti+80OBTqgbKqjtTPfpUxY/tAh83vpEBo+q5Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,126,1770595200"; 
   d="scan'208";a="51311524"
Received: from aer-l-core-03.cisco.com ([144.254.74.204])
  by aer-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Mar 2026 17:27:36 +0000
Received: from bgl-ads-6462.cisco.com (bgl-ads-6462.cisco.com [173.39.34.78])
	by aer-l-core-03.cisco.com (Postfix) with ESMTP id B8791180006E6;
	Tue, 17 Mar 2026 17:27:35 +0000 (GMT)
From: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adiyenga@cisco.com
Subject: [PATCH] PCI/AER: Fix device reference leak in aer_inject()
Date: Tue, 17 Mar 2026 22:57:32 +0530
Message-Id: <20260317172732.58053-1-adiyenga@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 173.39.34.78, bgl-ads-6462.cisco.com
X-Outbound-Node: aer-l-core-03.cisco.com

In aer_inject(), pcie_port_find_device() returns a device with an
incremented reference count. The function returns this device but never
calls put_device() to release the reference, resulting in a reference leak.

Fix this by calling put_device() after using the device in both the success
and error paths.

Fixes: 0e98db259fd8 ("PCI/AER: Reuse existing pcie_port_find_device() interface")
Signed-off-by: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
---
 drivers/pci/pcie/aer_inject.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 09bfc7194ef3..5025843157b1 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -467,11 +467,13 @@ static int aer_inject(struct aer_error_inj *einj)
 		if (!get_service_data(edev)) {
 			pci_warn(edev->port, "AER service is not initialized\n");
 			ret = -EPROTONOSUPPORT;
+			put_device(device);
 			goto out_put;
 		}
 		pci_info(edev->port, "Injecting errors %08x/%08x into device %s\n",
 			 einj->cor_status, einj->uncor_status, pci_name(dev));
 		ret = irq_inject_interrupt(edev->irq);
+		put_device(device);
 	} else {
 		pci_err(rpdev, "AER device not found\n");
 		ret = -ENODEV;
-- 
2.35.6


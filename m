Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C953ED132
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948660; cv=none; b=peferwgK0RwML2Pet4o634Qm0DNQVQdwZN5rmhcaqOmm+2jSr9vDnHGTE6pr2W8LfFKgRSNd43iUWaUeUn8PBw5TVVsUSR0uvpIoB1cOFUVdy9zBiENyz9fdhMf0d+IYgUd51ieK9qnSOGxp8Q/Qaz7kNlFXZWCrW15bE4vBn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948660; c=relaxed/simple;
	bh=N/eES/Xh/38FhKMRuW7Q6v2kLjf92GpFC2BRpl1Ud4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQe8S8UvF+GKpzPBEi0kt12DdgOLiyJgpN8tFOI3lXQeESk3fIG3lLx/6sZ4RJwUP0KG8ywRTDF/LVBCKcOShypwSTF9A4rBTkEzx71nb1nJvYH16l+UuZ8A2/NAxs19fqSxc7Sh+Qukx9K97SJkwSQnYQ7XaUQ3TPmCKiMLes4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sf5b7NfN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H9OA+HSR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sf5b7NfN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H9OA+HSR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5SH0f2408168
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=N5vIQzVWTdz2F4TNIPIiGoPdK8bGPWTisCz
	WzVjic3I=; b=Sf5b7NfNiJQTHSohskYwVmu7ZnhPhLyShbQHQplcY2QkqqIPGaj
	zBhr7cfuqZTDhHjOzuyLsrTVsgDe7EuRrL4qPmIE2+gYp4//xiUFeN/z5zBenaBA
	KBppuSduPZmTrf00Mg4U6hR+Ck3RU7FR/In+GEMofWbUxUx7NJWogJ+Ifu6VR8Au
	8WwJ0BWa/7MBv+AxISrlHt5PTWc2zKbbGHodCFrAN8V+xks2EDp3YlhYtQ8bIjAz
	0AjUvygqct8I9R548/dIX8TGUn0OdvzEvGLW9DctahTZkwrPpuYaDXRfgUXqclEp
	P/Sts/3RCH9Yw5Blp0qkdEmQOfFVNPmm6mQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80hetbwt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:17:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a90510a6d1so53292855ad.0
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774948656; x=1775553456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5vIQzVWTdz2F4TNIPIiGoPdK8bGPWTisCzWzVjic3I=;
        b=H9OA+HSRw4TRxI7CjGqTEIeiQoX7/7miajnByESfBokbRfeBuTZXaFXz2Cq3nhiJ6S
         zhm4n58Il3xwNo+2xCkPOPPuT+1NW0tZovRyCOE6T2KAbwyjCYuyuT7xniVxmJLHUSlW
         /ZYMm9DaXQFWPFw3Z2BO/Hi3s444C95O+PhUtqDjCzvWjy6z1PABANiMZl1t+0L+A0Zi
         BpMgcY+7V1efgbvbKGwXG80CS/BeFiuxNpeQcokO8kyXCXW9yGQkXcFc50/CMoFyNcub
         SaeZCmNuhWUyrHxHLC9zoyTYbNsLB/KBAx+QONYS3e+qkIFJk5qrmEr3LID9i6PAvnWz
         0Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774948656; x=1775553456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5vIQzVWTdz2F4TNIPIiGoPdK8bGPWTisCzWzVjic3I=;
        b=ZLAhiYfsKWYBq9laqMvMT5D0GnqGo56m+yxIfxUJJG0lZlvyCJj4WtbU/e7pW9Mc8u
         RubLSBGXejl4APCLT8J1BsKYlEYajoGg/HFssEnpEa9tOYAcAD07y0bHqcMOF6wxiG2Y
         7OnlxhejJaLroy9hQ71LmXW2jBqab7Vw1blVeAp6dLzGvWvDoyeOKfMCgIBQbg8Qfw+M
         6Zr0njpdl9/9J5l9rQNixHDeTsROvfWiAngAdsHVHTnz4N8zYuR6aD+P+ufWWSGftIEW
         4iv9ErzBdii5Y5Ni/UIvq9qo7DshK7RsbgMhLLm/LWBIpL8JUxX+mpSItWhLhwpBr94T
         pTNA==
X-Forwarded-Encrypted: i=1; AJvYcCWTsoCPRlEmh9S79hQiLCNGWHk2EDc3yVWgT1dRbnm1Jiye3LWoLopsPeIqwdQ5keFJgn4pn765/g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBXRKdTmbBX5qvCQaL8RxawxsCe3hecF27nRXYLsKReM4GiZZ
	vdFfD8FyTMg5QuiT6RZqDMPxfmMwfdbLhHu2eO90xMkyFq87FROcSXXDjkNJ0GPUCSsnxV8tI2z
	CYfYwuiKmafqJdN6xdV/rIFe/bwA6qUuSdAm/l1sv5CJTtoArELjpx4FeeDSBAkw=
X-Gm-Gg: ATEYQzyC9Zungvl9LVogQJ3N/PcssheuEU+88kDHo7X67XfRC13EPg/QfVGxDyVx0Jk
	NSjF5iV07+33EnKniTFN9F9TNvwJ7Zx733XTU36qORnr3XKOHBFn22wOulFP4ZjCq51x5qR8Bt3
	CiSbGe31yPekvEWIhsaTBbWam/IpEVyXfEhFAQhKV6IACAi282GQjQ0UNpKg+Auf3EiS8VZ2NeE
	T7/xRP3/C77JQhrLtYlqmoSmhjFBoMtgQ7vS7QXX8f62NReFKKA/aeEsESLsfBrZ63mggzFkxfE
	pGyXRpCnaHZq8JpBkpG+XQCVHct4IUDs/YmAbXRAr/6FuVk21pCh2yopqGQkX2krZC0tgkT8HxX
	AGBJ47GIWuSCswop3c7PjVkbT6C3v2AYIAoLobis=
X-Received: by 2002:a17:902:d60d:b0:2b2:4f43:b49a with SMTP id d9443c01a7336-2b25ef77bccmr24215075ad.22.1774948655931;
        Tue, 31 Mar 2026 02:17:35 -0700 (PDT)
X-Received: by 2002:a17:902:d60d:b0:2b2:4f43:b49a with SMTP id d9443c01a7336-2b25ef77bccmr24214735ad.22.1774948655386;
        Tue, 31 Mar 2026 02:17:35 -0700 (PDT)
Received: from work ([117.193.210.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427663acsm104909665ad.46.2026.03.31.02.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:17:34 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        John Hancock <john@kernel.doghat.io>, bjorn.forsman@gmail.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: [PATCH] Revert "PCI: Enable ACS after configuring IOMMU for OF platforms"
Date: Tue, 31 Mar 2026 14:47:27 +0530
Message-ID: <20260331091727.33552-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gb0aXAXL c=1 sm=1 tr=0 ts=69cb9131 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=vr9TklybbRi32TvS4M0W1g==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=lAgNKBcoAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hAXPUp1672zZkZ7mbzMA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-GUID: O4g0REmIGFYrcLfgk_ycEyydcIpOaVpM
X-Proofpoint-ORIG-GUID: O4g0REmIGFYrcLfgk_ycEyydcIpOaVpM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4OCBTYWx0ZWRfX+aMgNQb1iOl7
 nibZiONLt/Ktbp62Vo5ecsf/KvqR5OU12AechaL/7YuZRTtpd7czctjUNM03cjULfeLu24OUOi0
 LnYH6dfFWo0LYPLcNKlko/vlI8UjJmSb6TV5AKvBvHh0tQ4A2xRHB99O/DpyZCYjiefwXpktN+r
 sdrR92/h3/Gs3dJluCAD95Dg+CDg0LnD8k4PCyHCBcmp3pH4etsNB2ywEZpMAU9O8bs1R0nx+RI
 V6BGBqhImfBVy/xPp1adwAdd2hgKgBKLUWs2f40NbPJhqq5QuZdVNIt4ceoZeGeOawQOpl6xd6d
 JxA8gYcCdbeJg3bVX8ZM8uxpCOL1fK7GzDlUEtW6AbiQWexo3NphP7TtL2GBdSYUvviadMxyJv7
 D3eYEe5r/3VWENpYFoSIyHhqP2vIz+7/cMRPIOq/92tiHxuW8VrDRK1Y0RJbaYkW3RylKa7Yo0E
 UDVrOVhcvi90Pb7U8dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310088

This reverts commit ec494c0260bf57a6fa3aa43a91daf7a774f8bd97.

The original commit attempted to enable ACS in pci_dma_configure() prior
to IOMMU group assignment in iommu_init_device() to fix the ACS enablement
issue for OF platforms. But that assumption doesn't hold true for kernel
versions prior to v6.15, because on these older kernels,
pci_dma_configure() is called *after* iommu_init_device(). So the IOMMU
groups are already created before the ACS gets enabled. This causes the
devices that should have been split into separate groups by ACS, getting
merged into one group, thereby breaking the IOMMU isolation as reported on
the AMD machines.

So revert the offending commit to restore the IOMMU group assignment on
those affected machines. It should be noted that ACS has never really
worked on kernel versions prior to v6.15, so the revert doesn't make any
difference for OF platforms.

Reported-by: John Hancock <john@kernel.doghat.io>
Reported-by: bjorn.forsman@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221234
Fixes: b20b659c2c6a ("PCI: Enable ACS after configuring IOMMU for OF platforms")
Cc: Linux kernel regressions list <regressions@lists.linux.dev>
Link: https://lore.kernel.org/regressions/2c30f181-ffc6-4d63-a64e-763cf4528f48@leemhuis.info
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

This revert is targeted for v6.6 stable kernel.

 drivers/pci/pci-driver.c |  8 --------
 drivers/pci/pci.c        | 10 +++++++++-
 drivers/pci/pci.h        |  1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index b7a6d8a28fe9..8c941d6267a5 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1668,14 +1668,6 @@ static int pci_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
 	}
 
-	/*
-	 * Attempt to enable ACS regardless of capability because some Root
-	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
-	 * the standard ACS capability but still support ACS via those
-	 * quirks.
-	 */
-	pci_enable_acs(to_pci_dev(dev));
-
 	pci_put_host_bridge_device(bridge);
 
 	if (!ret && !driver->driver_managed_dma) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d015df77ddff..b82927905968 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1046,7 +1046,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
@@ -3823,6 +3823,14 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 void pci_acs_init(struct pci_dev *dev)
 {
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+
+	/*
+	 * Attempt to enable ACS regardless of capability because some Root
+	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
+	 * the standard ACS capability but still support ACS via those
+	 * quirks.
+	 */
+	pci_enable_acs(dev);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index dae7b98536f7..3c35aae7431f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -557,7 +557,6 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
-void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
-- 
2.51.0


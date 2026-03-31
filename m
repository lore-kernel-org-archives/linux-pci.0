Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A204344D86
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948524; cv=none; b=JS9LcCBx5sXRUfFItjXCcP3JrpeaF+FVCyzLCr10eooSuDG/Rgfv5NhafbCjDzfh2dBY80377Godmnce53+x1IBIYmWGquzMJT4Yoh8OT8ckbaTdX3sX3xNE8BiPZsCheKC4k5R0lY/zqbhQhTUibXeSpEVGY8oMBbKOTR29xFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948524; c=relaxed/simple;
	bh=wqEtTcfrnfkB1/1JAggq7TeFTa6jZH31RqJX87K/lOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atKHORbYXVrSzXz3VqCaLxDSjq+SDt3k/fbWDPHY0nOhDFIhgyJoETA5qo9P65i9v8rDCTvPcQJZ23l0H0USXtvTeGZ/tIzLnxLh9qmkDFBzMF5ShFqwRT8yexpFpVna4KtFxdPkbeHGXvgeafxbCcwyEHWDq3rvOOisyIQ1JHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a5rzIaPP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GCPgZWFq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5rzIaPP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GCPgZWFq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5s4OC2409165
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mwgbVgvQHgOopgtkJu/D2bFIW5S1SsBBybk
	+5nhk3pk=; b=a5rzIaPPWYZ/yKSPse1+2tR6kEr3RHcj7ZMNPi0t9/iUPCcSCQt
	jwi2yDN2+hCnDQAdLYG8HQGes5sHE1aUgtpgv33+EzRZSP8iFpEHAy5EsOHaRiii
	A89Xemcdb4dF+booUb0mX6SluqH5bzFHWrDuTwl+pS1JkN9/pfV0uFbKmvvQPepG
	TZsUoMR+lEg1SUvwrZ6BbJN9+J5WT0VqoEpgbV9Q9Exmrso/K9dqvxAjx/e8g3sD
	yZ3cLZhjv44SqvD0syeShb/NU5LQGLmXWZjzCbK2DJGLRXXTfcBwUQSSbBL5mJ7y
	SP0AZymxvlGKtgPfbbCyuP9B0Er1ZC0diug==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80hetbnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:15:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82c8768a704so2738371b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774948521; x=1775553321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mwgbVgvQHgOopgtkJu/D2bFIW5S1SsBBybk+5nhk3pk=;
        b=GCPgZWFqSc8uCivfhvAfTQOZQ0dX6//d7SbJXSmg97qBp7+ISnEeBaqd7i4Y1kKmt5
         e0LSehacH3XU+ketp3QIERtemhEvFfD2ZSe45SDk6VNSJrn/pWrUn4HBBMzhCLubrU5M
         rAV7Lwx2MltYRU+jtjdD4VDZjJQ1VDkx2WK7A1WuNqxajEwCyVL26U3LVuIeYKjhhWXh
         h5YfObkKdvvEK9PjX+RGF1iivnoNvVZUaUcbKpwzFoEnRvOML/p7tkAnNaRtsve+UgsK
         7sJMm0T2+Is0CfjwTY1WKpdAVOnseRAHP33AvWnKyJgDTlZQg9G3zbyQ7080dzIFfP6U
         p/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774948521; x=1775553321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwgbVgvQHgOopgtkJu/D2bFIW5S1SsBBybk+5nhk3pk=;
        b=nxb1nQJadFGbJBbcqL325Ggy7xzUFxJMKy6zM38irHXep2Sn6Gs6qM3VS/jKnul3Ge
         63kY6RwNP7TrVuJFo+KKxoPBtzfOFoMj47bb/XH9KQl8kscPDPgfHE5OhaGwtvIHRlX3
         2YO1+0d0SxmrfL9CGwdMYLb0B+WQoHROdnihjFpmUOg5hd7oCP76LyE6evopWgeUPnva
         gD6CGoiXs9A6S44o3yEr8QZ/13d4jZIA6ATfhVfSD7WbL3nXlPUy+U2oM86nMd84oFJ+
         e+Ooq06ongr2T2xlIYgjk8ReHg99xSSXsBa/YBR4YanztmaQDehnlGiAHWR4vLYfH6uY
         uOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJzREPEtRAeT0G78DV9HMTeweEyYT+bemkQ1uzNvACicG5elrIcgQ6Kz2aXadBMi9W6YpqRagkTvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFd+j6hLkx9lNW7QZg1oWwccapIzqIT4WgrlKvaa6SGWEswOf
	X0yigFYe2lacpnAn8zJWpaqin60rCOcMqHjd6h0yNZ0Ntu11e6/ijLhBl26pFqYjdEjwwdsvKoM
	Q/ywC7g0/9QV9zbfvYiw6SvfFSEp9ggtVjKetkxGinj+S+dkoG9/wfoLqMjwY9ak=
X-Gm-Gg: ATEYQzxqzRnddGwBYSys3GucNlLuYV7s3DA+dpC8n53+SI+pO7O5WUZ1E71PmaHAVMH
	Zr5yfQ6ReEyJEMnPGuIuUAPKWjMDiBk5TiYQ+7p76wk5d2uUfZFFvNslxXmFVMdWSeehE1tEwmI
	OUSp2RhwOLSaJaX0cIbyDNpmZTg8HShNknUK30OiAzxn7zZFhXwf4ZNwEgbzJuKFYov+dFkxY3d
	BcKRRNN55ATgVEh/KAGoZYwGVe7bwJ4CISO7TlFwM4p/D9ORqGa59dzfuRzpf0GqF3BOGc8dfaf
	amUPgXB+aN+BBEJaRAI7TAPT07FvArJ3/faeXVyBYYyY79JCzKvulFSIe1Bfp9em1yKXLEk1quU
	etf2mnMtg0oMQnKQ0HsY+tO4F15pOv4bOqExstSc=
X-Received: by 2002:a05:6a00:4197:b0:829:7057:b99e with SMTP id d2e1a72fcca58-82c962124bcmr13030029b3a.54.1774948520795;
        Tue, 31 Mar 2026 02:15:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:4197:b0:829:7057:b99e with SMTP id d2e1a72fcca58-82c962124bcmr13030002b3a.54.1774948520077;
        Tue, 31 Mar 2026 02:15:20 -0700 (PDT)
Received: from work ([117.193.210.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca847ff4dsm9760492b3a.23.2026.03.31.02.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:15:19 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        John Hancock <john@kernel.doghat.io>, bjorn.forsman@gmail.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: [PATCH] Revert "PCI: Enable ACS after configuring IOMMU for OF platforms"
Date: Tue, 31 Mar 2026 14:44:55 +0530
Message-ID: <20260331091455.30394-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gb0aXAXL c=1 sm=1 tr=0 ts=69cb90a9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=vr9TklybbRi32TvS4M0W1g==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=lAgNKBcoAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hAXPUp1672zZkZ7mbzMA:9
 a=IoOABgeZipijB_acs4fv:22 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-GUID: 4m8eeK71TszVtaXqs71P7UOWvuOujStu
X-Proofpoint-ORIG-GUID: 4m8eeK71TszVtaXqs71P7UOWvuOujStu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4NiBTYWx0ZWRfX32PvgGsrVGeM
 a6RMnAk2Ylexw2Nhdjo4212hZSqE7NkIE15sqMS5tlS+EuFJcWZRZ683ftu23kiJdUN3C999UC5
 freilLQo825m9kgy9/9L4fJ67ICszBWZXDVRC7G0J2j96tQRmo4BLXexRnmUbkETe+bgED3kZ6L
 3Lqocl3ARLI+ORkzC0jFZDrzgVywSII2Mzpkj0T42tmtKEpvbLX18irs5BoBykkX4llDLrjbxK7
 sFCRRpIOtOniY+AQEfOLFGz6jhJC0qjro//SGArPLYx4JOihXDqrKPJyl+KSBhEDR//ZqKG3ZKe
 6IQtAaofNxRWWDQBn1wspMyE5QlBISwkLU6R3M65vvvtewzTpO3aqKjTI5fFhp1ykvEHvCSulq2
 XnE85U0P8aWIyzxmwaxu/4GcN3UjnS6f/hgyTJLQhMXhTpm+hJJa9kAJ1PhTp4b2RWvfA0S38Bm
 me4JisknAYqZ/JldYBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310086

This reverts commit 5d57164c0ab0ac5c99eca49c577994bfbca70a2a.

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

This revert is targeted for v6.1 stable kernel.

 drivers/pci/pci-driver.c |  8 --------
 drivers/pci/pci.c        | 10 +++++++++-
 drivers/pci/pci.h        |  1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 8b5796a6ed5f..fe6e5f716543 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1667,14 +1667,6 @@ static int pci_dma_configure(struct device *dev)
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
index d2d6b7da8c66..0778bb09d878 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1040,7 +1040,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
@@ -3777,6 +3777,14 @@ bool pci_acs_path_enabled(struct pci_dev *start,
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
index 0debf921a9fe..85488bc8e779 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -526,7 +526,6 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
-void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
-- 
2.51.0


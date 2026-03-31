Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF83DCDA4
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948232; cv=none; b=D3uMkJ/CevFwrEzKFyX2cbPPBmkyX5xDxxmeZtLwGViqt93PhbNjHRQk+LrJg41cBlUWwKMam+jxbIgZKrUwL1m9z/ShFr2JUFCQC5yVVAMSBepgOTPj7elJRduTkTLBsxIJiO8o/3iTXeJF4273Bmh+1pMEDNxBAHrHxQM88gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948232; c=relaxed/simple;
	bh=+fcgrokixlEbcf+aOsmiZdoomim6YGRO5kT5k3+jI7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgEKU+IkF2RKK2883erj3boaCCPh9FUx+yOXeDcmlc7lGQvaTKxkszuXuPq7dRv0yBnpgsAyMRKIdtOZTBDFdW3/fvd5C6hBNpDz2Fw2BPQDXgF832HWHUpCzL9RLRKV81Hu/DYKj5iUm9vCLslq/+u43sA26oO09iReLEDUqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i+BvmIya; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jjzj3mS1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i+BvmIya";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jjzj3mS1"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V914Cm2761401
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fcs5ftBhXtYRcqqz+HI3Ln1If1xisAux+zA
	c7yob4so=; b=i+BvmIyaeE18u15CE/47Qr73cjIGc8PTRv4o79eFGzPG2yvFM6m
	rKR4wsLmVtIinwoDhT9cl5qlLrpXDVMnNsUttiZfIoC1jaHNrdEBKOYFLO/aiZul
	OQn1X2FeP6ZAkrzjuJdtRZz1RENybJsJU4cxd6/Sjm/CKrZnNijdnJm+e8Uo5rLF
	VBOcUv3bPL3z3QD6rrZeeMtpjChRm0cqA1PL2MLqZqrt8IzIiX+r9putRxu0Suhr
	UYvhaY2CVZ3rLolNTYTa7PF1qJrBqAkijjEjpnlCPluyhw3cNRnql8qRqtMNW8sh
	ewDj2ZkYvotiJ8iRpjQKlblSBamiSXwTFlA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b930168-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 09:10:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c73c065dd15so3476161a12.0
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774948229; x=1775553029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcs5ftBhXtYRcqqz+HI3Ln1If1xisAux+zAc7yob4so=;
        b=jjzj3mS1NGrRYeTnU7zTB5PZ+3lYBhnE+iAO6cjX0UQHudV6sBm/kiq9eoiDapYEEY
         U9u1ol9Tc9V6PjAhWWXbnM8Ibgf4wmUQ/W6j1jFu6taDSjroxWX0esrKDDSIX+DMUnFd
         FuNKd6fhms1js0Nw2GWdTqARPWXAKpdYulpkJz5Bkn+/hI74UmZWeEpm52sPWKnetOmd
         kYYlg+IWaoLD8Rtvcuu6SWMH2fMp/oTytpdCxu/mAZUy08FNntpdOQ37ccOBKTPDWWms
         +btYW9rIPM0JVRABPpOudWZpZ7hcjiDmnHefxqA+JwZgKtVaWQkfekeQ4yll0qVqfxvK
         JEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774948229; x=1775553029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcs5ftBhXtYRcqqz+HI3Ln1If1xisAux+zAc7yob4so=;
        b=bO7c4tX8XgwszCE8GqW6K6PXG05L0FmFlojOO40hXEIx24UyoA8nn/E5hiKnKPMQQt
         u8QsiCNnWN1QhIjwzut7MSh37XDMkAkP2jDev4Nq6caxNqQkMRu5BrYK2h9KdfxSDE9R
         yAIcAlkWYfNQBs2Quz7ikeiUhSr7MADrm6K5UCATAj6b2NOJcuoc5V18PFh5i3jaqRrP
         rw+RnBrjnauXzUP2cxeT79KnEUhd7v5nS+eg8eMxaaKW33JUFsEyaBefdnWsK+EC/8CJ
         Sm00wVLmD/fX2AznKHUwO9IhIh1YUEbr3yHMfMgYn3z/GJH2DsnKwbyN5Q0v9VKIz0tu
         PbJA==
X-Forwarded-Encrypted: i=1; AJvYcCX+tmBQL5N6qZwUHguoZLxS7fr9wEAKnkTjf0krLkKqcYzWbBNIrlxdNKmIqppv940bSeBPwBSl2F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8u5UFa/ipzziVxPLJAGv5U4g2muY6PighWtgVwa8DgFq7QVTk
	g1itjROiptW4u5maht9h04uD6N2sPIlZCUGxCzlWZGzydWfW3XxsNEip7Coi4ks0BR7Uz3cwlSy
	PwV1qPEZ2xX/teCHwDYeTidxE6jkO4Q7mT+U03fbdelJPM413HxBSDcXV2d+a3iM=
X-Gm-Gg: ATEYQzzU7NURYF9x1KXOpGmvJhpSwfwj990UktqzLATQTMWHNQv5i/YHEITe4hWQjF0
	rcPeuxR4Z3V6huP6ZZ7BbCO3vJpehz6rlD0J/otopcBTtmJTLjIv0/O8dNb2zZoG1WmFTjKuIUR
	sIgPSgWW4CE7WUv9ug21wLbLDNNkCTXJoDTlzN+OCfnXjf+H7jtWw9t8D5cPJlnXTmsgOVzFZdk
	fUhG9vwMITQZ/PXtCaVdeF8+8XCWsUxb981MAI28JCOB/qY+eICqt4/Dhn/4WQm/fNBEgNNj5o6
	vMmd7aCyuwaecXvAlS2P7l2Y6YKnprQomBtZHP9uZcZ55quWBAIskg2s88nztsI0RgqEae6D+5j
	ue8RfvZC+itj4v57ZMYS561LagRayELl6TyXhB74=
X-Received: by 2002:a05:6a20:7d9c:b0:38b:de3d:d542 with SMTP id adf61e73a8af0-39c87aea147mr17138846637.51.1774948229248;
        Tue, 31 Mar 2026 02:10:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9c:b0:38b:de3d:d542 with SMTP id adf61e73a8af0-39c87aea147mr17138802637.51.1774948228605;
        Tue, 31 Mar 2026 02:10:28 -0700 (PDT)
Received: from work ([117.193.210.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cdaa4c3basm1567941b3a.37.2026.03.31.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:10:28 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        John Hancock <john@kernel.doghat.io>, bjorn.forsman@gmail.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: [PATCH] Revert "PCI: Enable ACS after configuring IOMMU for OF platforms"
Date: Tue, 31 Mar 2026 14:40:09 +0530
Message-ID: <20260331091009.19536-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4NyBTYWx0ZWRfX9wg8Dff2B9NG
 9x6DsTN88jIql0rwhBRfG+umbgDMHyY4OAJdGDmFP6JHE62q+gwJHXhWShc/T/COjDJcP5feJoa
 IFBIuXvN1ujF1x2RV9zOvgLjVzzn/Lo8lk9PWZdF7UDa/65KwSVD8Lzm9+Qp4o0lWQ2t1EuSwRq
 /Wt4e5B4mJQtgVkdl3RLvMqnEpLHrBSkIqxm0Tl0NHT9ATsrrOYt8zrD9uHDTgQKzsYOExTerMa
 G/LsqXxrHIavW3Ezg2mbSRKyGLyXKasPOjBb5GjM8FeHv5a/7Yx4W10docxx0uLT3bkXMP3okUi
 pIqYHVlRccXW8xS3i0AIUEEmry3V5RFCoyNr/NCgYONJDJIzmCLNd+kBbdc+y0hxkpHf5xIqiOG
 +hv6jwwZgVbAHNpCU0VoSLV9tFuk7NVkZriSXbPpGDuSB7HskFDW/R23gdIzXaCsJwPvr/m1st5
 OCf3cKKdfM5JIInk53w==
X-Proofpoint-ORIG-GUID: O3flhZmCuXNoLs4fslKPQE8f0TSVY78I
X-Proofpoint-GUID: O3flhZmCuXNoLs4fslKPQE8f0TSVY78I
X-Authority-Analysis: v=2.4 cv=NLjYOk6g c=1 sm=1 tr=0 ts=69cb8f86 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=vr9TklybbRi32TvS4M0W1g==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=lAgNKBcoAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hAXPUp1672zZkZ7mbzMA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=drE6d5tx1tjNRBs8zHOc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310087

This reverts commit b20b659c2c6a072560b360feda81ae52176034df.

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

This revert is targeted for v5.15 stable kernel.

 drivers/pci/pci-driver.c |  8 --------
 drivers/pci/pci.c        | 10 +++++++++-
 drivers/pci/pci.h        |  1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index ecbe382b56be..08c985478b8f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1616,14 +1616,6 @@ static int pci_dma_configure(struct device *dev)
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
 	return ret;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d1474b2129ab..2d4f3080e4dd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -936,7 +936,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
@@ -3609,6 +3609,14 @@ bool pci_acs_path_enabled(struct pci_dev *start,
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
index d9d7a79e3563..4a8f499d278b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -562,7 +562,6 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
-void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
-- 
2.51.0


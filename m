Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D83750AD
	for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773594499; cv=none; b=S62AJu56VLsixauJi71S6QxPO/q+xosXd5g4+WDrH6o4IDtwSCHbIzYpdy/oYYteBXkp+CWjL1d5K70V06Nij0u5SFVKtDm99I6LXluB+aDm+xs7YgnoKjuVQNIV+E2Y+6w7uoyjNptDnHwoV16NZUBvCyTs+uL1FwRdDlUmNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773594499; c=relaxed/simple;
	bh=SoPi6EZR36E7NYzW7ROn+VXlsuvtsMeKrxme0hCMUPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oMccgPcj2XiPHhCiCSKt/B6ktIxkIajHt6pptrF/5e1/cvYPuoYtBE3DQCAbe43ZLlprPr+m03uQtQ4vAUWanYekjuEDUMSa+corTMRYRoPtK3H5hlJ+AyHk9i9AixiGZ3wy2O0Va3RKu5ALnQXKcM8Z5T9PmLSyRWX/hwwgsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Amnfi7m0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uu/L/QJV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Amnfi7m0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uu/L/QJV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62F6UAaI2043861
	for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 17:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=thJzkvW9uOc7ANNbvpiJj/
	JZWbmF086MfCsEV/kb1PM=; b=Amnfi7m0rPnXRh+qwWteFyKXFGRtWdWJPLHVgi
	3X3StFtnBtdGAP3Vk7NREEwWfihYkgnwEA7QAWFi46mPrZp9eA2/lUA8HlJX9TxU
	lq7Id5YO7BlZHa7YPPEqihviIVmDqJV8GytlpdfCGy41/Gfmd22lP3iZ0sd/ADBS
	9uenNtpdCqDzntK2Ia1c0NA1NyblfMJ8+sTAvMGgpjkVDlvZv/IO76Wsgwo7NZRu
	7bAm9wy+Qx/3iT8JyCoPTl3FkAvGAvMMQiVUlHw5/gomHywQN/V2INbXM5FWDeUC
	eX4WYAy3dJqalyon/Ax8+4aiFxj2d6Bmr6g1IQfy3Kpvw6qg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00bb460-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 17:08:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aec8d85199so19160915ad.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773594495; x=1774199295; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thJzkvW9uOc7ANNbvpiJj/JZWbmF086MfCsEV/kb1PM=;
        b=Uu/L/QJVbofXGVEeTN1Mk4CHy9msT/U28dax8q7odVmxJmLiildWzi1TyLlYCe89fs
         lDfORnxjGhFiIKrvylM/R1BR9LUIg9E7HdO/yzPS18MK3AaPG18kra5ps4jxTOKFa6O9
         5T7XkpRHgs0yhx7PRq8iyNs/K6v9FYTiiOuPOYa5RBiKxLygPOrwe/F5qtfSnXNyny7P
         wkRnmkSpw9aDrEykkE7njeh+jG438uLq80m/Ci5MIbf5ccDJMAphVsPs36RE9PejQBef
         AnAlbB1bzP9f/F4gTV6z6sDjfbYntIM8r69zm10p0JerxMrKlb4Jud7B267EPPfQBwYM
         mYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773594495; x=1774199295;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thJzkvW9uOc7ANNbvpiJj/JZWbmF086MfCsEV/kb1PM=;
        b=WE9cU2aj6qW4zMtw8hXefSZ/EkhmSHHF15MJftMhuj0MN1gzAAOAZRWjJJ5zdmB+Nu
         P4JsaqmV+jTQE0Hw1YxtWY63yAPeLxK+dIwZIKMj1IxdXGON0LkeDJlhqd/P27VN35pA
         xStp3R7jQ0qoFQBDgQ+nlN+Is5IKI77QV7JckIK4tKBwbdRacSxeT8S8StGLcUjHEFDL
         oTuUz+aD3fqBc/T8h3kGIbo4TUMW+6gAt8SgxBOVcQkZJdvnrn6WFLE7oGTh93f9USwr
         o0TnwIge29nD2cS8bbxGA7L8fFfd5mtfRTScSq779l67IBTID9amDQ7S20wVGuC0mEKJ
         yq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVHHMUHCECkceOfDiGitd4zzFlrhhRPsuSFAtU+i7PHq+0b7WlIV5T4QDNOrzJgeWjIYherJ7u/QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEub6Wy2XkW8mJ3X2uK9vIm6Ob6cEgjFqxBelAAgEFZVBFiXVP
	HZPWq0rjwvbysm1+Q/w1c1fQjsUN+SXKMSeD1VNQgVwNLlBcov5XVOxEIhmHeqR/NqDaognns4p
	BFqrwyd4gUBL+H/AcpH2RXEehwENz9zWLLQpq73wxFCNLs7VUx/aMN+6+0CNY8+KKvz3mCog=
X-Gm-Gg: ATEYQzwTPD8uF0wCpIXY2c7+GZ5iOG8X/MmlWZctRW7CUFmjn+HyMTlKDk6emsNFDae
	JKnDW60A8Ro5EVHOlhAMm6CdkRPbQGO34QpvrL86HuKQYh06i5FCHTKhGM9fw2c0l0O78w/PP0j
	w7jYA5dOJIrauaXSULwR0llFWlWfirl4HdwdFnAg1VZm8AgqMEr/00jaa89JtOSw01GPPqOPk52
	wHWNpOEyq0cVsQxLXPiFmEuv1sf0ZkGq8BSQbI/EkgW6SoGxIOx3ntOZDkL+b1kyvkiTwYvlMxm
	LOVax/Vw9URZ3gjj6tc5ackZC3UVb4gJO4Nv8W1yj38Rh7rkOa9A+SY2mMPFNQX0FB1SDjLD4ys
	zOrXG/hvjOhZuZPJLcbARn2Rxlg7hZBgVN3xGLKAlaPtGOUQLwHVIYUS1
X-Received: by 2002:a17:903:1b68:b0:2b0:5306:5f20 with SMTP id d9443c01a7336-2b0530674cemr17093195ad.18.1773594494955;
        Sun, 15 Mar 2026 10:08:14 -0700 (PDT)
X-Received: by 2002:a17:903:1b68:b0:2b0:5306:5f20 with SMTP id d9443c01a7336-2b0530674cemr17092635ad.18.1773594494295;
        Sun, 15 Mar 2026 10:08:14 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c393sm78973035ad.17.2026.03.15.10.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:08:13 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Date: Sun, 15 Mar 2026 22:37:43 +0530
Subject: [PATCH v2] of/iommu: support multiple iommu-map entries per input
 ID
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-iommu_multi_map-v2-1-51b98cb79331@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAF7ntmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDY0NT3cz83NzS+NzSnJLM+NzEAl2LZMskcwsTS4PE5FQloK6CotS0zAq
 widGxtbUA+zWOvmEAAAA=
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        linux-arm-msm@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773594484; l=11143;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=SoPi6EZR36E7NYzW7ROn+VXlsuvtsMeKrxme0hCMUPk=;
 b=xJyzCudAB+iilqpGW9jjZhvmYkMUYUWeUOH6tnG/x8TC/YIZ05rxJXUEds5TaDqR7UknSPvcR
 OdGCrfnovcbBbST29yWlUwSy457WFOvR6FoxeZZsHPtfMKGP1PCqCGz
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Authority-Analysis: v=2.4 cv=IsATsb/g c=1 sm=1 tr=0 ts=69b6e780 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kIQn9afXKFv-EtykHQIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDEzNSBTYWx0ZWRfX49xZRRI8m1Ky
 xzdXRGGlC+kAPnscAblKR45o6+W14c7mjelyHNaBYtfIdRKgNzlnQNT8qhwdKeV/AM8GJlBtIKK
 e/Wq5aibYFQFfM1yGXXIYh015rZWS67p743g9w1lH57jKJZOwhaehqoHYMRZK9TAyYvs+LYvG7H
 OXmitZ0O7p2DPUqnI+KeICj02yyZeiUctDv5Ur0fuqSPlY4fVJ5pubifppPhiHcRwQ/eumKdkil
 lviRTJgLH0V1LeKNpaEOartstn+LGBqQNivoTO6MBDL3EeFrF8KreeANi/gf3q0CbzChCXqw5oy
 CMQIGcddwkr7vbjDPhFEXD/S6kI0DJ4d0Hgn9g5e1xTzjkC1uebU58trWEczroykIdO1uDe4zAU
 ckBhSoEqe63/Zo/FHDd/RnOuJBWaFxPAqDA6d9THW3wIzceknZ0gZh6OQuiZ+qaRlGhD/Ix66et
 +0EwmDs4ohScOEsu7Zw==
X-Proofpoint-GUID: 59dTGvcpkVgk9ywChvGVtLTFT9gvva-4
X-Proofpoint-ORIG-GUID: 59dTGvcpkVgk9ywChvGVtLTFT9gvva-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603150135

When multiple mappings are present for an input ID, linux matches
just the first one. There is a usecase [1] where all the mappings
are to be maintained in parallel for an iommu-map entry of a same
input id.

Add a next_offset iterator parameter to of_map_iommu_id() and
refactor of_map_id() internals into a static helper to carry it.
Update of_iommu_configure_dev_id() to loop over all matching
entries to support this case. All other callers pass NULL and
are unaffected.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/

Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
On Qualcomm kaanapali, the VPU hardware has multiple internal blocks
that generate different stream IDs for the same input ID. The device
tree encodes them as separate iommu-map entries sharing the same input
ID:

  iommu-map = <0x100 &apps_smmu 0x1940 0x1>,
              <0x100 &apps_smmu 0x1a20 0x1>, ...

This requires multiple iommu-map entries per device.
of_iommu_configure_dev_id() currently stops at the first match,
so only one stream ID gets registered with the IOMMU.

The v1 series [1] addressed this with a callback threaded through
of_map_id().

This patch uses a next_offset iterator on of_map_iommu_id() instead,
keeping of_map_id() unchanged, and updates of_iommu_configure_dev_id()
to loop over all matching entries.

This patch also depends on iommu-cells series [4].

Changes since v1:
      - Split patches 2/7 [2] and 3/7 [3] out into this standalone series.
      - Dropped the callback (of_map_id_cb / of_map_id_arg) entirely.
      - Replaced with a next_offset iterator on of_map_iommu_id()
    	only; of_map_id() public API is unchanged.
      - of_iommu_configure_dev_id() now loops explicitly; no
        bus-type heuristic (dev_is_platform()) needed.

[1] https://lore.kernel.org/all/20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20260126-kaanapali-iris-v1-2-e2646246bfc1@oss.qualcomm.com/
[3] https://lore.kernel.org/all/20260126-kaanapali-iris-v1-3-e2646246bfc1@oss.qualcomm.com/
[4] https://lore.kernel.org/all/ce25b963-0e8e-4411-a406-7b466eadb1f9@oss.qualcomm.com/

Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c              | 20 +++++++----
 drivers/of/base.c                     | 65 ++++++++++++++++++++++++++++++-----
 drivers/pci/controller/dwc/pci-imx6.c |  2 +-
 drivers/pci/controller/pcie-apple.c   |  2 +-
 drivers/xen/grant-dma-ops.c           |  2 +-
 include/linux/of.h                    |  4 +--
 6 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a18bb60f6f3d..947eedd9a88b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -46,14 +46,22 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     const u32 *id)
 {
 	struct of_phandle_args iommu_spec = {};
-	int err;
+	int offset = 0, err;
+	bool found = false;
 
-	err = of_map_iommu_id(master_np, *id, &iommu_spec);
-	if (err)
-		return err;
+	while (!(err = of_map_iommu_id(master_np, *id, &iommu_spec, &offset))) {
+		err = of_iommu_xlate(dev, &iommu_spec);
+		of_node_put(iommu_spec.np);
+		iommu_spec.np = NULL;
+		if (err)
+			return err;
+		found = true;
+	}
+
+	/* -ENODEV means all entries exhausted; success if at least one was processed */
+	if (err == -ENODEV && found)
+		return 0;
 
-	err = of_iommu_xlate(dev, &iommu_spec);
-	of_node_put(iommu_spec.np);
 	return err;
 }
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9c44eb6d445d..71175e670757 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2146,13 +2146,13 @@ static bool of_check_bad_map(const __be32 *map, int len)
  *
  * Return: 0 on success or a standard error code on failure.
  */
-int of_map_id(const struct device_node *np, u32 id,
-	       const char *map_name, const char *cells_name,
-	       const char *map_mask_name,
-	       struct of_phandle_args *arg)
+static int of_map_id_next(const struct device_node *np, u32 id,
+			  const char *map_name, const char *cells_name,
+			  const char *map_mask_name,
+			  struct of_phandle_args *arg, int *next_offset)
 {
 	u32 map_mask, masked_id;
-	int map_bytes, map_len, offset = 0;
+	int map_bytes, map_len, offset = next_offset ? *next_offset : 0;
 	bool bad_map = false;
 	const __be32 *map = NULL;
 
@@ -2161,7 +2161,7 @@ int of_map_id(const struct device_node *np, u32 id,
 
 	map = of_get_property(np, map_name, &map_bytes);
 	if (!map) {
-		if (arg->np)
+		if (arg->np || next_offset)
 			return -ENODEV;
 		/* Otherwise, no map implies no translation */
 		arg->args[0] = id;
@@ -2262,9 +2262,16 @@ int of_map_id(const struct device_node *np, u32 id,
 		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
 			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
 			id_len, id, id_off + be32_to_cpup(out_base));
+
+		if (next_offset)
+			*next_offset = offset;	/* caller resumes from here */
 		return 0;
 	}
 
+	/* no (more) matches found in the map */
+	if (next_offset)
+		return -ENODEV;
+
 	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
 		id, arg->np);
 
@@ -2276,6 +2283,38 @@ int of_map_id(const struct device_node *np, u32 id,
 	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
 	return -EINVAL;
 }
+
+/**
+ * of_map_id - Translate an ID through a downstream mapping.
+ * @np: root complex device node.
+ * @id: device ID to map.
+ * @map_name: property name of the map to use.
+ * @cells_name: property name of target specifier cells.
+ * @map_mask_name: optional property name of the mask to use.
+ * @arg: pointer to a &struct of_phandle_args. On input, @arg->np may be
+ *	set to a target device node to match, or NULL to match any. On
+ *	success, @arg->np will be set to the matched target node (with a
+ *	reference held), @arg->args_count will be set to the number of
+ *	output specifier cells as defined by @cells_name in the target node,
+ *	and @arg->args[0..args_count-1] will contain the translated output
+ *	specifier values.
+ *
+ * Given a device ID, look up the appropriate implementation-defined
+ * platform ID and/or the target device which receives transactions on that
+ * ID, as per the "iommu-map" and "msi-map" bindings. If @arg->np points to
+ * a non-NULL device node, only entries targeting that node will be matched;
+ * if it is NULL, it will receive the device node of the first matching
+ * target phandle, with a reference held.
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_map_id(const struct device_node *np, u32 id,
+	      const char *map_name, const char *cells_name,
+	      const char *map_mask_name,
+	      struct of_phandle_args *arg)
+{
+	return of_map_id_next(np, id, map_name, cells_name, map_mask_name, arg, NULL);
+}
 EXPORT_SYMBOL_GPL(of_map_id);
 
 /**
@@ -2285,15 +2324,23 @@ EXPORT_SYMBOL_GPL(of_map_id);
  * @arg: pointer to a &struct of_phandle_args for the result. On success,
  *	@arg->np holds a reference to the target node that the caller must
  *	release with of_node_put().
+ * @next_offset: if non-NULL, on success it is set to the map offset just
+ *	past the matched entry. Pass this value back on the next call to
+ *	resume scanning from where the previous call left off, allowing all
+ *	matching entries for the same @id to be iterated. Pass NULL (or a
+ *	pointer to 0) to find only the first match.
  *
- * Convenience wrapper around of_map_id() using "iommu-map" and "iommu-map-mask".
+ * Wrapper around the internal iommu-map scanner using "iommu-map" and
+ * "iommu-map-mask". When @next_offset is non-NULL, returns -ENODEV once
+ * all matching entries have been exhausted.
  *
  * Return: 0 on success or a standard error code on failure.
  */
 int of_map_iommu_id(const struct device_node *np, u32 id,
-		    struct of_phandle_args *arg)
+		    struct of_phandle_args *arg, int *next_offset)
 {
-	return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask", arg);
+	return of_map_id_next(np, id, "iommu-map", "#iommu-cells",
+			      "iommu-map-mask", arg, next_offset);
 }
 EXPORT_SYMBOL_GPL(of_map_iommu_id);
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5f8a11774eb5..0d7f5e6d037a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1146,7 +1146,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 	u32 sid = 0;
 
 	target = NULL;
-	err_i = of_map_iommu_id(dev->of_node, rid, &iommu_spec);
+	err_i = of_map_iommu_id(dev->of_node, rid, &iommu_spec, NULL);
 	if (!err_i) {
 		target = iommu_spec.np;
 		sid_i = iommu_spec.args[0];
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 2e86f8fd300b..c780e3f9d14d 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -765,7 +765,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
 	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
 		pci_name(pdev->bus->self), port->idx);
 
-	err = of_map_iommu_id(port->pcie->dev->of_node, rid, &iommu_spec);
+	err = of_map_iommu_id(port->pcie->dev->of_node, rid, &iommu_spec, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 36547d7cf1d6..062beb5825f5 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -325,7 +325,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
 		struct pci_dev *pdev = to_pci_dev(dev);
 		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
 
-		if (of_map_iommu_id(np, rid, &iommu_spec)) {
+		if (of_map_iommu_id(np, rid, &iommu_spec, NULL)) {
 			dev_dbg(dev, "Cannot translate ID\n");
 			return -ESRCH;
 		}
diff --git a/include/linux/of.h b/include/linux/of.h
index 953f2dbe0e86..990849f00e74 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -467,7 +467,7 @@ int of_map_id(const struct device_node *np, u32 id,
 	       struct of_phandle_args *arg);
 
 int of_map_iommu_id(const struct device_node *np, u32 id,
-		    struct of_phandle_args *arg);
+		    struct of_phandle_args *arg, int *next_offset);
 
 int of_map_msi_id(const struct device_node *np, u32 id,
 		  struct of_phandle_args *arg);
@@ -943,7 +943,7 @@ static inline int of_map_id(const struct device_node *np, u32 id,
 }
 
 static inline int of_map_iommu_id(const struct device_node *np, u32 id,
-				  struct of_phandle_args *arg)
+				  struct of_phandle_args *arg, int *next_offset)
 {
 	return -EINVAL;
 }

---
base-commit: 9e94742cffb7541f55fa904a40c1ca9d836d303d
change-id: 20260315-iommu_multi_map-8c9b78490ace

Best regards,
-- 
Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>


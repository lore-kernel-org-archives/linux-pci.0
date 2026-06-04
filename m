Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE9A44B67F
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575867; cv=none; b=gt1jOQ12BI8l1SlMuDcrEbfpuDF1gkpen2p7Xa+MeHTkNJ1FNODpdStb24g7CrQ573CrJTGcFe865QJsQ51Je4c4X4zMH2XL2MeACXGj7Xjfp085yisbjdhfWdwiyMYrjxPPW+8iZLVXH++2wXd35VTdMNG3oeXZfr0ym4HhXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575867; c=relaxed/simple;
	bh=apo2ANK3NU2TBFyfekj/mxPztWFp1Q9vmW6QhNbAwlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTEWfuD2RJ8Vzt4IP2pcIngIE/wpdmhLUOCMbPmP6C/ttG8ItFR5q57cxhsIT7FPsV547imVITSYSYyQLunZgx4MNHOfsZ7VmBsNLuoogZRWDBQUwIRhCK2CMq7zpJB0oyGz4/zs6sES9e8IHVFxM9IP5CGTHfolrveZ3VqE2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TzwDUUV1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBmwyvtR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TzwDUUV1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBmwyvtR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548IlXU313865
	for <linux-pci@vger.kernel.org>; Thu, 4 Jun 2026 12:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VbB0DABGOtK
	JoHg8hFmspUueMVJinTA763aGb11Q0CU=; b=TzwDUUV1cqPPPNDULsx7pcTxSPg
	HtsFmaBAHsswIDxGwczgXetqNYD2rEB6KuRPUn9lSzdbhopBzPE9RR1OiyMj6fhe
	nw0Aht1zkmaIrA2ALaISAJe+MV/HCcNvVLKy6XcS4n86ilMs4NuSpDchXnAKdSQv
	EPQOASHxCgWO0X90FWGZiN2GQz9vYMXHD3E7sqZlYJH+6yyresyho/LJr+KnpgbS
	bl0VTDS2siNQ5fqfMfLukCf8wRHb9RyFh4/0wi0pfX3e33B4BYYoCBcArX1tij3i
	kpi+x2a4PkBuR9E2nluaHE/P8+XZv3OIzH10kBehVEyW5F3ybDP0OBdPjDg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy5v2anb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 12:24:25 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423efdbe6fso468039b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780575864; x=1781180664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbB0DABGOtKJoHg8hFmspUueMVJinTA763aGb11Q0CU=;
        b=QBmwyvtRt1Ukx9s7x6eiHzbIz+KfiBMm6tkFtRwazBNioXfUdrhKQYoXelGcyB3Wj+
         3oIvSeIFJpFfS6i9+nqHnkbtfjxZPyXx0IHdybdQdyTdpdfYZsVPBWJh6EF4HssRRbFh
         bIQApTvgaYm7aQMYhdDDCBEMbiIgBzllWa2qaPZxTHQd5OX4nJ0tc9tMZ6qzJHkVVJ0o
         tzuPOneIG3rY1Okm+xa2P9cynj7uwQfXnACpB3TzAXVqr+eWZ8kSg0P1VtbSp1QWNi9D
         pg7Y4exEws+YZjjEDf8mTBe0c7C13L8oLf3gBjXq/6AcVoKwQRKym9YZzvGgJSkHWKMQ
         FAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575864; x=1781180664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VbB0DABGOtKJoHg8hFmspUueMVJinTA763aGb11Q0CU=;
        b=aeQzTmPVRmA5YlCzHzRA8ZvUcjwUpIz/Ob23dmzj+xCuSncLt8+UOGeUhP0fHPq48P
         J5m7+wzCbP3PbKvFt5yJtx6tcEaTVPi8YG86YOPfOwnweh2Qhy3ZR0jXuEuhhPyLbAvF
         /ooL8RapyjhBTMOjE6RwZ9BxtXBXX+8sp0l42tYD/OuTnVXRdU5I945Jiw0+liblgZEr
         NLDDQnN1LHb4dHCGH9ciENjvvbMbXQTsl/v2ytQj5fdx4Szc0/j+Jss9L7uWJ6Su7OTf
         VqWAYeHdILfDSJmUUhWsq07lnT14/emp/nk6A5WUYb2qY+NgA9cgVz7Hq1XIW8TxE6Mn
         JFbw==
X-Forwarded-Encrypted: i=1; AFNElJ9/H2lw2iYS+IY7WhILuO34l+q8dd8Eas7ENJkVAncqXGRaViBaY4Katca40FYgPbvTlD0dC32NmaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6whkWp0WqPq/v65AtFaAnbqS1ATYG6UIU0gTEeYvLALy93pmP
	UNDNzZ9cpaTMjmuF415Ggn384AErsq+9hPeS7iJnSB431gEdKPNDlCV378n6BWq3Haqq358AYLu
	qsDGoc6jKiF/CwcuYVwZjP89XAuFAGak7wYcPSy/5Nn9QOPPWiu7YvefIiKrxN+8=
X-Gm-Gg: Acq92OFAnF+rfEthKHG8Sf3Bvkl8Y4/2R2NWe7FQeQb+LCrFMsz/5H7XBxAfpqpVE3t
	LUNQ/s66PR6r5g2RuQpJpi1MZVmupuDxf6O1QlKVs7OBS72BPkXSfZi08Jpa57YdBF7RD42tqSu
	6KnF8JmzMo3GvndN7XmFZwyeZOyq7Lrfop7SprkpNMECiL8lds0BBV0pxHkFjUmom2vmTYtI8YW
	q3tCW3Yzwvs5CBXfXAEVR2BYWrk5VD7v+ENUVrxaGJKTgBrsbSp7DJVL0fWIWYKJ1GR/TUtozB9
	s8I3mZe3cEC67XLc7dKD3lRJf9wGzuEEwcHnKoMnWsyTsyIPZJb1OJxAwH6WRcWdC0Mh1l7OCP8
	1zljD9TrCSQ97pGFbpfYhHmw1T+QFUnZmPFBlQAd6iJnCf7NEzWhZRan2OPdiP5m9aE91+iRGf2
	4dOpl3dTUir9jvRD48vzkIvABD+c7mXrYl2VCF3ac=
X-Received: by 2002:a05:6a00:1d8d:b0:842:2cda:7aa2 with SMTP id d2e1a72fcca58-84284ed9c20mr7471895b3a.30.1780575864379;
        Thu, 04 Jun 2026 05:24:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d8d:b0:842:2cda:7aa2 with SMTP id d2e1a72fcca58-84284ed9c20mr7471861b3a.30.1780575863875;
        Thu, 04 Jun 2026 05:24:23 -0700 (PDT)
Received: from hu-ymg-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882156sm5841960b3a.33.2026.06.04.05.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:24:23 -0700 (PDT)
From: Yadu M G <yadu.mg@oss.qualcomm.com>
To: mani@kernel.org
Cc: shawn.lin@rock-chips.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: qcom: Initialize DWC MSI lock for firmware-managed ECAM hosts
Date: Thu,  4 Jun 2026 17:54:18 +0530
Message-ID: <20260604122418.727274-1-yadu.mg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <rn3iccwguseu3dvygwauog62jgcg4azrxvusotolpfr6tlga7y@odknnlfue3ym>
References: <rn3iccwguseu3dvygwauog62jgcg4azrxvusotolpfr6tlga7y@odknnlfue3ym>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDExOSBTYWx0ZWRfX1mXSaLU6UfyK
 j7VUDHfMQOAJ5slyAvNtfmUz2isY/ys6rzT9XkRej5punag26T9YEjHNkfPDaPEaIbZCj8543bK
 Byh5rQ9hFIOf5ei1MmfxG+q34vSnBwT0gPexX6oc0P6fFdke6mSVU5kusBOIOQF0hfY4i6TKDcf
 TecXMdInUnfVVBLUD15VPO/+RKHWgdk2NiLlKWVDWU9mRvctZQFGASOZj5eW987R2zhQHseKDNg
 Uo2yYP0zv6dNwyMByI5+/I6RBbvwXTAXQOyBAV2YTWMG2SdM9+oYKoHuPFDNGzZU87j47GQm0lr
 1ttgcixn/G02N5aSRFsMfxJLueCZMihXM/xuUbkB1pLS2MSDyZABJCDdFtZRN46jbRwekOEz+hw
 MJQCGy62KEAVtKf6vj76zxhIQAqO7iUs/+d9BE2YxNb/C38sklPy7B2SGZo7uNAKiq2zSmYAYlT
 Y7wk1z2VilSE1ZMYSKQ==
X-Proofpoint-ORIG-GUID: qOK3UfDLyrDYQyZZfEddv3qkrFHmgDoe
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a216e79 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=A-MhOCtGDkUKx26caKsA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: qOK3UfDLyrDYQyZZfEddv3qkrFHmgDoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040119

A lockdep warning is observed during boot on a Qcom firmware-managed
platform:

  INFO: trying to register non-static key.
  The code is fine but needs lockdep annotation, or maybe
  you didn't initialize this object before use?
  turning off the locking correctness validator.
  ...
  Call trace:
   register_lock_class+0x128/0x4d8
   __lock_acquire+0x110/0x1db0
   lock_acquire+0x278/0x3d8
   _raw_spin_lock_irq+0x6c/0xc0
   dw_pcie_irq_domain_alloc+0x48/0x190
   irq_domain_alloc_irqs_parent+0x2c/0x48
   msi_domain_alloc+0x90/0x160
  ...

dw_pcie_irq_domain_alloc() takes pp->lock while allocating MSI
interrupts. pp->lock is normally initialized by dw_pcie_host_init(), but
Qcom firmware-managed hosts use the ECAM init path instead:

  pci_host_common_ecam_create()
    pci_ecam_create()
      qcom_pcie_ecam_host_init()
        dw_pcie_msi_host_init()
          dw_pcie_allocate_domains()

That path constructs a fresh struct dw_pcie_rp and calls
dw_pcie_msi_host_init() directly, without going through
dw_pcie_host_init(). As a result, pp->lock has no lockdep key when MSI
vectors are later allocated, which triggers the warning.

Initialize pp->lock in qcom_pcie_ecam_host_init() before registering the
MSI domains so the firmware-managed ECAM path matches the normal DWC host
initialization sequence.

Signed-off-by: Yadu M G <yadu.mg@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 11fc60489892..b925a7af1d75 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1794,6 +1794,12 @@ static int qcom_pcie_ecam_host_init(struct pci_config_window *cfg)
 	pci->dbi_base = cfg->win;
 	pp->num_vectors = MSI_DEF_NUM_VECTORS;
 
+	/*
+	 * dw_pcie_msi_host_init() is called directly here, bypassing
+	 * dw_pcie_host_init() where pp->lock is normally initialized.
+	 */
+	raw_spin_lock_init(&pp->lock);
+
 	ret = dw_pcie_msi_host_init(pp);
 	if (ret)
 		return ret;
-- 
2.43.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C2286D7E
	for <linux-pci@vger.kernel.org>; Sun,  8 Mar 2026 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772998452; cv=none; b=ggQw2a0C0m3GmC5cN7zPF2UxXaTPpcRYVQrbbau1dWZc1RYGbkoPH4D7SqDVfC3DY6fF8lMbwCoNYd5BtlLI8jM9M90NuXsIblFomGqoT09oiR3gilT+dBew5RVHOrM615XKEGqcZn6I0XSQh5XRqpP5GnOfrX0MEuTYRBpwCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772998452; c=relaxed/simple;
	bh=PtTdudtjBZ/xPMrnHDRK1H9Z6n/XjfTDJSglqtupcDI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cJFfhfDWg4gSQLGW+vEku3tdDuigNMBsFBIkpH77dIfwN6tiputAFG6D1U82S5tYKNzX1dH4C21tpCglf+1SWp4T1vOpcQnoBDc3WIQ7A3vIJK+mCqxJanWj3/EOKf97lL/ZATRxkwB2VhEDvbn/7bMb9nEc1vRzPYLqdTYyddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iz5I4QQh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yx/0Jqkv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iz5I4QQh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yx/0Jqkv"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6287F2u42513345
	for <linux-pci@vger.kernel.org>; Sun, 8 Mar 2026 19:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DNMdCDB4m/JS2Eqb4Zd/0G
	6oEd9rQSbuN+RA5pJMqjw=; b=Iz5I4QQh+5X+EdI7ZbWYkCwMd0XsXKEgZSSk7u
	fZ9Y3l6+S7LKgAOi7D3AfsdoMASdDUtGTK7RZzHvs5t01JfUzEaojPuJ6bMc9ofc
	2/bd2VGoUOQMpwJRFzwOorskgCxsdkMtTQplIHuOzWjx8AvvZ9lxxJMGtGLNxgSn
	anN7DXhtVfkGW27Ex2TmfG1rL90bMyaGXdzyW12WT3YHHeNaHtVQP07xfglcjK+U
	3Hq+dgArnD8ScoB11PW9t66PZ9SMoa2utjEkZ1vtKayFBjoNbGSTSExpPj7knnQH
	KyxIdiH5oJAi7giVdLeW41AZ3NV+Hguvx/+DxBT7wj64Xk/A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crc3vb06v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 08 Mar 2026 19:34:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c73a4983fc0so800351a12.3
        for <linux-pci@vger.kernel.org>; Sun, 08 Mar 2026 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772998448; x=1773603248; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNMdCDB4m/JS2Eqb4Zd/0G6oEd9rQSbuN+RA5pJMqjw=;
        b=Yx/0JqkvQUSPveBKs3O8kovCl+BlxHe8F5WqxoTpKnUsLilouTgezVJ08H8cw8W5kD
         VnSdufS0GclvmSvH469bjGCdfE9ym08FvZ9K47zvQjX7Y2vg25BcxhoxIAkgLFHeLVlA
         NDNSY/F5H1B2k5uwCGfPopKWwxZlFP0Gwh36MNF8p4rmY91IBV0auVjs9cs9ctonrCwm
         5gwDsWLmtMlJ+v/4NvLh0Q2cn0p7P0UPkV/P7LNsB0UqoOp+li6bgE53yrgvnlE9OUUj
         TF2w3g/tzSgSrl2pde2hSj3VTJJyrZRc/IMqzkmeytLkJDmxBK1n35kGimpHs9WffewN
         ApQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772998448; x=1773603248;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNMdCDB4m/JS2Eqb4Zd/0G6oEd9rQSbuN+RA5pJMqjw=;
        b=gsg0a1LL1MpjaVWf/ozni+tN3qc951EPEAt+kzXePceesOVHxpi7+ZKbEffty4Lpor
         Oy6kfd0kaNwzJ4/W9PKh0IBC/A5xQN0L46K7UalCfUIxEX+wwkqdWkB1vilsChOH8IKv
         I0qYTft9QR+vfw0jZkRtXPaNJlCmXVEY01VHPcFd6BEWqboAS5eku/+HM8s/GMkvbL4X
         tFslZM688DfrFwVk2Qn7yFmOVXVcpybjAfe1GH/yxe3XAcYMbp6vGriFRGyDQUroYEBd
         TckvEHjFCaOjpfjWmlO0NYKCa6f+LCT7C0n5gC/M3o4K2Xgkk0Bly8mAgaOPjJaN5kF6
         70pg==
X-Forwarded-Encrypted: i=1; AJvYcCUiIU7Rtl+6D+VLoy7xu3RRR7WOJCIsUsISi9zpclIF5nL6S54Yo7B71n6iS0zrlH+CrcuDFl1iULc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjc7yPrfNHJAPjGTucZYwSZaD2ckvDGggDpvjYEhCO4bPtDqY9
	Tkx5FT8hy7dwJA3UnNg1/WFbgZSL1wEObQHd3AftQHqxf9OXelzxFETzAWtm8U7LiVnXonA4+JN
	BqHVHzHtVRp6jz0SQzaXZJj1ijUJyVkTfVnX9r4azopHstBQgtD/9aUWc7TSe1pWW8irWP4E=
X-Gm-Gg: ATEYQzxfMGyrw98nV2ukxxZzJ7o3wBuQbh44qzdz6qLjfI8DUds/4lm0L2E1Yi4cKHN
	kMWEFLBIBuz7IVdHtyGHtEIaZcXc1SaSaCpLcSRCV3CYYrZFamKQ1DKLUlxq/61s8A3vQql0rOl
	PclIWg82szbBvfZjIrzlbymLMQricPjnofJ7Lq2p3N4JxsdHfwqQvUCw7V/o8GFw7p+cTMoII/j
	OIa0z0+Bq5aw4C/V2szLfy5qn5Mg//FJ8Joho6Iy4ueygZdBCf2aDoceyL+jzeqAIirqyf/Dyte
	NpwsDTXfxuOYei/PcNS5iGcIwQP3a829pnKeDxt5L3NYDX9cIw8UckTGjbHClJjGSfPxGMNxklL
	z1QKm+CqyCZZGA7vf1Zi8/iHuv1cX5Tat2owM5/A2oq4oMrMZ8qcFFdkP
X-Received: by 2002:a05:6a00:4b53:b0:829:6f9f:ea3b with SMTP id d2e1a72fcca58-829a2e3d086mr8046042b3a.20.1772998447804;
        Sun, 08 Mar 2026 12:34:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b53:b0:829:6f9f:ea3b with SMTP id d2e1a72fcca58-829a2e3d086mr8045981b3a.20.1772998447234;
        Sun, 08 Mar 2026 12:34:07 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4676593sm7818909b3a.28.2026.03.08.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 12:34:06 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v10 0/3] of: parsing of multi #{iommu,msi}-cells in maps
Date: Mon, 09 Mar 2026 01:03:36 +0530
Message-Id: <20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABDPrWkC/32NUQ6CMBBEr0L225KWKgpf3sMQUpZVNgGKXSEaw
 t2tHMCfSWYy82YFocAkUCYrBFpY2I/RGH1IADs3PkhxGwPIdJZrq42aXBCq2Q/DXCP1vSiD1p7
 zi6OmcRB3U6A7v3forYq+Y3n58Nk/luKX/qMthdLq2JoGiRBPZK5eJH3OrsfYSqNAtW3bF4mVr
 Ue6AAAA
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772998436; l=4795;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=PtTdudtjBZ/xPMrnHDRK1H9Z6n/XjfTDJSglqtupcDI=;
 b=EBb8Dk6BIlgjCH0Fqcmr+R/Zem16FjzSLlrw2KGhDvNxeYgPJwLHInLgJNWKtbmBgHLkCc5NK
 xDxh7Np2VUaB9ZsluGW3jBruuRfE5BZGHAei8UQe3BXzG9rX5bRMd84
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Proofpoint-ORIG-GUID: A0CoSSgqyzFSuq1jeTjSojJutcZ2o45W
X-Proofpoint-GUID: A0CoSSgqyzFSuq1jeTjSojJutcZ2o45W
X-Authority-Analysis: v=2.4 cv=OOQqHCaB c=1 sm=1 tr=0 ts=69adcf31 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=hUMMoPFcHhpVZiwYRzIA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA4MDE4MSBTYWx0ZWRfXzyRwvTaiidVO
 PR13cJBvusEBNJdYtLKALIKRhXIBWePUKDnBXkhDR3rUU5eRmrScVspbiUXQFeAkQGEGFORu9se
 I++9kpIwazA4i728MW0ZqcY+j+BaxGortnzIe3UkupyHcn7r6K7G2x7pODBrVIn1lG6xh4MVPJK
 KKs2E/jT2MOAAB3TJqxcoa/dpdqyAlpjxqZQE4+TkYHrSEZXjcZmvxgj9h4tyfHI/HZsl8dacQc
 v4/Ydc8NYqdaTfNXWojz7m/hz07bbRKoG0h/wJly0PwQ7qWpvAtBfnB0c6Z1dBGrbxbvQLY0b0p
 Mo5Uvnciurz2xIVn6FXn/FSUTl1/RuoK8SfN4ff3B4aM5rkmA3gsLx7S3K4RGjtx8MFeoMKHVSl
 4SRIkcRW6FDE9LzHIXHsNPlL3G+BC7gAzpHnU7tcP8FMf4Crw0GqlUHZH2hjQuQCr6ME407HnMz
 kmOXFECubXjnd5l2cag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603080181

So far our parsing of {iommu,msi}-map properites has always blindly
assumed that the output specifiers will always have exactly 1 cell.
This typically does happen to be the case, but is not actually enforced
(and the PCI msi-map binding even explicitly states support for 0 or 1
cells) - as a result we've now ended up with dodgy DTs out in the field
which depend on this behaviour to map a 1-cell specifier for a 2-cell
provider, despite that being bogus per the bindings themselves.

Since there is some potential use[1] in being able to map at least
single input IDs to multi-cell output specifiers (and properly support
0-cell outputs as well), add support for properly parsing and using the
target nodes' #cells values, albeit with the unfortunate complication of
still having to work around expectations of the old behaviour too.
							-- Robin.

Unlike single #{}-cell, it is complex to establish a linear relation
between input 'id' and output specifier for multi-cell properties, thus
it is always expected that len never going to be > 1. 

These changes have been tested on QEMU for the arm64 architecture.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/

V10:
  - Move of_map_iommu_id()/of_map_msi_id() from include/linux/of.h to
    drivers/of/base.c as out-of-line helpers per feedback from Marc Zyngier
    and Rob Herring.
  - Add kernel-doc to document both helpers for discoverability and
    usage clarity.
  - Fix of_map_msi_id() wrapper and all its callers (cdx_msi.c,
    irq-gic-its-msi-parent.c, drivers/of/irq.c) to correctly use the new
    struct of_phandle_args-based API with proper of_node_put() handling
    as per feeback from Dmitry.
  Link to v9:
  https://lore.kernel.org/r/20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com

V9:
  - Updated TO/CC list based on feedback to include all relevant
    maintainers.
  - No functional changes to the patches themselves.

  Link to V8:
  https://lore.kernel.org/all/20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com/

V8:
  - Removed mentions of of_map_args from commit message to match code.

  Link to V7:
  https://lore.kernel.org/all/20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com/

V7:
  - Removed of_map_id_args structure and replaced it with
    of_phandle_args as suggested by Dmitry.

  Link to V6:
  https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/

V6:
  - Fixed build error reported by kernel test bot.

  Link to V5:
  https://lore.kernel.org/all/20260118181125.1436036-1-vijayanand.jitta@oss.qualcomm.com/

V5:
  - Fixed Build Warnings.
  - Raised PR for iommu-map dtschema: https://github.com/devicetree-org/dt-schema/pull/184

  Link to V4:
  https://lore.kernel.org/all/20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com/

V4:
  - Added Reviewed-by tag.
  - Resolved warnings reported by kernel test bot, minor code
    reorganization.

  Link to V3:
  https://lore.kernel.org/all/20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com/

V3:
  - Added Reviewed-by tag.
  - Updated of_map_id_args struct as a wrapper to of_phandle_args and
    added comment description as suggested by Rob Herring.

  Link to V2:
  https://lore.kernel.org/all/20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com/

V2:
  - Incorporated the patches from Robin that does the clean implementation.
  - Dropped the patches the were adding multi-map support from this series
    as suggested.

V1:
 https://lore.kernel.org/all/cover.1762235099.git.charan.kalla@oss.qualcomm.com/

RFC:
 https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/#r

Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---

---
Charan Teja Kalla (1):
      of: factor arguments passed to of_map_id() into a struct

Robin Murphy (2):
      of: Add convenience wrappers for of_map_id()
      of: Respect #{iommu,msi}-cells in maps

 drivers/cdx/cdx_msi.c                    |   6 +-
 drivers/iommu/of_iommu.c                 |   6 +-
 drivers/irqchip/irq-gic-its-msi-parent.c |  11 +-
 drivers/of/base.c                        | 202 ++++++++++++++++++++++++-------
 drivers/of/irq.c                         |   9 +-
 drivers/pci/controller/dwc/pci-imx6.c    |  18 ++-
 drivers/pci/controller/pcie-apple.c      |   6 +-
 drivers/xen/grant-dma-ops.c              |   5 +-
 include/linux/of.h                       |  28 ++++-
 9 files changed, 222 insertions(+), 69 deletions(-)
---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260301-parse_iommu_cells-1c33768aebba

Best regards,
-- 
Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>


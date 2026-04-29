Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54BE38644F
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777444957; cv=none; b=SibnxYOT7GhJuaUQWtOnx3cWPVXyRD4KiE7cLzzGIaWaXwPsmcgRNpRO+1QZTDH6tcZlZHEgMsCoB0g63H511vU6S+pn4LZV0e/cgCXwo+0NTxpdxZd0+jLPce/LX95L2nrs8kpIfyPgAjC4Sr3ReddCrFpAYqd3FthC3lVT4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777444957; c=relaxed/simple;
	bh=rEjaiQ56SR1KUsMRM2T7xYZF8Samoy1STOTX2pwIjxs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hwFIJzuVEtVdxZbiW6j0pu0I6D5EYuOh+sEgeGgbx+ap/gWgttMJShzD4ZO4IdTjwkksLdY66R6XpB88QMiPLiidfbCKgRgvspfmoD1Qq37F3HHL8fS7cohCrFEK4bIgvlPFIlf5F6R4aU0b0dvrywte3m0dmPEVEDkSrCHT2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oLCgepus; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eRM4A/0N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oLCgepus";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eRM4A/0N"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2gdLc3184120
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UTUH6bkslQjtgduW9VKGT6
	0BifNc2etF7zX5YAiYbfg=; b=oLCgepusP1XZEwmXqnyK5u6/0z3E9x5hL6HT/J
	1hXaPa2NSpPTSo+XShuxRugIC/ZFIn1DtB2zV8mx4n8P9xTryypBTz7zabAdE7s9
	H+WTeaFDs+O+usOT74B97j1GkNg9TwWSeUQUBhXXqIV/d2F5V0wBuM3lDq5tO70J
	Fz71POYHxw+SBNsYUAdXENIDkatDx6pbpv0131SqAM7YcDhOO1sWl/JFhRXAvWb+
	yJ8RpZFzqud9cB0dER4x/wfF06hsmKZS1xxll96PucMMebrq8BAFBjC71FlZm4zw
	lz3NZFSjwT6Mo1AzWe0VWjzaEIXLs009NWlemImYWl3f+Sew==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du9em0qcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fb969a4c0so13150253a91.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777444954; x=1778049754; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UTUH6bkslQjtgduW9VKGT60BifNc2etF7zX5YAiYbfg=;
        b=eRM4A/0NxTbtn0F0NH3oK6ToR6XUypg9THOt8muvexDTTS+TukOPQT+2RrxX9lGAtJ
         AXmKImmOCIYoBW9UdJJ8bT3cjrCTcg3nXjYsGJKt9XjAvRLwkwUdJYJTgQmFYNMysheW
         Y2JwgNyHA0QOP+XQGGcoj6WaCnU3nhehnFB8VYEJZgJlDG/LYtnyKYsH1CQ+/UBnhpQf
         r5LBerP9/vNP3GZTGUrznKsfMAguNlUuh+wMLDCwDndF2GSUScMMand6QqRUWXIKJJNy
         nybne7664xkn9fG3Pc9+853FDDRIzFSVseK1HdRV9ehjc232UTbmgznj5iTHlNfX0hW7
         wGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777444954; x=1778049754;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTUH6bkslQjtgduW9VKGT60BifNc2etF7zX5YAiYbfg=;
        b=YhB1Uh+OFJJ3K8kDhbPEt3Vy5T8akGJq1ipsLMeVFoSJqxqmBE6lc3RGM+UBkOTnk9
         8lSrT58nV01NiQlKIi/88v6hc6iivQK2S3M1iFetinOdM/66TqIbR2iEd8JYJqXX3tY4
         oCrPiFkn+OLUFA5CwOcwYM0hEQdtDrqKR5enM/lhWzB1Pf/7KsfCCNd0kU2zO3iFO8cX
         9BllwEySraH61wH+ldcHUVwLi8z0FqCsQSlyYVIJ3rBODM0Ck5Mh/MxNNAU9KPeAmVtb
         UqcbLmHMToafxsXwPbppk4ePFCBFEwTLiyQsH3krbvRq/n8KnJmddv1i+1b98/Y5dOcH
         UR1A==
X-Gm-Message-State: AOJu0Yy7IaZLRtHA6ik+f2bCbN9kMZjmHa5VB5Z5Bf8PJFpej2Zsf4Bm
	/2olkdF9ggt2D+gi991PZqCKOgEuYDDp9nHePcoVhhyxEvw76zPMTh6ngPL0/UYL6mZNVos0k6W
	rphg0s2bC0lJdiUgon3ensrQdJQ6iuFaH2+vYExseJpQihI25pR77o835p0oeIwU=
X-Gm-Gg: AeBDiesYb0BpAGbgTWhaIjkLTVM32K6PuirINb8w+9uyJUpF1sYFTWpjtfLYoQvX1KG
	vZy09NJv9ioGSwWyR4mKY26VAr+wbXtKL7XGwm+HWlI/tyN2sEgY+B/UcXPBO8gwwyflFIJcZ1/
	WVVG8kWETTXb0+IDSDYdyJJWwmHYSQr+LlLxMcO8jTatCObTjPNK3HZdSe5tprXLeWDsXQUXiKc
	/37O2oZ8sBdLYz+941SB/ZE4tVtoDwBAYK78hOd/5DnJj6uYLvi22RoJWpjgNCtJXdB4XoxQA8o
	8ruhn2FCQf5WyPf74TFDJCt/om5vAUY2MS81mpib56jOB6TFy/yLEe2347Y8nWWdkC2pmQ4NhbE
	D526tNP0v4217hFOE93eFfpy7K+F0hq5An4T/iABKqPGzlqsC8PUG37HzB1hVQml5JGE=
X-Received: by 2002:a17:90b:1d8a:b0:362:e826:cefe with SMTP id 98e67ed59e1d1-3649206415dmr6932180a91.23.1777444954339;
        Tue, 28 Apr 2026 23:42:34 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8a:b0:362:e826:cefe with SMTP id 98e67ed59e1d1-3649206415dmr6932128a91.23.1777444953773;
        Tue, 28 Apr 2026 23:42:33 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0303d59sm2021414a91.15.2026.04.28.23.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:42:33 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v5 0/5] PCI: qcom: Add D3cold support
Date: Wed, 29 Apr 2026 12:12:22 +0530
Message-Id: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE6o8WkC/3XNSw7CIBSF4a00jMVwL4+CI/dhHMhLSVS0aKMx3
 bvUxHaiE5JD+H5epIQuhUJWzYt0oU8l5XMdctEQd9id94EmXzdBhhIQDfXc5aOnNhpjEIxi1pL
 6+NKFmB6f0GZb9yGVW+6en24P4+2YUAxQfxM9UEa915FH5oJGsc6lLK/33dHl02lZDzKWepw1Q
 jtprFobyxG1EkzwP5rPmgNMmlctvJbetQ6VkX+0mLVg89+iamuhhdhKK9QvPQzDG0GufaddAQA
 A
X-Change-ID: 20251229-d3cold-bf99921960bb
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777444949; l=5111;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rEjaiQ56SR1KUsMRM2T7xYZF8Samoy1STOTX2pwIjxs=;
 b=nFE7WNlOA2D0NObbgbm8Z28DulxFlIX8tKKG1NRoYoKSnvSrvGNO2dS6LRFn3a7VGpIm07p9L
 GKXMh5FoWDHDRWNtJMdq1UH/tRj5rH/WuJHh+F9FP/hR43OUVpHkfza
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=bvd8wkai c=1 sm=1 tr=0 ts=69f1a85b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
 a=JfrnYn6hAAAA:8 a=Z0v7mYVB04eUNMBhXUoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: lp9CKJiSypN_eJXUgVv6ZHUGjbwUh-Z8
X-Proofpoint-GUID: lp9CKJiSypN_eJXUgVv6ZHUGjbwUh-Z8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NCBTYWx0ZWRfX25UNf1a3R7K0
 Rz2O+Xh3oPk++1nftrv6PaXlqncYGZeagATU4fW0dZjcsR9DTdiQUsSO1x4RQ46v7Gntxe7ZGAo
 vBoE0GDAxKEGKXDlrEwoUoVJ6TQB5hoSYH4TT1jEcnrkBoYWA5o2Tyw0fxmfmZ4xmFdHzph1Bb2
 ClbVzpAWILpma9It57kBj04eWpLqqEAT5Vh9du2K3zB7oVblIAnI2ep6Rcqy/9caXF0EMiw6FeR
 9IeS/x/+DkWdcuPKMZgn5wrO98JuBNqz+e4fJFPybEc/ez1JjIM0DcR7eDmT+o0rU+z7yjRp/ek
 gaGOyBcKNqc8UkByyQm47012+J3fmGcOxncSb9VxfGYSKaMX4bsTPTSpvgIKIa0iCEITQ4+r1a8
 yqxM+Ko71YACgMpqRpjbLtvap/LqAp+8vuc+VHUfbY3Ae1uJylN/HZ+BozUhltkDJyiAKHZksEF
 picDPuKpg9aOwNuQSog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290064

This series adds support for putting Qualcomm PCIe host bridges into D3cold
when downstream conditions allow it, and introduces a small common helper
to determine D3cold eligibility based on endpoint state.

On Qualcomm platforms, PCIe host controllers are currently kept powered
even when there are no active endpoints (i.e. all endpoints are already in
PCI_D3hot). This prevents the SoC from entering deeper low‑power states
such as CXPC.

While PCIe D3cold support exists in the PCI core, host controller drivers
lack a common mechanism to determine whether it is safe to power off the
host bridge without breaking active devices or wakeup functionality.
As a result, controllers either avoid entering D3cold or depend on rough,
driver‑specific workarounds.

This series addresses that gap.

1. Introduces pci_host_common_can_enter_d3cold(), a helper that determines
   whether a host bridge may enter D3cold based on downstream PCIe endpoint
   state. The helper permits D3cold only when all *active* endpoints are
   already in PCI_D3hot, and any wakeup‑enabled endpoint supports PME
   from D3cold.

2. Updates the Designware PCIe host driver to use this helper in the
   suspend_noirq() path, replacing the existing heuristic that blocked
   D3cold whenever L1 ASPM was enabled.

3. Enables D3cold support for Qualcomm PCIe controllers by wiring them into
   the DesignWare common suspend/resume flow and explicitly powering down
   controller resources when all endpoints are in D3hot.

The immediate outcome of this series is that Qualcomm PCIe host bridges can
enter D3cold when all endpoints are in D3hot.

This is a necessary but not sufficient step toward unblocking CXPC. With
this series applied, CXPC can be achieved on systems with no attached NVMe
devices. Support for NVMe‑attached systems requires additional changes
in NVMe driver, which are being worked on separately.

Tested on:
  - Qualcomm Lemans EVK, Monaco & sc7280 platforms.

Validation steps:
  - Boot without NVMe attach:
      * PCIe host enters D3cold during suspend
      * SoC is able to reach CXPC provided other drivers also remove
	their votes as part of suspend.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v5:
- Add additional checks for legacy, integrated endpoints also as pointed
  by sashiko.
- for older platforms we need to read LTSSM state from ELBI regitsers,
  updated the code to read elbi regitser by sashiko.
- Couple of nits by sashiko. 
- Link to v4: https://lore.kernel.org/r/20260407-d3cold-v4-0-bb171f75b465@oss.qualcomm.com

Changes in v4:
- Added new argument to the API to know if there is any device with
  wakeup enabled and pme can be generated in D3cold. we need this info
  to decide to turn off power to device or not.
- Couple of nits in commit text (Mani).
- Link to v3: https://lore.kernel.org/r/20260311-d3cold-v3-0-4d85dc7c2695@oss.qualcomm.com

Changes in v3:
- Changed the function name from pci_host_common_can_enter_d3cold() to
  pci_host_common_d3cold_possible() (Mani).
- Couple of nits for commit text, newlines etc(Mani).
- Removed -ETIMEDOUT check and added -ENODEV & -EIO(Mani).
- Link to v2: https://lore.kernel.org/r/20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com

Changes in v2:
- Updated the cover letter (Bjorn Andersson)
- Add get_ltssm helper function to read LTSSM state from parf.
- Allow D3cold if there is no driver enabled for a endpoint.
- Added a seperate patch to make phy down in deinit part to avoid power
  leakage.
- Revert icc bw voting if resume fails(Bjorn Andersson).
- Link to v1: https://lore.kernel.org/r/20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com

To: Will Deacon <will@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

---
Krishna Chaitanya Chundru (5):
      PCI: host-common: Add helper to determine host bridge D3cold eligibility
      PCI: qcom: Add .get_ltssm() helper
      PCI: qcom: Power down PHY via PARF_PHY_CTRL before disabling rails/clocks
      PCI: dwc: Use common D3cold eligibility helper in suspend path
      PCI: qcom: Add D3cold support

 drivers/pci/controller/dwc/pcie-designware-host.c |  15 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c            | 224 ++++++++++++++++------
 drivers/pci/controller/pci-host-common.c          |  71 +++++++
 drivers/pci/controller/pci-host-common.h          |   2 +
 5 files changed, 242 insertions(+), 71 deletions(-)
---
base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
change-id: 20251229-d3cold-bf99921960bb

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


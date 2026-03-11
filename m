Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4003C9421
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224819; cv=none; b=qwMbLCyWPNPoSXKKhaoWr4UBEmy1auj/vnDbri2vnorPvJzuFYf97APuWXpDD53bATvVGue092moWyME2rJX86ZPjfOEEGMBukDLaaTBlJYPxX5BCCwTKYT1Wq3BDn1QBl59ANAqMe/3mtLmUoXbTzWQVTwougu+fG143yeZyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224819; c=relaxed/simple;
	bh=0roWHWaq+9JIwfuEVTAKqaeo0DsMFH0UtaWQXi8DhmY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B4GmeiOddfk/K4ZORoEU0CywP5xY7Fms5ArhXfsltb3nWwiFTwuOPxrdesoFOjHagRFC8R5U88RDBdObXcFZyhV5xuIVHDqIbOiL4s0CAtruD57uCMEdCwgPuwcgw1YbL6pjhVZ4ct0yTQQUCccfqOzlUU2ORpGBahUi6WdfAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OLwncwu/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZITOvwBW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OLwncwu/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZITOvwBW"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BA5fLi294284
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AtSnr/pzwqYQ0YYWzGf34O
	7TLaFW7or12l2zSbgjEgQ=; b=OLwncwu/HAPwFhT3jI8C08s2NPbDwyWZgIDD+L
	DnoF14RK27L+sFtE74vZKXb8v/lIESP29fRP0bRtBGYyGLMKpXGeo531hUBN/HPK
	uZcup5BQv8OpZLc6U97+rx9iHE35MHhQ4Zh5XG6AAdQhIhr7HfjpidGC0IBMlGsw
	+cu3nA7pkw8hi1bO+GCpRVnfh9ca8KaxyZaIudmQNsNjFFecLdExMSVPiKHyKUa6
	FUeUbnU9iR0LsLy8EiVkRyeGqf5jq2R3f/45HfVcfQsVtJoqPpiZCGRBWnMOpjmy
	SCwGqr4faJZe9fW3vxxx6VIia3gQ4qj/Ha2stLFKX645FKnA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu6bb82kw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:26:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae50463ba8so568019845ad.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773224816; x=1773829616; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtSnr/pzwqYQ0YYWzGf34O7TLaFW7or12l2zSbgjEgQ=;
        b=ZITOvwBW5GD34P9FnKeoI8/F09kNmylADjpYiu4yX2FW7Qs0I99CXC/BghdA6zTg7N
         mKbIadYQRNdAlMWigv1884topHiictAprAtquKVN4M7/EfHbC6iXWA9B5OKe3y3hz9An
         OvoThD9lD161hD8iuFe7JVbFBA07w3U5YmS8ReTUfiDTSXteKuJuAp+OzN1eTcDCy7rU
         Cup2T4btYIcKCty+ULjSy+KinPNBLz1W82U126mYlMm1pH/Sis9KKN+k9RcSi7Fqgfut
         WuFCatcNMUAUF/gaJNua99312tnjPdJMAJIFPXeyDOMO+qBRyOaRQwX4J2UzhAbwm7jv
         w62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224816; x=1773829616;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtSnr/pzwqYQ0YYWzGf34O7TLaFW7or12l2zSbgjEgQ=;
        b=M+5hC1T18yIPiwuQVSsm1tSQXuOXlq4Gal1RUyHDfu7StiF3gJW1GXO7Dl3FOWS3Re
         Kiv9KlHPBKdyuyCFU2i/fSmZV8ZunStWxtmhQ5JVgssyhl8JqzbgJVzlOfgxJdyv/5Do
         buGfag5pF2hG2tdTFmFOP0n1xcT4DOYzg2UHrAijPJ06iyE2Gpht9KpNZECX8rWDgHCs
         njeJ1xhfxKJwtjain+NGi1fE/S6GJ9q3DBMU4+3rrVefJBYFrKVhfxyJl6WmMyUJ5yBw
         zXUCZdVoHpG/E7N4pKjfnp9FfyfncCRVSD5wtykMeQx9V6vTFO4vwR7jqOuS80Hlzct+
         dZ5Q==
X-Gm-Message-State: AOJu0Yzz+KW7zunZzKzrjBp9+BxiVIeG2yY6U3R0WLDeZwVrQWWy+Hs0
	etRF5EsYV4RVYiRrQkOj3OSgWDUDnJYiqmxmmK+CZLkx5TCTmvwK6jl1wNAqkaZ6deaYPR3rb9C
	YZxw/IQseQGtY5DcEYOiwz875r/STS2F4G+eWhH9rFmc8gDt3nZGWp4FhLI65OkM=
X-Gm-Gg: ATEYQzxrgGClQkwdkEjGhKrMSgZ0yrARipQ0XE8K9B+wrbMx4QeY1KjjnteDQIuOqK8
	2fqzQKP6xj2/IMSPPrUuFKyWYwjy5tR0zkTKnTF5GCZINN6LiSc9MWuyhEZ386tqDHxbr9jroqG
	iQ6VY/iMbLWKCKedLrOZREVWVFUeXjKqLIKqXfdIRTDc0JSzU9nNMuEjw+tD2yJpcir9xw+ygut
	zWbsGXc1UlgjstlagncaUDVPxVolD0/9iD1tIOOmKczgXN5TsVdGDxJM9CpxuI0VZJF9Tx2E9se
	xgN2bj1lO/ZEl1iUZMNEBzVGdDXSZvG1+L6Mt237EpBAPHuQrc91LtnUVfvhP2iwedPXvr4gOV1
	SqjFXzSiwmySS5QJqOzYfYZHLpq/mJh6/HOf9vj4wUn7irM7aq7bxApNc
X-Received: by 2002:a17:903:b48:b0:2ae:5b64:12e6 with SMTP id d9443c01a7336-2aeae888648mr22133035ad.38.1773224815823;
        Wed, 11 Mar 2026 03:26:55 -0700 (PDT)
X-Received: by 2002:a17:903:b48:b0:2ae:5b64:12e6 with SMTP id d9443c01a7336-2aeae888648mr22132685ad.38.1773224815269;
        Wed, 11 Mar 2026 03:26:55 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222872sm19575245ad.18.2026.03.11.03.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:26:54 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/5] PCI: qcom: Add D3cold support
Date: Wed, 11 Mar 2026 15:56:45 +0530
Message-Id: <20260311-d3cold-v3-0-4d85dc7c2695@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGVDsWkC/22MzQrCMBAGX6Xs2ZRkU2viyfcQD82fDbRGEw1K6
 bubFtSLl4VZvpkJko3eJthXE0SbffLhUoBvKtB9dzlb4k1hQIpbhiiJ4ToMhignpUQmW6oUlPE
 1Wuefa+h4Ktz7dA/xtXYzW75LoqUMxSeRGaHEGOG4o9oKbA4hpfr26AYdxrEuB5ZSxp+NbPe1s
 dhCKo4o2oY2/I89z/MbQhO+3+EAAAA=
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224811; l=3914;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0roWHWaq+9JIwfuEVTAKqaeo0DsMFH0UtaWQXi8DhmY=;
 b=BiHYt3kkPvBXICm/9in+VC/Njx2c911zUi7hE5MRbt74rQVdRgwjYJ/mDOC26hMb/bIpr/DtC
 xVWBvMzRsb5Aic3UIwVcUbtGRRibwRJsCZEKJkngMLWt+8S8j50hAZG
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: ENjLr0f9idJCH0OzBiIyA5aOR6bK9vOC
X-Proofpoint-GUID: ENjLr0f9idJCH0OzBiIyA5aOR6bK9vOC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NyBTYWx0ZWRfX/NDIfc0HKgx8
 G3pOTnnntOos4aD3Y6hMb/6mmWMgFYQENKaAekwp0T7CGZl0/RBTO79Px/aaaVGa9f13GMNdEWY
 eee7pscu7mFQqf4f8wXEm5YktgDuOL3oDm3QV7wogOf8CbqKpZZH/5YWVgqIgYrMODNd4dk7Mfd
 cVu4yL46ASAAhI+ewW+crtURFcUdw/oydZV7rjorut6ZsYjq5vTEZX56PpW0BdvsX8ZxHHggknN
 r+FCVtP8vE24Br05nbdyQuzkWF7VU70900TVkwuMG4jNVkW9y9O+Q4ez8LemIzjVr9ELmKHZdBc
 QZZmQQo5ZSULamM/7h7pthsCv6k/TEG6OH2ViMmgO4vV8uzBXU/roVYw0r0x36MmnHcGqKEN2LB
 +Vs84ww/MsZDjCinac9826sNlOl1mSzUZrrGKK56251z+tpwyf2seowsogccR4vqAlt5rOgW9SJ
 U9Km9tXql435p3AoXiw==
X-Authority-Analysis: v=2.4 cv=CKwnnBrD c=1 sm=1 tr=0 ts=69b14370 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e1WyCQ9WWvu24y8kmCgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110087

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

---
Krishna Chaitanya Chundru (5):
      PCI: host-common: Add helper to determine host bridge D3cold eligibility
      PCI: dwc: Use common D3cold eligibility helper in suspend path
      PCI: qcom: Add .get_ltssm() helper
      PCI: qcom: Power down PHY via PARF_PHY_CTRL before disabling rails/clocks
      PCI: qcom: Add D3cold support

 drivers/pci/controller/dwc/pcie-designware-host.c |   9 +-
 drivers/pci/controller/dwc/pcie-qcom.c            | 165 +++++++++++++++-------
 drivers/pci/controller/pci-host-common.c          |  47 ++++++
 drivers/pci/controller/pci-host-common.h          |   2 +
 4 files changed, 167 insertions(+), 56 deletions(-)
---
base-commit: b29fb8829bff243512bb8c8908fd39406f9fd4c3
change-id: 20251229-d3cold-bf99921960bb

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


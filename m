Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3803A1D05
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567004; cv=none; b=sHDKXeOtKmKk0q8Y2Xe4OJp2uXDqRY8MExh/z2WNe7LWt7QpX8XC6Q/Gqnsiw5p7OhPejVp/40bMcWxju7/KqZKyQaRsSJ7br436xZUjsuMYRYYeCHCNAcb4arZOdceE7K6l+Q7cIfuUQ1oZOeu+xmz7ljF6+LeGSS0w96aiJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567004; c=relaxed/simple;
	bh=bbZHPBwF0Y3DBIKbxtiScwcSKdeSgmMbid936OxbnBU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pkHRI64HfIAk3va8U/HzJrhQkci7hh1vcGtrEa/NFwMXjWojgDxDzn1SPlyF1k2d8ukHnzuT6/pGB+CTLPhUywzb0tLhuc+4i4whbQEXmwu8rLSw1+JCzWmRF0488BTbFuelfBb6VMZrJ49NoqSMghrIgOjl1GNJnEwxeLloytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H22OXZ5d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pl6F8mjM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H22OXZ5d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pl6F8mjM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CUajk493331
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 13:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EWfiOTUoMlsU2KnUtPmDzh
	DH5pQC5b/7NcEX/ql4yZI=; b=H22OXZ5ddH0SJQY6Os/LiT+625TJYyTYzyuCUF
	TZYWDMdjkRSss8plmfoBBM6Ng0i4A5guCSGs+sa4gSNwDhOFAu+3JiMniPXH3UTh
	bsBbSFTvJ3CR5jFXLQoSwtbnauWHZC/PQufPKl20d5fyCs4taQXytVpy1hsoJQsq
	RrmI7M340+JMnJwSk7L1gpveK7m9JWIiLA3xqwFNN1MU60G91y/iNuFfQcS6QVCq
	CPQM3puRQiVGnTzq2uRTkcSQei1fTW7H577bcuLYgOAbq+btq9S6fmFwz2uT4fMy
	DptwRqFxYGK39BkfcD26NhnNMAwvM4uCnfvgQdyTy4BlP+qg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8trk4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 13:03:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0b57e192bso38832685ad.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775567001; x=1776171801; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWfiOTUoMlsU2KnUtPmDzhDH5pQC5b/7NcEX/ql4yZI=;
        b=Pl6F8mjM5It+LLzKP/hXPSmky/0JW1PY9B0nYQ+dqiljHBExdmWIH7t/dsGNxXF3O0
         1xD5SfEIkIBGqwUCrqBJ0iHV7GnKBN0EZs3J5tdoZ6WHt1v0x6kTkTyW4qdKrqNXVzxW
         hR9DYnkvQtpxW+SvQl406c11EAXnaBHjk8YRv9OY9n1G2PqcplwUy02VbpWE/O/xKst/
         RdpEm17fdDHXjAEwajpm5mzVB8lz7u3A55Kpzn18JnwhvHJYerd5Xkkpe18aKH6I6N0f
         WEAbu5jeC61uX8Ujp+Vkl6aGiUfbt9XtSHoVF+RreyqQmUGKL1vPy2SzJW2CI8ILTlF9
         Yo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567001; x=1776171801;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWfiOTUoMlsU2KnUtPmDzhDH5pQC5b/7NcEX/ql4yZI=;
        b=cYi/24txkXHRuFXFBJyn60hrpQY9MswGqhqUY5ayFVamPCZDhQaizD8in6iks/a/Yh
         gxU0ZnwzlX17wT8xNuLhnF5V/9sp418FrfWM5GFI67E+9PFMN2pkGCJVZ1EZXVqmIvSa
         E2OcjtlMDxbzHB5rULDOmFgeAXKRyVPn38M+lS8yAHHP1umFyuq2y5A383cGj3bEUMBL
         5lkZ6OFEFIFw+d20DtlinKw6WaZLXLoS3YVWN9oBvYjThdT2bOztmVONOkmijPuC/cEH
         i6wS6fdGvLu+vIORnsc3Oo00KRFtebPYqWhIMVQtKFChY8FSbPbF8GZ38rJMnjoQLuRU
         mqSg==
X-Gm-Message-State: AOJu0YyHoByFFg3oyuIfqUcfGKgFgvrVjMXy9ovltnVIAaFWl2iz6T8/
	zaiqibVZ8ujyCALyPVvghtWYIKavTMONOKiW+k++lCBd1BO2ZocSOVtJPv3rnFoO9f5lweE6v6Y
	oVJnwlzTvi9iFJaHOY0hlysGr5oLq6Gl3QNUBADd0pXBpEs2295zyBzvZjVfJ05o=
X-Gm-Gg: AeBDiestThl4hOso8alRt72vQjGbk5R5+VPIpd81INrMH98CxKR44Bhs7XpcJMB8wnk
	WJRXw0/thF0psEQtKhZfj/SSXB63DeHEGAAaVTgBFclYd51c6WQAm7f9Zly/FFZCxyIGY4NqzNp
	guD394hkto7Xbt4FeXZ6jnKPsJ1cp2VdmnwaV8jr/Vlk8ImnAzS0fx8lsOiJfeqpTugbmT5Bjam
	cg3d7vF+CE6aPEoFyflPlsLN6Q75L5yjr9fI2Foq4NtPi3tb4/laK7NiirnnwsJIapYaaoVV9j1
	AGWFGhzr0sXOwj9toMAwo+XANu3NZ/ixFAEva+fKYwJNSaM6Blvyu09WLjwq/IdEDCg69SjORn7
	4byWWOIhDPRtdgQDmSnqpEt16bar4ZnXnk23zHmK2pI+9VNrzV7O2uMLo
X-Received: by 2002:a17:903:1b2e:b0:2b2:4a9a:b149 with SMTP id d9443c01a7336-2b28164b6a8mr163831705ad.9.1775567001073;
        Tue, 07 Apr 2026 06:03:21 -0700 (PDT)
X-Received: by 2002:a17:903:1b2e:b0:2b2:4a9a:b149 with SMTP id d9443c01a7336-2b28164b6a8mr163830075ad.9.1775566999609;
        Tue, 07 Apr 2026 06:03:19 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749794e8sm181564885ad.53.2026.04.07.06.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:03:19 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v4 0/5] PCI: qcom: Add D3cold support
Date: Tue, 07 Apr 2026 18:33:07 +0530
Message-Id: <20260407-d3cold-v4-0-bb171f75b465@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIsA1WkC/3XM3w6CIBiH4VtxHIeDD1ToqPtoHci/ZFMpKVdz3
 nvolp7UCduPfc87oWgHbyM6ZhMa7OijD30a/JAh3dT91WJv0kZAoKAAEhumQ2uwclJKoLIkSqF
 0fBus8681dL6k3fj4CMN77Y50+V0SJaEgvomRYoKNEY45oq0Afgox5vdn3erQdXl60FIaYddAq
 01D0kIqBiBKTjj7o9muGaWbZklzIwqjKw2lLH7oeZ4/GYnYOx8BAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775566994; l=4316;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=bbZHPBwF0Y3DBIKbxtiScwcSKdeSgmMbid936OxbnBU=;
 b=qB71aTfgISqqMCT6mCJwX0p5orSaap73x00G+PAaNBw94RsyjSLRYSvbPHid5mkc7BTNk2a1a
 GsosDzP4BIOArgbVzPjURXPk3AYKV286hmCaS8667ujUbbc2zZlgn5c
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: tNVzSgRT-25_M5oUgmPbDUOWhmq3b8jo
X-Proofpoint-ORIG-GUID: tNVzSgRT-25_M5oUgmPbDUOWhmq3b8jo
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d5009a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z0v7mYVB04eUNMBhXUoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMSBTYWx0ZWRfX7SGZ+vm1usCb
 bD5dGaTOCT7s9dr1o4UvHNCC8TUD1IipRE7FjjcdL+syYjXLp1wCJL2mmohpUTDWJeeUTLNkyoc
 svckqnAUVxWnrdMYo6rXtAVtcrb3d7af8h1a76BkjrE3dibXvqdovLzWsO/XQE/4mhHavnzf5cn
 Bdf0B4GKV3fqPBGk+pBjuBnrd2SHRjMSYoIW/eFeyikbxVcQjDS8pC4Qq2zS3XyIPjURPN7xfcn
 ybJ9NDua1f1zaY8bElTcnpU8Ium0ahSMYlRRlClLgKUcVb/Oj8OLmHJH52vE0BpaEyp5wQQM4aB
 kAAUbgr6N1lEJjs0xl+CZTBI7T+WaxJWnsQn5LMHYE9fONb9DcxODuizi8Q1yH5nvGnfpylFbJd
 PSTZRS9QB19skvVwO9ecx81wR+Yk38M/t5PyNR/ea1N1rSqq/7vAIjIAohTtVSi8QF/AocJKVUY
 BidTij9nbQoxVWRXzPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070121

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

---
Krishna Chaitanya Chundru (5):
      PCI: host-common: Add helper to determine host bridge D3cold eligibility
      PCI: qcom: Add .get_ltssm() helper
      PCI: qcom: Power down PHY via PARF_PHY_CTRL before disabling rails/clocks
      PCI: dwc: Use common D3cold eligibility helper in suspend path
      PCI: qcom: Add D3cold support

 drivers/pci/controller/dwc/pcie-designware-host.c |  11 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c            | 194 +++++++++++++++-------
 drivers/pci/controller/pci-host-common.c          |  63 +++++++
 drivers/pci/controller/pci-host-common.h          |   2 +
 5 files changed, 204 insertions(+), 67 deletions(-)
---
base-commit: 3aae9383f42f687221c011d7ee87529398e826b3
change-id: 20251229-d3cold-bf99921960bb

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


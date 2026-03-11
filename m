Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF23E359A96
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232848; cv=none; b=XbXoCrZsCUUiag2rgfn0aPqJBdKh2ndKS5xSOjMU4Dp0ALwXSNqYaZ6fFrAsZsddzs6INenOq0ufCaBrsk+5mfUKiCuOMfUU6wVFumZ4QfMWx6apSeMeEKdYzAYl8mIScynSnxTgtM7OZ10c5g6N1ElOD64XkfuXvDbok+ML0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232848; c=relaxed/simple;
	bh=yeNLhpwlGrnJbUWstvtgsoL3I1MN2Q+qCaW4VvGmYX0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZD3T8FkD+0S+ZTum/X9R5A/0dUxKOE8BdfvZNXTKcfRjK3hx8VW+dK8gmgcrbimMHOgYgr5JZNVWgomD8qAMs/GHyfBLdmygLCBjfGiTbscbUBcxZ+Edb3F5Nte8rej+3PtsOdtcxgxy4YULUypxmNJBcWhVdaqxtTlROgvnH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p5bSeG1n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VJBIeffg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5bSeG1n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJBIeffg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9GXRP614152
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1yBMq/jTKLHJJXy3GsinWi
	QWvtQ/crKeIbCkXbKmlHg=; b=p5bSeG1nGeBMQn9HG1XObivj8yO6+CChfscbkt
	habmsQdfyc/kBMmX1ZTANuEZzTsiicvZXNT6pKa7oTHH0GroxwqcSiex2CiWU7wW
	sG2LAciLCKVqePx8NXMqigqIFwhocWEw1vvXXo2j7rHrox6PK2EexI+3XQ6jWZsF
	snfyAGzF2jJzZaL0HkPmkyixx2lbs3YZDfNsmAih9zZXCaNpBGdFnmKtQhv5OIIS
	HJNM3246AjFaBPlc2RhUlDUkaAF81BFjX19lkdp3sJdufejV5bAj9CfdHS3sU0jq
	DzMt4pBNzIfM5KRbDTb8O9mFReHriSV2M6O4nUvQSo4Z/x5Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf1wf1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:40:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae4af66f40so112540105ad.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773232845; x=1773837645; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1yBMq/jTKLHJJXy3GsinWiQWvtQ/crKeIbCkXbKmlHg=;
        b=VJBIeffgu+8rqgRk6CibLUUqIxH7UpqMTc+Z9W9Sj/4slvna8TdFGK2eSJi8CWbwZl
         IvT4J7QpvGXDW41UWSh3FrMduUkB3wj/id00BbK6gtLix9JgeyTcR7TMXo6QQif3/ejm
         2dGoYCqVu1DtawaV1IClGcBad8FvFHQOp9MTpT/HQKjAv73ox1Puqdsnw17R9/5O+psZ
         IeQu1VIVFoHrS97fyj0dRo148Yt7WANBdnB407iE/onZfS3eDakKIIIHY4rwa/sdx8T2
         kDYBgmdTqDrPXQT+pbg4Rh2bLXl3wPYHN1Mckjxzp/4XDaRy5xLyPP8mteSvrSV8y+eP
         /Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232845; x=1773837645;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yBMq/jTKLHJJXy3GsinWiQWvtQ/crKeIbCkXbKmlHg=;
        b=Q8x3NuixBay3494NQryGZCU7EbPUuzXAhAmyt7woNotWtWmJ2Z/L/x9wTnG1PzJAUi
         xVTvlj55H9YlMISw7Zj1pJxHAXmovq6gT1GmwpEkJU7FPSh1Gf8K6rNQ37QfcA5Swt8t
         nobQS3cVZueoyLofqfBTji+I8e7GHDwFsfRwv8txK3+ZqcrCEvtIHMwKq6iBADs7Nnxz
         HTs8u+VQzkRZ5TEYt62QN0C1+jYqDnxb83tDHLhnDW7rU2/gHwWi4RSr1G+ZK/v03dYA
         EWoGEtBI+e9RgCc4h4A3ZbXH14esnsfbH1r8EyKh9FnxIvnemBb0TADG0kRXo0++tMtF
         aMvQ==
X-Gm-Message-State: AOJu0YyqDgP0XgMLn3FGELVdxkliiMWz3jUsj83ixFEcL/l2HOf4Ggag
	EtAKyYBYcRaqoqTWfFRNNRBHgLPuytGaVIw0w1R3Qi/HhQogPa2ckKtoq+mUQ+4a+WMWR/6L/we
	yqaC+sg4egE0Fxpk+rvrLL4p4fyUNVlJEXKIlpVufZPvHWrk/fOekENM4we+sKWs=
X-Gm-Gg: ATEYQzwzIiart+/lGd6qijpfzoMzdr24HdhyrgpbrwK4fWGIFsIIEfyOKAk2BmbqZEO
	RJAmkBl4Ocq2loxSsSTqKvmRXGUvrpJQs5ZA11HzfXC1g524OxhTiSrej5ff8Y3NQFJtmZp9J4i
	Hcp9dL9KWF9QCGaHud+wgcCJd3MAsN2ziP8pebUhQNX7WsT39ecYFIh6dr+ZtLWJHTZyO8Z9h2k
	WSfdb6lJpueyqDEV+hvzv73ylIJcli3vJCvau5D0h/8LbxZ327uQiAuSEGQPH3uvniQDakAE3pB
	qhRMLYbYFl/6MuFWr9IyKGQzXrchG9AHKsXtWUFoNS6moreSLV3t5vywyCTy4PFx2lVcnA3xctL
	s3YNSvddS8PP2gZdtUu1yRAJ5XjrNMJvQLRjDT5ogJPd3T4NMZlUI1HaE
X-Received: by 2002:a17:902:e84b:b0:2ae:54b2:27d1 with SMTP id d9443c01a7336-2aeae8eb5f1mr23906455ad.44.1773232845515;
        Wed, 11 Mar 2026 05:40:45 -0700 (PDT)
X-Received: by 2002:a17:902:e84b:b0:2ae:54b2:27d1 with SMTP id d9443c01a7336-2aeae8eb5f1mr23906215ad.44.1773232845015;
        Wed, 11 Mar 2026 05:40:45 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae2466a7sm23304385ad.20.2026.03.11.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:40:44 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/3] PCI: qcom: Program T_POWER_ON value for L1.2 exit
 timing
Date: Wed, 11 Mar 2026 18:10:37 +0530
Message-Id: <20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMVisWkC/3XM0QqCMBTG8VeRXTfZOerWuuo9IsTmzEE523QZ4
 rs3ha6qmwP/A99vJl47oz05JDNxOhhvbBcj2yVEtVV31dTUsQkyLABYToeyt0/tStuVzThRwWr
 F95kQMgcSR73TjZk28HSO3Ro/WPfa/ADr9y8VgALVl0IC17loanG03qePsbope7+n8ZBVDPhRO
 EPMvhSkjCJTEgE5CiZ/KMuyvAFKupLI+QAAAA==
X-Change-ID: 20251104-t_power_on_fux-70dc68377941
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773232841; l=2442;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=yeNLhpwlGrnJbUWstvtgsoL3I1MN2Q+qCaW4VvGmYX0=;
 b=12G+fhC8nr09Onw0LGr2UzL2F1j81HO9yguUWiYoDN0IDdcWzZxQUXtFY9zG0SiR1qUdElYJF
 UXdxUva+L9qCrzSMtR8vWc5zuNEYBZBOclZCcHHGifi/ShOQ/FcYs1X
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: Fp6y5FQeIswLlkJ2tq3xvNHX-IRacxZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEwNyBTYWx0ZWRfXyXQ/4Q2b+A0K
 TWDt1EKDELIGkjdBjHCMLS2LGgIyzc2XpNioFctwd2y/8b8JWuFVuzh2exYLlVk/IBkuREIg8oY
 3xTfRmREEKcqzgPtIEw3DXjy+sXxtuMX7BbmosRMfeZmzfc17njZOPlCUkkPNioF2xALfFCIXaD
 vyuXWUdYSYSrwDbor8X40sikwTMv7RVJhl/i7RKxy+AY+pmXvDc73T1ar3oLHPovk2Q9H+6B2Li
 s1gmKgBm+6BJWZ6OmC85rkPsPfoUBFFI2KlPgSapJCdEm+Q1jk6fUucbeZ4cFLDWZ8i9l1fnfQE
 o2YWcpGjkU0zMaQ2LuRaYEAt9pgVfx8QUmkOB+3aoXPEFRT7jW0MJs7slgkn5X+aG146RG+scHA
 fNS/Q7liy1GufywShgtu5qj+FvdtZliAmtRO3OxpvR1ElWBPFC15GZVRJ9JEcqcWRVe9RcGIZHu
 2zQKV4nxod8Ew64tUfQ==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b162ce cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=l8mvWsQ0dvX29tmygDoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Fp6y5FQeIswLlkJ2tq3xvNHX-IRacxZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110107

The T_POWER_ON indicates the time (in μs) that a Port requires the port
on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
asserted before actively driving the interface. This value is used by
the ASPM driver to compute the LTR_L1.2_THRESHOLD.

Currently, qcom root port exposes T_POWER_ON value of zero in the L1SS
capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations,
which can result in improper L1.2 exit behavior and can trigger AER's.

In this series, qcom controller drivers read the devicetree property
"t-power-on" which got merged recently[1], and use that value to over
write default/wrong value.

To convert T_POWER_ON in to T_POWER_ON_SCALE & T_POWER_ON_VALUE created
a pcie_encode_t_power_on() helper in aspm.c and also created
dw_pcie_program_t_power_on() helper for other drivers to use these
helpers.

Link [1]: https://lore.kernel.org/all/20260205093346.667898-1-krishna.chundru@oss.qualcomm.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v3:
- move pcie_encode_t_power_on() include/linux/pci.h to
  drivers/pci/pci.h (Bjorn).
- couple of changes in commit text and variable name like t_power_on (Bjorn).
- remove return 0 from qcom_pcie_configure_ports (Bjorn).
- used FIELD_MODIFY instead of FIELD_PREP (Bjorn).
- Link to v2: https://lore.kernel.org/r/20260223-t_power_on_fux-v2-0-20c921262709@oss.qualcomm.com

Changes in v2:
- Instead of hard coding the values in the driver, created a devicetree
  property "t-power-on" to program it (Bjorn & Mani).
- Link to v1: https://lore.kernel.org/r/20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      PCI/ASPM: Add helper to encode L1SS T_POWER_ON fields
      PCI: dwc: Add helper to Program T_POWER_ON
      PCI: qcom: Program T_POWER_ON

 drivers/pci/controller/dwc/pcie-designware.c | 28 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 13 +++++++++
 drivers/pci/pci.h                            |  2 ++
 drivers/pci/pcie/aspm.c                      | 43 ++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251104-t_power_on_fux-70dc68377941

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


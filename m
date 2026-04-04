Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C933B6C6
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290649; cv=none; b=Qi0+IiBwxt1qmXmJwSQ//bCwKQh7Rv6P9BDKh6cD8RZz0pCyBrjjzNCrOKyt/VRGiTI7mdRB/2xcMokYTBppZ05QNeybuBgEHi+ezFUkjVNyKF3qZUq4OFaZ1+htvCc+OWBYspRxqKfhb3b+9RJOuEk5c6MK+fJGUzitQrZZgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290649; c=relaxed/simple;
	bh=qdnUNga94uLcJe/gNdftrxaAv+ogb/QdF4r+eQglgdQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jA9xc/Tt/1HD69IVobw9jpL+GU4AracTsFYW8tC6F2mrZEehV/NvSu4+INfnW/hyHGjXA6voD5/eiNYGQEPhrDfC1ESxSKjsDvSe/iVfTHDqZs6Sq+nc6JJbkeznuIDvEsePZo7AJtbW0A2xFUjIfbabgXJO3TS+mRm4zKwf/5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SF7xY7+j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eK9sRvDl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SF7xY7+j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eK9sRvDl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344eH6s2973615
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 08:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=E0FV6e2v+ZOZtHenrGTq02
	JA87NDx4JFU/cHYtMUrU0=; b=SF7xY7+j2QMKoMEhvuzR/PrW8tNAO7IufJrjGT
	ybeesYK0kQmTvbgnaYtVUz12eQnoPD2ORMVGxH6wXbzoMyNE1TJs3rEURv4XNh9j
	pEV8kbkwu1y7B9GDqbsia7k6g2XxkYfBg/Z9IdJII6iLyNkrjMj/LIu4haargLGR
	lfYD/IecUqeKMhGcDGrVLOd2MYSfR/YxJcp9qM3+F4GbfJy0zqscKIOb+pyfiuyu
	+U+SYMeA7hQaEqLAWNhx2ALsyfa5i+3hcw/SV61BHDqQPM3RDtm/gtjxN1HzH+cp
	qsIfAls6H5aJRZyge/wobxVozX9lKcHJWzEVFKsfR1yHiAKg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dauth8c8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 08:17:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7651644975so1543258a12.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775290647; x=1775895447; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0FV6e2v+ZOZtHenrGTq02JA87NDx4JFU/cHYtMUrU0=;
        b=eK9sRvDllvciS36vFWQMgDNVbE2cB2ZdSvR4OlTqiFQ1TGOn/p0QTpZxJR+R5fmNSq
         QeQgbhcAreFUC7UG0QBb52m0Bw9b4ySNInCZ8nCVouE7KATv8KFuPUjqH3y6jOvVo7vm
         UE1Mffp5lx4WRtlDQQ1HrevDLafYnuvmeDUAzYo8ZtkEG+nJcVCJXzovsZKtkDBlZZaG
         a/BroKD9DLA5je9az1HkxUhaFBJXr6mwDFoMGBn2NOSeWf7EgSBYb7nVId4oV7AWb7HV
         WuUquLUdNsm0+8qihpZq8xZaycfWHdeS9j6YoIcZYby8K4FK0Vk3C/GUiYeEFNxDUidK
         6r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290647; x=1775895447;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0FV6e2v+ZOZtHenrGTq02JA87NDx4JFU/cHYtMUrU0=;
        b=YwehZCg4NCbopocRMIf8fTv1kG6nZGz5HcirMkwuHCB3N/1/gRLkuPzx5GdDlNEFTh
         JN5Ve3vMJwndsROSVVqb0SFA0Kd69Vr+ca77prdVf78vcphxAafa6nNOx5uglfBrlK4r
         UukICUV4Qx/uhOIKQq8b64jlJMHv7iuAQZtjLq8uoqg6Ynh6F/mt0SkCBNtTKktC5f0f
         EHuQ5jG3XF2ZRlJdF9nDcY/SvwZEdzQE6Q65Pp6Io2maFkklL72SGm/X8w3btLZVCSnJ
         Kqc1ha/u2X9tiECTkwis+fiVhp0eYAmc8bgA8lpIq6f1leXIRC9iKLmGKvEQlA1i5K6t
         bOHw==
X-Gm-Message-State: AOJu0Yw88jMID88T/zjMEQpWT8zQbga9APZyVapMw7xTg4a1BwhiVilC
	ZQGxeDbMIlSQlNqNXuHRfpul63q2IolOzp1syNXKNwn/xtOekVURTLJRmJgG20PmxIiWiX9mn4P
	UkZ+ew10NdrhWfHqH9PCiBCksWaKdw7k0vaM+sgQfm5obIs9/+n81WlHWHdzjyMA=
X-Gm-Gg: AeBDieudHV0EuCO2adg1L42QDzVw2CIAReb5ByTz0pw7fj/faWWSQBrl/YA62yGIZK8
	woS6xBZ8BWMzXOFqUHSvyrjc7tf+/V1PzN9ElJ2zFuJA8EWF+n6nvXu0duFP7hLBuyuQfaykJn2
	P5B7OmeO8fB29M2+cbHNg5fBvkkJKYExSxOBsagju7CiF/KJro14DyiGE/+OJWJMktql9oZoGfr
	jPA4iARsCq1jSMNKT/uTcuAKm5y995LNUCCi7kaYx76uI2aKVRqYbsBw6fFjHJhG78hO8+mZ3HL
	3t3zCpbr5rJe1S2XYSxOB0wqwzp2+dI948V0H/cbPGrCxskChBS2o8YjPYT9VLaq0RMT8qZ91zF
	eGMTeWRbvyZdUcqJF0rYP99OIQRzkppEDvNgCCdCEOvi+5EUsgAC3X5rY
X-Received: by 2002:a05:6a20:7d9d:b0:39b:e789:7d0b with SMTP id adf61e73a8af0-39f2f174eb5mr5580698637.52.1775290646726;
        Sat, 04 Apr 2026 01:17:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9d:b0:39b:e789:7d0b with SMTP id adf61e73a8af0-39f2f174eb5mr5580664637.52.1775290646228;
        Sat, 04 Apr 2026 01:17:26 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm6786408a12.24.2026.04.04.01.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:17:25 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v4 0/3] PCI: qcom: Program T_POWER_ON value for L1.2 exit
 timing
Date: Sat, 04 Apr 2026 13:47:17 +0530
Message-Id: <20260404-t_power_on_fux-v4-0-2891391177f4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA3J0GkC/3XM0QrCIBTG8VcJr3N4jptmV71HxFhOS6i5dFuL2
 LvnBtFFdXPgf+D7PUk0wZlItqsnCWZw0fkmRb5eEX2umpOhrk5NkGEBwHLala2/m1D6prT9SCW
 rtdhwKVUOJI3aYKwbF3B/SH12sfPhsfgDzN+/1AAUqDkWCoTJpa3lzseY3frqov31mqVDZnHAt
 yIYIv9SkDKKTCsEFCiZ+qPwj8IBvhSeFHUECzVTWlj+Q5mm6QW7UbCDPwEAAA==
X-Change-ID: 20251104-t_power_on_fux-70dc68377941
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775290641; l=2785;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qdnUNga94uLcJe/gNdftrxaAv+ogb/QdF4r+eQglgdQ=;
 b=JI+Ew2L2ICtllEYmUY4chUJtRoaYvl+O1EM5DBsPbqNJfNAE1mfaqrrutoR/rNwACTrmW2c7k
 6wjUi3QwBSYACWTORG6JR0+jW7GqehdLZsf0DsEdkLF0MyJO4iGnYA/
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA3MiBTYWx0ZWRfX/z+PR+xlEkfj
 nXk/vowmD21wfEFD9cKrhZKeMJmxDSSft0G31Nyd+h+jRpVJNC0TmwhclZlkXp5xxHf2q6AJhx2
 WkRrn5j8qoYj9ue6lnDt3noE9sNNVxxtJr2armbW0MpZywFZ2dK3Afx5+E7X9dUp27QC7vgS2RQ
 UBQ56O9B5Itbrz1Osup3/0uPRS1JEXHle6EQDXwtH23X+iL0659bX/P9P+wfg1d2l0c87R5P9R6
 iI6hWm4DAKFEt7ISIQhzK1aAuZOLFEqg7UlNcTEo6B0+ma/8g1r3gUVxTy3Bo9zCZrODwRjBKWt
 0Jo4pRP1cwwYShZXB94u2l/0vPF3s07VFmDEiPtEfdhlyx1IreObpjn76YNeh6J8j/PCsGD2uEK
 G+V79ogBE4hMj7Q1LdpXoXfNIqo7yT5tuBRDp+RtEx2GDdEVR79Mo3UAgujfY9Tiz7A7fotAwhM
 QEluRmidVQvjuEYUdTw==
X-Proofpoint-GUID: B_U5-8f3cG5zc457GLexKUCSbU4lrO53
X-Authority-Analysis: v=2.4 cv=MIptWcZl c=1 sm=1 tr=0 ts=69d0c917 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8_GxwEYHqknyFer8HbIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: B_U5-8f3cG5zc457GLexKUCSbU4lrO53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040072

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
Changes in v4:
- calculate maxv from PCI_L1SS_CTL2_T_PWR_ON_VALUE to PCI_L1SS_CAP_P_PWR_ON_VALUE (Mani).
- added a todo to move the reading the devicetree from qcom driver to
  dwc once multi root port parsing support is added (Mani).
- Link to v3: https://lore.kernel.org/r/20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com

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

 drivers/pci/controller/dwc/pcie-designware.c | 28 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 14 ++++++++++
 drivers/pci/pci.h                            |  2 ++
 drivers/pci/pcie/aspm.c                      | 40 ++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+)
---
base-commit: 7ca6d1cfec80ebe46cc063f3284c5896c344d9a1
change-id: 20251104-t_power_on_fux-70dc68377941

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


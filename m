Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83B3314AE
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787376876; cv=none; b=H8VPpm0qVsKNSdQQT7Sk0KycoXgml2MTvqQd9m2dwmphWUBUIoVGI6iHSypgedUnJtQlbb8x6haVMfhu7Y/Jy73qJAi1ZKJrm3fa4MgCkyO4epPT3GaZalgQkQdDk0mR+fMD/YrllYd7HqI/DKBgGFH5XL1oHH0Ir/Tp2p4mdfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787376876; c=relaxed/simple;
	bh=RL91UTvYbZW76eRz+2B6ER0owSlhRMJj4Hr2EC7S1u0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aI1K4v+GUEsHgilEkRWTfPyyeFq4byGP9V+iJkesZxFdXg2ILRgNXmSzBw3w8hpiW5BT6pNKPrzBCFXHu2+6mmd8r4Ctv6RwZYnsU4MwalTbcW9DWiP0LCysD4/+MXWTMxIM8ij/Mc2T2CvpT/pdSk+lXIrwB9Wq5AJIV3yiH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m4+gR2QW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ES8kyyvq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m4+gR2QW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ES8kyyvq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67M4hhv11295573
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 05:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QUZpPU8ncvXJtUpgN2LTk+
	wqFuszyYUhUbUQUNpFo+c=; b=m4+gR2QW32FH4p6oEd5s5HX2ftRNOCjo4TY7QU
	pKiqUoEa+cbx/L1j1tFlLqkEJH4865khS9V9NBx/lPtNBI5yuCxOTgMLD67i0kNR
	9JtEF3cQC30sJqXA5tIRVvw1BR/44zSZ9E54dZPl6aNrpNoKSdnw35FNqGJvUxbW
	MikmqEEWfdL16ci+xrMmj7aD+u2XXPc8rTrsjlXl2Z98grtEf1OoIVqQR7tr5vBh
	Y2T/0nUerpu6cqqeic6IKkgulucKHIvvJcBtwWWCT1ekBjDWpiZ/s0WuAVuHwsJs
	5ms2R4i++jeJHSu27HFg5Ir1x0BHh7pu1AdXj6RoYg0z7Qbw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g743xg5u5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 05:34:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so30856835ad.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 22:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787376873; x=1787981673; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QUZpPU8ncvXJtUpgN2LTk+wqFuszyYUhUbUQUNpFo+c=;
        b=ES8kyyvqBOM/YA7qyBRHpI/Bdf5djpPNuhg/E1uukI16IDx0EftDW85zEBKWZJBb8/
         BsZOq8bTVthsunir1xCCNOh1wQMka8S/iXG91MbGDx73jOyueH7ktmYIwX7Sp4FaMDzO
         3p+y3FUGA+7QCY4l617+GsomDRBu1NR+gj3yS9puT+AnQGQxiieTJ60CbZ3cRblhTNoe
         ldgBiN9Lqoo9MBtK+40kDtE97942fJ1hbiAtA42wmZti5S8NlcuSLnGmR74G+sJsq7hv
         OnzTRjvVSEc5KeZz2DLR0xM17CoNgT322IucLVbD876TAigi6tVx2FUi9ELTsdZe7yOo
         bL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787376873; x=1787981673;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QUZpPU8ncvXJtUpgN2LTk+wqFuszyYUhUbUQUNpFo+c=;
        b=l2VSx6ZxNrqRRVXIjYYXh8Zj8K0kAQcOZy9SpWWcca2AEE8J1CEUwMuGMPjTbOHaVp
         VntGpBjUs0zXhVRaHsjLU5xMs/4kul+3Wqc4FFxGiSGgU/DyxaQmjm34Erh1XorZPSpn
         lf6tdiLP7+56hsgowO+B3K7rmqm0WkrTqjzdR8dme7if/1kcZNDQCoLBiPXK1+kzJqls
         LNYjs4YXQInVFs8BAWYP3tFgXmXV1KXDleSBMKsQYCRcdBf8FJd66a8DTk/v1ie7GofV
         JS84Lmnjo0FyNZTUGJHUpDcbCkyQ4+uEO1wQAgXDemDKWHn5Dy5fKXw2QbTXb2QRYRgV
         jhsA==
X-Gm-Message-State: AFuF++nbTruo+EuBm28EQ7eyIb1ksrAUt+WHuURXvzMnep35tl5VqVew
	+KmXD27xXFvu1aUVNrJCx1HOdm6RGbHc77ivoZFwSDmDYj5zbns+xooyy3b9ALM2GxVVvfOlzxd
	oZIJbQ2zTY2kd8bdHjdDpnJ7sG2z0GHd/bZvhbuXcx7a0xl62XfIt/GXFnuV9W0x1gr/zvmQ=
X-Gm-Gg: AR+sD11/ZKchB5t5ihTl1JKO0Kp13Xk6hDd7UDatFKo5bHSLTsy57CgLcv8Ak4cOv1q
	/P4ZiP9bSDoykjfFXDprMSZSjx+izKkpliQ7hTXmtnXO6Wj0WC2pE+h48ThdOachV0IRm7brPdq
	sxCSuTUirR4OhE/H7ZM/X6/647FMR/bOSgKCVSFI9BKGP/moMc182CBG0MAxgBk5/LQEfbJo7I0
	5g7GYuITp1KREsK+8j8I4iFpXJ7ZsTaxM4OFRBXH06YelzlYwF85dTcRZwIAzk8vcdgI3+ot27F
	a6hL3+zpoEyLufPfGbRBLp+1fijM7MBbJ6NK0y78eB9lKLvxnjHysv/e2mY5TsvNaAnlY1uZgZw
	TrYOy0DqHcf8s4PLHGDPbaTDjUkLuCsriCaY=
X-Received: by 2002:a17:902:cf04:b0:2ce:93a3:c16c with SMTP id d9443c01a7336-2d670cbd303mr61688655ad.12.1787376872862;
        Fri, 21 Aug 2026 22:34:32 -0700 (PDT)
X-Received: by 2002:a17:902:cf04:b0:2ce:93a3:c16c with SMTP id d9443c01a7336-2d670cbd303mr61687825ad.12.1787376872436;
        Fri, 21 Aug 2026 22:34:32 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f923490bsm3533807eec.26.2026.08.21.22.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 22:34:31 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/2] PCI: qcom: Implement shutdown() to avoid SMMU/NoC
 errors on reboot
Date: Sat, 22 Aug 2026 11:04:16 +0530
Message-Id: <20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANg0iWoC/yXMyw5AMBCF4VeRWWvCSNxeRSzQKWNR0lEk4t0Vy
 y/5z7lAyDEJ1NEFjnYWXmwAxhEMU2dHUqyDARPMkxJRyeQ3vRxWGSrTrNLGYF9AyFdHhs/vqml
 /i+9nGrZ3D/f9AOSSPuZsAAAA
X-Change-ID: 20260822-shutdown-fe8139dff2b7
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787376868; l=1462;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=RL91UTvYbZW76eRz+2B6ER0owSlhRMJj4Hr2EC7S1u0=;
 b=T5JnL24k7YKOPPNKP2N2/goCpN4xbp6TeV2YL6IZePMqyhuMFMSXDiIYbNPLglmbIy+qMFilH
 YQ/1NX/GbVZB9N0JBIe/wlu9Cyt+xMicRIFdbBylY8yYc3RY/6ElzaT
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA0MSBTYWx0ZWRfX/k8RDvMd79ai
 DA6qonrvweV6JbZ9/o1P/sZuIIjbw8SeY8LTGZSK4t+JwJ6s4hrLL58vt+SGTA9Dm3Tjna2sFXj
 f6MMUHkunqqYiloYZtxPlsQrGKPjfxY=
X-Authority-Analysis: v=2.4 cv=HYckiCE8 c=1 sm=1 tr=0 ts=6a8934e9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qIbWdXD6M1inJYch3NYA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: FIJGGrCM73QCA7vBlWQArmTraQ_HJIbv
X-Proofpoint-GUID: FIJGGrCM73QCA7vBlWQArmTraQ_HJIbv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA0MSBTYWx0ZWRfX3cmr8ZqQli+s
 vksLXFo7N+ihT2FJeJaroXMg8ge/EsOpOElJhFkrbYcXYxqZhgxHKW82ReZBrlOabuBbwqX6DMi
 nU52Hy41QXneM5oq3VcOXE4i0uZviLUmjlfc1qBpbyxcLyvdfHYzbNE2c4O6S42eaYwzup+uXXt
 dwO+c5m0zhqLm31+iAEWeGmW41T5CxO+DXtfHwtun1CXNtj2e4OYJLs//kYObNP6k63H/G2UXsh
 Xqmz4peF4PTD+ULsjnBlyziDNHFI8ZkG1KH9SuVyutjC68vPKATFgpzbV8kEHU6G85eMEvajjK8
 PXojlthKhvBp5bKM1WhbDmYVYAHgj8z8IjPhGgX+ySZB5yt5clHbJ5Of/gp5r0QhPxh9bpE7vUM
 Id7SX0SEl8FX0z35S92R2yq8L6AVGaTI9hyVRhUykg/6SiYAMJcfmkyh9HQp5oKvb5rggXt10fd
 xoIgHS6d2jg0x06uoCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220041

During system shutdown/reboot, power/clocks to the PCIe controller get
removed regardless of link state. If the link is still up when that
happens, it can trigger SMMU or NoC errors.

This series adds a shutdown() callback to the Qualcomm PCIe host driver
that forces the link into L2/D3cold before shutdown proceeds, reusing
the existing suspend_noirq() path.

Patch 1 makes dw_pcie_suspend_noirq() skip the D3cold capability check
during shutdown/reboot, since that check can fail and leave the link up
if any endpoint hasn't suspended yet.

Patch 2 adds qcom_pcie_shutdown() and wires it up as .shutdown.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
1) don't remove the endpoint pci dev's only keep link in D3cold.
Link to v1: https://lore.kernel.org/all/20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com/

---
Krishna Chaitanya Chundru (1):
      PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check

Manivannan Sadhasivam (1):
      PCI: qcom: Implement shutdown() callback

 drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++--
 drivers/pci/controller/dwc/pcie-qcom.c            | 10 ++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
---
base-commit: c1366b72ad4e87be60b57b74635a3a0bc58d2b0b
change-id: 20260822-shutdown-fe8139dff2b7

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


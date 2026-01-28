Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81EA34E755
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600455; cv=none; b=u0POBJcSi0rmvaRl7XUut6CKqU9mECICVE62FeMgFhAfdW8cGm6kRU1VNZ92b/zNjUwH6DQuyuGhhgclCVLaMjX+cHqpXMuzI3xZcssSmM9pypPfET0JXkcTDV4/V8qmgQgRdjuaIuKbX8ZSCyiEgzpRiW4McN131w+he1eA7S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600455; c=relaxed/simple;
	bh=kCxwBVLfjz8Zof/slL59vAhcEvihO5RxyP+2uMtSV3o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U9wIwy+zX7E+DzVS424xkaor0HlZZTu5uecyn7JNpcAvUZrh1DsqV0vwOp2sbva7u0oJmqZMfWZqQxb6HRB8asWs+MMVOFazp/couAx8nrB6/6olqH9yE2LmOEDR3R3FD4AF8bNWjWV+7PXnpGqyG/V9hOX8vgdZgAAQVpDqZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mRT5J5JQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XHYHquB4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mRT5J5JQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHYHquB4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S91omk3879030
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JFMs7MAk+sF+EwNnEAo34q
	HviH09U+JEWLB9Q+75nFM=; b=mRT5J5JQRBdLBX+aUJQa9SqHbr3lCYdUAB8k/P
	W0dPHYXGuuLdO2VZIeDY8D6IIuCLVhoF3K1eGyKYfN44x/QKylodfhy0TPo5dYFn
	jEhom0FkLe/tk4zVDPTvXaUxESBD46nLE7bBhNOaxemafNEUQ4Xn4Rzha3u+ENHI
	udJIKhmTnzkQKM+lT6UJ0xwS5LAN6jhVn2bv/1JKk6jq1iFVUl6hrB45sN3dUykA
	UsXPhpa4/YmVMO0gQ5Q4ZSeDViqNkEkzAmqWIVkUeKlG5fPdZhSRAv2To7LXAslM
	ZzagYKy6uz967Zb2igjIG9P0N1TTP0ZrybuHe9kYnOgbYh5A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bybyv18us-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:40:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c636238ec57so2960068a12.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 03:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769600452; x=1770205252; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFMs7MAk+sF+EwNnEAo34qHviH09U+JEWLB9Q+75nFM=;
        b=XHYHquB4ijBGYTioJjw+cteIu9SGpkQs0WIVDKPXbZkEbHiIj3E5PdETlYxpYDqzuh
         7KDS1UYhr1TyWYj/vgQ4VMaFOjT7tgyq7zm8Nx7rKLW2x1pHtV9vc2IFUPk8iOp1zo4a
         qRaOUks+5vUQB3x9AZSt/W+3QpsIygUMHQB42Ye4WV16L9+HHtP2Pl+WWuNaehpFscov
         qOOWI0yb+0CXQPFojrFyROkj1wVW5YM+tr+EMi4dlSvTset3tFTUTxDzJ4Ffor6SfTpJ
         r+GniGj28PB6DnNB2bkAaKPpa52NBJfjf8H4+BLw2pQOcoBz6wgRgaGreJSiN5TA5chK
         suzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600452; x=1770205252;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFMs7MAk+sF+EwNnEAo34qHviH09U+JEWLB9Q+75nFM=;
        b=iMs3N5RCnh1l1Sul6dd2NaandRV1PLVZsiUhdwbQAv6cLjM+2ITx3TI5549L15YE+d
         rmDr6YwOxIlFJGMpfG1n8psLL2roVgrOnMdjxSGkTGbn9AwIYJBV2s7BEaOrh3yg8U2O
         Iv+9KHSuJ2QIj9ccqeOZvIjyOQHNKejAPVyllkeMFT2F9NgbDya6wdtsFhTB+6EAPX4+
         c6ciYYn/tfXkoAOb6jAdw7yuek//qpVnVZWhmoM1jw7hcdsbO0yxX6XivyUkKKvCAWhS
         b+Xf1Wfca8atvZSSK7sHgITc74vhpOhj6BdfBq/ccKWqYQRfaoUufom9jOWj/b8RoYsC
         c1OA==
X-Gm-Message-State: AOJu0Yy/O6jN2m4TXHYUmpH9E+V0YJg9sm4+CJUPlFkv+pV53j+kbmuh
	ckTyWutyVwIWNV6RKWiLdg7YWqNXs7I3ItFfmzzt8L4Tkbn6EFi8Ttk9FfO7eP2sXX5S5Nyxmck
	4YGrnCmWCYd22/msqq8xourP7NLVohQAry9aGc5kfU5nHKqOJlBaikS9UioK4e38=
X-Gm-Gg: AZuq6aLWrP/lySUByoS4dLfmDcRh1LBmXIV2bGXR59Hhzk5Z+f6DqCq5s5dbVY/x/EX
	AJpINLbI/hYh3NM9Jc2Yi6f1LPV9Ok+AHUrCrhN73IUmgAqRMrThiAKbP0Vtc8xlST5HKZomnaQ
	lfQQz8j9CZsaQ5afLbUf+61ca3/8qriVG+EQw2WIoaPftGMeXt1TxRh5eWPDI13Em5/WQ27dyNC
	gQO3aiDzWQiMsUzocmYeoxPa03JHjYJ72UzRmFbE9uH5n9olmoUO6GqF3GfJ005Aixa+WLsBkhe
	LptAW3UM6Hi9PAsD/JokTWGuWtDIKFE4GZmEGTLwcwGg0XVMqaDeRIEbGV0gfJzQb9uizuIGeO4
	vLDF7YpUqaCuiIftomJ0AE1tbFA/rpm8ywOp6+HqxlWSZ
X-Received: by 2002:a05:6a20:729b:b0:334:a784:3046 with SMTP id adf61e73a8af0-38ec64052cfmr4524171637.38.1769600451653;
        Wed, 28 Jan 2026 03:40:51 -0800 (PST)
X-Received: by 2002:a05:6a20:729b:b0:334:a784:3046 with SMTP id adf61e73a8af0-38ec64052cfmr4524139637.38.1769600451143;
        Wed, 28 Jan 2026 03:40:51 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f41d0sm2010678a12.27.2026.01.28.03.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:40:50 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/3] PCI: qcom: Add D3cold support
Date: Wed, 28 Jan 2026 17:10:40 +0530
Message-Id: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALj1eWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyNL3RTj5PycFN2kNEtLSyNDSzODpCQloOKCotS0zAqwQdGxtbUAwAp
 ahVgAAAA=
X-Change-ID: 20251229-d3cold-bf99921960bb
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769600446; l=2654;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kCxwBVLfjz8Zof/slL59vAhcEvihO5RxyP+2uMtSV3o=;
 b=1iPC8DVEc59rh8Oyk/lTBCt5bbqG+rgzg5oRfZjhYHR/NihEy8k0OzMXb8Thi5aaQ/SRGlKsP
 bbdS/jV/Ig+C94DjoNcBjWXw+F/lw3XTB0XWbQDQnBd8Or2pB88f/Dp
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: LzlXglBQptxAByH-eQ1c9tNxT-LoBpw9
X-Authority-Analysis: v=2.4 cv=ZZ4Q98VA c=1 sm=1 tr=0 ts=6979f5c4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rF_suA9G3wk1FRvBKDEA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5NSBTYWx0ZWRfXxthoeItjDWf3
 KsK2sCeR04tq537wJSJD39xSblKs7sVHiUbUWnbkoQrNu3qRuMekZvqw3OAsRmBi//Zr62J3d/b
 tVA8CIeuQc0qGv2Iadf5smHh+CdIzSkOoMbdXTMAt292eZmdLL1BrN9BLZdTEB57vaacmoRmAvD
 T4lV+CTdVSrvJcgm2rg5YVUdRgNHE0KBJZIMxFe7tNQ2sTuDhnVy5cZ13jjTzANpDn6XspEZHYl
 7V957S7VAw2suOH+UUWWS/ceBnhhQvA4/zqVz6vMkZFKIe4uiPvvaG17TmZjc0lDGsfnBeAdb6/
 HkX2jHpgkVbi6Th0wyY9/zuq0c59wraz8XjGps5F6BGrg8uQFfu7lVNkrCdRhyHxFaue7LENCTP
 jf6W4+hLUZQLcZSDc5sngz14GiL1wIZcG4lc1tKCFaok2cQiCP/yTRPpuJt+3AsIhhC0tz7EKjS
 n62v79bxCFKdrpeOlEQ==
X-Proofpoint-ORIG-GUID: LzlXglBQptxAByH-eQ1c9tNxT-LoBpw9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280095

This series adds a common helper to determine when a PCIe host bridge
can safely enter D3cold, converts the DesignWare host driver to use that
helper, and enables D3cold support for Qualcomm PCIe controllers.

The first patch introduces pci_host_common_can_enter_d3cold() in
pci-host-common. The helper walks all devices on the bridge's bus and
only allows the host bridge to enter D3cold if all PCIe endpoints are
already in PCI_D3hot. For devices that may wake the system, it
additionally requires that the device support PME wakeup from D3cold
(via WAKE#). Devices without wakeup enabled are not restricted by this
check and may be left in D3cold.

The second patch updates the DesignWare host driver to use this common
helper in dw_pcie_suspend_noirq(). Previously, the driver skipped
putting the link into L2 / device D3cold whenever L1 ASPM was enabled,
since some devices (e.g. NVMe) expect low resume latency and may not
tolerate deeper power states. However, such devices typically remain in
D0 and are already covered by the helper's requirement that all
endpoints be in D3hot before the host bridge may enter D3cold. Using the
shared helper removes this coarse heuristic and centralizes the D3cold
eligibility policy.

The third patch enables D3cold support for Qualcomm PCIe controllers. It
adds pme_turn_off() support and switches to the DesignWare common
suspend/resume methods for device D3cold entry and exit. If the
controller is not kept in D3cold, the existing paths are used so that
ICC votes, OPP votes, and other resources remain managed as before. In
addition, qcom_pcie_deinit_2_7_0() is updated to explicitly disable
PCIe clocks and resets in the controller, and the now-unused "suspended"
flag is removed from struct qcom_pcie.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (3):
      PCI: host-common: Add shared D3cold eligibility helper for host bridges
      PCI: dwc: Use common D3cold eligibility helper in suspend path
      PCI: qcom: Add D3cold support

 drivers/pci/controller/dwc/pcie-designware-host.c |   7 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c            | 114 +++++++++++++---------
 drivers/pci/controller/pci-host-common.c          |  29 ++++++
 drivers/pci/controller/pci-host-common.h          |   2 +
 5 files changed, 101 insertions(+), 52 deletions(-)
---
base-commit: 590a64365d9bcc13ee644a3e73ffdc3df26cf23c
change-id: 20251229-d3cold-bf99921960bb

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


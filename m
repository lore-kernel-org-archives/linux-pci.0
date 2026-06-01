Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B5233DEE0
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335052; cv=none; b=cX63y0TitgSZokK0k/eqnk4WsLQp44LYNkZyqK7mz8Bt0aSdMbIlKx/W4y8yOcysDQOukOqrkYX33eLRMfHlEWxFjEfoL4a9yfeSOZKCU4PfuVkTs1kh+gXgzhFlNUy1yraCSIKKFxP8zNgP4xngQfMOPwSY3rw4QwmABoJp9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335052; c=relaxed/simple;
	bh=dTxWkC9D/nQhAvkCNBylGPNDKnNQFBcLRIV4F8qd8OE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=STJ86DGcKuBjN9YWFRcqIwyESHvmrLb+7bMZ8LE+Mp6/uccisA+NiU6leTsBEaaPOi72ADMJl0/WH1iiOP84868t2fUv8v1Dv2iTRYViB7ZF/UK/5M/RbtCBLeDHiFJRgrNtBJbhZgi3mk7INaEtyavZE0bXqjYjfTo1oxUHP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NoHcs2Ak; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KszhFwwV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NoHcs2Ak";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KszhFwwV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651EnKI63563527
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 17:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1sUnhF+L9/rWjdKJJ0odJH
	7BcvEADzaujue7QqNbFpk=; b=NoHcs2AkVINkHBMo1UxnXo9Lg21KG+lmgeXhjx
	tNcuv0fZep+lpCwWlxhXFAI81g1efigyLZJxZ7NipfWBjxfi7/7UdOYdiNNHg+cu
	RNMpA6EvETSWSA9Za0RCsuZJvWCdooXHcdSuF682Bd+HIZmL/W5CXrbvCoWyFrT0
	CARIfVCsaxvKsXIh8y21xLATKfMVOpXsBzRlYtZ3OrQQMP9XEEgSCpiNJn9d1bWq
	IqGHAiormyNZ8KiHu4FvVQhuIJxggo+2NgGrHRhoOvhubZL6yb+hjlMdwl0l/HMx
	wGe74B88mAn7bCfxkkeHLA09U+9KEckPfHkdswrtg2sFP6MQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6rxt8pf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 17:30:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so29848765ad.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780335049; x=1780939849; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1sUnhF+L9/rWjdKJJ0odJH7BcvEADzaujue7QqNbFpk=;
        b=KszhFwwVxj4XJ9KZY1tSDKTtk9CnlhtxsD9BVb8z3ta0UFRpzyu8KN20I3zp2wAQyV
         UcrAkeTuwivSYzaVjMSQ0RtTaDE/x/7xWmVKqZikCZIBptqh66yhHkEscuMJklFjS5FN
         ljV1dPz4mWNQHD5EKoGF3QdgSOQT7PT0KmXa1pq67tRw8n6oQY3/81or6GceaRZUcYdr
         +DIj+RoQ7YQnw3B4EYVrCvLvgUXJ/sLWDXJ4FiJsAxZ14pPcmRrAdOgDrjb6FFV+lW7m
         tYY9FcgxHv5S2T0KmhTlUuR+HB/f1EDIUKFRPFQwVV+xygkz07Mr6K8iClDMB9wz8qZ9
         a6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335049; x=1780939849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sUnhF+L9/rWjdKJJ0odJH7BcvEADzaujue7QqNbFpk=;
        b=iUppfYZMMdE9IBK0oOJ3VgFEmwtA24SZK9jJKLvUX1zUWgBrxloqLfOgGLQxLCOq/5
         Z9ArNqz+FEmM9K3q1PW/c7358wcVbmC51LdhbOtguGfGiPlvOrIoNZoXfTVhSoB4zH/F
         XC+j+1vPIJR0NhsGwWTloXaLsiFeOv2/5bHwZHaT+hhNwoJLG6PNNcARkAbxcJeySdED
         ZvcGaZFKD8Dm2EOOnXGGbHO5NvOjqYR4tIoUeTRiNsv65O8EgT1j+gB7izNFeOOX5+os
         nDPYN7N0yKZWvghGQ4jhmymKY/Wlg91+g9YX+x8XLHy2iiAXPE+kBzUsvCYlZ4+WyUSM
         VYog==
X-Forwarded-Encrypted: i=1; AFNElJ9K3Xan5cH65qVO4Mtw/TDajjmXla3rUXJBpuB8BfJCS58cohzThtD0tNmjy44k3CdFW9S9qf58lWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ZpTHXZzInA2Y6vcp39CyZbF/uc+2glgvV6WuTq4XK3+s0oF0
	qL14ecFS2+HK79h2gwgsURVO/rv+Mld3CTTkyMXDFYvIRGomW8NnNrT4kGFDra5YKjuS6/vxTpB
	O2MGkKZZXGT3ABDv6Q1MfvQPk8olWB4gdxAoVNBCVZx7ZuptJ2y8DGuA4KH5GnbEVbqTMZiY=
X-Gm-Gg: Acq92OENo7ryqRzS+kaTTqAIMmh580rXlbhoZUx7IIQ1j7IWvur8aO8X2PpiLALd8Zq
	jko9W0cmto0TNzEzCIP1YInMf0nZ5pOYx6ooMpC2XBExHCrD5HbRR0xHnngv0drc8FIS/4h7lHu
	SG86esLm7SKeCnxBqdHjg1eWdeVMBLUqS8whREwdZBU6c+c19vBRXrrTDK2J9bQABZxXKFPDA2N
	I6qF5Skjjp4thmP1aWJPxrlf4gVwOjz71jKrE92rp+VWA3BN8I1MJgXf4ifQMBS1PF/4FyVwPxb
	YOCt4QieV06scktNtrGwZwRSJFEERLi7tulw5gD+0IIu7ekkrUkMPHIIzF46Jn6j1ZrKfDJFupl
	lzX1opTRByDzaQXLmzcfalS94Y/H786EfrvycrSl9BBd94V5KEnK7Jp1zEP8Xtm2bD+U=
X-Received: by 2002:a17:903:1905:b0:2b0:c59f:3b58 with SMTP id d9443c01a7336-2bf367aa885mr142466345ad.9.1780335048864;
        Mon, 01 Jun 2026 10:30:48 -0700 (PDT)
X-Received: by 2002:a17:903:1905:b0:2b0:c59f:3b58 with SMTP id d9443c01a7336-2bf367aa885mr142466035ad.9.1780335048449;
        Mon, 01 Jun 2026 10:30:48 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm149136085ad.41.2026.06.01.10.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:30:47 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/3] PCI: qcom: Add support for Eliza
Date: Mon, 01 Jun 2026 22:59:43 +0530
Message-Id: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIfBHWoC/y2NQQ6CMBBFr0JmbQktVsCV9zAsShllDFDtAFEJd
 7eAm0le8v6bGRg9IcM5msHjREyuD6AOEdjG9HcUVAcGlahTclSZwJa+RqBOpdYG81xJCO7T443
 eW+da7sxj9UA7rOPVaIgH5z/bo0mu3t7USv6bkxSJKDJbVyGb5kV9cczxazStdV0XhwPlsiw/N
 XXKzrMAAAA=
X-Change-ID: 20260427-eliza-e53155ae8821
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780335042; l=1634;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=dTxWkC9D/nQhAvkCNBylGPNDKnNQFBcLRIV4F8qd8OE=;
 b=i817uyArXAMMqslAv/+8fL2dnAFE1MVeVBOaxSzivu9AVo2CwzvvglB3MKVuJQfu3fpQc2QR7
 xvCY2FF/gswBAD/2k2XNLQ5erDIcvuEmPuV9CJy6s0L/gAw/nXLQ9L2
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 0wlIhCCvENYSPKUWxSv2kfJPrAD6HQ5P
X-Authority-Analysis: v=2.4 cv=dsfrzVg4 c=1 sm=1 tr=0 ts=6a1dc1c9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=qIbWdXD6M1inJYch3NYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3MyBTYWx0ZWRfXxc2AB/T4a3d9
 jZSkdsdht1vYlforMBG3ztEUyxNuysSyvlZ2GVbUq4mcKUseseqsOtLXQrvtqga43lEYIfyonOi
 eWVqlUS+Mwv9jfock0CeAjVqNlbBi8qy9w86SmF19hN4Oy9hijSnjEhua0Eoqe0wTtrMKZd8Y3b
 laN1xBKCOkd0dMj1Mp+mLuQCc3qAfpdJlDlKZL5QxP49IhAx7NXteEgJcftZKB/8/9r2FESfAcK
 4rRV/zxxX7Eg2xsWGfPhSjohush9gk21GJOG1voOT0r1kTAafFku59kAQJ4NrVbyq2m5tim08k4
 QWAzvry3y25tKOll9JIifOJflFLXm2exEErnwEvBwCVojX2eQnxkO9ZiSboqCODzANxJLNyLPjd
 ay2a+Kd/P3LpDD3VFSpJSao0fCmwzT44RDO4B4N3aLcLphU4/oaEW1U07paE9gF+IK6Urg0uCrh
 Ux7bROvdAnioNbLz7kw==
X-Proofpoint-ORIG-GUID: 0wlIhCCvENYSPKUWxSv2kfJPrAD6HQ5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010173

This series adds PCIe support for the Qualcomm Eliza SoC. Eliza includes
two PCIe root complex controllers capable of 8GT/s x1 and 8GT/s x2.

The QMP PCIe PHY support adds a new Gen3x1 PHY configuration with
Eliza-specific initialization tables, and reuses the existing SM8550
Gen3x2 configuration for the x2 PHY instance.

The series consists of:
- dt-bindings for the Eliza PCIe QMP PHY
- dt-bindings schema for the Eliza PCIe controller
- Driver entry in the Qcom PCIe controller for Eliza
- QMP PCIe PHY initialization tables and configuration for Eliza

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Remove the driver patch and instead use compatible of sm8550 just like
  kaanapali (Krzysztof)
- Move all the phy settings to lowercase (Dimitry).
- Link to v1: https://patch.msgid.link/20260521-eliza-v1-0-97cdbe88389d@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      dt-bindings: phy: sc8280xp-qmp-pcie: Document Eliza PCIe phy
      dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza compatible
      phy: qcom: qmp-pcie: Add QMP PCIe PHY support for Eliza

 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |   1 +
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   6 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 139 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h    |   1 +
 4 files changed, 147 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-eliza-e53155ae8821

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


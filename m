Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714D29D294
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372342; cv=none; b=AMchS4sn/5ZGSSC+Se4UGC3bpNRnPbi1WsWZWFlKfKJoj6/q83bXgWkihT/D04FGq7ACLsDH+zEI4LOnEi/forjo87ztJZZ6A9bHg3rpcovRzAMalvJo0LTWM5nb4MRTSKgm/njOrbNC2rjFzH+bxtnAS2QKPEDXdwrPFIkUrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372342; c=relaxed/simple;
	bh=O7C+WAshZBT5qe7BGQyWLbLRGLqNcCFqdNXx9ENZ2ug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aVPEPMtIWZI5S74Jdo1lXR6iVsTFndVdV8E9IA4oXD/nivfzLgWeH+RCYW9j/bxFzO5IpFQIbVIt6GmhveK0iPMHOVwN3ZW/bx/FVj0Xbh4rBs1gUl/RJSk2C7gXEYeoZ25TU0bN2nrVFtwBerjsDsJt+lDeZd6PiNPTGfkrP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I31eoLTl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XqpjpQo2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I31eoLTl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XqpjpQo2"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99n593118648
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3OTRDFg5JhaU43k+bSlIH/
	IJf6yxe4CHmbFjPGs2lIU=; b=I31eoLTlZxSwY4D7eKvF9DrRGuKU5fS9wyoXER
	sJ/5uko/s/wbnZ1PxNzVEqsM3rxLAj8yrUU9CL973njaVGN7Djqk+A/aym5y7YLC
	c1a58MtksLOzv1/NUABWuu3yx6q28MIDk1O3VckAqHr4/TpnHU73jbaU3Xeb048y
	DlOjXUTId2e7ZY7iTflLckcfhXM1mLrzUPVCsF1wXmlbJ0oeOjvpCvwD6V0eERi0
	mqDvxKW6HGYTF/Ml4sfF1/2e/4ltCofwNgYNb7ORZq8AjRKFO64hZ51epQ1mzZyb
	SqJYzciWuh40RoTt4Yb6YN8FO0ssS9sRQfDemLKcexGP0HvA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9r962t28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:05:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba86e35aa1so103633745ad.1
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779372338; x=1779977138; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OTRDFg5JhaU43k+bSlIH/IJf6yxe4CHmbFjPGs2lIU=;
        b=XqpjpQo2m5qvzcc4Q/XDDgw2sP0OpNdg8MjMU/XTMzyLonAiCUVjQFGWszvuGEMALh
         8UKp1A5xkGXgD71QFYUTRqg7VJfSwsPfA5UGhIbjOI3EPNkmBoAZbhZyM6OueBd4vKxP
         DbfcHLXno1YblKi4uhO3OhfLZ+6rhaMSWj8LIrJ8ebcBV+xDyjeU0UK+AKVR5PveZbn+
         7fazC8bGxcOyxz3rWMaK+OcROoXm0AqUdmNSQxhbP8DYUHFnU1JGSI029BU/g6VUy1aZ
         0yQN04+dpLOhmqsqvJsxXmHrDZGYgRfi4oXGcG+C5OvpAi8KJlmwH8hqfHMxk1TU8gDL
         nX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372338; x=1779977138;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OTRDFg5JhaU43k+bSlIH/IJf6yxe4CHmbFjPGs2lIU=;
        b=ecqSa+CWRPTFIpBibyAXGfJEsSHt9A+dE4hABbuQZijGLHyEGaooK44d9bOjn5XBDJ
         N7W/J2fvVRPJrdSPe2doj5n/uYJRZMCDYPQQPrbEZNTul4nTAeR8Vatqk/HPdfPYMTsC
         NcmNCGVhpYz+yEzaiMSXP6ezVAODJG23AGKfYGnMfRO/iaV0wYI5mnR5MVi0Nm88YrgC
         D2+ZR6r0ZobJjk9GKo6EoQOaelggTIfPvB2hetRGK7qRwuKvYV1e0Uc8t7BC+yFbuukk
         NtN3bvKagjzPz95OTUYkVY+fgbCQWcQ6oJ4piWY/gvMdXPbOLc4ipGQO+aTli11FkrHV
         /3Ig==
X-Forwarded-Encrypted: i=1; AFNElJ/vjImGABGszO51/I5SVMP4S+PG69Kjw5uNRmEz3Hzskhrpr1rjHxGPHYJWB2/hSR9SHPvRLuZAgkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5r/0OXWeCa8HxszyXqj2xY1hdtojz+LA33TE3iIObk8shZVFJ
	9itAvOfapYic12U26K7dbOjli//KTad97Tpzh2HuaAbzUUfvuaqiLtuV/mgpS/J+60QNWLDikRZ
	tWxbeVvQPjF9VXMTM5l3DLkWNipl9yrrzDa8zdafT+kry8z7jwUq2OX0TwWf0jnA=
X-Gm-Gg: Acq92OGYytG83QHbbd2UpVzYadvF14HUg6hC4Ie7VmBW1GqTKo/eySd8zeh5ANdSHsi
	W/FX94XfQTyOXaQE49GLRn0Qlh9RutPNWFIPvGS1V3BpjY/8Z0VgSci3vE38ZwL9aUNoXZvrmpm
	JHSkUV6wy/oSn0SUFUMaAnvRzNhR2okt6A1SfTjaSz4ERxLLIA+1hHwdYKmcGlQzz3Ri0Zk3ES2
	ICdE6V9yMoI5S7ZKva5qldXNWTN+uoyVey0SzhxyQBXMvawUD0/rZMCesjP1qWec73gGjACGXlW
	CIoXgwrSry2FqppXP5EGnLZW4kS1NFm1VRWlxeWSSC2JLdFzyI00VW3rFahToikDHJ84g80AgYO
	QsCLs6aHjHJuHVCc5OVrP4Y6zkxAH73hyEkemL6qQ2cRL3jbA/lcG8Eod
X-Received: by 2002:a17:902:d551:b0:2bc:7d1d:b677 with SMTP id d9443c01a7336-2bea33abf63mr34891345ad.36.1779372338094;
        Thu, 21 May 2026 07:05:38 -0700 (PDT)
X-Received: by 2002:a17:902:d551:b0:2bc:7d1d:b677 with SMTP id d9443c01a7336-2bea33abf63mr34890605ad.36.1779372337563;
        Thu, 21 May 2026 07:05:37 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9287997sm13189765ad.24.2026.05.21.07.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:05:37 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/4] PCI: qcom: Add support for Eliza
Date: Thu, 21 May 2026 19:35:28 +0530
Message-Id: <20260521-eliza-v1-0-97cdbe88389d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgRD2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNz3dSczKpE3VRTY0NT08RUCwsjQyWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQCRIcRQaQAAAA==
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779372332; l=1529;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=O7C+WAshZBT5qe7BGQyWLbLRGLqNcCFqdNXx9ENZ2ug=;
 b=qL6upoywstmBHfEA/kiZY/0E1OCxGPxyH5TmL0lnTocWoJBsNk0QQEwjSWCA4ZdE4q5vbc/dw
 BP2qsvW2fqnD7WGsvOL+X0cDgwsAeSxb0W4TQitGgfNk2ublP7xS5hw
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: D4Xe1z_JEJmeiWQ--_ls7509z4yGD-qf
X-Proofpoint-GUID: D4Xe1z_JEJmeiWQ--_ls7509z4yGD-qf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX7Kg680noDO8B
 k1rhU3YSIb1m9ZsNmcBSlMSJLUq5AY2KcnXt/2Yszn9ZhqP7/z0DJ1bXc0Sq4KmsnJ55ObUeZQz
 Id8+vrOEKsTd84rbQByAGbfrGnkq8kt0eM41Y9+/gdG656d+f1yMjBfiLaKUy/unmGGsJeszKl8
 g8mzq6L0z0d5cmZrLfKAWG5Yo2h2tZltV4UIGKk41foPPg82a4GYyRkVtV34MZ8Dhu+11k9z+Qs
 ET4UpFhZBvrgztSGJqOPlBFSHZobe+y7xyy3fF1USJbtJu0ubRXlD+rp3miPv54zQ3K2INq0q2d
 Hebd0vikGm9W4bnAEGQ501GgcMRpgYRWo472KfO2LnLvHvAc8eOtAUUXSojK7hzOc1owRmomZhq
 0xEHS17fx8urhtRqAniDYpZsQaw4DkuNoe2In5Zr4V+itvQWUGDd9hFbnEgdA06tHEC9DS37RCP
 z0HHaVx5/PA4P41VgOw==
X-Authority-Analysis: v=2.4 cv=GqFyPE1C c=1 sm=1 tr=0 ts=6a0f1133 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KRKipztoQesxEaMeAmMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210140

This series adds PCIe support for the Qualcomm Eliza SoC. Eliza includes
two PCIe root complex controllers capable of 8GT/s x1 and 8GT/s x2,
both using the cfg_1_9_0 configuration.

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
Krishna Chaitanya Chundru (4):
      dt-bindings: phy: sc8280xp-qmp-pcie: Document Eliza PCIe phy
      dt-bindings: PCI: qcom: Document the Eliza PCIe Controller
      PCI: qcom: Add Support for Eliza
      phy: qcom: qmp-pcie: Add QMP PCIe PHY support for Eliza

 .../devicetree/bindings/pci/qcom,pcie-eliza.yaml   | 165 +++++++++++++++++++++
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   6 +
 drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 139 +++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h    |   1 +
 5 files changed, 312 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-eliza-e53155ae8821

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


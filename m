Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B774825AF
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988313; cv=none; b=qth7HMkodXEuq6h8Vq1OJpF6pkh1rXGtu2xBAM/km7DL/g02k94oqd3KVA8Eiiq7yIs2PFbCjrDAKkSKBgpG6v6rDHHlAsBbPrbBjr8N0d7ZEcEfzyo1NyexkonsVQ5HWlFgbgWIv3AnF+rq9/8LgpWFKfSA2fS6MnwRv9JZKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988313; c=relaxed/simple;
	bh=peVqRNezccL7XCLjXAEvt4zPOCLA8KyAaMpzFXvC9Bk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dSOs7BqpNNVLEh4gMewzdiSCZckRTa+LfckGZkgEhUJefGlcOyR9Y8YR/kIemsbBopjSdECsvkLXaiPJerZOXD2AnblIlnOMDLWDtA3MIfFopx9Ah1v8qGHUF4KSkKfxlncfBdP4GKN8cMNGgZls68QtAXRiznYHR6AQWz5Z9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UjUuvhP+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QEWImqsW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UjUuvhP+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QEWImqsW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAduDp1076516
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JPpwA4CKVsWowfWLA8IiUg
	S5i1q1YmC4GCe/GawbpzM=; b=UjUuvhP+afkcbhGiOqqkSP2ufcdIX/K7rSlX6Z
	RHMaHbTHjT0t1BOYcar9AL8gHNzAyckAHe9TihdEK6MIp+qQPHVuc6hvtiRDSoJF
	NmCp4ddDC1XqWAkBD8KFuoiPvl5xhYcXo9rfxd0vn0YOh/IWxVem16HkxzCCLYj9
	flJ8+XBjuShXkIbskmJqANZPld5p4ZK2x4zIi5JgWI3zWZLm3Y9XRMTAuuRGzs//
	I7M5SM4CreAj7OB4N+BXc2pMs6of3Gzvxc1qKUKiEzS95xO+oPsn6fb8nCdsxR9+
	FDw4SqhEo1/AxMlBpz0T7b/bWyhK6P8tws8rmqVsmX3PtfMw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1ehx57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:58:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86917d18880so4614162b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789988311; x=1790593111; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JPpwA4CKVsWowfWLA8IiUgS5i1q1YmC4GCe/GawbpzM=;
        b=QEWImqsWsK884t99sEE0mBYuGptIxIZmNuseb1dJWKOGNT5mYD3pAr9Vym+WdQUaqV
         6pawCC28FtVaitN9qcjFGIw3SUrwV3yURnVhplumZD7Q6vn0TRSvjBHcb2Ux/e7VQ8zl
         +Qn7Yefelb04Mss2DcIoSJL+5i/g0iKUt/aj+TqsIViP+pQPYpBDV5fxbH5w8BzBmAoV
         bhfmg7UQ4fK/gbFgBSOHEdB+667y4GH6SIlrdoUgKYyJ18c3VWYSxDg9ne838cwJoma8
         pvKniZsVdOMraDEwvMQBNEBeJRxFF8fuIyPDxv/S8RiWacvaVAGoP+RB5V6Iixvpb3qX
         wiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988311; x=1790593111;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JPpwA4CKVsWowfWLA8IiUgS5i1q1YmC4GCe/GawbpzM=;
        b=A86U9Tl3FX6/u9MUlg9UH1vFshsX0ygK3iG/W6T/Tp1KPypRsw7zSXskyDkdukgd/B
         xxDRilJ6FJscIwok+mbEUlJAfnqIJcFVtfbnK7pd3kHO87zqcrq1+zwqSA2o0nFpsKW7
         FYj7AOPesiOatIP/Qhsl0kj1mvWPrNFFRWAN19ohvs4UW95XI6wdkBlsgjeUa3zyJ1iI
         Tj+T/8mJa5/mZ56u7m+2fjqX/GlpJBcyVX5biP3fFtXyL8e1xy6TL7uTZnC1iOy0XvLV
         DvzNVonahwuEwPJOZ8B34EuPEG6MeXAD4C+hhC8oUZ1XoCs+cEgagkYZBGKBk+RZ0EMA
         7D0w==
X-Forwarded-Encrypted: i=1; AKwUvBwMr1Cw0fon2YcuzrjlcxfELoVJJUU6ehycdVIvCXSybxPj/py9Y8WFN+25DIzOTJLFxlAXJiyufUI=@vger.kernel.org
X-Gm-Message-State: AFuF++kH0q6FsZAZfQUyk4xQRuOsyY2lePRkY4gNs2VheOZ1H6m/9oMM
	GbfubkaWQxKhY6n4vtHKG1BcAlK/IRd+0mrex/yZIG2Z0ZlzhOtaANVZR0J0igeWdDvjS8xeTeq
	sGm4S+DXFOHK715H75aXL2LnJfCDaqF3yA6+DeLvCMattH8Tu46678UfTabiU9Ug=
X-Gm-Gg: AYBFou0OxFY6pa73HixsbJGUEWgeLvLvqWxZIX6+2yfYvLmwK0BMnjIKfMdUmn9tzdp
	T8RMHIeVnOmktk/Sn3M+UP4EDfju0kb80lvWD0dh8dxUbzxgWQlmLyIuFRTatMJg3bnl8QbYR9E
	ektSQpoQcva0ad2s/L/iiEX8DmbIKtD/zdZSq2U/oTW1SN91ezwL6nX077/DVw+d+1GWS88+gWp
	1w5xHbp01k61EOUoufotIrZGRgwrJx0xFzDoE51Ox1tCvybgtBbVASRBxaGtirS/97aSlRfgJSC
	yCrF6DLqzxilYR5lcfPMTt+rDMSdJwc8LeSLqyiXD95bCTmDX4cpnUCp9Is8gpJx7tq8i9ek4pe
	fG4v91gGXgdzOsI0Bt9qc8knySaNB48EDzQ==
X-Received: by 2002:a05:6a21:e8b:b0:3d3:ae40:51e3 with SMTP id adf61e73a8af0-3dd8c53b507mr14688661637.23.1789988310685;
        Mon, 21 Sep 2026 03:58:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8b:b0:3d3:ae40:51e3 with SMTP id adf61e73a8af0-3dd8c53b507mr14688644637.23.1789988310229;
        Mon, 21 Sep 2026 03:58:30 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d55cfsm23544128eec.30.2026.09.21.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:58:29 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/6] PCI: qcom-ep: Add PCIe Endpoint support for Monaco
Date: Mon, 21 Sep 2026 16:28:11 +0530
Message-Id: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMMNsWoC/yXM0QpAMBSA4VfRubbaJOFVJM1xxlE2bUjJuxsuv
 /r7LwjkmQLUyQWeDg7sbIRKE8BJ25EED9GQyayQlSrF4qxG19EqTK9yo80gCRFiv3oyfH6vpv0
 d9n4m3N4B3PcDBnaa920AAAA=
X-Change-ID: 20260918-monaco_ep-fb14fafd0ecc
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789988304; l=2427;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=peVqRNezccL7XCLjXAEvt4zPOCLA8KyAaMpzFXvC9Bk=;
 b=2j+QB7Yy6u1A0kRk0gX0z2/49ykQ8g6PYURbir7tJ/F3c9vl0NRtyLJuDHkaNoZAjuUV7kxfh
 fdg+mSGQVK8A5uVGyHf48EsrBVwPdUfECFD6Tcn9Giqwxde1MM3LjN+
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE1NyBTYWx0ZWRfX7aHv++C8hbSI
 eeP6KhE+6Btn7GEcuSOAPERA4UEeetRAGbJc9GwFY9NwowNg7hXH4jUvxLMnLXMuCO+3UzVYgod
 dd3tx6psky2xcyNgN/3iosWePhYDJjg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE1NyBTYWx0ZWRfX6mSFMhVFEhHe
 6qH7sxuloQSEQFM9uJiOkov1jHlb4Y+kWNRZMPIUjz93qARmolYrcUNErEuEOXcZrxfC+H3+rti
 EZxOb9+wd1CSyF/npkYXLzDzw3X2G4nAbDn2n/g0cxVCWMB0HeWbb2DoxrTpGHY02YMhiSKgY1i
 cB2xrFjgj9+rtFE/lOApoHAGViXKDmGQIue0GdWsD96VfMWkqecBsHO/Ahi+tROIwpXAMr80VzN
 GKICh8Pv2PTa3Nb2pRRJ9Dz9lBrufKWcNardW9CJgoYnypWQQFAYK4whwHi9UgOyCz3MhPAoB0x
 2zhCIVKE3KFDHE9SQh8AWI0OSlWHPHMb9qaR82QuuHFdJXaWbMtjjZCHa9DNqsDj8Gg2btOOPnh
 V8F41haoRhziSAF3uEeUzqqhQSAe77YNhL1bUGLgSvtP0Id/Nn3FZZGGKJHhm77EtKFAx2p1QOz
 gqxUINPVSW6zjO6bH1A==
X-Proofpoint-ORIG-GUID: Q6xmX5L4jdlVTIFvrbjZpnrOEbZxx04t
X-Proofpoint-GUID: Q6xmX5L4jdlVTIFvrbjZpnrOEbZxx04t
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab10dd7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Fm6EAR0vVewXWd2bb8wA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210157

This series adds PCIe Endpoint mode support for the Monaco (QCS8300)
SoC, which has two PCIe controllers capable of operating as Endpoints.

- Patch 1 documents the dedicated 16 GT/s x4 QMP PCIe PHY compatible
  for QCS8300, correcting an earlier gap where this PHY variant had no
  QCS8300-specific compatible of its own.
- Patch 2 documents the QCS8300 compatible for the PCIe Endpoint
  controller binding, with SA8775P as its fallback.
- Patch 3 adds the corresponding Endpoint PHY register configuration
  to the QMP PCIe PHY driver, reusing the existing SA8775P programming
  for the 16 GT/s x2 PHY and adding a new configuration for the 16
  GT/s x4 PHY.
- Patch 4 fixes clock-enable ordering in the qcom-ep controller driver:
  some platforms require the interconnect bandwidth vote to be set
  before enabling clocks, otherwise certain clocks can get stuck off.
- Patch 5 fixes the existing pcie1_phy node's compatible string to
  list the new QCS8300-specific compatible first, ahead of the
  SA8775P fallback, matching the order used elsewhere in this series.
- Patch 6 adds the Endpoint device tree nodes for both Monaco PCIe
  controllers, covering register regions, clocks, interrupts,
  interconnects, IOMMU mappings, resets, power domains, and PHY
  connections.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (6):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add qcs8300 16 GT/s PHY
      dt-bindings: PCI: qcom-ep: Add QCS8300 compatible
      phy: qcom: qmp-pcie: Add endpoint PHY configuration for QCS8300
      PCI: qcom-ep: Set initial interconnect bandwidth before enabling clocks
      arm64: qcom: monaco: Fix pcie1_phy compatible to list qcs8300 first
      arm64: qcom: monaco: Add PCIe Endpoint nodes

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |   5 +
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  87 ++++++------
 arch/arm64/boot/dts/qcom/monaco.dtsi               | 147 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  34 ++---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 105 +++++++++++++++
 5 files changed, 319 insertions(+), 59 deletions(-)
---
base-commit: feaece109e78a40818d20528ffaa95d2f22227a9
change-id: 20260918-monaco_ep-fb14fafd0ecc

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


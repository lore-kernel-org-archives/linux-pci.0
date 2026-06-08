Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EE3AFD1A
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908506; cv=none; b=tcmfbtSQd4QiTgNNUrnns3TlhB2ZuugB54zbUodCpzGH6yJZeR6KLS7ZBPMI3hXAXvt9qO8e6tlZdBgKbE2XliUMnC/cqpaI+em3q3h4H1TKUfpEZwG7AxfHqWrswwK/KsWDC0FeSyvNHHv3jjZGfEG+jyXqDTW1lUnhgg6R26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908506; c=relaxed/simple;
	bh=cdsPMqfeWD35Ac1rhIkKLbMsGtZjV2Cq7h7n1rY1KCQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ExUcSo7t/AZpCws4iStu+u+xGpob/kZqD8lEy+nh/1f93dNBiEP0TMPy7DwMTKDPm4KKJB21vug69PXXVqf50ZMR25mwcAKYbFOHoGNa7QktalpBgXcOaTM0BR38OXMRvB46aaQxauqV5KGFAAy3kXZ02ikysYUYxUG8YosLA8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aideAHVE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZbBgFDwy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aideAHVE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZbBgFDwy"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586QqA42771101
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 08:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2aTHTubIziKVG4zlKxyz0c
	AXqTiwuCicZ1yd32rnqXk=; b=aideAHVEgxtRLrcoemMiLwDOXftCri25RqAneU
	cXk9HkPN8NW+I+qqha55fmAv4ebCTJk/Uqk9udgFdQYUYsodKnGfuFCxLUCJp9v4
	tIZG8yb+TnJYuYSMBktwyLXzuiSp/gi2+BbtynZFr+IjG6wWCl0Rd/5wMq2uv8lf
	snvrbkFbg+i3mpQU0oPMDoZORf+17i+3ZT4QnHHmj6CgRR3ySpGnq9OlodjObvct
	nj9Jweo/h0FyqFF5vepo0wLzaNiFEFH05NbYzZNFTiu7ngvgKF5YjMJX+mWqjONS
	gj5K79eWV96wcNhhm3iYbHtXXu5JKBhDY8SVfstAR23vjiQQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embx6etu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 08:48:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d98b828c8so5138097a91.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 01:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780908503; x=1781513303; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2aTHTubIziKVG4zlKxyz0cAXqTiwuCicZ1yd32rnqXk=;
        b=ZbBgFDwyhYspPF2ipxWOgrdLFqpa1MxivIXRA5zgN+LVzjC4yngYlbmrM03N9RbSYI
         eqfcxiconHCl5HYi3eq34GnB1TPTArNe8KwluI64ZodcVRX8FkzApmkK1CxlMrFpKmui
         na//EUUh1dyp1LEZBt2BmmjPrV/qX+VNaMNB8JRo6N5GF7Z4lhPRuMs4AZWn0V9SBENT
         DTM/wHzzY7iNcRloQwtEMyiDWk9LT60Afvfr5zfMPzsZTtMqsJSBTzepoA6/5Tsy1RfC
         KlnC8Pf1zlO2mKnsR5wK05j7oVf3SKy+5wK+xqp9yAFOxfXj6LEMxR1wW8WJEYjzABkg
         0wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908503; x=1781513303;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aTHTubIziKVG4zlKxyz0cAXqTiwuCicZ1yd32rnqXk=;
        b=LWVdZRTF3tI8iFyqHGA2DX846uf4wTmO7OqA6ClmS5yghNAsoHW7fTpzgFkQCfE2O0
         LAgwYhL7gQv+wnFzPTyfee+jxS5l/L98Lvm3SlHPl+0VSVuar81F0mgPY1Df6faHEsdM
         Uv5yBXguv8zsJI5+PDo99uPnByJUFJBwtc9HsMPDcT5g8ADTml2CD0HMMtB9Sd5QY+Vg
         /adXwI0aAdgMfDyzrozY3p8B2c0HS8TcZZtzKDdxFry3TxxUUWc3a4jj1Mr6R3wR6wmW
         JaUfSRh/vZKZp+3zOH4zuqlgXmo85mccZTp+OQ4BNzNC4lgwiJCc2RKPP36Eg5fcoc8Y
         4kRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9idpA852L07U7N8Q5v8c4nYfUaoDL3ZMRkZv+06i4WAGHUV0fT4FIrCzrcR9eVKMQTVATYm4mbLNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOssjSYWcwkSyiLseQpdZ7uFqqYQC2pA2TS2s5039FT49rfhb
	HWLLYoTsPOo6pDt39XoeKByM9cLF2r6OHmxeh1CuqmIYNRCoit8U5z8U1pgB5RrZatjkoN19J9t
	lNY+SXp7meR9TVcgPIgmJu+F2fjZZ705pVZBvPe6ERi4EKVHB843n49QWtHah2RU=
X-Gm-Gg: Acq92OE5epNtfc+F4TddAc6ywJVW4VOMrnoPCTdf6Q4gHdRulotWCgmd1ui1XzHu6G8
	jguFim1aH77Qd8WTxjbh0Hc9ygeAdcHzL8/YcxW3aC3Ksgotz0Ol2Hy+6G+joARgdjTRMAfBL/x
	IQImocDS3twPGUxmHiezf/YelWPZJMLBDEyxm1NSHHLV2y0HzPnynXP0P7rTmwjjwI/4DgKSjn4
	wCjyWAtIiYfRPs04HcqFA3YJHz9eHM5czx3VTWF/4nCjs1iBLQyqvj2+ntMx8o7Hbwz6oUSNqhP
	CjjBhUXQ6e826wFeAl3gGEuuaDTzOhVsSIJ8P8K13Nz8htkHu5cVERKhgiQ0eWQf6bQnigGyrfv
	2ofGBjY5MPb8VivWxNbSzhyRk88qx041I3Aj5o6RSjgO72j3uBU640YjbJen2dg3mYAY=
X-Received: by 2002:a17:90b:1d89:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-370ee82fe25mr15451770a91.6.1780908502804;
        Mon, 08 Jun 2026 01:48:22 -0700 (PDT)
X-Received: by 2002:a17:90b:1d89:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-370ee82fe25mr15451729a91.6.1780908502386;
        Mon, 08 Jun 2026 01:48:22 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f712de91asm15070198a91.16.2026.06.08.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:48:21 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/3] PCI: qcom: Add support for Eliza
Date: Mon, 08 Jun 2026 14:18:12 +0530
Message-Id: <20260608-eliza-v3-0-9bdeb7434b28@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMyBJmoC/22NzQ6CMBAGX4X0bAltKT+efA/jobSr1ADVFhqV8
 O62YPTiZZNJvpmdkQOrwaF9MiMLXjtthgBslyDZiuECWKvAiGa0yHJaYuj0S2DgjHAuoKooQWF
 7s3DWj7VzPG3spuYKcoxyXLTajcY+10eexN3W5JR8mp7gDNelVE3IsqpWB+Ncep9EJ03fp+Ggm
 Pb0JxfZV6ZBLpo8l7WkTHH4Iy/L8gYx+WBt8AAAAA==
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780908496; l=1742;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=cdsPMqfeWD35Ac1rhIkKLbMsGtZjV2Cq7h7n1rY1KCQ=;
 b=ecrik45mYwX77ErSUKzG8xA3oHBydDoNjh+Dyt1/LxNH8+i5JjlSkyEgZfViU7d5S6sgMQMf6
 Ju9syZl1cUwCc4e1Wh/vrygWyWiYrecOUYAYVTouvVPE0NX9TjeN5J9
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a2681d7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=RZHP3SvTWnTKgiXxB68A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4MCBTYWx0ZWRfX4uuYHlP08CG2
 +rZbbkuOJRkFqWEYTBs87DbnTeMXNWQKbPVf8Ht7Ivf9ki5bOfuB1mVe1cNHN1jlRp0UOJRIRZk
 Qy6IGxlQ9hc4X9rbK6fzZboBxtJ1IqTM2zLVw/wjTSNXylTzvmHeTzCo93pUivP5YuUpDKzNY0H
 nv3mZkQvirRNwxaVtg/fluJ/b9dnv+3jfm7D9iM5W+AvpLSLjWjt+xbyfy53eaLfDKcAhBrYQgI
 h9iFFUx3dijplSB9g9AUcvAod9wLNK32/aQ3SVOcZsyo3AeFUxGWVNcFqvgABXGcgzUYyxz3LqZ
 vEgnY05vQSrvxJPLQMmlaeX91UVZKC/NWIvwFLN0eTN0SFp/DRf8em9KoNhxluY3irHdfs2qDXt
 8lL80o7oaPGkWD/ZXKHxzjorsHejaTSyNazYgCoKupHdl+VufmVkWXiVF6kjTfx2zv+vinMcWDO
 CvdQ4Gfar3+Qv5uL95w==
X-Proofpoint-GUID: 6ajYdtTMbybS-gQ7nSK5DOxpkreQghWX
X-Proofpoint-ORIG-GUID: 6ajYdtTMbybS-gQ7nSK5DOxpkreQghWX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080080

This series adds PCIe support for the Qualcomm Eliza SoC. Eliza includes
two PCIe root complex controllers capable of 8GT/s x1 and 8GT/s x2.

The QMP PCIe PHY support adds a new Gen3x1 PHY configuration with
Eliza-specific initialization tables, and reuses the existing SM8550
Gen3x2 configuration for the x2 PHY instance.

The series consists of:
- dt-bindings for the Eliza PCIe QMP PHY
- dt-bindings schema for the Eliza PCIe controller
- QMP PCIe PHY initialization tables and configuration for Eliza

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v3:
- Add allOf constraints for eliza (Krzysztof)
- Link to v2: https://patch.msgid.link/20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com

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

 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |  50 ++++++++
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   6 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 139 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h    |   1 +
 4 files changed, 196 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-eliza-e53155ae8821

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


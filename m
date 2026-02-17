Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284451624C5
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327156; cv=none; b=g60qPHNa90BAtRHUw6MjNyEmVogH4pA+r+ffrXo/iuq0M9revxxbsaO7u1F0DunFPtYwjGIBZoxwqyfW0WKXKByl846zIpYqG5i5Q256rP/XsT9kWAH/S0iKbM+BNV0Uc269Di18wBAOThq4IXKfPMRMwCAWSvYTU/9z3btfpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327156; c=relaxed/simple;
	bh=vfy+YzqqKerb02XrtXzWTVN+T8EmD/WiyxKqOvqNYg4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E++1DdiVjEOzCgWcSp3Lem7oy95hrJGem/SmFDDC9b6ydnFiYVFtWhSr0r9ZbqzCGcVtPKXWfi3y6MdjCRNMPI959JPjurUah5qHZSTxc1wcXm7cx0zinnqhxODlY+/J45YqReGBYrlVkdAc2WSd79FY/qDamnARsISxwEztR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IBtByGiF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eVUFZg5l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IBtByGiF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eVUFZg5l"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8fSq71545010
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bqnU+1TM5gIEHCVNQzhu+5
	3HuEr/QxKQz4ZoYABsYvo=; b=IBtByGiFfKARYol4oLKZadtge89ZfGjf06BhOF
	DpzGV8YBamjsJdEXaL73tp7cHGbYnmV6mhgnmbbrrU5GFF9dpeKCkBwNfB4aghmq
	Vhbt24U0XbEwGAC1OjFGsfbatxOCx3H+Lo53/mjFlEbIby6dlSsIKjIUSBuV4+AG
	O3oyJyBVWYMEutqd39LO88hntrhiOahhAqwU99qDW0E/bENr1WoV6+ow4nd6oV/Z
	VtHLqJmN1oRaGPn76gaNDFnsuao9NrX2ChDfnrvXJBED9XZnHB+VS1CFEo6Ei46X
	IwocB9mkrlow9n92E+lPG8GrirwyoCWwxxi5CHYCTuHLus9Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ajsxws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-824b461dc9dso9421234b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 03:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771327153; x=1771931953; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqnU+1TM5gIEHCVNQzhu+53HuEr/QxKQz4ZoYABsYvo=;
        b=eVUFZg5ltoEp2APDXQM+C7zWKYpoHxHUoetAmLSaz1q0eMiSl2bwYY0UmRVlCAWyp1
         9KnHszP7t/2W51staDmX84+df6yXF3T6uknQt3vK3L2TWQcYODGZi/53/JK6QKpqxQIG
         tqykn4Ahgrq7w632jBMBH3JqmXT5mDuyLic8o4cH9NOaq+QKTAjtyN64V96A+z5z+ZLd
         28T4TdelMqatur7wq+QIKX8+qGY1IgMnzHYHB8wbQbj03mvmpQHpsMFIRgJUJNNG+R3d
         kUUp5jxLN6/11EVSw8Y1926XFFkbud7ukHaykVL3ceScC1SzleN93OYwokHoo9hu6VEr
         qv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327153; x=1771931953;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqnU+1TM5gIEHCVNQzhu+53HuEr/QxKQz4ZoYABsYvo=;
        b=s8IfYTmikuCSvgE/RfuPPantNDh3SaOa8KbkzEx9dgykXoyQQghvO7exbPjnK4qHft
         zB07a3pgG7TkaB9842iM8N1TFON3KcKPdOqKWIehqkkZM1krkbgy20wfUl8RYFMjJ0wI
         kE+v0yPW8wtx2vkvNgzgsvmYqEnNUhT3zsTK3FfNWq00TaRD0MxlkLsdycjpkrA8EpLz
         X2jeo3Qwtn7jEMAmVnoIeXXwCzivz9JIBcQoPr7h6ZgF2Yk8GDAZkT+nM6h9ojQxW/Qn
         If8LsclOk9QfiyBRrxQqqhQpsZT6oxoeUXpwPJCrODxAlxySBKH8FxJQFTtAtX0n8VXV
         +mIg==
X-Gm-Message-State: AOJu0YwrT20wo3y/nexM4kfC7B6LlQUGwD4F1ys3Lbup3ZKXO+ME5o9h
	hzkKcRv3xRr8Rr9ab59meRsTpE+qNTasQSB5Kyx+WZGCaGl1eXDQAKimtmOkFTfwYLKBKUpSEJq
	jJIU3ZuJ7C4S2/5H94C6f3PZjY4LeafeCJLvf9N/Guwfv3GsTXjfx2KQvjNQLJnd/RacQeM0=
X-Gm-Gg: AZuq6aJ04/1hyejca3Y3tcML5fXPhrU/RWDFDxbQuRF2BokiFESl2jpvzPe95cN/848
	vqDaZoIe4f8LNpbCKwKWamucAsUkcTLlfjohVGpHrhjjb++HEtjEaSlxhUmRiv+EPrVn0Xorh9F
	0SfgiU5eUT6GwSbpe2IqIrtNamaBC+l7Edu/QAuhAMkZGRvyEv7wkSvvLqqDccKhDfd37nSYay0
	42tbQudo6KypN7A5G9GZNhyzEuO0XN+GIWhAWcNQz9AAwUtUFG5L5EFvSHZGPYxwgVaPSYeL9nl
	CKEKIASa/3Dt2url/OYpdOLq+/gFUrUcPO+503gl2qWfF6jIy32W2/Y3Dx3nol7UF7ILKR+Ivg1
	EDWKZ54iUq1G9G1UXWOzJbIFalWFWaxeO+VyhZGosHV8eEj3G06fboArx
X-Received: by 2002:a05:6a00:2d28:b0:824:374a:13f7 with SMTP id d2e1a72fcca58-824c613370cmr13273010b3a.55.1771327153587;
        Tue, 17 Feb 2026 03:19:13 -0800 (PST)
X-Received: by 2002:a05:6a00:2d28:b0:824:374a:13f7 with SMTP id d2e1a72fcca58-824c613370cmr13272994b3a.55.1771327153092;
        Tue, 17 Feb 2026 03:19:13 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm13181914b3a.50.2026.02.17.03.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:19:12 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/5] PCI: qcom: Add D3cold support
Date: Tue, 17 Feb 2026 16:49:05 +0530
Message-Id: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKlOlGkC/zXMTQqDMBCG4avIrBtJxlaSrnqP4kLzUwfU2KQNL
 ZK7NwrdDLzDx7NBtIFshGu1QbCJIvmlBJ4q0GO/PCwjUxqQ40UgKmYa7SfDBqeUQqFaPgxQxmu
 wjj4HdO9KjxRfPnwPN4n9uxMtFyj/RBKMM2OkaxzXVuL55mOsn+9+0n6e63Kgyzn/AAJ8NLijA
 AAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771327148; l=3572;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=vfy+YzqqKerb02XrtXzWTVN+T8EmD/WiyxKqOvqNYg4=;
 b=Bn9M23h3apUJmIuD/7Q/hILoVU69OPDlI4bmae1vUzWbKDwi1LNRx25XUFJlmFU5bAOo7qBuB
 nrYGrQQ0rmvCcpeuE0uod0BCwRYMWp15bw5jPFucUC+qdJ5YG0olQR9
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NCBTYWx0ZWRfX6l521oaN77Q8
 KCaY9/viIvS+T5oAGFYqdzeaVcm9qA6txOz2bk0TxDKh60nw1dG0vrIGd2W7TayMWtamU/MlDt2
 hB9cZvc2fA9clw2c3aRKKK4l4XLcJpYwypj6mdM5KPxbhNrbHft+Hql3XNO90ZfDYd0KZ080ZDt
 psk9lZtWQm+8j3MvpEhvT5lXutUGkBIBdo96g9r/1kNUFQ5MpI0DkCO7BXJlyA1s1qV2B1NpdZB
 OzvLrXeXpuxQT/mPDu6ZgAieo5Ff+YyAGRO/CcyKLpFEme9duTAzMYOWHiU/fZQsE8XmatpOcOs
 2QUJXsMfydJjUkMgYBzdk0VGxvpT8Vghz0MQeITUgI4SvshHg2Es8+5p79TmUeVeFPHBnWCUdUZ
 ZFkQmR+7S9lBn2AgmxkB9tmVwWU5GNsa6sfMKrdpSvuQEEbAbf4WjRx5P+m1bXKr/z+dJrLWia4
 rYvUf7Ab3G9yMNCVHRA==
X-Proofpoint-ORIG-GUID: onMJXRuuFGLWm7eNk-jSflSytNc3jPEF
X-Authority-Analysis: v=2.4 cv=BryQAIX5 c=1 sm=1 tr=0 ts=69944eb2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e1WyCQ9WWvu24y8kmCgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: onMJXRuuFGLWm7eNk-jSflSytNc3jPEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170094

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
 drivers/pci/controller/dwc/pcie-qcom.c            | 162 +++++++++++++++-------
 drivers/pci/controller/pci-host-common.c          |  45 ++++++
 drivers/pci/controller/pci-host-common.h          |   2 +
 4 files changed, 162 insertions(+), 56 deletions(-)
---
base-commit: 9702969978695d9a699a1f34771580cdbb153b33
change-id: 20251229-d3cold-bf99921960bb

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


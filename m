Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04940963F
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412848; cv=none; b=g6oFkcu+zB4atnFAHzZ79KG/6OByrbpF/wJNHIoltioHVC1PIT66+nyz/tzyj1Q/FVdAX7TymztBDCStO615qRBvOxqq0x0pu1N/28d320MH0szqF7QZtkqPjnZQt6Y6n8d3iN0Bk2u8dy/BEOTs3axA79nZs6Ag25Kj3KR/CN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412848; c=relaxed/simple;
	bh=9UxZt9xMHSYHTHGJxL65aZwn4DZTQspmhit1ukiKFHI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iMFODMFmH/zQPLtqCCDuF63+6ntmRydPDG2BniW/Q6KQSDBfztUFOtIdQjZ4kGxVs0qmNrb06DmF4tFkb0wU2Aap3ZTG4La3ntH106qbg3kry5DscMTj2KV9g8XD2jf3Z0B1+r97Z628EDFN1J16f81moPJNDktWJEkNvps4XvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iEyOaFt2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eTyJuCfD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iEyOaFt2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eTyJuCfD"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UBHPRo917820
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zGBMMPYWL5uZDW9KeNl7ez
	DQLOJYmti5W6EhFehsQVI=; b=iEyOaFt2h4PQ9aEueorlqbAyQhfZJf/zuODWiT
	oSmKoX13zr+yi38JB0NWzs0MYV0u2lPH/MESydjtm25e/+WhbwqW8aWt00NX/o/R
	1/EViVPIwv1EtNAjRvdTWu7aDwfNtfX+8uL347xDf8su/oZORay/d/g+sYk7jkCc
	Y/rPzd6KkSxCusIi1AB5JATLz/E6pWy/4XPOmixw2DntGvhp+nqisX8gs8+HjPHl
	CH8oXyF7KNJXOLYTOPANPWVg+fx957lzCc53UtzFnSTF4+t0AE5ptIOIA1VfMeEn
	LKj876lrVhEawPU+Xt0URhQPqD3ujzNHG0DRewmYxZ34efnA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr5m084vh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:00:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8488ac68185so4824503b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785412844; x=1786017644; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zGBMMPYWL5uZDW9KeNl7ezDQLOJYmti5W6EhFehsQVI=;
        b=eTyJuCfD8O18LXrf9wkd+ng655L9oQ/IkkOtU0NgYAZV8SkXq6MAQv+RIJ/ODKsmfY
         Tt6wAVYcMONKI5XLjK+4Dnhgx2IlDJ4obfcaMuOosiWURC1Gt+nxqehkK5c6M9kdwdeY
         6csQQ32Kj9mqGiqRfomJBam9SrDZaIusl0XaHESzJKQ/zBGT1nwIU2sPIqZ03MjTZc1B
         BiX2J5Sd6GZMaLm2qDsjiV9x3dacIu6wBTLOtwiuN8cZGy2riEzWFDfsC7vVf5hJxWDc
         NeO0svPth4FooUXcy4FcHkPmbR+qYh5ttzgLi1hP4ULpgg76Kx+NV5w1Ixbp7uO7TC6T
         luVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785412844; x=1786017644;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zGBMMPYWL5uZDW9KeNl7ezDQLOJYmti5W6EhFehsQVI=;
        b=VNhoO+co4JLIuTMvhpMvKmeXHBwl+/0lhEpFvs1gHH49/OMu5Kf4qzkrosJWpzQXi9
         zQgLgm4wXj5aFyi84aumHJ6hkMRnGaH3h9CTeYNCnX8tBKe8CQs3i4sRvZFfoqRzuKAR
         6uwYkst4y4sAs/1JXmabZScqMadvb1pQZD10mt2MHaDe/dFjmlgAxEBMtXMRRaSEdTrp
         P7wbIB0Cia/zUYLfLJoWdYyWxTFAce96SjVUm2gF/W3oypV1C1js+TeMsVHSr9h5uMaG
         b4yOe03qO2jqiHBRBwTs6cANXKcb1wVxr0S75sT1UlGcHbDRW2VzeHkv8F/1/kXhfEPI
         jtig==
X-Forwarded-Encrypted: i=1; AHgh+RrYnUaCyHmo7NRrOxC4a+/cv3KuFnSk6MbazFTATe39a9h20RQ6dHMkgUZqK8SOPg1szv7ng6fkUT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyax39SlMC3Bu3wKX1n7kFWjmdf8/E/sIsUZyuYCz2f6/KjqSi
	gUMKTBruia4AnBjAz5tSEIYk1Vmp8/h14HjgSOGaPIe75nO8qcSVqjHx187IKWff92npCzj5mD8
	zaR6wRJskSaRgYPuw+gmsClRS9uFrobmVYgeUyKdgbx8jZFWesrtVuOPIxOc4Xlg=
X-Gm-Gg: AR+sD11ZN6r0OlLMNhqv1tZ6W2lxLgAXlavJIB9frNgbg0Robh9IiDbOLYfrQ1ypdvl
	4HbP+8Kk/s6lkGf2Dzi2IozFgIrxYCxykH9jBZmQoW+mmM9tQ2ZcQ04XmWuqjlyPfhzx43UUHif
	XhhVg+OGQIRhCMCVkUN1lrw6jx615iHZapNnu2ilknR9gIXx2NW3ImfbZ6qTNl9n3uo1PzIglu5
	6B6mvFP6XDXuXFJIi7vOo34ODL9b5P1E5Cm6NI3FuEkF75PBV3gk0rY87yqmggzAevsHlvK6IWL
	2MdfrQnQLuVyPARguqBKiRwkwNPol5g9B1YrjdkcS3bubYNyjjt9Y6/gMRUoJC+nit7GHy3P/jO
	Im0FAxhgBTTWjSYwuqSuaN/Y3+/Hi1J5d1ak=
X-Received: by 2002:a05:6a20:918e:b0:3b4:7b3d:179b with SMTP id adf61e73a8af0-3c9006ecd7bmr2364551637.12.1785412842611;
        Thu, 30 Jul 2026 05:00:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:918e:b0:3b4:7b3d:179b with SMTP id adf61e73a8af0-3c9006ecd7bmr2364480637.12.1785412841924;
        Thu, 30 Jul 2026 05:00:41 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13f9a041e36sm7822776c88.7.2026.07.30.05.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:00:41 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v7 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1
 with M.2 and TC9563 switch
Date: Thu, 30 Jul 2026 17:30:15 +0530
Message-Id: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANA8a2oC/3XS247TMBAG4Fepco1XMz7GFUK8B0LIhzENbLZtn
 EbAqu/OJEHIK+hNJEee75/M5LWrNA1Uu+PhtZtoGepwfuGDe3fo0im8fCUxZD53EqQFK72g5+F
 X+ELLd2GLAtvbiBZLx/cvE5Xhx2Z9+ryf6y1+ozSvwJ8bE11vHDLv17pLmNOJI44HTwi5RFIWv
 MaUQwIFEEJBq1B7Z4w3svg96W9VoZQI0IEyGEMBSJH6YqMCmTFT0dn7GEt6W+VdyjZF7U3JGT0
 XZHKcrQ0VJUkHq3pKfqsaqdawjeF4eL9PQYHIcxXXdB73cYhxvoh1JCFncRmHVMWCAkXRzEFxq
 e/jx3OtT9dbeOaq8YkfH1Y9hkpifTPMx0NOxpMuFHzuu3WCp6HO5+nntpwFt4FtHfDnNnvgKBD
 OSq01xOxs/idqwxbZAn0LSAY420ttE8WADwDVABJbQDHgZUQA1RdUjzrQLfCmA81A5l26Qoa7o
 AeAaYH2X1wMAxqdh2CC1PkRYBuA19gAdgWAEsmsFKL+D3C/338DQU0VPTADAAA=
X-Change-ID: 20260629-eliza_evk-6f30686b161f
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785412836; l=3699;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=9UxZt9xMHSYHTHGJxL65aZwn4DZTQspmhit1ukiKFHI=;
 b=Bui2klLzrQRtPneFg+7koP2UUCyuJdToNmjtHYkB8v6ayXa3T1fKig8+wyGnxCetlgZzWH/L2
 QKJ3WkRm7LXDnMSwf5NTn3LMgN28IWJYuHHMiqA5YvU/edBO1moMPer
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: Hny9_WRLUMGw20sR2NWGYm9EKYdac-Cq
X-Proofpoint-ORIG-GUID: Hny9_WRLUMGw20sR2NWGYm9EKYdac-Cq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5MCBTYWx0ZWRfX785jNNDyqMgT
 ZvYoJwTpLnw8LeVUkKwLbJreLHruVxJt4XgEBIGV9r8qVNyMLRrFNuW4oa1LaIKmSoVJ1Icg1Yn
 X9DtWVvF1POncvV7w/Ta2I0/qbdkYUY=
X-Authority-Analysis: v=2.4 cv=esPvCIpX c=1 sm=1 tr=0 ts=6a6b3ced cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=7FPx-eIICnbx9kjoaAIA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5MCBTYWx0ZWRfX3fboe24eTB1w
 czRVtfO21vChlwDIU7DGQDvEDtq25rgfiKVtuPjMigtDIt2WVEmxrOlCDRLlDMnzD3ftgq3SIjZ
 sblITYN1Ib55v/RGrcId5FFx1nvbMXvopoBUXQMk+1QX1ycBw8zHsDiBMPDMNOJkM44kElM34p+
 ZJZzot+2ZBX61bDSsEGbYQ4sNr0RUlDPcxDNUgZDM6BOtcj1XHm7ZrdtzmubxpSKAus7S43GvvT
 CnyXO+oFZMB8zYZY6WFa7DXChLlFeulfwMeyyKlnlTU4zv0kxX1FGwU4UXnng37U4/ZXwF+7OR2
 EjcU7ba8mtnyP9zkiNgnPuUHfAwimaOdyVtXbVwRcZqr5d3kRNjWLexxMZvMRRuBYrLBuDzEm4V
 38Clt82GCwF58HagVU0XzYtVWJaxeBo835z9sFB1rXBSJk5mzrYfqqnB5C0d7E19d0GQSRkxnlJ
 1ojF+A8geOx3QA7XcRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300090

This series enables PCIe for the Eliza EVK board (CQS SoM on EVK carrier).

The Eliza EVK exposes two PCIe ports:

- PCIe0 drives an M.2 E key connector. The 3.3V supply is GPIO-controlled
  via a TCA9538 I/O expander on I2C4. The slot hosts a WLAN module
  (connected over PCIe) and a Bluetooth device (connected over UART5),
  modelled with the pcie-m2-e-connector binding.

- PCIe1 (8GT/s x2) connects to a Toshiba TC9563 PCIe switch, whose
  management interface sits on I2C4 (address 0x77). The TC9563 RESX# and
  PERST# lines are OR-ed internally; reset is driven via a TLMM GPIO on
  the RESX# pin. The iommu-map covers all downstream switch ports
  (SID range 0x1400-0x1408).

The M.2 WLAN module carries a Qualcomm QCC2072 Bluetooth chip. A device-ID
entry is added to the M.2 power sequencer so the serdev node for the BT
UART interface is created on PCI enumeration.

This seris Depends-on:
  https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
  https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v7:
- Change the pcie sub nodes under dsp3 from pci to ethernet (Sashiko).
- Update the iommu-map to 2 cells from 1 cell (Mani).
- Link to v6: https://patch.msgid.link/20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com

Changes in v6:
- change 0 to 0x0 & remove num-lanes property (Mani)
- Link to v5: https://patch.msgid.link/20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com

Changes in v5:
- change from pci to pcie for subnode names (konrad)
- Link to v4: https://patch.msgid.link/20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com

Changes in v4:
- Added new line and used pcie port names as pcieN_portM (Konrad).
- Link to v3: https://patch.msgid.link/20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com

Changes in v3:
- Clubbed pcie nodes to this series (Bjorn A)
  (https://lore.kernel.org/all/20260708-eliza_dt-v2-1-e6281da26408@oss.qualcomm.com/)
- Added comment for PERST (Mani).
- Extended ranges property for pcie1 (Konrad).
- Link to v2: https://patch.msgid.link/20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com

Changes in v2:
- Drop patch 3, as this is already applied
- Rebase on top of https://lore.kernel.org/all/20260708055017.A90C91F000E9@smtp.kernel.org/
  and remove pincntrl as pincntrl is added in the eliza.dtsi patch and also remove
  pinctrl for resx as this is covered in pcie1_default_state as perst gpio.
- Link to v1: https://patch.msgid.link/20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes
      arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
      arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 221 +++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     | 413 +++++++++++++++++++++++++++++++-
 2 files changed, 632 insertions(+), 2 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-eliza_evk-6f30686b161f
prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


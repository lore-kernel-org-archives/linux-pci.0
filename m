Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316194;
	b=EnB+nQWdbeJGiPz9Iv6M+sPekGD4Fg0qoQMyCX6iVnHPXX67P1h1SP1ZEUxFpEXX+J/B
	 bIVO/iivmJ1x9fyIlV8d+2iY0q10D5ezXdp6DZnPBRBmQme5aJJ1Pdaq/I7fUiUpgEXVT
	 sMdTOxeKjBxqI/5r3y3ycrS2QdyYk554A1Gt+EccCzNg4ifu1svacKYYLbX5aXhlHqiG9
	 PHpx4RBAS1hqvS/+mX+m/fiCjmfZkHTBKrbddz8TvKb5p2w+uy53x7PG2G6be9gZJDD7s
	 l1JYlvIiHmGSjwmNbtFNmz5iZm8UMLBHvo+DfDRqdZzfy+9g4mIVdNYQ0FTva+dmsJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316194;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=R3tSSWYPQrETVDjfSFXNDw1wYtJcf93mV9ZliLI0xY4=;
	b=n4v2NN/rNZsZv4BMIoYt5lt7JxbhBVT1CHgXyT/vvGPkW+jARAC8IbqR7AE+UCjlykWN
	 4KbZ0e25opPkbGR/DchDnEKkFNytZbtMivA3HJaQmmwrhoQcJd4hhg1rzW+GqyWTLfSPQ
	 9RSVK4CwPE/iWf5qBXwCkFUhcNCVadomYWeEKGCreFO319SB5ZxRL1zpsgyTT1lJ0l28U
	 hb0qKfLGowr9a3vRz4L8So+5bqT0LRrBrx9kAZ2+B24QamQwKAgszEA29Tfn6wRLHmDyi
	 /US/pFUM3XIvNpb4i8BuflzXpjZYmD3dZw5hkn2Ug7sxn+gsO0EWdnCemjxsZLWcPrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XGilMkxt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jQx1A0aL;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E5606A330
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D71E5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XGilMkxt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jQx1A0aL
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM08iZg2011010
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=R3tSSWYPQrETVDjfSFXNDw
	1wYtJcf93mV9ZliLI0xY4=; b=XGilMkxtU5MPR2MdQvH5iyCExm2UtSoU4z1J54
	+lTV8+vUGMTIWNOPN1Sm0MzWa1hzHm2j9w9O9GjMgu9dCt3iNPS4mijr7Y3IfT9V
	Q30REE4LuUUbit1Xg8xL0k7aTTkeKKgpyXZGwAVJDYjis9Q+SAD8HxCl8NDwzUBS
	RRdyhZc/rgOUJPMaI95vsOL/AqtaVww0SA/E6pL09mPOlruOPOiam2CoHQpKNuWM
	+ONevSO6lLvqatKZS+skhek/f1LU2aGYa5NStgX/DWn5aSrTqTX7ATagS4OIT6PK
	VOiVTSDOWhNmYq1t9qvuzNINgSbam/IecjKt8COxVWEcOWWg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j33cu2j3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386a65fca25so360305eec.0
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 18:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795316192; x=1795920992; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R3tSSWYPQrETVDjfSFXNDw1wYtJcf93mV9ZliLI0xY4=;
        b=jQx1A0aLu48vLa/83kpeO8uNu1MJ8qqPltcKgbJkd49OE7OPwGaKjHRXU81vL6zc77
         hI8TQEP3rXgJ7CnCZPgJmm2eANbLWbGNKieiiGHFOP80On23gMYRi9jXZRN4jkEjE2C8
         wYmBHqlmlWnNVPStyvVBBKvW0xMZdW9Ld8G0va1irCvBjjlbIix1ImeOCHjLOq2EbQ8F
         cQUOmwj77p2yv0gLo1LiZvgF+eJuuLGQh9Oe6/p23fHVcMqX+r9Xt0wIvwQPmBYmZRKf
         guXQZF2ke4NSh8j7q56g4IJcwqZNzjztFwzGK76jvjJsVqlMTtO0deG0FbcVS5eu6I+I
         lDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316192; x=1795920992;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R3tSSWYPQrETVDjfSFXNDw1wYtJcf93mV9ZliLI0xY4=;
        b=yrSkvAMkGtcToC2ZtA8Fa+vXb/oob/BU7ne6isfo0nrTpJvWCjMNCPL2TMJSXmQsKX
         tMAzVDlFUinpfWz0PMb5KzY0BOtfJ4eJT3kuLMnr0s7Sn4AIrtAv4LKXg71n0wX4yGWY
         tXCUAX7PAI/He1kGMfzEUfCOELTHVUcERj8E6jQt1Vh4l/PvQRkvzQgDEXe5SNGnG3Gp
         vZ+9XFd9EqsIhMUiiZttgXrabA2jsWoaq5VY41tyX8SdEaMNrGDXdvJJ6Lc6Tld5WfRJ
         39kULBjT0nuVe3M5/eSXxkhIfc1Lhd5MmJiH3hgZMqgsdUt9WBZeUMy+5uRstnDuv8I2
         Gowg==
X-Forwarded-Encrypted: i=1; AL+hErE3mqQ7f0N0drxAiGegm+FbFtdNaOspC4GSe2mNeD9ha142Xm4F/VGhMSg4PIA/gWzXy6je5EZNQMs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VhU6Hqg/vL+U9d+JXTKFT+wO8j/gIwSxhdMSJ0l3zge5afu1s
	ajhAho3QKr+Bzs3624l35hVzAWeloGzwX1i95re9UHmd5Cn5O+72arbrsTDcC681UQdq3zGFnD6
	bSfLbvFSDsgerlAIRoUK2cNUAsHt9jDkSIhnoriQzkB41H4C+NFxBSImT/wK/Guw=
X-Gm-Gg: AZFdTZfwCgbbxkV6GQzimh7EDiS0RGzDs6MiKFzIfpFKs6B9jxvrgA6tByqlFxJhENQ
	jMAqafI336IYDp9BdUaWtFrNKkA5oSOv9pY6XYrk2nLGadPp72YnfC6LV069sTt71v4/uZjwUb9
	3RQNGiQyoXo/Q6enVPjjWoc2UAVQem08Xwif+P16Y2YZn45CPNYToByO9M7zMU/EFIYmFfFMxRu
	9kXPU4wUPW3ARToUliATRXaLi5cMD9JvE6hnDSQwQpodg94OP52aUvckrGFjJdNkNrz/KDIjyNX
	8kN6ByM7kMPNthMKycQhd0rNBcNg+k5gvdYnzQ6fc06x97GQBDJnwjK698ikz1F96W1meAwmu8k
	mVpm/q9jejKAyFasXDAHXzAttL8bJ+fdfxsXVquTPKwBYLoT9+b1Z6O6ETIRniJwuo/2wYguytJ
	DGmgKbW5Dq
X-Received: by 2002:a05:693c:62db:b0:386:a7e6:79c5 with SMTP id 5a478bee46e88-386a7e68253mr696551eec.12.1795316191453;
        Sat, 21 Nov 2026 18:56:31 -0800 (PST)
X-Received: by 2002:a05:693c:62db:b0:386:a7e6:79c5 with SMTP id 5a478bee46e88-386a7e68253mr696514eec.12.1795316190850;
        Sat, 21 Nov 2026 18:56:30 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm312044eec.18.2026.11.21.18.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 18:56:30 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 00/11] PCI: qcom-ep: Add Nord PCIe Endpoint controller
 support
Date: Sun, 22 Nov 2026 08:26:13 +0530
Message-Id: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM1ZAmsC/yXMQQqAIBCF4avErBPURVZXiYjUsaaFhVYE0t2zW
 n7wv5cgYiCM0BYJAp4UafUZoizAzKOfkJHNBsllJbhUzK/BDrgxV2FtlW6M4ApyvQV0dH1PXf8
 7HnpBs79zuO8HGfC76msAAAA=
X-Change-ID: 20261027-nord_ep-f6e8d7b9c107
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <cassel@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Anvita T <anvita.t@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795316183; l=3900;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=II104LFoYUY5bCZ8dL7uJ2flJ9MTEs2ATqgjrm8Rkco=;
 b=Ntg7aOOnLDOr1w8i2c53tVY/kOb0lH6r/CYyPBiWkneCkTr/bxCvNhbKpjfNZoLJIvOXy1+8+
 Njf0+TGjGSaAZ4mMQbKmueG1j92os4RS3EA/8VCY+R3lSnJ76GNuoQh
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: Flo-Y30ieRWfikbJUINxvec93tGT3-46
X-Proofpoint-ORIG-GUID: Flo-Y30ieRWfikbJUINxvec93tGT3-46
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfX8qvAtXcTjMuS
 Y/wKcvTKtxmchfV0/A2PGLIQ0asw0HojBP3FM1wRQbDvpWNqQbsULHoTj6/ooOvJprJkAVCeRgy
 AOiJWbzKE6M+LS/Y2Xhe/WuDVuyTOpC82v72FEuQkfW7DQNsyOG7BSJU4hF9/6bDtPh8jLyHhl1
 QvHbckV/SPUNI+Dh/k2/kHH9xB6r64Pc0OOqAqzjcPfMZYajTSJmMf0smIWAbhwDpdk3u8V0pnJ
 Il1JBU4S9XzaPK5zeLn9XvNOzPrNJJJVpyOHnAJCS7Q1hEZsNhWKk1EJ4RkQs/ZXlVoyx7xLHJ2
 mJJj1z4EtuCYxvJQAKzlFR4X/Sea14A2tmOD2g4vhKBsjbUQzpUIXw6iZLdvv3Cu0qVC/aLvOMJ
 6/xPnLQuU7OzM53aqDWedEjPqNG2Rn1Hlyx+UG0z3YdD7PaoNSNN2jUyTHMiGG+5/4L+cfl4aH5
 Qh3cjDgsQnMNki/yvqw==
X-Authority-Analysis: v=2.4 cv=MM71C8Zl c=1 sm=1 tr=0 ts=6b0259e0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Isxxj8DTuwmncN1cjOwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfXxiDxvBvCuvG4
 EZiauVK5/RmCnIZnCUmlAlw1mbBM3yR4nFrkm5l9nnnxvSAiIpAQMdImwHVKUHHMM1S7xkk0Tqv
 CVKliTaEdwr7DUVPjwfSUG+Xr5Zxidw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_06,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220011

The Qualcomm Nord platform has four PCIe controllers (A/B/C/D) that can
operate either as root complex or as endpoint. The root-complex support
was added earlier; this series enables endpoint mode on top of it.

Bringing up endpoint mode touches several subsystems, so the series is
arranged as a set of generic, independently-useful changes followed by
the Nord-specific enablement:

Generic (useful to any platform, can be reviewed/applied on their own):
- PCI: epf-mhi: Pass the actual number of MSI vectors to pci_epc_set_msi()
     Fix a pre-existing double-encoding of the MSI count; a prerequisite
     for the MSI-X patch below to request the correct vector count.
- PCI: qcom-ep: Add MSI-X support
     Advertise an MSI-X-capable epc_features variant and route
     PCI_IRQ_MSIX in ->raise_irq(). No change for existing SoCs.
- PCI: dwc: Preserve glue-provided eDMA HDMA channel separation
     dw_pcie_edma_init_data() hardcoded the HDMA channel register
     separation (ch_space_sz) to 256 bytes, overwriting anything a glue
     driver programmed. Only apply the default when it is unset, so a
     glue driver can describe hardware that spaces the per-channel
     register blocks further apart. Builds on the recently merged
     Channel Separation support.
- PCI: epf-mhi: Add MSI-X support
     Let the MHI endpoint function raise MSI-X when the controller
     supports it, using a dedicated MSI-X BAR from an optional "msix"
     region. Falls back to MSI otherwise.
- phy: qcom: qmp-pcie: Add PCIe endpoint mode support
     Add a .set_mode() hook and an optional per-config EP-mode table
     delta, applied as a second pass over the PLL/TXRXZ/PCS blocks when
     the PHY is put into endpoint mode before power-on.

Nord-specific enablement:
  - dt-bindings: PCI: qcom-ep: Add Nord PCIe Endpoint
  - PCI: qcom-ep: Add Nord PCIe Endpoint controller support
    (HDMA, NO_SNOOP override, MHI RAM parity-check disable, MSI-X, and
     the 4K HDMA channel separation via edma.ch_space_sz)
  - PCI: epf-mhi: Add Nord endpoint support
  - bus: mhi: host: pci_generic: Add support for Qualcomm Nord
    (lets a Linux host enumerate and drive the Nord endpoint over MHI)
  - phy: qcom: qmp-pcie: Add Nord endpoint mode init sequences
  - arm64: dts: qcom: nord: Add PCIe endpoint nodes (disabled by default)

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Anvita T (2):
      PCI: qcom-ep: Add MSI-X support
      PCI: epf-mhi: Add MSI-X support

Krishna Chaitanya Chundru (9):
      PCI: epf-mhi: Pass the actual number of MSI vectors to pci_epc_set_msi()
      PCI: dwc: Preserve glue-provided eDMA HDMA channel separation
      phy: qcom: qmp-pcie: Add PCIe endpoint mode support
      phy: qcom: qmp-pcie: Add Nord endpoint mode init sequences
      dt-bindings: PCI: qcom-ep: Add Nord PCIe Endpoint
      PCI: qcom-ep: Add Nord PCIe Endpoint controller support
      PCI: epf-mhi: Add Nord endpoint support
      bus: mhi: host: pci_generic: Add support for Qualcomm Nord
      arm64: dts: qcom: nord: Add PCIe endpoint nodes

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |  38 ++-
 arch/arm64/boot/dts/qcom/nord-embedded.dtsi        | 369 +++++++++++++++++++++
 drivers/bus/mhi/host/pci_generic.c                 |  13 +
 drivers/pci/controller/dwc/pcie-designware.c       |   5 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  33 ++
 drivers/pci/endpoint/functions/pci-epf-mhi.c       |  74 ++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c  | 123 +++++++
 .../qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h |   7 +
 8 files changed, 654 insertions(+), 8 deletions(-)
---
base-commit: f3ad6a695e245798f9a5bb34f2c7616880bac3d6
change-id: 20261027-nord_ep-f6e8d7b9c107

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


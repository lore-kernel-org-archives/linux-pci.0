Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6FD3D5C38
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906637; cv=none; b=MRTNMos+n9rYRM/KFxT8spU2jiqDcD/CJCiF3PGtPmTbUw3yfxx8wIFck1u/kV2AIGo+IpArjIbfir3zIXSU3isb3DJXVVmlmOsGfjdhXptxUvenPfplty22uz6+6ZNKRaIqaaofAY66KKr0TGDXpOFs6flalBMAcEE37bRzhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906637; c=relaxed/simple;
	bh=tIwPPb3FEHbFHjDaQ5ESAFuaUuExJUDsggZM58cySkI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ajp+cI2p+6pWqwAhkNN40UFKhLogtYpNLdxyUSTufp/ZLyZPq2PqhNqVXnD6VITOSfl0siICrABmeZKoir0qOrn3uZaRbVUqipFtFKpjEj/99U5pwYnf5tNWK8wa1wHCf7TK36y4Htenlbwwox9vMn4Sp5zLwboGwtLsEH6C/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j46y6+rN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jMP591Gl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j46y6+rN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jMP591Gl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S66sSc2196980
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 08:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Z0PYFW43js7S7UiYi1d8R4
	YiJmIx8iYtVRZMJ14WZXY=; b=j46y6+rNkv6KjRxKPyX+1h7DZknrCuGNo0Kso5
	c6tEObIYIkVfixmcnuJZRbEr1MqhOTMsPK4ReQJQMvzGLDyKITw4Rxofxudv85aj
	xKSMAPbS9y/LJzJCXFvRKQgzRirI0bLYcGI8afW/UQM4wY3pCMLUP8KlZDTKhzPR
	YwRYSWzEVyqteZby9UXd0YanFYpEzqlkQKE4FSRCXDAmVVQZzVEa22XeNrTreAic
	tZYQSeX/y7J/chy53RUAP1khlEoZhLzw4ICzMI2BJL74mLo88OKdj5fsYtvNjz5D
	cpsD8HHLuwuJ+gIabvVcEgURH3iONPMfxrG6XV1pd2cNcTYg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mxrvwd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 08:43:53 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b8088202so866113a12.3
        for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787906633; x=1788511433; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z0PYFW43js7S7UiYi1d8R4YiJmIx8iYtVRZMJ14WZXY=;
        b=jMP591GllRYWjhQX5nVqGosFkcwyspkVXuMKKA1O5LsoewuwNnSmLjFO3RY2QT/Zb7
         FZ+F4nuWDc+PlMYOmBxI/NqDvuTNx9gDlpYzZN+4k1tt2RppPu2xHDaJS3rn2cXAxnQC
         SYMWS4K3Vx4E2J3kniwQFz+HpF7uR7KuzIunmQiRbfm5eVxuBgnLg9SEPXIgsOsxI8RT
         bxYfXheBOiqjGW1tLnGfA3GnstR5Zq4LvdDRuMPxLgAQPTSZgZBdCwGWHSstBjwk0eK5
         zXAnehFcerEgZ4bIxCDRmDInyrOgc9eiekWSWiG5T4lBvSU3pNrXPyTGuilTXCmCWQ40
         ONQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906633; x=1788511433;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z0PYFW43js7S7UiYi1d8R4YiJmIx8iYtVRZMJ14WZXY=;
        b=i4ftOH4SIuw3jsHK4dANBr0E3jNZ7PtDuCOsYrOmeLGkCdnC/vA1USi2d4f6kb/V+U
         +ECjXQJTGR8//Q2PxiPcfIOnHNZoanoD1m8FNLAsVR6vjATpfGZdBqbPbFBASBvlhFXO
         ofQsYpJtuNal1+BFeOWHuj5OiaUC5/lbv66ERVkB4c3QypM3NZmb96zFcCpMiV0g0yB2
         zF6bNw6EeygDAanHZbd8My0c02L0DzbSApJcQyqARutDNRhCqf6PoV/+btLKRPigNK0D
         CLWeX3hqkpeYME6HlR1c0jlW+fOCWZRkg3NlSLaWYy2We4hyNkbpbK5LsXEtS3H9d1AY
         XTtw==
X-Forwarded-Encrypted: i=1; AHgh+RqErmqx7w0k2+PTh7mJhwuzrGV/k5rcAs1LjINPi34nrycIQkbkxUpBrU0vV6UiHGe/9yVPOzLGG58=@vger.kernel.org
X-Gm-Message-State: AFuF++n1rDfRz56Z14P2FaiyAkSsiNVUqJiPhbF4tPo9lRHoY1xHlt3P
	5VrApuy6oXx0BbZX1ZiJRJ9uQgqgfzSgDIBE9JieQNvK5wLKOXwadLXQUYoXabXOtLMSqWoccAq
	okRqakDjPO6QPWrSiMeG1w+EhM8xvjUy4tVXBLL8vFE5AYSCJHki/bbr5W9nHpRU=
X-Gm-Gg: AR+sD12NonHlT3vw8MbfDJlJ6TtIpTbtzFd97jjn8AchTg99XWDwLU/mp0g2Oh4gAt1
	4fv/N3lWXTPBqih9PZ1wVIjSPFN+c0GpKXL09MMq9hkuj8mC7/sXThMVevP69UUkxbBKuiJGia8
	bjLF/QysTAmL/SNUceewVaEEfrm9Oya1ngbiGQIb769AM6F+z/AtERLaEmxnG77h3VHm3XSL+Xf
	0e2zS82CMm6gGvdk7LU9o3JbhWqqr22YfnY+3zhPbmWg6s6riBv1qMZp9DQHN4a+ilUWTAuz21G
	15RT3cR54mppxfE4HsCCVi/LKFwz1XJ8vCyZbrrTkHxAy/SZkGab0FnGS67U81mnLwG6IXqBsUZ
	5KDBDLZacIa1xuXwkw1oM95ZeLLX6CZ3CDoI=
X-Received: by 2002:a05:6a20:9c13:b0:3cf:a7a5:e310 with SMTP id adf61e73a8af0-3d267b656e9mr12127967637.9.1787906632749;
        Fri, 28 Aug 2026 01:43:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:9c13:b0:3cf:a7a5:e310 with SMTP id adf61e73a8af0-3d267b656e9mr12127876637.9.1787906632314;
        Fri, 28 Aug 2026 01:43:52 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f784857sm3673459eec.3.2026.08.28.01.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:43:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/4] Add PCIe support for Qualcomm Nord platform
Date: Fri, 28 Aug 2026 14:13:34 +0530
Message-Id: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADZKkWoC/2WNwQ6DIBAFf8VwLgZQQXvqfzQeALHSVGlZNW2M/
 15QD0162WSSN7MLAuOtAXROFuTNbMG6IQA7JUh3crgZbJvAiBHGSUkJHpxvcM5pSaqWNoU0KEy
 f3rT2vWWu9c4wqbvRY3TjorMwOv/Z/sw07o4ky/fkTDHBFa9UJoQiIssuDiB9TfKhXd+n4cTM4
 RQ/jtCEtUyVghfy36nXdf0CA+IPcOUAAAA=
X-Change-ID: 20260810-nord-461809f1d5ae
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787906625; l=3019;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=tIwPPb3FEHbFHjDaQ5ESAFuaUuExJUDsggZM58cySkI=;
 b=JEUk8jdqpAVjMnx6k0dgKfpIFjSlX9NiSxeD2+qbk+SjZjFRWPJuDPz7I2ZXvNr+nr/jHcECL
 jZAHHJtdjwuBfkC/ateQOYmBglb5Yqa1x0KMPIAKnkvCh4q/LoXONUZ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA3NCBTYWx0ZWRfX7cz8fpgayBP2
 7bsmNawaLBss8lOahgrw1AQxBrJhYRZ+5QFDtNj9Qogl9Y7TG7hlZubqyNlUzzVLwNYfgdzPkvo
 KiQMlcRVwmXQP1elxbjlXYBMl/DwysSOyLrPJKzcWcHiXErZHWGLb3dDRH83nbt7eLQ1x9hQQsZ
 QFy57rgrP0+h74LoWRbNojwXKANfJnQZWGQUcz0iLDTb5p1d/+qgCyDsvLwykAlfW7ktxxWbKBN
 wkkhMQHjJW89hk5rLPKcvOo8z0HnEqj5gzK9SxFo5UtgEOUUheNMrJNdakDTkDZai8r4sQx4s8z
 g0PKc+FLHQYzqe8xX4HSqZX1B+5AFDaqkLP1rLM/5EK9hEk4IvzWX2W/mZaIp2zxa19LNdZylCH
 vpZqyWNZggP4PEyyksWHyFyU5qYHCC3nN+9++x2VsmMxoZE3rE0OzN5iKMuaKChqhdSSuNE9XDD
 mHp3FBn0dwO9nTJYQzg==
X-Authority-Analysis: v=2.4 cv=MONQXsZl c=1 sm=1 tr=0 ts=6a914a49 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=1XWaLZrsAAAA:8 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8 a=mkAmWphk72FtIL2ZoEcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA3NCBTYWx0ZWRfX3eMTBWEDayaC
 WzmUJiqftofVJ08bH03YKhi7qR4vb3ceXAY2etbKzDJJhm8FHPrubgDBslkvXOWuLUpOQ2lQVQS
 YUoMiouY0szOIH1z86jFi7RoZKOUZPU=
X-Proofpoint-ORIG-GUID: z3oP1EfCW0V8BTp4THcoiiVaegErDKFe
X-Proofpoint-GUID: z3oP1EfCW0V8BTp4THcoiiVaegErDKFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280074

This series adds PCIe support for the Qualcomm Nord (SA8797P) platform.

Nord has a single Gen5-capable QMP PCIe PHY block split into four
independently-clocked and independently-resettable ports (A/B/C/D).
Firmware selects the active lane topology at boot via a TCSR
configuration register, and the same PHY block can appear as a single
x16 port, x8+x8, x8+x4+x4, or x8+x4+x2+x2 depending on that mode. This
is similar in spirit to the Glymur multi-PHY support already posted,
except Nord's PHY registers are programmed by Linux rather than by
firmware, so this series adds the PLL, TXRXZ, PCS and PCS-lane init
tables along with the power-up/power-down/soft-reset sequencing needed
to bring each port up.

The series also documents and wires up the qcom,nord-pcie compatible
(reusing the existing SA8775P PCIe controller binding), and adds a
CORE_CLK_CGC_DIS/AUX_PWR_DET workaround required to avoid a timing
convergence issue in the PCIe power domain.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
To: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Bjorn Andersson <andersson@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org

---
Changes in v2:
- Fix dtbinding errors (Krzysztof)
- Link to v1: https://patch.msgid.link/20260825-nord-v1-0-7c02f2b8765a@oss.qualcomm.com

---
Krishna Chaitanya Chundru (4):
      dt-bindings: phy: qcom: add Nord QMP PCIe PHY binding
      dt-bindings: pci: qcom: add Nord PCIe controller compatible
      PCI: qcom: Add CGC disable workaround for Nord PCIe
      phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe multi-PHY support

 .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml |    1 +
 .../phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml        |  276 +++++
 drivers/pci/controller/dwc/pcie-qcom.c             |   16 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c  | 1077 +++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h |   56 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h      |   14 +
 .../qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h |   94 ++
 .../phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h        |  194 ++++
 8 files changed, 1688 insertions(+), 40 deletions(-)
---
base-commit: 6e448b42dcb885d89dfb80c4263e579c1c4f15ca
change-id: 20260810-nord-461809f1d5ae

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


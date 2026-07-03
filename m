Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071A3CF043
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080532; cv=none; b=RimQAF7JWMLgZ25vma8lLc4vCwXGk0Nsiu6RYglR41Hz4Shgrwmbokb5BPvYx9JqcWajX+K5eImuAApIgA5xJC8djB2GC6OtJJgcYBIsqR3U9VlefHbdrrvhJHUFH7eweCLCgmfz7Uy6KDaA+qs3sLLrWayVKXKCfDDmlcMOtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080532; c=relaxed/simple;
	bh=BUnkY/0PhRAAb4fytqk7lD65By8W889aQEAnDJ7aUVE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UjeddBT0ljl0IRQ1aIMpPF9+yiS/jZ1lwn3ZmbLk1DhNPEvyiSjFXVNMjiLc5eT73utUrPLlhIOG9wwwEoAqZF2SvLwFMOrlsePCbADDF6uVEk9bAXzj0MHkOs0awWC5oRZwRdeeF2AgSXQBk6riOYFEC/JC3p+xKX4eShD3Idk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lqrSXaoX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZTbqd9Em; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lqrSXaoX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZTbqd9Em"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663B2gOK3126390
	for <linux-pci@vger.kernel.org>; Fri, 3 Jul 2026 12:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bgimtSI4aro2GhawYEE98j
	B/geFpQ8EBMgBfF8FzehE=; b=lqrSXaoX1UEei3eG8FEcJ7G2MaTbKPG6Wikb9T
	WuyIhFEerATSshhir549oADX71e1RXjE7X/HYb9Fz3flTfb5dSriEze7rYj2DXxT
	CBnGKYArmTIrNyMR9AEhLKhRpjZXf+tiDqpSbZpjEWxGAuEhh3ie/zUqxwSfbwoo
	iLZKE/chhvMwvbagxYtnpHJPPSofEVXbmCbK2lF3geEkhnp18O/kWGTCpbGViajW
	LPquW0SF+8rskfeXySfvQFNvpoICOjw9gD87noBDKZSA4moazue6StXXxpXnN/6k
	qoMimt/m7/YaV4j7P3dbKJw/8Y7qbyRGpBzkX5vJd4ctLYZw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5tpnmcug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 12:08:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c892143db7fso527931a12.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783080529; x=1783685329; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bgimtSI4aro2GhawYEE98jB/geFpQ8EBMgBfF8FzehE=;
        b=ZTbqd9EmJJlkvZzTFmycIq4ppqPRiOKrRoSwqzP4KvnPV8V3rE2fy4gRrtuaOPIBMc
         Ud9i/5uenBXKhSAJsBRCbHpUGTeHJo9iKA3mNCobvaX4+gRpbR+JnxKmUvAA7D4+cPAD
         YGy3O5FcG/aPNGz+kDIePfafny03COnK8EVtcnrphOHcOXGDNyg/aXGmQnw4lS47Qu+2
         35skNgPgWW5VF8WAHFeRcDZrn67PyL9B5yl8aaS+BiRSfYvPUfqpiUGjYW5sep0JZRle
         w1uIwykRoMYQ/GvfSzWAtlfb8FsxuM+X/sWmS8a1XyeJQXp20euGwjEjh196+DoOwcYW
         F7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783080529; x=1783685329;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgimtSI4aro2GhawYEE98jB/geFpQ8EBMgBfF8FzehE=;
        b=jJ8A+CUo2kPz3iGi8gGa0s2OBNQ450OXaQ32zJtjgKy2Rrs0Doumvra7y3vTHef5P/
         KEJnT8LHYjUUpUJM1FESJuUvJzhpa2f3BS9FsKJEPgNsG7qKzDiYdn5M4eiEzND9oddN
         JNHB8AVWMbQ349zdNPaQO0EWIH+046iTxg/e9CMCeO6w9wbRUhDmWtsLjVtoL6ZM0vHW
         pnL6bWSk474KADNuHUc8YTQ9nysPhblISI6HnxxGfH+WvqVG8cMJp61v/6zk5gyt5ggP
         wLgrN1eg/HRVYLLiblh0VmpWyTyirV7gmU77LRiXtGvxweUqdNpa6Ri38EEQFCGbwup+
         t4YQ==
X-Forwarded-Encrypted: i=1; AFNElJ+exE+wOVXGFbQTqF+Gy7q0HEHvyNhh7ZI7QZuDJFxaQVoZpyIFdKK2wSYvXyK9BSLtA1DMpFn4G0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTuCwHPm7/IrX66fgvh/0bBX2CUBvd38N9vxguutgZqC9UPDgy
	DJ4Jm4EW+LVg58B2vkFr2zxwKafB2g312YjRmC3oCo6W+hExg/OpUelx4/T5QFQzk5kLV1l2IMN
	yDTI7YgorAgNM55gUsnkdr7HaNopT1B7BnvxMu4XSXa1eSBgp2qBY645Ana2DEqU=
X-Gm-Gg: AfdE7cmz9x46nUxNv3xKgMsICtst0kIZGnKZs54aly/baIbgdWduxheLlgmUKXjVn79
	C+Jw00TXDYU2y001s9Zx74m44cY840VRf3Ch2NYbigApdQcN5+FV6Xnb0VuG+NOj9Brk4LGTVTW
	Zcb0u23ykDPNESBd6NUVoiVlEIUxLEYypjJ6tht808G8gfNMfeRiButuE9yoSuBW3GOjn5A5lSX
	Q8WOKmp9zhFoLieYqYBOJ9xzM45tqCBd24R949Pr6Nutko5DOtYUM4kcT2eN2Bje1B8taC4MjBM
	gR9ep5kH4lK92Ds+yVUArAmFowI5WPH4Ncvyy0BoiOshkSI+ORuWL10gzyAKyYkJAn1goBer7Vf
	lZ6T3pKFfOs+ksD6GEi4rO1HqVYAFVAVoxmer6Vb+Ms5whpES
X-Received: by 2002:a05:6a20:2445:b0:3bf:a489:1483 with SMTP id adf61e73a8af0-3bff4255df7mr11649236637.33.1783080529186;
        Fri, 03 Jul 2026 05:08:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:2445:b0:3bf:a489:1483 with SMTP id adf61e73a8af0-3bff4255df7mr11649190637.33.1783080528550;
        Fri, 03 Jul 2026 05:08:48 -0700 (PDT)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb10638sm2530779a12.2.2026.07.03.05.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:08:48 -0700 (PDT)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Subject: [PATCH 0/2] dt-bindings: pci: qcom,hawi-pcie: Add Maili PCIe
 compatibles
Date: Fri, 03 Jul 2026 17:38:39 +0530
Message-Id: <20260703-vdev_maili_dt_bindings-v1-0-c9df0916cd5e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEemR2oC/4WOywqDMBBFf0WybmSMWh+r/kcRSXSsAz5qommL+
 O+NdVG66mbg3Msc7soMakLDcm9lGi0ZGgcHwcljVSuHG3KqHTMB4gwJCG5rtGUvqaOynktFQ03
 DzfAUEJIQmjTMgLnnu8aGnh/xtThY47Q4/3yEX33u/cpb+aDyaA0XSVzFWZOAalRuA7a7WjLzq
 F+fzS7aZf/m2YADB4hSmUYKVSwuozH+tMiuGvved4cV27a9ARxJl7sPAQAA
X-Change-ID: 20260702-vdev_maili_dt_bindings-80e0730f8390
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783080523; l=1468;
 i=vivek.pernamitta@oss.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=BUnkY/0PhRAAb4fytqk7lD65By8W889aQEAnDJ7aUVE=;
 b=IIvPLEPo3ILp9Ml/IKyB60FD/DR1nBHlasElwM1yCiueOsNQb+FaXoYLj0BA8j5VrgH1TnA1P
 nRIggsUh3VGAp7smc+TYGlcTGklmUuwDq1XxSbXaEbmsXjLqaV0aShA
X-Developer-Key: i=vivek.pernamitta@oss.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-GUID: 34HgqZGccjYCFEgk0YPdrr5gXqAYMDtS
X-Proofpoint-ORIG-GUID: 34HgqZGccjYCFEgk0YPdrr5gXqAYMDtS
X-Authority-Analysis: v=2.4 cv=UMft2ify c=1 sm=1 tr=0 ts=6a47a652 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=suQaG4udzKv4wnHqcH8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDExOCBTYWx0ZWRfXxKov52yZSs08
 2E81rJwDpmkZrXY8AMWwug0/qkRRzzBYfO+tp3AOBgIyeojZf7FeqjF7YcPeNWi8lKDjauqqogF
 kqtIruhJvkyCi1sG98cd5QjRjt0OIzM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDExOCBTYWx0ZWRfX9gDQJdRh3Ljn
 rpK97ld0TOAJRoOodFmsrAlB1cpzO4qcG+ta4/F7Wj9aKFrZNvceSi7WzA8MIHSqBe+r9rsJSvv
 ReaZOaCot38MQ0MasWvc7hYGUrCIpoHLtsroto+ESMYv/+1RdfM3ZgQHKXjxo0oPuFY9yNQWH72
 m6nHChnPODVfaXpyii+kzSTaHihDCg7/0LzXgpDobq1WH5blx7UcxogjGH90dGyQxrHblP6WDSK
 GhVi93RFH/eQDsePp+eXMWmiOfOUOKaOmUcty7FfIWWgt50QvU0rxRi+F0tOdjAaM3OHbE/q68l
 iGmLZw5WZUbuJy1aa9ZFCiXdpRzppNwUbDwbk2SZBbkmby6rkYkQYZfxU70kWmhS6F0smrLnq8f
 xJQZhPd2afgi63/ZbNplrRd1r62EbzoXfbVT3VjTi7Iyb28HEDarzF941tXiPQjGGtEz96BxvYw
 G0rw7tTJtNqEpLR2vPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030118

Add the qcom,maili-pcie compatible string and make it fall back to
qcom,hawi-pcie, as the Maili SoC reuses the Hawi PCIe controller IP.

Also add the qcom,maili-qmp-gen3x2-pcie-phy and
qcom,maili-qmp-gen4x1-pcie-phy compatible strings for the PCIe QMP PHYs
used on the Maili SoC.

The Maili SoC is a derivative of Hawi and shares the same PCIe
controller and PHY architecture, allowing reuse of the existing Hawi
PCIe DT bindings.

Dependencies:
- PCI: qcom: Add PCIe support for upcoming Hawi SoC
  https://lore.kernel.org/all/20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com/

- phy: qcom: qmp-pcie: Add PCIe PHY support for Hawi
  https://lore.kernel.org/all/20260618-hawi-phy-pcie-v3-0-3fa42ca45ea4@oss.qualcomm.com/

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
Vivek Pernamitta (2):
      dt-bindings: pci: qcom,hawi-pcie: Add Maili PCIe compatible
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add Maili PCIe PHY compatibles

 Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml          | 7 ++++++-
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml        | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)
---
base-commit: ac5f929f2f373245abe6fac242c8d3fec4ca38af
change-id: 20260702-vdev_maili_dt_bindings-80e0730f8390
prerequisite-change-id: 20260702-vdev_hawi_changes-275c59f70bfb:v1

Best regards,
-- 
Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>


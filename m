Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749D3CF692
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080543; cv=none; b=a42p1qqiSotX5wOmNQdJyKNiuFpyKlo2f8Nlckp20eCe4BluuZQLECy6CoIPfPUJhjzJQsVU4GsiVfLJBjQCRzPb2SkkeVEjRShkjW9XD32hQZ/SXLXnX2i7VzNowGXZ8pqFcSlF6s0KbERu88BR3/4r5vBDaICMMaQZ1FENJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080543; c=relaxed/simple;
	bh=RLQd+8L2duBjcipyPTJw+yVMnJfcWltw5Gg8I61tJk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hM6fuotlkoXO/wlWPyftI598a4WuD+vh163n04S9EvP+nJZfImjX0idNE01SVg9R6mCw+P6O024hQNmKDIy6SygdmCZVhztAQWPW/ls9r2rb4RnFgVr5Zor5sGGyUl8OTECnuUSP68THAEWUi1VOIQag5GWqYgXJbr3JpkpMBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QsV1Vm7C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEihPR1h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QsV1Vm7C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEihPR1h"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BPjns3108955
	for <linux-pci@vger.kernel.org>; Fri, 3 Jul 2026 12:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KYQhHF4yO5tQSQmCplJ7wLXwhEcx8usic4R8j8a5X2I=; b=QsV1Vm7Cv4qlZga1
	+JfGWGDdpU92l472Nr+xVk+5E6RpIa5832TKX4ZoqLhWyooLRd0cdtMwDZevT3l0
	9HnDWw+Rw5gQ2T/WVLQa3+V66NWv3f3rcZ/52qes+4i2s2zdM4kGCO2DbjqOXZMx
	iFoZQOzYmlESetPB6tT9aUdRtXJnEPKP2rZJxEs/cKtTWLIB+d2LnEkkgmEZIpS0
	FEI8BsC5Nu4BhaI0cRjcGuT6UhOcXM452TpoptL7inzNpkx/UClo2MfW/gU+TbZs
	fDZFEiqN7jE7eA1jDNzsk2seyWQmF0/igoua7fMA1taVsfGd4s4WC4nKTdl6MWOX
	PSevGA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyaya8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 12:09:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88e0f04e51so603224a12.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783080540; x=1783685340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYQhHF4yO5tQSQmCplJ7wLXwhEcx8usic4R8j8a5X2I=;
        b=IEihPR1hwm2OuBcHzmUfN3gnKSwssZWJ4HseBd2Bg4VO974s3u7RabqZmRASI5doT9
         bvuEpR8e++S8xODxpWjZ6perEeB6FIsVX+xh0ZxgsBLU25lLy8qFUtxoJ0DK1XlrvptN
         zwQp4MZ0uQ0R/olH2F4/qR4fsJdWajmqiJ/KWmEtSVYRhpOe1ljqBeTungSYLM6gTOpp
         MDAIEylAirb7z7R1A9UjwM023/TNg8xAuEM8ie8a0nyf7LoyRRb+gpFRAuNm0HVlJGV9
         hXPF2CJk0IXZYBLcXy69lvFpqTLWsxnH0phCap10psmMLoZ9ogq6Q5G8jzlKaf3/xbWa
         4Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783080540; x=1783685340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KYQhHF4yO5tQSQmCplJ7wLXwhEcx8usic4R8j8a5X2I=;
        b=HOfL6FbcqXIYjObywGdXKy2G/eZam7dM/yg40XxvJ1XNSwUf8aZwwAbOW0R4k+kiMo
         vPe/aES9gwVgeCYnzuygWg9vLU+3aZrlpj+sL0sxIOAMy+R3uRhzjGhfTR4GDriwJtwk
         OB1N3sXCKrWQUCfyrGl23mImJXJ8KxVHvfuf527ThIncji8zmAG2q9h/D7JXoKlvqfoX
         1bjO3a1Jc3Xjehaj/UWyNf38Xz2ELAyZiC3Fxk2mFk4RJi5/Tsrh0zNHGx4r+1TOMh7a
         P+slj0dSLqKY71dMj0U6oCyCAu1ZyduEgDm/2P0nZfu7761tCw4H6+EpNMiLefw5ggmX
         4Zkg==
X-Forwarded-Encrypted: i=1; AFNElJ+VDhW3QQndiCl/W6ETTEw2Q6X582bTD1ktmb5BPg0flSVq51qakaDv6ZhxmkEbP8+COnEUv1h93hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlY9a0mLxngxtCz+PS4RCsCmZPju+/8NZX5ABUnA+Z5uurzB4/
	OZTnWhrM9DlT/x6xASUOKiMbjknWabePu+2JfpmfDvZpg+KQuUMATzHrsa/p9PGLFJWZm8IANQe
	/JCmjafLsb3fyJ1DC5Z1+j1DX8qmDTpsWPVLakXEhQCa3ub18vKHfl729TX1N2Pk=
X-Gm-Gg: AfdE7ckprEuzgvNVWpu+LXBHeNAKrc1E+1a2e2S2+cqTXM/ZLafdIAhWNMqJ5oROmR2
	HD7VK5+iNG5/+iw3T0jkvCoaD0L8QKTGux80BIga0MT550mx77uBVwIOIEEj2+gnN9ne5QF8AAX
	ao4CfVL1yonyLkidbaJi7IJ8Z6I1F4vtaV6iGdqsvwLg4rCCiF9cBstSTw4pVD9qbpF+ffmcSA1
	BYnBkgYRuNRgIBj1Zw50F9usP41Eo4jNFEbb+wRUWZIcBLHr1pLu7L5RKlilZHN/ieI3Accg/iV
	63TqkCs5XkASNHx816WeDSL5s4OGlQfncr59gRm5F5qR+MvbyKyQHXOZ55s0Eoz6mqDrZtzreT2
	OBytre+6lnZDy1z/z/Ui2YYOi9GCgbtd8nx1LA2pyMiVsVy3H
X-Received: by 2002:a05:6a21:6f12:b0:3bf:7498:9cd1 with SMTP id adf61e73a8af0-3bff42b62a6mr11392375637.45.1783080539649;
        Fri, 03 Jul 2026 05:08:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f12:b0:3bf:7498:9cd1 with SMTP id adf61e73a8af0-3bff42b62a6mr11392323637.45.1783080539153;
        Fri, 03 Jul 2026 05:08:59 -0700 (PDT)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb10638sm2530779a12.2.2026.07.03.05.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:08:58 -0700 (PDT)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 17:38:41 +0530
Subject: [PATCH 2/2] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 Maili PCIe PHY compatibles
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-vdev_maili_dt_bindings-v1-2-c9df0916cd5e@oss.qualcomm.com>
References: <20260703-vdev_maili_dt_bindings-v1-0-c9df0916cd5e@oss.qualcomm.com>
In-Reply-To: <20260703-vdev_maili_dt_bindings-v1-0-c9df0916cd5e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783080523; l=2267;
 i=vivek.pernamitta@oss.qualcomm.com; s=20241114; h=from:subject:message-id;
 bh=RLQd+8L2duBjcipyPTJw+yVMnJfcWltw5Gg8I61tJk4=;
 b=AxTvxvUKlTazRBczJfhkLqI1ilqpqocvA9VMTCUBo2s9osBbfUxOMT3rka38QjfODOl0oIE+e
 WPvCvBzZ+5KDt8UxK1zdLrgcZivTo7eslU6Sb4OYKTvlyjQeSoSsiOj
X-Developer-Key: i=vivek.pernamitta@oss.qualcomm.com; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDExOCBTYWx0ZWRfX/u1j0djUrqnG
 JrAzQanNQ6rlAbU2ZzHcdYrc4ui7JNNxa029/JuJKeRkSIV8xozRIzy0qK+OBHRpgJxWpcGIhXt
 Z8u2K0o2mWwddWKJCiPQN6CGaGqzPBSStIZkNz9VaTaG5gSwJLL3SSJoxz+QPrYfvH8ANQMLK1H
 HXwlR15QlbF8yUGWEuBAEiLdb8HzeuTfo8ntH2E/gQGtKozh0Yq+pFaeDY7fhPW/R4BBelZ7MIl
 xs2C5niWBF0quBrk7wh42qcZ7AOx53a4BfmqZX6FdE61ZG+qPePKlQBjFgjodNzxagvGXYFXlQg
 E6g5RBoCRudaGK4/zeNC5j/lsxqatTj97mw1iPrjz1kQ20B9AjiG5enOOTe/0+5WOAUGpl/0tVq
 RELfzLQ7wp5LaxFIGqZt+xD1K8ZyU3W/IicpEXpQqTXM3CdkWXnBiNjWeLNRjwkdlGlEUCtRxD2
 PBv28a0eARkwfC30+Yg==
X-Proofpoint-GUID: O7vtPTf2q6rVxgsi4AO0aXxJXdycBXzM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDExOCBTYWx0ZWRfXziOEnDdqJbd6
 nb/nS2WzkQqUUyyj/iDhD+Zq5CMzt25dEopFKPYtGFpGDcbhFbnyIz6w/nWMYaeDdL3j5T3/VOG
 e+hszDg3QN/ha4UbjnBaCZ89Ey9LN5o=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47a65c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DH4gakA0-Fj5Mf9eDRkA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: O7vtPTf2q6rVxgsi4AO0aXxJXdycBXzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030118

Add qcom,maili-qmp-gen3x2-pcie-phy and qcom,maili-qmp-gen4x1-pcie-phy
compatible strings for the Maili SoC PCIe QMP PHY.

The Maili SoC is a derivative of Hawi and shares the same PCIe QMP PHY
architecture, allowing reuse of the existing Hawi PCIe PHY DT bindings.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
Dependencies:
- phy: qcom: qmp-pcie: Add PCIe PHY support for Hawi
  https://lore.kernel.org/all/20260618-hawi-phy-pcie-v3-0-3fa42ca45ea4@oss.qualcomm.com/
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 259ed9678393f12c03535389b972fed0c7e36517..971474526cf97cf333a80a31e8fb13abcb995e97 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -23,6 +23,8 @@ properties:
       - qcom,hawi-qmp-gen3x2-pcie-phy
       - qcom,hawi-qmp-gen4x1-pcie-phy
       - qcom,kaanapali-qmp-gen3x2-pcie-phy
+      - qcom,maili-qmp-gen3x2-pcie-phy
+      - qcom,maili-qmp-gen4x1-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
@@ -200,6 +202,8 @@ allOf:
               - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,hawi-qmp-gen3x2-pcie-phy
               - qcom,hawi-qmp-gen4x1-pcie-phy
+              - qcom,maili-qmp-gen3x2-pcie-phy
+              - qcom,maili-qmp-gen4x1-pcie-phy
               - qcom,qcs8300-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x4-pcie-phy
@@ -230,6 +234,8 @@ allOf:
               - qcom,hawi-qmp-gen3x2-pcie-phy
               - qcom,hawi-qmp-gen4x1-pcie-phy
               - qcom,kaanapali-qmp-gen3x2-pcie-phy
+              - qcom,maili-qmp-gen3x2-pcie-phy
+              - qcom,maili-qmp-gen4x1-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen3x2-pcie-phy

-- 
2.34.1


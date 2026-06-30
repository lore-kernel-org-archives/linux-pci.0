Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1A34389D
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846207; cv=none; b=f9setmbGVkGGE1hmXU8I9m6eMqWJYz25hrescNOXCjn1htDJtOtOiJq3xP/ZgU3Lvc0spRkqfwizalMG40C+pSYcMKLXy+I8y2MbstwD/pEGMpGe0LIz3Veac4YBBWdGz76UuI4zTo1+MycNvIs4kXkbupTgmXYrQnKfmnYG6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846207; c=relaxed/simple;
	bh=Idyt7VPiLOMUneagHN9PxugOsJessHhJSGZC2obkP8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEQXes+EZXk6id7fMDGC66IaKSjzzedQZOd7UA7HKzcGIyWJEDhvOfOdbJO9JbaBlXJ3sjJhQc4xgdWsPHGK+efkSHkaLurmlmcqj7frdfWRdaHr6ENhDroTY8+WCBNoS9OMUZag17y8kenkX3GQCgI3FDhQAFJ3eaGLQ6ZFom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R1iXZhg9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eIf1U/ab; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1iXZhg9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eIf1U/ab"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UIDCH72768462
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6FR5VWdYyPP97YYCxGcdgj/3+qyFVzAQu966AQXL308=; b=R1iXZhg9haY6dm/S
	2F39eu4ii4yyDRtTNPemOjRDf69aWTMnvRIIejfqUATWkEd9EEA0B2kRgSfL7QQR
	RPqXr7eAqaKlK9WpfVV7noyzy/Qg+JjMLELH5gTm/P9/1D649+q7Pm/HdCPyLJ4w
	r81nuKMODFhFYaeSDbp6nhUotDke3RY7kbdisBNVesbuzpl+neBO5+4JAMNOJC9Q
	0rypCDuDh1Ak6G9LOM0OHBFfywAwo4ccijxp1NnFbqkwNO/RTKDrv/JQsoW4eCWQ
	G71krNoJWJC4qgbtisuTBnB8SHcrbZSGOqruUwhbZR0uVBAj2ef+fpCsskxzbPXR
	Mb8alQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvw8892-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c011c7cb9so13661893eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782846204; x=1783451004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FR5VWdYyPP97YYCxGcdgj/3+qyFVzAQu966AQXL308=;
        b=eIf1U/abMtM22/dkTQ8GhUQOLwpYi6NudSKhT+5PlPeHp03MSl25kXnTYPirFu51uF
         JbM2IkfWhUUMRxBeT5ipQ+86BnVtKhl6/0opwtHtrj36AwXlsMG0ZS1wuVbqp6gxLfGn
         mAN7cq+sFXjqHcAZ9mpJUWqd4UYmDywF2y9pOCbXVmf+25BoJ9uIaFggpC27gRcP4ZK8
         Cl7hj44ozSqbHBV/jq526vcuCXWKMkw12u/TjcaViriot7qD7iYcdOjyehA/8SnaWgOW
         GIvZHYIxg3GJunlbrG9ljezFEReiiljg5qK8UGlO5yLP5zMFS3B9CpUqfWkfndAH60vC
         ZoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846204; x=1783451004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6FR5VWdYyPP97YYCxGcdgj/3+qyFVzAQu966AQXL308=;
        b=dwV+L4Vu/eP5Aimzhz5jDF9pISqxUK/DlEymF5BHOM3JeROeouaI4GxAP7eALS65uO
         FYgnuGLBKmefyYAGO9mjaIwZr6BwDebPzEtGpWL4JxuVwLrlgvD7DbFqeYUutwOn9Hqe
         04RKLzmDTg2qW7ZidSIYi950LiXb54g5t6ZuEp5fs9TDoNczWUIAVPpqKr49CA2IZ/rm
         qNmDdLO+4IWnxHBayR8QerhO8eLp/MB6I55VV1JWYtDeE9beRf7shq94Dzondrp6iT0y
         kfqi5NU0+szm/ASRYGJDy9T2O44IlpV03951OMZte/SV3VrImJ4kByhV6ddWopDGHmxS
         g0Ig==
X-Forwarded-Encrypted: i=1; AHgh+RppHsdM8fWB2lH5IUMF300XrVAeAveom+vOC8BRjeVFXZLxOlapCN+T/HXepJI3Ls4VEj0PHZG7gQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwztDWJYOExv0xYyykASiSiEspZg9rvdJU2f99+V7xFVyE6QGZr
	ZsLwohCwLnSykEUPfSOKTa+JMcu+P4YN5XZVS2gX//ANGmD/9492CsJX4CJqffj9pBJVvdtCnx2
	AaM4P6aV8XwA1AZXPqGLXaySLRor+vAb8LZijpVghhUYQr9IziDPvvGQWzfDUMYU=
X-Gm-Gg: AfdE7ck4vv12Ql7hKqEULvsFdqfAqJv5/Ns4L/ktdWbuq/D14aH7BQ9NDkxv2IoXGgE
	YXvFG5Gtbf1UYfPDQtKcQBxwJW6lv5m18jnkGW9C9FiTJdNC80I/fJ7oBaMRIhmvp9jmIy9fw1T
	lObCabwuLNB5h6fGif+Uy7GryAKXI9F2SwIa8f6k+zKcC4Jb6G5cNF/bksqxC/F9x3RmaXBEq10
	X5cFP2x/RweWSHYk9Wpyre9F0tAH+jx4zN9RQIlxzWYeFDYaM6CIw7xKbrsrtOnrrZvibTFJ0rm
	qR1ne0oF/9O7W6u93/S9L+OfvyjYMxRQX8dVnjb23fglWzwRrbMiC1VzntKRMae1FXAjnmYYFNk
	WAQrOR3IZD44X7NFIb8hN4h8A1BCJu0UzqvK5s/J0XZyHFJY=
X-Received: by 2002:a05:7300:1824:b0:30e:da5b:2725 with SMTP id 5a478bee46e88-30ee12c0a42mr3649123eec.6.1782846204243;
        Tue, 30 Jun 2026 12:03:24 -0700 (PDT)
X-Received: by 2002:a05:7300:1824:b0:30e:da5b:2725 with SMTP id 5a478bee46e88-30ee12c0a42mr3649064eec.6.1782846203728;
        Tue, 30 Jun 2026 12:03:23 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee317095dsm14963815eec.15.2026.06.30.12.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:03:23 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 00:32:43 +0530
Subject: [PATCH 1/9] dt-bindings: phy: sc8280xp-qmp-pcie: Document Shikra
 PCIe phy
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-shikra-upstream-v1-1-e1a721eb8943@oss.qualcomm.com>
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
In-Reply-To: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782846191; l=1298;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=Idyt7VPiLOMUneagHN9PxugOsJessHhJSGZC2obkP8E=;
 b=uqjVKoeHK8WWuWX600D37o+uFPkHhRKB/ccwAF+sT33TdNNRkCWATn1i6vmYcLafrBzb9pTBf
 Cv8UhUYEmfRC2ptExN9cTlfzWDtzTDysF/b39BoFm1OhlzFicTx4WmQ
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Proofpoint-ORIG-GUID: 1emp9bvbHOjR7M-9aBLxWMuyNecfFGVE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MiBTYWx0ZWRfX7JnIPQZC20c7
 2DSlyZWTImmZssgSkCH+SHC4j5SacApN6GtgyIOrbpB4NaTE6jQzQhrl53mLcmyNOYFp3MypvQz
 kvwFLjNikTVYZ8UTneTK8mj2jc/ztBI=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a4412fd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=EF49ANZLUTmcXe5zpi4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 1emp9bvbHOjR7M-9aBLxWMuyNecfFGVE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MiBTYWx0ZWRfX8y3ucj4hq0Fa
 NjPNPFUVCYYhFVQO1tKmTuzVpQ+i3Jp5fwvPRLX5C4QvFppuul2lZX7VDaPqpuUCQSc6ilqhXlo
 9kVCPB8MrZdF+GyN+rLYzWcysdKHvzxt/atxV95S5h+DMf4BQGnBxBPcQOhC/AsLh3i0f8ccXDP
 jJ4TV9Mf0q6x26qcm6ZBbAxh25b93xioEw31b0cBrE07USwnjo5q693cNK94FE8md8OyWxQ9ooV
 xdvLl/uUlQFxzFFGKpE8/4HYhedNeDNhso4nG7FblveedjyXoYZPgXIz21ariGDG1Z/4/rM6Xwz
 FVFfj7CmS6P/1Rs7DObm2fuEtLFCxTVVKJGUPTb//G48THD0tgyp0Y1VIsRyZ9ojCAEPi/WK//S
 jIMjU5c4XeMqWfuC4Euoef/mw6VhnijFffnCSJzlTTzeIGqfBsVaFLEmZBnPlejlaWSw5rW1UGr
 Z+PmbKu5Lzu9/pItB6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300182

Document the compatible of the Shikra PCIe phy which supports
Gen2x1.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 108cf9dc86ea..b9b0fa26347b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -34,6 +34,7 @@ properties:
       - qcom,sdm845-qmp-pcie-phy
       - qcom,sdx55-qmp-pcie-phy
       - qcom,sdx65-qmp-gen4x2-pcie-phy
+      - qcom,shikra-qmp-gen2x1-pcie-phy
       - qcom,sm8150-qmp-gen3x1-pcie-phy
       - qcom,sm8150-qmp-gen3x2-pcie-phy
       - qcom,sm8250-qmp-gen3x1-pcie-phy
@@ -166,6 +167,7 @@ allOf:
               - qcom,sdm845-qhp-pcie-phy
               - qcom,sdm845-qmp-pcie-phy
               - qcom,sdx55-qmp-pcie-phy
+              - qcom,shikra-qmp-gen2x1-pcie-phy
               - qcom,sm8150-qmp-gen3x1-pcie-phy
               - qcom,sm8150-qmp-gen3x2-pcie-phy
               - qcom,sm8250-qmp-gen3x1-pcie-phy

-- 
2.43.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE739FCB4
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161181; cv=none; b=FRr63UqFkiyKggjOuU7F8lwtMB9O3oy9qMTA5D7lmOCDyW6hqZx3LXGHBjJkKfglZYfkv73QfxXmrDyPTtaMXyO1yqw8bTQdEYZnkkLmywlmJVDoxCe9CfoxlqlLFGEHMH4S2TKOj9JbSmfILrGkUHs6jZm1FOXv6ww70+wx/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161181; c=relaxed/simple;
	bh=Idyt7VPiLOMUneagHN9PxugOsJessHhJSGZC2obkP8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIZH5AyiTca6ZVtj7Nds0DwKt7Bm7U3ejfMNkbj2rVnQ3YSckEJ7yPe8EYEPILxeaVhJ+mgDHjA8TXFXwjY+sa5Nily3u2Tu4PGx+fdYOaxE9eARTGpdvEWy+z6rTJ4qNJF5C7wN4NsOc/8WACz6Us9xnYJCJjCYNAtTFFd8kPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UeuqUghM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TJQ7kXt4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UeuqUghM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TJQ7kXt4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52RT52679944
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 07:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6FR5VWdYyPP97YYCxGcdgj/3+qyFVzAQu966AQXL308=; b=UeuqUghMBsSlqmP+
	uaXpdMJRQC0JDgdfrWW9nuEFJ+mgEzV8QJOmkn/mgY86tdj369iS8g+nkiOga+dW
	snU0f/UBNPfgRIRowvgwMuNkw0vdcRlChXrTRaGDwxPff5asfZLck4v0K1gJgrUh
	lCJvr7t64LkstypJ0lTDvVb1qsVqFN/rTk37nkm2/hGsIXdyYRJtDW5rtQbj9XUZ
	MVN3InalaQtJvrjj2ZOWe6s3uYnucC4WB1ZruSIhgGNaqjMOmvGL0E+FJnceKKyK
	fTmgjcKGczk/oHwdwlgSL+BsDDsuyPvJZdOrStzL0WmMEFbpFvjqkdJmiXUkSDTD
	NpAaeA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqhwd78g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 07:26:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc640dfde3so37341255ad.1
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788161178; x=1788765978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FR5VWdYyPP97YYCxGcdgj/3+qyFVzAQu966AQXL308=;
        b=TJQ7kXt4zi8rZ8BeWsdGv8yUZBAG8S0DLV4Tiupg+x6qEa0j46UR1oygIbxL9oumR5
         mK2GAIpKF5gsAG34yiUNGjwDqvuQK9lZqtTYB6KBEl2JdKlmgxQgxy71ImY4v8JrUpTB
         TB9SwEC4XD5N9aADZuZM0QHLD6ipiuNKhtmD92ciIeuBLKuJNG34BoxLlkVVO9jug3gn
         ligwRiBEpmoFDbwYPB6uIrYo0VfpJlHqS+rn/PvPUEcX1aF7Jcga9oid2k240PkFtdVN
         gGVZZi10ChIcC7+vjRsicrAzpUZXdhT2egeVc1/fvc9hS3R7ANRJ2e91QQRrzZR3j2d/
         VcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788161178; x=1788765978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FR5VWdYyPP97YYCxGcdgj/3+qyFVzAQu966AQXL308=;
        b=HSegF47GsWeNL9Zd1SPrUDnzH8S1RrImBjavZmEkhC80YLTUCOhtJ81jfc1I1FsnSz
         6nHIKiMZKZ9TZ6dxNaBD1221EpYOZHmeFF2AlvqjoP7HJbXiJq0H3J86z+5nGR2oGtlR
         UZa9qC7qpAO2UYAYnPsSwl/p944krxm/1BOGUQxjBrh2hOnhHZ0NX0DOm9+P3kE5v5PM
         s7eJ7Q0oXV/GryaU4NFBxEu80ywOwwDgNC3iRAs8kGauOcaqKp4NU4aKBd+LG40/TJk1
         R2zdQgURz7wU/on+E54iJUyDZlh4XAtZTVAqpx3G54POYAFrFZ6jOZ4PTO13nNwdGeMP
         nlgA==
X-Forwarded-Encrypted: i=1; AKwUvBwnmOkCoSqEr7Vdao84X/U1sXWgSdtyLxvrvKuOWXqU5HwVcDYi/PSzeR8LVwiIVgROSJrIuIyg0H8=@vger.kernel.org
X-Gm-Message-State: AFuF++nB5wv9E0z5yQHanAxw/ZYzSyehy1ttPc96bhzuy6gG7LBAhdPG
	FB3XPOTn9cY/I+MQ11/9pPFuDkwW7IifmOKvfM9sVs+z/BySL+uiMzEz4yH3xS5Rh8f86/qWxmA
	nYL9g7HewcSxPT/Galb0Jr1YlRPcrRUoUVDAAofr5vbuO+ZpxjVQDOdLY7lsrBHI=
X-Gm-Gg: AYBFou3aJ92w43PVs3iYZHFKblgu+zCGt4Zh6lOsvOW488sA8nGUQkIO0L6uo7PLkbM
	pZIKq5Ff0CLyz7CVnT/WagOizLe5SJ0s9BpU5oGhfmwSUrbrLA/JWuEVwRPf+Tmz1lBlqCfRt08
	3fcZcv+kFClUlZphM58okxLP4+f7qsJo60iRaye24rVvyWEsxTIpNL7Ie2xA8ZfmJ+YOoA2Mhrn
	V80nWhYRpBjpImYj75QsTbB/BJhIzd2UpOJTIomU9hSnFGaDWp60EsnU1wXq3UYjGAvlTVcFoPI
	8NMtNffrDDuFywHV6UjoTkI4toFzILuvae6g7s8N5RxB9KgH39VxgxmHgrebGIxd5hsyPE/PR5X
	+N9FdTASzHbWqaSQEdZFqitDAk0SqwMGqCLHp
X-Received: by 2002:a17:90b:538e:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-396d0e20f00mr39218624a91.5.1788161177752;
        Mon, 31 Aug 2026 00:26:17 -0700 (PDT)
X-Received: by 2002:a17:90b:538e:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-396d0e20f00mr39218563a91.5.1788161177311;
        Mon, 31 Aug 2026 00:26:17 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9595bbsm31327059eec.14.2026.08.31.00.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 00:26:16 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 12:56:01 +0530
Subject: [PATCH v2 1/5] dt-bindings: phy: sc8280xp-qmp-pcie: Document
 Shikra PCIe phy
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-shikra-upstream-v2-1-406661d75afa@oss.qualcomm.com>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
In-Reply-To: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788161164; l=1298;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=Idyt7VPiLOMUneagHN9PxugOsJessHhJSGZC2obkP8E=;
 b=Afp4er87SYR4UN6qgzu7q7JgcYyKFGUWxXYEngUg1Vyuf9jT+hcvLmpPB3DdNO4CY1P8fIq7E
 u1rd3gw6+FkAftA6Wkj+JrJZlae1Ejx/nditm3eyklqmkkUbVCWeP+X
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Proofpoint-GUID: iHsh_Dc5BqfUVSrKfpDuzBdiXlWmcbeH
X-Proofpoint-ORIG-GUID: iHsh_Dc5BqfUVSrKfpDuzBdiXlWmcbeH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2MiBTYWx0ZWRfX++WagKQtEuyR
 XkTvBbHxq7wH/QYDT6mVVR4WTeCKGf35+JUX7ghfREL5DGCiycCFP2HLjo2regWta3awQgKXuA9
 Us16wRPcmMLCyvZSKlcXGQMG3Tn7XWM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2MiBTYWx0ZWRfX4QLRlq2or/vM
 ccC76c9fhLwxucc21Vs4M09HwhESOvWWqrSe/k6zciwxntimrM6XusfRskR2Qs/RiCHjHDoywF5
 1aT//VoZUKPOJjOTcmVfunPa5UfnHUXsZokJDufB7BdDA9riOXi9Kgq8okZpVb9+U/zMeldz4pr
 fS0QseF8LKBirjQqsokLefHLZcls3245uZVKAGX0fxPe16R3J5x0ebRhlKiZWiQcP5XGqIoOzSg
 ls5mqQ76eWtwYhWhgfxmZp3r2+TRg4cplk2HDaXjp1f9rlrwARDXRCutdENzHbQYcPEfkQWzhMo
 qqBnT2GYy6eSSnYJ9LdVSB3OIRQgCMqyEzXAeIQHClysyoZG0m/bzVRjBcQ3blQ1cvlqJS5fWdI
 KArzps7ZeXJY1Vyq3//fPCkl8g7vc2kDJiM21w/qPq/8O3AFSZwESJqRMtSvaYOK/cfUz1yiO7v
 SgKrG5BlDJ8Y7dFT/pQ==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=6a952c9a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=EF49ANZLUTmcXe5zpi4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310062

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


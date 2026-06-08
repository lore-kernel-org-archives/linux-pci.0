Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E53B14BD
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908510; cv=none; b=NqT/vJJT/WJ4dY4zUvO8RO4V+pUk6wIbxjtHBflrImG+AJ5v4Mb06wFWndmlHn4bGqKw4HW4lT0Ede5F9RyEHV/IjMNt8UNiMQTaXfD5I1YKu/CeeUtiDiQ5ody3V8JNbDLkT1jd03FkJRGDt0QsbTBJvalSFP54xP7h1Rz1fpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908510; c=relaxed/simple;
	bh=xeSQHPitzN8ohDKs18l6esrdselqsjwFIBvIjhevBqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WkgmNxhs3QHZq3R34miKAm60NT+0VfR7gmf+LuMOeptyinZ95SmfSS/jY8PSA2yze1ufuD+aZxv8qNVMhN2LyhS5JllOzhJGKDejlUKOtRjy36wZm83zrjRr/1DxEyRTgJ5Tt9+Frp41wLDgMr0n52ZVCh6LxcY1vl3jXww+eIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hz/bSFty; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SXxy9FxV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hz/bSFty";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SXxy9FxV"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OkcI2347125
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 08:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wVm4TdG5n8U+Jqzsg6ytMrzaYYKYP9UWAt7EIHGxQss=; b=Hz/bSFty7HgdrBau
	e5hogukicKy1U20NFq5et88eBdyW+eCgZeJMxZNvbH9FoXoUiXlXZSvpNjFtabG8
	4w/e8cX+l1yrjNeRVSWXMPGauu5jpTu+mrrTVDB4cspCNyzi0yBjkdpCGRsINXqY
	2c/iLWUg3iF2WkxUHeJcFteUh04Oo86xEixQfM9Lz6U57h/mILAYFCJRjiLX/jy0
	Ndzu9tVc7CyC7ux64pD6wMju0IiWRvQsIewn2mJKzcloUCLf88V+sYl8YLrXgXnw
	MMHLfzspsHuJQm27nCWCpA3M+ZDdgjMDLDInILza3PnSwXp95/sV/HLVb5xP97Aq
	NSceSw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagrf5rt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 08:48:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36bc380fbf9so3991374a91.3
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780908508; x=1781513308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVm4TdG5n8U+Jqzsg6ytMrzaYYKYP9UWAt7EIHGxQss=;
        b=SXxy9FxVXD/YTdBZzy+v891TFC6Us9XeG7MjuRZrwbu5kmQBPtSGoWBUjuRP4g9lc6
         heZKLdoaX8cjftS1gjBMY+02a5SsLb6bjepdaRQJ9KAnqsvXQWZNTlVg1D9SfAai6wCK
         wNxJ8lTpM111xDWLO4Pi2bjBmo6tLC16W+kxCgn1k7veUfwY6QflfajfJCZSN4c5DPaQ
         kEe/VnQ2c06ovi6bDvvCvYqYacslInkROU+NnyLAT5UAcwPv4gdXyojfhPLyveqAUuCR
         G2M6sJWIIs8qlocuSOykfQAiRq8UNoxliN4oSV7lLn2fXVXQZMGynAzcf1fo3fz+/8Qi
         CjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908508; x=1781513308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wVm4TdG5n8U+Jqzsg6ytMrzaYYKYP9UWAt7EIHGxQss=;
        b=T0V4Ce3P43hCzFVC83KAMz8nz8JpK8+WC4etiSd9b6epRsFgNsrc1UEj/AmeCzoajT
         x1S0qheVGeFsqk3/3dVmS7xGE6W5ZYSqxHXgyu4V76k88t03z9XueZdW5EPeNljWLj74
         qjbC3aFEOTI4MCVo2l09PJjaSvTiWnSUBj0sghVQIUKuORh8BU9zATpF4n+gErAiJ1SM
         r2f4RcEsivofGyiY4Lnz9CnGPcSPhXAsgXV7+C+7X3cIgh/Ant6BDE1eolKbfQsYgPtw
         b9/OX3cp5hyYGwImqaG1SMhCvqqmrerGj5keaFUQvE4wU2E38rbdNqmu91NuONEZAYly
         pr4g==
X-Forwarded-Encrypted: i=1; AFNElJ9NVdudM1mAZS3ayvWOe6BCtYl2qCoHE41AqD8UNQ/KQJDyjZFxEWTQKrsNPTmFCBOSKJYoebZRDyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7Tv9L4LbdRt7GkQa3O5TCxCj7tZBn47fReOhC2thKsWt2SNs
	YnDy7uLNepltDLje4FWRmzNZO4MW9YupGsn2DbeX0x5pWO84aMEf3PQPNVaI9lxuHlO09nEWQK6
	/E9BiO0I5FLXRVjlbizvRARRABGHgrxCYQpwH43z41s/xanuFjznmhrN79RF7mFY=
X-Gm-Gg: Acq92OGOzizRdflm4oAC2sBjlhyR/5MOAXH1JleXT7eXwLldjUGgxIfcV++8w6chLFI
	I5Z26GAxvsjdPKumGMmZaT0lhSWO5ch6w1Y131sZiZ79BqA8k7cIHPhuGmCAcAyt/S4xWnWfW3c
	gOrq+xAt+M7CRwV2PZ4obcrpl/3OhQ+FpVd71ZLqw3rSQP6XLpOX5wR61r37QemzsoTaC0m7TyK
	weKhWoz1SyYH/vprIT1cJA51FnW27Ek19r892Fgh0aRNziPxKoXMT9tWNi31weZ1VxEtm4ZTWLs
	TFGxuAc71coemFnuoR+y/bMnBF0wXvSqA1X+BFz/g6Oq6Jtx+LHYfqCzFXDuxrS7kqy04+aIEQS
	xjRVH4VY5q92joRqlfO7S/KhxFZ5rr03Zjt9ciVgrNetm1eoS7G4UZ2AEc8IZQr6UI5Q=
X-Received: by 2002:a17:90b:5111:b0:36a:aa9:eea0 with SMTP id 98e67ed59e1d1-370ee6437b0mr14861350a91.4.1780908508260;
        Mon, 08 Jun 2026 01:48:28 -0700 (PDT)
X-Received: by 2002:a17:90b:5111:b0:36a:aa9:eea0 with SMTP id 98e67ed59e1d1-370ee6437b0mr14861329a91.4.1780908507777;
        Mon, 08 Jun 2026 01:48:27 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f712de91asm15070198a91.16.2026.06.08.01.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:48:27 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 14:18:13 +0530
Subject: [PATCH v3 1/3] dt-bindings: phy: sc8280xp-qmp-pcie: Document Eliza
 PCIe phy
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-eliza-v3-1-9bdeb7434b28@oss.qualcomm.com>
References: <20260608-eliza-v3-0-9bdeb7434b28@oss.qualcomm.com>
In-Reply-To: <20260608-eliza-v3-0-9bdeb7434b28@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780908496; l=1706;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=xeSQHPitzN8ohDKs18l6esrdselqsjwFIBvIjhevBqI=;
 b=Sjyye9YT1bQn9mJ6+4RYuHC4tZCv5yvYzU6sZBbvTxZEUl7v12HTT5cSIJN4fkklVSTLMO3l5
 PsDZ6EIIgh8DlCs1TsOCS31yAStdP3uvP8PqWbGxiPtn0dFkAOO6eJR
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4MSBTYWx0ZWRfX7kXhXxGDTY9U
 fs1oBsowg3BhynvNrxAdBvDMKvFtw3UFzd0TLgrSUww8fBlcFdfrRZnPAP8jr3OmkhWTRuoOLHo
 ORINjW460P/dUmOZ+JENasqLfNM7WSko3he6QRtn/L/hx+paEVvNb0cvwm4+xGJNRLvcdCIeWz8
 qBslnQwX05HkvKc8bHp/k5iHKIkeSn+54JiB/FH2Xxx/2yjETAOqxnwoYVAzEa41XaISPlm8CGu
 ZzVbnd7ZG3az7QmAT9Cdk8FqVDORyxc1kWxRieAkR7CyhQN7LNvBjqeqyuwYpO5GHAs2aKw1hym
 okxzp62DhCMb1W7/yRinDpev+ASqhc9mdJmkcESpQYbLBij9tSfR/wDtQbBnfv1Dye3R2L4vdLJ
 OoxUdKjr0lyu9EooKkW059p3d+/95k0DhkfNHihV9w5WpuXQ/PB1xtbkQPanxIuv4jo+ASPvXPu
 FtExX7QMYZolqXXItMQ==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a2681dd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=d5_U1CTwwdyySJRbjq4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 7EAER_ufQ3btrENHYXf5aZejaMC5RnPh
X-Proofpoint-GUID: 7EAER_ufQ3btrENHYXf5aZejaMC5RnPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080081

Add compatibles for the Eliza PCIe QMP PHY's, which supports Gen3x1 and
Gen3x2 configurations.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 3a35120a77ec..be4bbc327982 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,8 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,eliza-qmp-gen3x1-pcie-phy
+      - qcom,eliza-qmp-gen3x2-pcie-phy
       - qcom,glymur-qmp-gen4x2-pcie-phy
       - qcom,glymur-qmp-gen5x4-pcie-phy
       - qcom,kaanapali-qmp-gen3x2-pcie-phy
@@ -181,6 +183,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,eliza-qmp-gen3x1-pcie-phy
+              - qcom,eliza-qmp-gen3x2-pcie-phy
               - qcom,glymur-qmp-gen4x2-pcie-phy
               - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,qcs8300-qmp-gen4x2-pcie-phy
@@ -206,6 +210,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,eliza-qmp-gen3x1-pcie-phy
+              - qcom,eliza-qmp-gen3x2-pcie-phy
               - qcom,glymur-qmp-gen4x2-pcie-phy
               - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,kaanapali-qmp-gen3x2-pcie-phy

-- 
2.34.1


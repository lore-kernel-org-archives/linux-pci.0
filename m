Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4E314D13
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335057; cv=none; b=JfZFovYm2Wie0wyO76MoWUN5ik1zXwj6d/kPKT4EaydeoUQ9sukIA8f95JPuFBc0X0bXxVObQPTqJEI7YhCL9JKc9cnUTJzFP7DiWTANm0xIbR7WmujsgfyrMh5iU56DSZjiP+3fd3h91D0uWXW7/xkjvZ+/yIZsP0s+tpqlq0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335057; c=relaxed/simple;
	bh=xeSQHPitzN8ohDKs18l6esrdselqsjwFIBvIjhevBqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSFMiCgvUQdx/3nB8IvWi/dcFYBQ8kt2FARxPI9DZMoMx6ME4d30naaYMU+uBcbtshpQ+D1Q5zAaXj+JsvCC39pDPtPY2lIozJ/FmhMuxgCVfBPbpWuqel1iUZSmGBkUdCdHthI/1oI6s7D/6Ccmu5DF0xu2TrUMeOXtgeYpz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkhQyHZd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FhRZKKgF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkhQyHZd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FhRZKKgF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651F4cPh145078
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 17:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wVm4TdG5n8U+Jqzsg6ytMrzaYYKYP9UWAt7EIHGxQss=; b=CkhQyHZdGEBq93G+
	F+4LsLU7U3kU9GOaCii62iiYuleaUcKScBEsMd2EUdp+zua5G7oRDwJlpYwb8aYx
	R9EToc4ZAPD/eSF7SMEo9N1eDKvavn/Jvitp/gw2W4fXcTUeTKwROq0UcV+8b44U
	aQfK+rt/hNXmzZrfIPpHAgDHVxi6gJbYqcvwbcLG9HyCzM686vR8ROeFTWGolFxQ
	u9CMWAVmhPzlgKuw115/x5CoQKJYiyrOn59iYqJnoo0ynXM5ZY/RmJ78X9iVpcfd
	Ur3DiX9XjIhs5TUnUanyUEKwHtFkeRD29WC6URQ7mMrWU2S3w19xuLKb1s9ULjLk
	mImkXA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6stt5fg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 17:30:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so40943385ad.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780335054; x=1780939854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVm4TdG5n8U+Jqzsg6ytMrzaYYKYP9UWAt7EIHGxQss=;
        b=FhRZKKgFNtgqCgLGDezBbLWRGMrpPwM2hozO5AikxaAriC0H1CynzUo7VaKTdRfzeI
         mIH3Ry1u6bFYiENErG+6QNP5fWTG5i/FJEE8jwP8cdfqgUbwusnN/hOnhQw6uG8jFMbA
         6Ewvhtwr+azd5skp2HWOkAns2Gz+srz/fGwiCPqLF97IBjuhohb475fQkrmagVC3m14f
         gesAwJ47KE90l6cxA/pVqB1Btns/086PTmfg/LEPtPGcZg993GQRFLMCETFoYcjOSd/5
         TVCg/2eGClyFw0xg9vc57S8zCKP1OydktHja+Xl8LxSIGY6H716/f0J97GjTIN4+eSJi
         FNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335054; x=1780939854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wVm4TdG5n8U+Jqzsg6ytMrzaYYKYP9UWAt7EIHGxQss=;
        b=cFVV/Jw5biqOQ87oAs6D+yHt1EaNjNj7Q7pE7Ue0eZC/1EuPQSqYyPh7RyZkky0E/F
         IUR8S4M0jpDsP0SepfnWvaj76SWqwtP8rCKCpaweu1g4qQFc/6vexE1a8d2mkKzC6v4P
         YJgotqmXQAZ6el76lnDaBU/KKBatra+6OXZ0NR7Y1XBCR8oYooYoHFeOfj9DDKapz/8p
         d8yoRNPC+U58T3ICMcD0bD6JGkh62MDHKARNF+cuNDLUZASj8EXcR8w7MxHUUXH8feZ0
         ypw4mypA6mDpqjDrsrepcw5oLWdyOFEVYiI5KomHsYzd1I/qvpZXoR4CRhyjnbilE+M8
         BR1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+W122Ef75BTZ7dfxIomIY8Nr9M4jEk9jd66+hCYYxZu9ST5D5jH3Z+dhHdbvJCcABlITis55yO39g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4SmmCVrx2VN5QLbmLxRxNc2Gw3+y7HewMeZGNt15zRdGg0bm
	u9q1nYhOxmAzj0ZJXsPyZSsVrdV0rMXQksgtt1Kyczk8mxGquG3F6Pk2URAoO36c5e6IRNQzdNm
	uv9E/mKE/AcbHmzlNf+mnOwgINRRs4ouMwFWYsjAPujTczNwq5r93mM9vaARVCi70WQW0vU4=
X-Gm-Gg: Acq92OG+v0ISOaHnR0P6hDe5PJiIISzR5kTy3R5d33o0HSlIk7hwjIgzvwaPCd69Q46
	iAeALXCa3nTFyd8w9jf8q1qmR3wKbQ5BhtzD7v0ECxxZDG2F+79YFZnwjwDxsDPejwRfBQQvVhu
	3gutYceOCrUjbCfe3KxVXhmC7w68/qz6qYf0LbdbXSnSJO+rO/eyikHm3EV2hwabYxT6JVeqHHM
	oVjdP+McJ0xCyX8y+XyH0FxCfyHH1tFmv5Ny7mdi6r3jdu+MfhvKnmgZbthZGwP0FM1P4RxVZ9y
	y3B9NOtp0nfFSfKmTCGqH0hvne0q3jai15Bd2tHaNyPTnjjoJ4kil6CEyTuLLX2GVR4q//xioZs
	MBs6QO7y5t7JrP/XyWYGZXmdITQffUAvoxb6URLjPyP3SJe2ErneK3z61t3RdMK/wRhU=
X-Received: by 2002:a17:903:2f05:b0:2bd:c925:3a16 with SMTP id d9443c01a7336-2bf367b1670mr141503425ad.2.1780335053971;
        Mon, 01 Jun 2026 10:30:53 -0700 (PDT)
X-Received: by 2002:a17:903:2f05:b0:2bd:c925:3a16 with SMTP id d9443c01a7336-2bf367b1670mr141502805ad.2.1780335053501;
        Mon, 01 Jun 2026 10:30:53 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm149136085ad.41.2026.06.01.10.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:30:53 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 22:59:44 +0530
Subject: [PATCH v2 1/3] dt-bindings: phy: sc8280xp-qmp-pcie: Document Eliza
 PCIe phy
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-eliza-v2-1-6b44c9c23d5e@oss.qualcomm.com>
References: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
In-Reply-To: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780335042; l=1706;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=xeSQHPitzN8ohDKs18l6esrdselqsjwFIBvIjhevBqI=;
 b=8TAw6i9HWaMl9TKddGR6bg7RHnpwPvMpNjH6kopEup+runXShivaFDIsfa7BjAa+eov0bpYQ1
 II6sIgMEXd1Bu/kukcd7mvNZ06W518oWDz9OnjtqH2oUbJ9YU6iA2qF
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3MyBTYWx0ZWRfX2CLK/dfW3YSA
 DHreIuzguhI8wxw5wsuC8qnNe2hejL+t8wWpCpfF0XOhCU+vMUxf5XnVpGJ/ZU9YG21r1kUtTeH
 A1HF0ijFaiVCnMkhNTaUSECW+XxfAM/nPGhs984gmNyh4BdglP+mpMkjMKkVHLxtLVbHRzks8Dz
 ZHHuTIarWSKG881sJVmxiIsFL86WPFcQ/CqSpZK9JxVPaCGu35mXoKALZr5uu3UE9YTHjkzRkno
 JAwSf4pb0WRuskjNFAZsjOg7bqpJTMiAiEO3TXSHHHCAz1TSSxTth1CEhHMB1lWHfDrvwpAKfMx
 e3YAnTDzyMtUAxt5uzOgtnljPLbQchVGUxb2fQB62hlh/9TOADhzPf3UzBUneN1EMiVgoobntR5
 CrXFNA7OvUoOYlHk+dbz10a4yN8a5g8jr8iHi00s2dyWNJ7gExT+5+VN54PIbtInVUm39FyRqC9
 NX7Tt+evxbbYStZWVOA==
X-Proofpoint-ORIG-GUID: pgKbZHM9bYVyfDs8F91q_gjo1ctXrDFf
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1dc1ce cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=d5_U1CTwwdyySJRbjq4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: pgKbZHM9bYVyfDs8F91q_gjo1ctXrDFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010173

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


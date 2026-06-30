Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A937F00B
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846226; cv=none; b=uI5F0eJSTcgznQj6sa4gjSQL1RRrWqFFuKtrPVtnhWDRmzZhzrc4lmAu94P8rdWqsYjwqX0drERFL0Atx2JfYG6d48DsjE4tRsCw9vZNzgzcP6IbTS4qwSDIt208fwEB+2irRNjvkaNgLLpU46Vk6qljM2z0gifUO0sx6vk2bpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846226; c=relaxed/simple;
	bh=GecsPtDzBCsWNuDkEsU+ZgpETbYSghfoMtZfgts9qAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSNjNTQUWQJMUuRATwkDJrQGaxMZ9W2mCmPSLGKXul8BrEKh60bIb8ZEE0QQoIgYGasBT1YctY9+DGgtJomvi+f2W8LyVYAPcxCVzkU1Q8HNQnmZGmydVX+Ai6Ml4YU+7bwsG81pauBkTBfHzFll9x1QqGSYw/H5CWgjhmN7EI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RBgb0u9Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ejjPk3uj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBgb0u9Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ejjPk3uj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UHrkrG2747852
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GCgClY81I44AjvbZ/aXoo8VK5dN9dzyBFnWzQ9hfEIY=; b=RBgb0u9Q3NWcNR1q
	fqduvcaEhgXaUT5tc5NwsCbXZfNsGyrursYZiJAapEhPgYQHLOpXuWQctT+WUpPA
	Zwq3c7OzDWnymEQGG3zVku22NqnGl+WTTCfrEIgwFV19uC8lVGz83SgOaYxEGAbc
	jcbVYNEkcoXhyrzroV9GMo4PnbWcBp5PN1aLrPpb2oGZQVEsuqqeoLB5NLD+MFOU
	l+VEzLKU/LeWzSqhHGplugqAh0qe+REfqAFx8LzCDpItFpcoOOII8bVmY6VS0yHt
	3X00bGyKVYey5XqpaEXWv87M9MqOfTiCanjDrkoBKY9mJg2DvXQoQQN3FWwXsqpY
	XjfZQQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jkt8bbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:03:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30cb5001ed8so128340eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782846223; x=1783451023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCgClY81I44AjvbZ/aXoo8VK5dN9dzyBFnWzQ9hfEIY=;
        b=ejjPk3ujYn3nvUVAJhuKcEsxl537YJUzmDbgNKipovenGsFQmWlKfR/Dup+YX287IV
         VYnuUNHpB1O//i8+bYKT0e3MyO6VAKMoOLNo8PNHnUm5xbuWOjRIzBzaaMan/OsT9dzH
         IEPCqET8UTb339YXrgIIqxgjo3YpDe0mTRAXDqFfg4qJnPNV5cNUpx5pQwlt/wtK6Bk+
         VazPV/pFEGM/LivMTkfPsWh4viGRwHOFIMDe3wcR681ZXA3OHYzZ6JFCX37NOj7sHMPB
         3SmxPgBR4NiBGRWUWUrVTjcViNI0TZeofwebwIptxFdSZCUQdUz79WQuAB56QZM4mMKC
         sL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846223; x=1783451023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GCgClY81I44AjvbZ/aXoo8VK5dN9dzyBFnWzQ9hfEIY=;
        b=TVEA3XaQnbgcS48T4Uz14lQQvi4FLAj3cJkiUjeTyibAGSuHpwveI1ZFWQ8qj/sCws
         /nWlHQL41TcqyiQ7DskfV97etxqSvisABfH7C2Nf1L/iYOty2g1eXyrTIh5cpDxm1J9P
         Q9xUoHKWQGWLjIxJW1ff3Be3cU/LfJlbMywUPplsV8N0nt1LInFsYizUeuIZYZLAH4T/
         Dl9lMI1qWRBj2Vf2PSrxUqKs/Qi71W0joZqqxUZXNmcPhrTu/9RYiUJApPXCBS72V+Vq
         C+/JpWOQ0a6UBEYUONUdmnbPMkC4p3qId4I7il8J0/rSCrutjc3UPT54ae0bKqg9HqD8
         pjqw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9/ZQNSwcGsLfWjSxjKPpUDirH46Nf5/roG9NorpNICQED1kojFNr/LkLWwZ9lbiIHaqGSz599R7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUZXgI46mIIx/Yee5s0p29JvbTQuILA4aGcLPECWtMWRJSqpz
	XT5YpOuqnY0rjDnI5CKgcR/PB+eqm55Dpt6ItPmpbn7SUa5rM6BHTY6g9Bab6nXZAr7FGCy2Pl2
	YTyLPpJgEUQ1esE4Xog4UBztY77IAgepBF6NmlgJk5ZsGTCpJW1ktes91r6EEJIA=
X-Gm-Gg: AfdE7ckyerFB48RcHoTW6MO4+sOIWIDohEo4rjbWSJl2eAPWOqpoS26VxEuBPwnrp9Y
	4Ao3STrMGARsWZndITXW4oEZZ0BcvA4vVXzYpyrSJdU5fFrQyx3m1lqiFJdaEYcsCD5UmzYru6x
	fbDtvfLx3Uhx5ntLafHhIvRPRDenUEWua3PWpe6vLgwCT6BJA/MBE+RrHY7iE/qmvUqibeMbUZN
	V8+AlsUtR4IcBJqVtOBJgyIBgpi5eZXIwm0B9ORbCweZ68sZx2CC4pY3yQz6J19UKTN3a14Ct0Q
	i2Y9A/DWbnNNkhTqIQnW9+PMEkP702KBcGrgrVeAklRfg7e+zzufa/u8zbGwg5z4CI4WtLrNuvj
	qUc1sz5cq+ixaBh3md9i9GOSXscJ7XQZjFdMAxvFFs1NpQg4=
X-Received: by 2002:a05:7301:2f8f:b0:30b:dd58:e155 with SMTP id 5a478bee46e88-30ef096e8f5mr1218367eec.20.1782846223161;
        Tue, 30 Jun 2026 12:03:43 -0700 (PDT)
X-Received: by 2002:a05:7301:2f8f:b0:30b:dd58:e155 with SMTP id 5a478bee46e88-30ef096e8f5mr1218329eec.20.1782846222658;
        Tue, 30 Jun 2026 12:03:42 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee317095dsm14963815eec.15.2026.06.30.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:03:42 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 00:32:46 +0530
Subject: [PATCH 4/9] PCI: qcom: Add support for Shikra
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-shikra-upstream-v1-4-e1a721eb8943@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782846191; l=854;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=GecsPtDzBCsWNuDkEsU+ZgpETbYSghfoMtZfgts9qAA=;
 b=P8iXgoZ0ZmeREPgz0BzlNdOW1PX47JuBxAE/yjvDHkAEX3OQpmUXJ5BbOV87TORQ23uz/0UyF
 zwsAIcJQLL2A6aVZRhqot74U2Lymzxtp+S/bx//KLuoZLN+ihrMtvYO
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MiBTYWx0ZWRfX/m43Y007da6N
 5Ndpgy28c3pCWGCnb8QTnraki+2h2dTHP91RfhYgvB8qWkN8JECZffBKux1le8yaQGmeQUInbsD
 pd9CA+sEzebOOuQAlvZE8GODD4gKhbw=
X-Proofpoint-GUID: DZl5Jn3fQ-WejLW1Sc7YFNXBaqhu1iUJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MiBTYWx0ZWRfX809QO3iM4+iE
 yYipl0I+vgxsQuB/RtM0X1mNtaVrclv6qroEwukyW2SUcEFX/u0OkdQ9s1p0uh6a50qbsF/ornx
 bgTJaBg2OWmYCGJf+50OhiEg+678MVwNqHLIUrC2PmcB7SLMc88vwJHJIc8eiPzrSpFr1EWvRQX
 0Mh7nQ2i2HuTUKPxapgjAP6+eXBB0kuOArf5jBsesRa4BN4BVqJLtufkVcqbpRdiszWK2r2E0mk
 22RuRNGs0pXo6gtXPe/MzEc8qGMgoa1tLVfhvU61cMTDpVOp17cFzgthJNnSxFyBa3bQ16rqrTJ
 3grbsqSt/JhI2x/xFQDjBzsN5V10NqCOV+/VPqDK9tC/rGRd8MC8TjAftvsdET7QabBSdwebohc
 iYeTkAtVumpJEi91sbXivYkEPlWYvnHguwecw3k1xyvX6nGIZbjktSswaMGY8RbEsSVN9NRrQgi
 fuEUOppXPmOwAzTBsTA==
X-Authority-Analysis: v=2.4 cv=R+wz39RX c=1 sm=1 tr=0 ts=6a441310 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=sKgv3_SsqRtbfYgyWx4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: DZl5Jn3fQ-WejLW1Sc7YFNXBaqhu1iUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300182

Add support for the single PCIe controller on Shikra platform
which is capable of Gen2x1 operation.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..19daadee65f7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2309,6 +2309,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
+	{ .compatible = "qcom,shikra-pcie", .data = &cfg_1_9_0 },
 	{ }
 };
 

-- 
2.43.0


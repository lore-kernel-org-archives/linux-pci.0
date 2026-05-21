Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5737C103
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372356; cv=none; b=HQUsQZ7tTVWs43SZNLY+fzDXOA3nKZQGLvkRlCNNaQC1UhgqG1Nq7xEwMlx9Yb3eFRXK1XK3dh0kv7gvmr1wRR+v+6iaV7kNxOLIDulAo1VJQ4+Gd1pLaM3L+w+tVC3jSkpYpX1JfBuuopa1AtL98SNzf7um/5uLWvBKbOeiFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372356; c=relaxed/simple;
	bh=sRGh7S6MyKVrh0BInxsk81hA/AV0Bj4E4laY11Hu75c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MJZ1I6x7c9VbAMg6JW5IvVvDg4R52EbeGc0JLeHhuJ46aJu23mTITbaeY+N9DLchMf4QklgH+/QSfBCjwm4BEOLruiRgLmcG6JpQ+590L1hcRZ1vcK7vhfU/74uLsJFzjN3ulZXxXWem8Wue730mPceqa22/OFfBsmiCmuEphDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LDh0IMi4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pxl9Wc6u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LDh0IMi4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pxl9Wc6u"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9AMht3556019
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iCoeHjjloUdX9dKsGMDAd4b+0Fil4rvCP2G2OTCb8a8=; b=LDh0IMi4lk7LWaSo
	/weudAX4lJnOKHPz/8o0qR3qlioo6g4MJN7xrNQMo2lTs0RoZrlSHF+9vaQYA9Ko
	oauuPHl1WqIqKzghurBLZAMtcPis8wzXsf6rZfS6MvkSjwBYSRqbXiJcUuRU+t5p
	+QTkvNQ5IQ3EXntbPVkJiwe5G9fDIj+j1TyUo3rwan24Je0cYiuYe7emJ9dnv3YU
	/IRwqVWLEmuM4QVYUPOeu6Tv2aYU837len/zn6ZigrONb3RldLVoBxx82PyCUHn/
	5FeRhOL3JcSdQSvOVS5ZgsZ20VQ9H2bvgWsBQPWfR009FB9qXZ+nX+mUCJ6GsxHX
	VUVX6w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6mvtn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:05:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b7aba0af02so58462705ad.2
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779372354; x=1779977154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCoeHjjloUdX9dKsGMDAd4b+0Fil4rvCP2G2OTCb8a8=;
        b=Pxl9Wc6uG6cEomxmU/DJnZDCSfpSym83xcR4byOwt/f2BxiEMd0Xe9P/UrpBoDEsPR
         m87Ruh95yQ0edDriu0RnwG4jA5QTl+nD77rrhUlitBDZld3tjzg80L0ZsCt+XVok5OO4
         tOwuGLvhhJWY8yQ1hEYhSpx9kPF2TfAo1H/tkaBMLa59RE+doHwo7/N9mjWyTp9J4Bc6
         4m1DSEWAwefRU2kuIIbAVGGUJ3QlkBntNU7JrBaalleM2jyhZaRHFERmDFF2OjmllOjU
         +J6fLvVoJps6od5kPaiNN1uAwYVMygYPbPPG5a9kLxJUsMS5KG7xSK3DFK1nWXVWkkIw
         p/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372354; x=1779977154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iCoeHjjloUdX9dKsGMDAd4b+0Fil4rvCP2G2OTCb8a8=;
        b=FznP4WJwAQsmTP4YpfIWhtiXdd3loj76OHBtV5otLhQrUtWuujINdASWWRouUj7FUa
         NYBlHJn3DhWOrKxP8hR/jNof5oKWSRCx3TSEpphLpSFqukN2l+yBarCnx0OBWPJLMAva
         nMAHJQfwJybmKLTTo2yZYx6MsQIGShFF/MIQgdCIkm1SXqeFCYiOUVWbJ/GUyjzYrhaJ
         /wCS7v3fKbOcWJCudHONhSdEGAnixyD1zJbT4cDy2aC85cExFbDwO4imkt0Uj8Bf/JO+
         ESt4uc9L/4ECXY3xDEgW759lfKUzTzZpQzR00bOB96ZtyOwOxXPsFTS8FlQwfrD2/yCw
         H96g==
X-Forwarded-Encrypted: i=1; AFNElJ8NWawViyxxrjxV9jI4uaWZamza8Q0RvWuHPCIy4Qo1E/8qySa2Hn6sek3b3Gz5WwKLymVpQ+M4lmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBNsWZ7MZTCXTGTnTT7JYO7ZKLDIU+66hXQ54l3yAIGb+w7E6
	midWNUwhmbtFCIXqDAAXvqScN1NC/a4ybmLmu3zpa4cOcJ1TN1gVJdQ9yCdfPeJ8LRCWw2LNjIM
	jFlnkSgeIwRPb9sHMwtHN/afi+Z8LA5gZElZdY705U/Ht7s/8lkSMCbhON1hvqYU=
X-Gm-Gg: Acq92OH/0SO9WQ3Z3aBEUi6JqKnue3jIfSvM4mVcYzHkcI2NM3/3tPqx7x9xa6p1gny
	Tg7yZHW+kzJZjUl9ngiU+WJ4QUtQOR2V04s0HJsiRS/FCZA494TsJGCls2HUs49WTLVfq5gN9tA
	Qgthe7h/vNBlDSPaqNJNKlJbfclPLF7Q8mWBalR0oi0gTLyVw9rsc9zV8yf10jmt/pkKZ8XvyDo
	TmG8oH+fohjgf7zo4+oNkOYpBX9RNGEB+yLpiOYPBvJM6mzO9yBihJSrFDdK80kP0iI5FTq5Z1W
	D1L1TTKa3/0RqdmpUZ7jFvXPEPRYT/aLKxNxbb9APFQlpWmlN7QjIPZFp7hMdRsbGLAAREnrkPL
	37IUjWpE/gAR8T8NB2dXJID8SANE7Bt95aMCgT7DiKHkpo0KQKGMvt0Ui
X-Received: by 2002:a17:902:c94f:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2bea2fd00b5mr31297415ad.1.1779372353197;
        Thu, 21 May 2026 07:05:53 -0700 (PDT)
X-Received: by 2002:a17:902:c94f:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2bea2fd00b5mr31296625ad.1.1779372352669;
        Thu, 21 May 2026 07:05:52 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9287997sm13189765ad.24.2026.05.21.07.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:05:52 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 21 May 2026 19:35:31 +0530
Subject: [PATCH 3/4] PCI: qcom: Add Support for Eliza
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-eliza-v1-3-97cdbe88389d@oss.qualcomm.com>
References: <20260521-eliza-v1-0-97cdbe88389d@oss.qualcomm.com>
In-Reply-To: <20260521-eliza-v1-0-97cdbe88389d@oss.qualcomm.com>
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779372332; l=1041;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=sRGh7S6MyKVrh0BInxsk81hA/AV0Bj4E4laY11Hu75c=;
 b=oOQiaTe3ZLkTlXdBjVUDD7f9dAV3Tv1of9VZx8/bw9AkHjzEgDPHhutpwKZncdvD99BH+M7QO
 7rLOozMHs9ODH50YlvOuz0y+k6tF4w1cwb0nlnacdWf9kTJsLW5QfMR
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0f1142 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: bEcvaJO_5NERp9eLBsNiNIJiBHrBEtJj
X-Proofpoint-GUID: bEcvaJO_5NERp9eLBsNiNIJiBHrBEtJj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MSBTYWx0ZWRfXzebufQjmezmg
 1Qyz6uWPqAZoz5Y8GcxzAMKfFqVUCkpDPLI4DqQ13r1ls/1VH0KrshVP1YZMhcku+RndOvdT+t3
 wgkwQJUKu9AMEZaUmFt5DBSQZ4filkk5lUOOKcazZUI/Te/NZwrUKQrgRlg+9cudOmBV1Cdgh0f
 a6Jtn6ek4OVtzdv3fOrUs/wl4saxAmqANC5qGi5xH1ctBbriSQF5wtCUtOPnGe3GU/YjMWflzD4
 slEptNL1iMX4g8uuKP4EfegOky8YSDvawm8s/GMayo+xG0duVa8szgyg09viFXL9dy3m8wChW1r
 pmS++FqiwABRmIWd7eoWfI6XWoi9VMuk/h6Qqg1JvfmdQ9GGdSGmolU6aGPlPCKr9wKC1kJHF0D
 6CWxEdL5nqJNUNtpUEQkrIQfaiQGz2MEO2vAwvE1C4z5YpyK5x+bbAi2z+1FXLENZZkmu2NCbEw
 uUUjTNr+275hqiWHG5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210141

Add support for Eliza soc, which has two PCIe controllers capable
of 8GT/s X1 and 8GT/s X2, using the cfg_1_9_0 configuration.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index af6bf5cce65b..40f0a5f247eb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2123,6 +2123,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
+	{ .compatible = "qcom,pcie-eliza", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-ipq5018", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },

-- 
2.34.1


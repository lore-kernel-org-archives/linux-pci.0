Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C464262FC0
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602973; cv=none; b=sOVnUc3dQQtLwDgjvbEIERk+BC6WWW+JDupxio44YVTEB4umuj9HKbclAYvYYHnH2IKwEw7istoM0ajwg+JgExEpnULgMr5+nNQyD7f3G/JoJXaHcu3LGnxF8WLnb5ihPNuPwXdlefJoSxeACPgWBPfLds1QQl/hvQnFmrxdxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602973; c=relaxed/simple;
	bh=4JMdE9NJQVFXpuxNLlszdXNC+CgVssf4XKGlXAmp3zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dFPgcNPpZfolF+3PKQ8qzt2AvykkxglcGBoYt6HiiHpn0E15lHDvfWqN1mCr/Z1yOOt/ZGUEoyyMzUi0zk9rrB3cLebrFHo76CNypWL7Kex9mVxzxvuJOYh8cuMOTvqIWGzJx+AOTv5ZCUmPfz3Y5T9gzXsB3mXo3tj/YcYpwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pgszGs9V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JqKaNgmy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pgszGs9V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JqKaNgmy"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SBdxwA1750532
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 12:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/o5W0AU+AT5/7iehDdb36k
	TbaGoQ5vrsHDFBVhX5e7g=; b=pgszGs9Vzxsa66dMmFUb1fv2phHV56HYtNAg2y
	ZZ/u/vEWMZpM3UTFAhLrKRB17y7mudFJ4e2B/rQI2J7ScUpvMBrZb9m7kLkR+mgc
	CS04+U8l0/iyr7AHPyRCJ33nEpUgQU6M0tEaCji9K7mM1lOzSSi34cXnhmUgcOIS
	FFD+ndBgfIC916sfheDmAttLFMl+frZXvN2RV5evK1HRvI9dDRad9tvpZ45EitkA
	gDw0lNtXozS5JGoS8bhhOKMOL5qvIuz/2aLsxm9RAecOWJTK+jXBVjmzBeD9SzbZ
	Csgo3pZBk0A+fK3lA9dAfAkNDEcfdCRz3mx/bypTIskrL6rg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byhsj84s6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 12:22:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0a0bad5dfso122118725ad.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 04:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769602971; x=1770207771; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/o5W0AU+AT5/7iehDdb36kTbaGoQ5vrsHDFBVhX5e7g=;
        b=JqKaNgmy/jwWPh/BwzqFDV1+bmCIOqcqQJkAFDNH9i9NRAkU+b7resvAaUgxjpZW+2
         4sb+aWTI2JhKKrXbESstmNF/Dpb8ss5Nfy+FjVr2X9CObjezdaNYqpMqiash4avi8Hww
         QQlI4IBkup4oKmeVL0XNdvTWma7s5GayfBe5OV+sp1zld2UYwZPqXkRaMzTzGgbgLCxz
         87QSqOHo7qz66kWGih1kmxvsdWpkn7TuKFyeCRfVbCq95nFniTqmsG6GCH+4l5ym9XnK
         b6q1UnaQQpvlbBMdqWgnJBcTOzCxNAKnxyus81Eze83PU34yX8CflX3g2S+yR/wiI/G9
         QeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769602971; x=1770207771;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o5W0AU+AT5/7iehDdb36kTbaGoQ5vrsHDFBVhX5e7g=;
        b=WxmCGodJFu+YVX1n598gyr5rR3A2unGP3d3HgfjKg+1lBPJ7V5EAQW8cUkwil3c+zV
         Maakzjq9y0WJoxnQdCYa7k09WEEUUciMBPB+X3P5iX6yR8RPLgTrkdH81n1C4dUC7ab7
         S9bPXgRXexvBfIXrUSzndOqccvZv7dfz3IgMP6Y7w9XAVCcUQ4m+U+ri/LHgjY4aU+ff
         uH4MMz5vXX9MGbI+iRZxB7nUj+zGPboPHVAVOyNlBAezWg5XY7e5sGYKlgx4W22HCWnV
         wbX18QturYjwwwPDF6/v/tZdMVb9nTnvksR8owqoHsonCzMIFOgB3T+qVwz4yrGieZZb
         pMNw==
X-Forwarded-Encrypted: i=1; AJvYcCUsrTQVo9CkEvT5Yb1X4Yl6bG97bvytDGM1Gjxn2cM0IGLthmv8X0hwWcOyi1+ehM4X3hZIF8CVjJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2t8/SvEjLnpqKRLATnyl+OC5kcCybUNesbdZYEQuo5hflMMHW
	1RkRroDcZqIhqpJ6bL7ec9WVwSm5YiXInhJ8vsFWsdzQp/UhCyFO1MlYlVs4c/kO2KSdNERO5AA
	MCrsnhuaK4Kv/LsGhKS9eXsjDRg8EGrlxrFGCMEt8sHStFbeF0fOF4fYKuAM/iLg=
X-Gm-Gg: AZuq6aKK4RkQuwQNnFURuoITxlVURbxkd5cJK28DGrNa8eneaCR4SSD4LkrNK31tjWD
	LNnr3ghGH5iq4u+zN3RS8H7TvoDXBxZqMz0INUt/6VuveEsk7qD+Q/u4Jf6+vMNp6WAhhuVGsem
	cXfbTxAN44cENhr8nW55ciiXr/prFrfcpBhU2UNTiehbTV1daAyuC3Xdu/tl4oSmbR45gKIsb83
	GlvKlJjqHpHOGzFeU7QP7gSAAoFZXzGwKdd3mdKVMr8Zb3ypUx2Uq1FV7gEpX8LsuTdgi1lwMs6
	K+u9XVZ+TNJbqwJ9FeyB8iT+K9y42Kj85h7+6e4vZiuxEzuM721qr6dSTYZptnnsVekbUR26Odp
	J8npoGFKAr/HBDdKUo0SRr3oihAMTucIsqfEAQ8mubbeD
X-Received: by 2002:a17:902:da8b:b0:2a7:d7dd:8812 with SMTP id d9443c01a7336-2a870dbe96dmr50894195ad.38.1769602970950;
        Wed, 28 Jan 2026 04:22:50 -0800 (PST)
X-Received: by 2002:a17:902:da8b:b0:2a7:d7dd:8812 with SMTP id d9443c01a7336-2a870dbe96dmr50893915ad.38.1769602970368;
        Wed, 28 Jan 2026 04:22:50 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm23358975ad.93.2026.01.28.04.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:22:49 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 17:52:42 +0530
Subject: [PATCH] PCI: qcom: Prevent GDSC power down on suspend
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-genpd_fix-v1-1-cd45a249d12f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJH/eWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyML3fTUvIKU+LTMCl3jxEQTQ+MUy0RjC2MloPqColSgMNis6NjaWgB
 e7N5fWwAAAA==
X-Change-ID: 20260128-genpd_fix-3aa413d9a383
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769602966; l=1865;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=4JMdE9NJQVFXpuxNLlszdXNC+CgVssf4XKGlXAmp3zo=;
 b=iT65jbwLJOP5XGBDzhM2tkLuvQr9kJYCj+Jh9tQqitACgbFyv9ZReugFb2tePaYavuGxnDtqQ
 /SwDtuigjTOAqN2RvKZqeyG+Pr4CObKjntChHdFG2E5KQ3XjJ7lRkBn
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: QPDBX-PDEe_rSmcx7OlDZGzP7dxNlJzW
X-Authority-Analysis: v=2.4 cv=GbMaXAXL c=1 sm=1 tr=0 ts=6979ff9b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: QPDBX-PDEe_rSmcx7OlDZGzP7dxNlJzW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEwMiBTYWx0ZWRfX6VisC+9QFlv4
 TKorttnNqLMJxBM2E2Mf2xDAAoFiIOHAoDzGvRXkUDqn7sBc5SagdalkBEZGoWRGAwG5qH4/cbQ
 t7mVUpvB+SiW23Fn+Lef7NJIXdDJVl/UwUT/9xBN6hasdA4K930wvdxMDlr04ZT7e2p+d/Swrip
 D9ZkwyXRbDpDL7ObSe+M8zN0xJm1cb711PzIn63475lnGjXo6xZblEz7ScWllHSmli17kGARE95
 af5pzT73h6GBofO9jFMhW3Ab9O+cgL9ncY8Ktatsxk2IqmDZgBYEj42Gs/LvdH+aV497s5lOKsy
 LJel5QW8a1KPAapxeQDvws9UBNHmUqGRf1IGJkwvq7WCawYwvvM4Tq/tjbn5OO6s8P3p5LimAZg
 qkNZO//BXiH93Y3wbkl7EtBpK9hdtM3Il1M09tJVCVLPTE1hoGhbICv1TfwKPkTtnOlWT1WbWKN
 nFtCUqrCjy4qOTFeAYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280102

Currently, the driver expects the devices to remain in D0 across system
suspend, but the genpd framework may still power down the associated
GDSC during suspend. When that happens, the PCIe link goes down and
cannot be recovered on resume.

Prevent genpd from turning off the PCIe GDSC by using
dev_pm_genpd_rpm_always_on() so that the power domain stays on while
the controller is suspended. This preserves the link state across
suspend/resume and avoids unrecoverable link failures.

Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5a318487b2b3f6c61d8f5b1fd5cdf2738a1f1dcd..314cf334a313dff35efaf0c023597e6eef483925 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/phy/pcie.h>
@@ -2052,6 +2053,11 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		pcie->suspended = true;
 	}
 
+	if (pcie->suspended)
+		dev_pm_genpd_rpm_always_on(dev, false);
+	else
+		dev_pm_genpd_rpm_always_on(dev, true);
+
 	/*
 	 * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
 	 * Because on some platforms, DBI access can happen very late during the

---
base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
change-id: 20260128-genpd_fix-3aa413d9a383

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


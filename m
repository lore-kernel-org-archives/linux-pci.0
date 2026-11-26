Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719644;
	b=Vpo7yIk9OTHjPArQvpUdu4YUauYw3FGZYYLy4ILJTbvD59KJdfOHqS/yGTnB/XiyGXiX
	 PIpduYM5yC5MR4uifZ4n+pZzh/2WV1kQ39gfHau7cOdD3736PQOc8DfdCTLmZEu/013+x
	 4qHgaOJqmbMuJbWW1yf5Bli8ZbbLXlFxaWmGtRlHbzZOFA8kwFPmeWkd8lwd0tM9DZ2sq
	 SPhUINGNLc9I0TGhyrgAfcebBXGeMnVeTeOYhluAGT7XikKXCRXKhfMoo/ujPWMGwzb4C
	 E3rAwkJjF4uuxcKu9EeXcJv8hVOH+H+5zuryKOe3qZ7dNkPkbFv5WyK0oO82IZmL7gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719644;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ql1s6Wqvff45G+O9tfHzNyc2plPbkIqdZSJOZHvJEO8=;
	b=B3BKLByxnhkODdifSS2D1ubTebbGYcxWTGq9+ZN0ozMKUO8L9cXjCtio4Aye+au379Ap
	 38UoBHs7/UpogVjt3RmZOhqFbgUGgVSehUNk8WCHDhmjR9NJzcSDfgV0IwIVflCqbYEof
	 bpnvk2mmdl9P1iCiIHlWvEUO2sTIoTdD6iBgtO8AJaJBClZ9NfpLkgz3LYBPgUZsU/dPZ
	 W7lCEe3wESb3xgeXdxxyrDCVG0QJBIYLcFyTTE0bD/9XWItjsCdjx0QQx0ZDIst7ypu0H
	 I/pIIUVByyfJa9J4pcQM4baboALExdoowyTLImMK0yRib4QWicSOwXBRWL+9F5+k9DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KckpE27P;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K+obZYRx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B8606A680
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A0B8606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KckpE27P;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K+obZYRx
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFu1SU1847744
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ql1s6Wqvff45G+O9tfHzNyc2plPbkIqdZSJOZHvJEO8=; b=KckpE27Pnc7JARjp
	MzLs6mLmrBzDyxPH+8dr0RK9QQrlA5YHJ4hihocS4UJbIu36aKKeYt8A6OTwSQdC
	3KyxHR7ds9lYXsZFHBi/OYlf2lrFtkRT9VXywuQHjxV0bFd6J1xvpF7hJhB3Pz4Z
	ucygLQrTkRlN03NBrKunYg+1PRvwVOAtxEtyY3bLhtThVcWOZoGWqVC3Je+0y3YJ
	RdtrwOkiqgwG2Zv96p8a3E6uyuLW/qqiDAudAcTXX2qT92Wwq6FnBuZ9+CdDjSPu
	CPtxnrembLe2oCmgkn2iz0YACPJqp7PhDlQYN3Y+2wL3seP70law+vgCg2UW7Ja4
	HkFS2w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6fw7tgr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:39 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b56c696405so10474669c88.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 11:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795719639; x=1796324439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ql1s6Wqvff45G+O9tfHzNyc2plPbkIqdZSJOZHvJEO8=;
        b=K+obZYRxwYumv6ZiG+MSWMmB08Z0yH+xcgtgjqpZ+XKG8/IZTGJ1qJZN/VXfVXAzwb
         NKJpQ9Q/L+40R4zWuoAcH7/pBLH4//qyXGJqLLWdtEY0zMu1BGATX1TJedKq3k7CR7yY
         6h0zcn6vKtadxxTh1tybGvYHVmesaat1kwXSMv79SeWY/gY0ipnh20LhKJDeT2K+rSjx
         zqrpbyWwoC2vUD5EGv4kaLiFNeGE4Zb7xUQfJhW5RHf5ZU8F1pR3F9K+p+1sawhWS1ea
         w2gWwWGPg4kDZUcAIbHLghoS2fGtcHZwnUAu36yzbbwMWjXjLSHnQPutBfmniQha1fRT
         skag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719639; x=1796324439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ql1s6Wqvff45G+O9tfHzNyc2plPbkIqdZSJOZHvJEO8=;
        b=XL404eMhZU/HDaF9YgUgnDfnh+o7LZKpriQHv+Ml0pV/VprHCtC1NHdjvYlqqNWWDI
         BE/BdTyrIOcrJc3mWVA3f8fE5e7CZAewnFnJqAVl1gEsdXrAWQwcAhvTwK6sqZb/9l5n
         sOsjuTV+PengGJUecma+k/kwVXXT2mMRltDXjwwGz6hMExSPyOCm7jKlLIoK6EXF58Z+
         MBL/ni4WKVKUyUdOgd7gPUe5c95xeVqYzoqT18ZW/IqYJBXs8yMsY/vj7wpr+YpfgjPr
         xhT57yN2XHQ/hQ0Rz1C6RZJbLqXQi2Y5Ufbi5jnEjH/rf9RaNB0ULzxCR7ZlIwgGCPPc
         yt5A==
X-Forwarded-Encrypted: i=1; AL+hErGNQeMrhE9v5z7jkR7cwIiXt++ZdvPPJERrcP8iVbJ57Uid2XCWmqLaKb7N/Bb95V5pFy63HALmvmE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WB09vbx9Va8JRrgdr6H9HIDJC8QqptqSZlz2AJRLmrgiKVLI3
	XKq64Dn1KjRPGCVkEfzRt95YgidS1QFO8D/L8pssG7cDMJwj8Enun2AzK7k3Z7weR7H77BUN1Ue
	Zjq1PRWXskfter1U/FOITJF1O8h0StHMNG1a+gXKmH3O+jx4x0Bhsw2sFTgzKu9k=
X-Gm-Gg: AZFdTZeN0sslJdNTk7bFjn7LbasHhHuH4uyCNHeQasCaguxuJRZBtuHja7WS4FTyBas
	Ak95REDuNTscYj7m41W2EXQQ1RMzbn5HtO57gXW7T9LMyBCuKcGY0CY3OgqJjvOIirF1086IGr8
	/bhjByC2Fbmcc1h+raCz+7uIbE/N7rkUwigSF54QBBQSHuZkIDW6d8XbCv9ipVPTK+tFv6r7vRd
	ykvZTWvF6hMRoauMQFifWq+wnFb/vtz0Swow1cYDncSkX606TRqMrE1Wm/A/JTSZY+VIaFr0s2F
	mhRaOE1iOo5O7T5I8TpZmBmF5vL4nqEfqNAGcljUBP6UnKcZg1aQZE7cVK5d1eEM43gMbrO8FWA
	tBtrVD/7pkAVXJ5d933tbY6+9UTT+VoBxdhEc3KkhOkNiYJhdVtA0hpFxqctFPTlibSySvazhZW
	hdGBp1
X-Received: by 2002:a05:701b:4308:b0:15a:9834:73f2 with SMTP id a92af1059eb24-1b55692031cmr22317839c88.38.1795719638654;
        Thu, 26 Nov 2026 11:00:38 -0800 (PST)
X-Received: by 2002:a05:701b:4308:b0:15a:9834:73f2 with SMTP id a92af1059eb24-1b55692031cmr22317792c88.38.1795719638043;
        Thu, 26 Nov 2026 11:00:38 -0800 (PST)
Received: from hu-jkona-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm60868190c88.7.2026.11.26.11.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 11:00:37 -0800 (PST)
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:27:16 +0530
Subject: [PATCH 8/8] PCI: qcom: Keep GDSC enabled during non-D3cold suspend
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-usb-pcie-gdsc-suspend-v1-8-485a08ffdc6f@oss.qualcomm.com>
References: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
In-Reply-To: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfXz5qOG/aOEtHx
 AeBUAzOgxKWjZrBrXez9RkxhyGySbTE6cxB0RaiWfcOHY48t63WwJiCjIWbnb/B7l+vh7v+8yVa
 GDJgH/j8aN8BcMN+9mZyy8Nr+vidpzg=
X-Proofpoint-GUID: GxyfQRy6pRGsnphxOKiNVfxrJ4P1R1eD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX28lwTqNI/Q2R
 eTG12I1hdCj26BIluvcqcFCdoNuBaHHav71eyo+7JtriYSWnm1ilOFpphD31qAyo8h2cE9z1f6T
 IZ1dFatcWmSTUJmVLGyh6nyzxl5RUPt8O+9OglScAWSlbsX+6o6ccX+zj1Rrq/Q4iepIZpWocPm
 VcYYLCdHI1V4tsQLsxearNpFTtDja5b7MOLHrATyP+JQ9gaFn1/kiQIQ9tGP5uu2Fn6q3eNDNSk
 bFBpk+aG1TCS7i6M+hthpYFVY6vnnYPUb7SEpRzyD2Ti4bYd8XJTnddXjWwFgpgwAXPUVL38LPg
 BlylFSPHCv5ajC5zMZFYJCSezFCSO+GExhDRMPShypDF5m0jhvzN/7H7oQ0jC95LJkSIEgiLl92
 j3fv4leuruTxydPMDTclagdDX1K3ZkNQtu8hRh3+KlEe+HVZESxJwsC6onSuMhiVMcV9QavM2X5
 9uh99Dvat3Fm0N8VVsA==
X-Proofpoint-ORIG-GUID: GxyfQRy6pRGsnphxOKiNVfxrJ4P1R1eD
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6b0881d7 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=qWrkvF7FP1bAQ4F7tlgA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260074

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

The PCIe controller powers down the link during D3cold suspend but the
GDSC is required to be kept ON for non-D3 cold usecases.

Set the GDSC hwmode to true for non-D3cold suspend paths to keep the
GDSC ON during suspend since the link remains operational and the
controller resources are still required and set it to false for the D3cold
link shutdown sequence to disable the GDSC.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index eba1b2cb30f0a22b22a40aaf2ec75cafc12b054b..a4cbd7dc896e5472dd2cfda3846c6ff38cf34ef3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/pci-pwrctrl.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
@@ -2495,7 +2496,12 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 
 		if (pcie->use_pm_opp)
 			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
+
+		dev_pm_genpd_set_hwmode(dev, false);
 	} else {
+		/* Keep the GDSC ON in non-D3 cold usecase. */
+		dev_pm_genpd_set_hwmode(dev, true);
+
 		/*
 		 * Set minimum bandwidth required to keep data path
 		 * functional during suspend.

-- 
2.56.0


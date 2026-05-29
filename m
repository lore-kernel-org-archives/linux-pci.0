Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A183537C7
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017039; cv=none; b=AaEuom21iykXBXa1RzOrsYgi8OTzDbTOBB8EIxnBllEncQfY9lbbbFlgiR6e9QMXNfWFD4F04LuGDUWxO5Mh/K/oJ1GGpbjQaMuF3qS1ROtCcxd45bBj4lDjA4lIikZlsLABKk5pRztE5ySXe3JNGmSruJoQrAx+JpnTT9rhY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017039; c=relaxed/simple;
	bh=SqRYyWGxDpggIYoY312hZiHBKDzS7/Y1bj/4uMnD8EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTbha/yIl12MMse7V94HWQs6+xlzhfmKTNiTbRLz239OP0qjw3zG9d3p6zURU+9qTzfGMklBmrWTaJOG0AKS3+mAXD1Rjeu4YtCLLy9a37YtmReGroSeyiwMCx+pnZhp2o8kaH/IHEW0EQNrct6K5CrhaVURnaEyWpoqywRxKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2U6yIqs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KUk8rV8q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2U6yIqs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KUk8rV8q"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SKl3vK148990
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 01:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3m15oxw937hnCUF7HC9R6PrqWp2ss+eoVplrm1OGcVw=; b=k2U6yIqsbXGzlfv9
	Jkz8GPwIROxGvmYMXqyCLYLTfEzhcT2hfU62gKWG9yu3gPwFgIBn3CEH+1Wl1Z+M
	+51S11FRPKOH9Jt7ieKGFHwLXqoNgq3yQqFqUYE/kygOZ0nedyyQmhObq1lEZFtV
	XU+N+fc6OebMrbwH7NwhIcXGRmlXaqIELHPIUs3YP/1ztsnFEWTofXcAWWVXKqlV
	++h3ZY6O6dy3qa0t0h/7w3ac+sMrGllcleNwUiVpaIfSU8Dj+7ytJWq+IASKELMv
	nBgJMWZikQ0wrBvT9njDdFnAiSgOWkc67SR0PLN2FAOruVl9PBzmS1WIWDYRI0Dj
	wLlcgg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y1wrcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 01:10:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304e7fbfaf5so1707513eec.1
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 18:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780017036; x=1780621836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3m15oxw937hnCUF7HC9R6PrqWp2ss+eoVplrm1OGcVw=;
        b=KUk8rV8qsejG9eczKExSh4KZ0MZqZSFi3grNHx6m+yqxZhw+T6C6/8BwEy5shQx3iS
         04E24UMeiWVvCdLkNLMhMuxvbXyNRZnP0GmIprt4Zt1xy5RkfjzvXC2czhU7rPSqdAkV
         +gtu7+RvYQJz8O+YQ4UrZUs3w77Ee+0b2zB06+NCMHkW+N4YRA4vcgVCjaf3uDlx9GVu
         E8cxVMmmdukEfZfxkHlEWCsXZa8fOLHEyIm6AKNHvJI7u6+SOVrE6fDqWQPRMIkObFmN
         4AKg/YgZUaiSZw52P5yWPvTjInw5t6VL5f+BBHQcIBK4qvsyp2lFztN9QSj70MBcnz+7
         uF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780017036; x=1780621836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3m15oxw937hnCUF7HC9R6PrqWp2ss+eoVplrm1OGcVw=;
        b=GfYOfTqBPoJn58H4pHn2ADpAXe9RA0E0uOXmINYYT1/XHuoexOYcQhIEwPOOvZ8mym
         TSAXtrQTKodEIIntMgieZMh5o1Jp6NV883N5heDztqCJoJpcHN/USuwJD2CR6KZ2HHUp
         t7blExSCnltvZvPujV5Ita53dhWEm+FD+t8uQQKRW4gTqiBrMscDrsVwTU6lxQfRPfaC
         ErUQ58EdLzLRisdYzkubxR0vGgjkLOjk00d5uGr75oB7M5jgxDiSZAAiO2dWCTGl6cvb
         C3/ytFzNtzukhE9jg+/cHUrtoG2WBPX3PpdaqjFCcAJNq5w0dxJxdZG9mHu1sBHyV3Ah
         I+Yw==
X-Forwarded-Encrypted: i=1; AFNElJ/2S82UgFtob+gxKCwDgAIgWWfzmf0rRjokxiqSUKmUFCz3IJXYBUudp4H3j5erKd70dUqVYXBsn/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJoxiPB/R5R0N63jxY40bUfnXdLoYz7VXWf6nFrseOfeLQiA6
	zHGdUP1A6yG43ajAO3IoiU8UUyf7kUUKXpcHMSm6dIfg1x4ST0Snf7fZgWXzMhup0nc7PS5GqEH
	RksqBrEJqzntZVkClLPi3XBaoIsei4Eki5XOr3Q4iNYtd+Qlqd+eYojjc7jefoUQYBdYREAw=
X-Gm-Gg: Acq92OEDhiU/u7J0n8Df4fIz0OQMOuk0FZQ0njKXePiRonEDbzP6sqQyOHkPT4IMYxg
	iURAPIry+M3VQRV1kSN7cjmXglAsqrpJ3J8Qwrh44YsDE9mjgy8R6dcnZaXUl2iBUg4ssw7tpTZ
	cy6R0jGPzi2zlimXDSGrdLx7i2uVZN3WLBKul6sDNoaupQnBQR/vuCjlSDtfwNV4iT6wLADfw5X
	sygMasuvRY0szOjZHLKOMYAAETDa3xh0MQsjmR9iPgVR40iZ6K13u4H4+7xoQCPH2L4h+dwAV9a
	seBkxOEQcSpiVv7VnmB1gcwbKTDSPD2liThEeKhkxxTKL1r4fe755jLMG9tpB1SDohIA6JkNOls
	GOuxXj/MmXHHToHhsD/wBRzLLq5cCl2QsKe3OqTQ5Dk2uCmJvgRd3aT5JsOZLWZpH8Pc8Xw==
X-Received: by 2002:a05:7300:7313:b0:2ed:e15:c922 with SMTP id 5a478bee46e88-304eb161d3fmr378811eec.30.1780017036073;
        Thu, 28 May 2026 18:10:36 -0700 (PDT)
X-Received: by 2002:a05:7300:7313:b0:2ed:e15:c922 with SMTP id 5a478bee46e88-304eb161d3fmr378787eec.30.1780017035380;
        Thu, 28 May 2026 18:10:35 -0700 (PDT)
Received: from [169.254.0.3] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a114dsm173785eec.24.2026.05.28.18.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:10:34 -0700 (PDT)
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
Date: Fri, 29 May 2026 01:10:09 +0000
Subject: [PATCH v2 2/2] PCI: qcom: Add support for Hawi
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-hawi-pcie-v2-2-de87c6cc230c@oss.qualcomm.com>
References: <20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com>
In-Reply-To: <20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Leung <matthew.leung@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780017033; l=919;
 i=matthew.leung@oss.qualcomm.com; s=20260428; h=from:subject:message-id;
 bh=SqRYyWGxDpggIYoY312hZiHBKDzS7/Y1bj/4uMnD8EA=;
 b=x2Mhs1h6QGe3C4hNRrzrpoZoETXQ2icHktNcZc//QGUXgaYDXCh2J0HryCQSgSeaG6TwVcjag
 AjHlnzlbhLMBN167zvse9emeWKy4lZdA/Veg3xo7Ms8JJvicb1ZMpOB
X-Developer-Key: i=matthew.leung@oss.qualcomm.com; a=ed25519;
 pk=aT25ggJo5PMHLN9N+TsZ3s/BVU++kEYuiFebPWe21+o=
X-Authority-Analysis: v=2.4 cv=DsNmPm/+ c=1 sm=1 tr=0 ts=6a18e78d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KdxOZhL9OB_EpBcCT-QA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: au6OTp0jqRrpScC8FpBMQE7fmFqmV534
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAwOCBTYWx0ZWRfX+1PnI0b97WBg
 Zxy7P8SeXKoxXNVrkEGr7iJusRcl4hpo82EPceq5LbtX8TEydLLwX/wnFiLS6skK/9ROqFFNn9I
 A7jvVNryPtPlRsisJWXda8mt60nUdmdSjLqZscC/K9ePX9Z/VJ7s7QqOkM/KqGyUuq5Yt+HImzs
 UOlzqfJuiSzzYhmc8IYp/LZ7a9LD9PGzcGyA67v2r9MMpevplRrv9d36BVH0VpjCz46HIQihU06
 5svdM9PDTwUWBkmvgdyf3j3vc4dZE1HtU7eBWVBxEyjWwwUajQsCPA7U+jBbnHGWLxsyzmZtt37
 jAC/UDp5d1CDQ42BGxR6I9i/d8GzJXp8yWBmliShVorwKm4hWmyqB1da5YCVe4bbiSnzIkrrtDP
 Lta3gSSBUwvb0BjZpN+zn/mcDduIgmOrhCE8zvL9y9SkBP7m2Dr1kz8JKaePCG+rGgFu9ijiywt
 fd/0dBTt1P639HxnfDw==
X-Proofpoint-GUID: au6OTp0jqRrpScC8FpBMQE7fmFqmV534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290008

Add support for the Hawi platform which has two PCIe controllers: one
capable of Gen3 x2 operation and one capable of Gen4 x1 operation.

Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 11fc60489892..5fe8667fdb8f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2280,6 +2280,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 }
 
 static const struct of_device_id qcom_pcie_match[] = {
+	{ .compatible = "qcom,hawi-pcie", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },

-- 
2.34.1


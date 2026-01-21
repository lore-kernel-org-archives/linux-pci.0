Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F854218AB
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004785; cv=none; b=DZK4ysHcPl2yNOG7RYyKeyCp05O7L5ab3dQPD03WT1v3/kunw48/XgMOV1Clcs0oZzcUtm3BDlHHBFsjuqj9BggErjPRRt0I2kvy9z3yDXguoxv8fmfvsJU1bVgohqKU9f2PDL0srBq+tRvGB/cUdpjvDuSL9xBrP+xybMiEWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004785; c=relaxed/simple;
	bh=1WGDd/C4AxXNYwQWdYTyMPQo+6KF2g4j/6nljKpSwPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bUkQAnZ994vNLugNRTaMoAcMXNM7c9pzuZyYdd8CN4CCDNl1uPJkNVkFOSB1HrE2JT7VuI903U3n2X3I9P26Hiuz8nLlZEECCE7miENmLyTIrF43Ners68qfp/sT1xLtpr6D/iNP4pHuyxucKGB7m5OSf32aGQw09xF230hWbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ugw2eKxg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pq17DdKs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ugw2eKxg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pq17DdKs"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L9ujbw2840751
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 14:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	umBEj3z/LESlnsW++p+V97CniCnqNLSsVrUC3L6GHxw=; b=Ugw2eKxghXbWq57k
	215Dyw6LYJc+NbVOugKInb0xA/l0Q+0qSYLz/ARyaFO6cee5iZsob9lATGXvg/W0
	ixVg4UaSnlH3Fu8cE8iA4sO/jGBRBGcvS0ZUGnRoXYgzA6Ir2FVlegJMr+U0/GbG
	Xa54Zcizax98t3nY8pSR7RfIKA88VaAdc67XfNQTcL6DLX5MWAuOwyInAOM8OqXC
	XqXtZCFDwsduR3bXQrTKuc6C6Vm7NEj+Lu44F0L6+fvC7Z/HCGORwf1SR9A8n4FN
	JVfeipXAWEl3aDsfQnlSnEakMyH8QHo0HqXhjl8csT32QoZb2KHtJGWc/ikbDdAf
	q2JeCw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btqm1t9ad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 14:13:03 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81f48cec0ccso5197295b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 06:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769004783; x=1769609583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umBEj3z/LESlnsW++p+V97CniCnqNLSsVrUC3L6GHxw=;
        b=Pq17DdKsTSOSNK9DqwZhzgryyhVXyRr0Tw7UCV2WcUlMlgcr9kbF29bHAHWXR01cu1
         r73YrY0/bBhic3mfugxBvUN1PyKIE4ZdNVCqn5lctXlPU/3iSHlRjJV0xZJupHC4LWZv
         Cjem3cYf8yMu52YqtxAaWClAuC1gcA79WZWqEpGMMYHu/ehYjacyruu+iuc9aCk9pYF6
         5uNr8XVUKo6UH8rn4MEhrzNs/9Mmf58KOwdktLUoD28jBXW/+DnQITGk6HbKwqlYoPQD
         fVUWqB9WfenXHXScB6oZC4GlY2jWHo1Wv7yzMGBLKTxMgvArk5VlfV66QTLCpBR+Q+MG
         ptZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769004783; x=1769609583;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=umBEj3z/LESlnsW++p+V97CniCnqNLSsVrUC3L6GHxw=;
        b=Zo7YmwKM4IGFWkRx1E/SMdOqPjxUSpyLAcF+uLNz+hi9QYuBoh9eOec7bM92jLv9Ac
         rK4Hra0vksiodwDYq3fSIs5LhwCozF4W7gbCTGRwq4ycejklYfWFMPPvMIO5rwKj/Pwb
         pVGflrBI94WrcDaf3caboacmGVt5LrcHlKDQcF5+d7flJfK8m75t8gm5O4XLKkDN7MZg
         Wm+P6unGuwjCXtrKPItDOT4EhE+MWWr7aJY4fhYX9j5G9plK53F7FrHgbTpvt9UAFhDR
         Rj0c6c4VzCDpVN/8NSX9PkS4PyvSU3+28Bo3vMWTtYyCzVaF114rejEDmI9r1p9DHCtf
         q+Yg==
X-Gm-Message-State: AOJu0Yz1foh41YhD3pGpTYClQui95jEgvaRTnbRwGJa9wlUP5WcYMdQB
	DuxYPbEWDvR42lG9bfArMXyKiRaB6E8zliPHAMg6qigYH5l2+3nHEqUZej8Ek4Uf4MWNh4ZAUvO
	q/ut+g/4eOqT/1EHkPW08f8jv8XHmIvFpBXO4Ev6mQsqSczdY4MbPhdO4+Mnen4D4GcU0FxU=
X-Gm-Gg: AZuq6aJmMUMyFz1Tj5SUBT7jx7qnGiAfxZeSgeDEDbEp5qf/w4Rw3PnpYq6j7kAsaTb
	Omo38lrcZTo+nPLNEaatD9SawZXygQBxgiMZsUI/Z+BQ62ihktnjv4k70uIlboxuOQS7U+QRO0N
	JwGXcczGm6neftIXK6PsuWLBuEA+kLY53y2JVLvwwQwnvqrST8Q6SHy7qGAV+X0MbLpF4UEKujS
	4t7UAMJ73smGR7SVe01qiAvFVOOLK6vmO7ZU1gsYQZBu6+gKMSvB6ar9oHWgC+HRDdGguXFrr6m
	Yt3UuEmFcs+rwxWhqW6qVGPcaXW0rlP/MUkOVl69SbaU0yrANFBQLBjWQIyV/3XShJQa8n20hvH
	J9LMun5tz
X-Received: by 2002:aa7:88c9:0:b0:81f:4e0b:324d with SMTP id d2e1a72fcca58-81fa03483c5mr17030944b3a.69.1769004782609;
        Wed, 21 Jan 2026 06:13:02 -0800 (PST)
X-Received: by 2002:aa7:88c9:0:b0:81f:4e0b:324d with SMTP id d2e1a72fcca58-81fa03483c5mr17030915b3a.69.1769004782025;
        Wed, 21 Jan 2026 06:13:02 -0800 (PST)
Received: from [192.168.1.102] ([120.56.201.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b51d9sm15252753b3a.65.2026.01.21.06.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:13:01 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>
In-Reply-To: <20251224-remove_dw_pcie_ep_hide_ext_capability-v1-1-4302c9cdc316@oss.qualcomm.com>
References: <20251224-remove_dw_pcie_ep_hide_ext_capability-v1-1-4302c9cdc316@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: dwc: Remove duplicate
 dw_pcie_ep_hide_ext_capability() function
Message-Id: <176900477438.343515.1230699650351022573.b4-ty@kernel.org>
Date: Wed, 21 Jan 2026 19:42:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfX1oC03Bx/sSrY
 zyAcNMiV0UDC4BnrvKZWz/10PTi9UD+RHEKlkYpCtmORWmeCVSIaee2Fy8egcAGqCtYld1JG7wZ
 X1V9oUX4PJ11GrbpOKbXLGlnkK1XCEF47vjGdfC9igAimVbl3D1a4B7Hk4GrNvFGrMZuYKx+4df
 JELfS9rD8gfLazmE9D/wEOOya21B/heFuXAdF0htbkpNjN3RS2n+MuF7e50Wc3onZxO8Vf9xQHH
 gsRwdMVtV6dgbkg7ZMviu12iDmbaeuDKGYrO5jKJm+RyZhZZQnHpgXzeBJWxvXagQfwzP3JfClT
 qGtbjsRcCokCpLPl42kh/rOTwPBNISbnSeim5aBvOt4NlpaqJP7/X3bqOvMZnxm3BAwNeeJMGJZ
 xukRRo/2UqopDiXI+zf37HnCbkh6uUzAbEkFYV5+03qVa++bsMPQAjYRWr8tsm3huH9sBAFUN+h
 mpgXazIUMobzLamS3PA==
X-Proofpoint-ORIG-GUID: v0KXVeLYFlJ55f0HmTt7FV4nORRF-oar
X-Authority-Analysis: v=2.4 cv=dtnWylg4 c=1 sm=1 tr=0 ts=6970deef cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=o3iIPP6MwdQAWb28Nvg98Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=bCJlsGfofW6EOh1BOmIA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: v0KXVeLYFlJ55f0HmTt7FV4nORRF-oar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210118


On Wed, 24 Dec 2025 02:10:46 -0800, Qiang Yu wrote:
> Remove dw_pcie_ep_hide_ext_capability() and replace its usage with
> dw_pcie_remove_ext_capability(). Both functions serve the same purpose
> of hiding PCIe extended capabilities, but dw_pcie_remove_ext_capability()
> provides a cleaner API that doesn't require the caller to specify the
> previous capability ID.
> 
> Compile-tested only. Runtime testing on RK3588 hardware would be
> appreciated.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Remove duplicate dw_pcie_ep_hide_ext_capability() function
      commit: 86291f774fe8524178446cb2c792939640b4970c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


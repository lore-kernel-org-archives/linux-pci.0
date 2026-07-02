Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725DA3C6A57
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989197; cv=none; b=flAukKEJYAsmx2UD2SRLKj50xqfDDCO02MYDEa01gHxENVrNlOxrXMYNr/wSOGDeOyqJlN6OBfY+ujVNPz5T3PMuMh1BFtDIYMFNqYJrl2IeXB+wkpV6zLO0f21Hf4LIBdqv+1o4YR/1NNrj3hc7JoPnqhd7OQK78q4YGGVw1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989197; c=relaxed/simple;
	bh=mh5EHmkfn+Hckeu/ga+6Zfj+PX1LbiyTWZjnRAILnCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXzm640SZyRLHHXeYZxAkSjw0NJx0rhoBb88m2pEyiRXgNP3u7A89pHF8U4/Dz12/gC/SAWLLEzS9/NjqXyYXJpLm6GZ+xksBD2lZY2ZfC9+Wl0DV1QGlTZ8b88EUeo5UkYdBdKh7KlL27IUp+ho5IkUrzK9NExuLD7X53wqOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5FpqsZJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xq8tZm1s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5FpqsZJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xq8tZm1s"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662AK8523591746
	for <linux-pci@vger.kernel.org>; Thu, 2 Jul 2026 10:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WzcL6bqjKCQ2yH1CTUP5oKTLu2gCWJgGGyQKXMvuqS0=; b=k5FpqsZJ/ul9VIdn
	MS/ExLfdrIu6kqgYNn79L58nooAp35PFbE2pSFIciwHwN50Xd0HbtCub+OE2k9mM
	2qFE4lAZb2imrPSZs8RdEnnf7CqrU+IvkSlWWM2OVCVIVPIIaBFvvKn2UHlB3mZ/
	YiyuGgqriNu/zKaPHWaYKykSyaCR/6q70El3YyKU2KfnTRSmJkTWKEh5PaPp7G4X
	+atz6T3tEB9TX8YVcabtXEL6fP/vK50px4OmWNecr+YA8SFtZH3sWlkl5xOCdJ33
	PVvF3F/ZZLECVAZir16LM6rqDw5zBmxOjge3VviZiraH/HdrWdne1MiAfAHDRQl0
	2rSg9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9ae6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 10:46:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91931144870so189716585a.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989193; x=1783593993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzcL6bqjKCQ2yH1CTUP5oKTLu2gCWJgGGyQKXMvuqS0=;
        b=Xq8tZm1sxJmliWfNsM0yAtEGKZ1FLelAlX04y5OfINOkjncS8H7DwJRwtYOiPIBJzY
         Ur68K5da93jVBT8vn+Mx/veMXAT/CNQ4xQkzjUHC+OLDATRUncJJxJ+1fGWwYfANmSxp
         b+ajcs999uhIez3PV3fFScetrI9q7JZIoeCP8u+uEtm0fxERv4iLipFcOvGm0NBP3H8Z
         ae2qD9ljaY5+NzDiyj3u+ekQaO/Z2bWyuznFpLwEBffMG5Nmemofuf2vhptUowUh2Zyj
         oX35oZsWIl57KJ1ftYumtnTSC57pK0p6Suyvsl3V0KULS8QnaHIyeq9MbJgI7hEAyWmP
         HpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989193; x=1783593993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WzcL6bqjKCQ2yH1CTUP5oKTLu2gCWJgGGyQKXMvuqS0=;
        b=rVynEmEPl71amXtWXk9legtSDh1xJl/bCD+cIaZCvLFekrbRMztnIP8SP6Wx04Uz5w
         WxfwGGT5avWQpqnBAIz9aIp9LKo6/8WOiKBAfFaHDWzyB17xRJMgZd4+2g2j9nmyOppT
         hgGQBCzfeZEiAWWBLj3i9G3ws3Z7sVHZeIcDQPdwIeJgargQvansp9lQ4HJiDfFG6fT8
         mTONooGbHfAkSJMib4qkhoJNPc4EBhLB+BrERW7fh2osk7LoEcGcVa25gR3i1kFZ8ahs
         hKDxN/sMYPj0YvzUwJy+JuXsAb0eRiWyJN9czFFU6bMsQHU4Q0DZjiAYrjkj3g69M1Di
         KZ3g==
X-Gm-Message-State: AOJu0Yy6vN8TiVjWMj8LypHLbzwIsMvRW86mpSXlxyOzWr7EUL+9a8/P
	zF9AV6c3QFQfF50fJtYlpmtObCoZ66bBxw2E2rBII9BV3wyCgraYTEWx+YXjmbfwk3hUM0Yyrm1
	Ma2zzn+Uh6n5IYBFmO6/hH21ru8RcDQTzz9KD2BUl63n81QS5k9oQ1aL+03GzJyk=
X-Gm-Gg: AfdE7clc3ZsPAAdVk8TU+jKCpqQOTiVzFu9T3ZMlamq9vlkwkAYTYHpQYphmvzHDLR5
	TcY8Ble/c19UlG+y3u5AJ5AkOKRRINmp47APdgGzne3Yj0ImANbFF/pDLK5UUe5L5bmKiH0O12M
	DBuWzbPhhzHmP8GrGQ5UIit0BrLwoT3ypMHStK0n3KFOi3y6hHCsxBan+LA/WL8NxafJ/eYy4ev
	FCdUY2Z1PPBBR+dzhXotgGF/Nzfy7JjDCDeWWnEijIO0tJGfx4Hs+1h7d2lCq3hk2ZghW9CdJ9A
	jSiXhFIvTR1N4R+FG1DbyBThKwiY/9bH4DB24ZsPq9rWKgg8f6yoyyhR5eaXnTCPcNISTnWonfP
	khIyC/Aol8rAkhZ0ugeDnnV/1QUbkw3nz6V+Zdz8zmMXL7siMcfFfSh0fUAOQmrRnORRZAEXY0t
	of8COVyVlLrhfxICyJS4oZcHPtmVAF7sMRe9rMvRoSRe01plsPgSZKWz/p2WpTg0Y=
X-Received: by 2002:a05:620a:284c:b0:92a:f65e:1e95 with SMTP id af79cd13be357-92e7825b261mr707542585a.21.1782989193439;
        Thu, 02 Jul 2026 03:46:33 -0700 (PDT)
X-Received: by 2002:a05:620a:284c:b0:92a:f65e:1e95 with SMTP id af79cd13be357-92e7825b261mr707539285a.21.1782989193046;
        Thu, 02 Jul 2026 03:46:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b5ae4959sm109689666b.0.2026.07.02.03.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:46:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 12:46:14 +0200
Subject: [PATCH v2 2/4] power: sequencing: pcie-m2: Add QCA2066 (QCNFA765)
 BT serdev ID
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-monza-wireless-v2-2-7b56e2a6a6d4@oss.qualcomm.com>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
In-Reply-To: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX8WnPlC/O5zbj
 PNLD9Yt4Ck5xji5gpuWXawUOtk/VWpWILublGRzzT/GOcBvx5ELfUkOXX9Lu6tVL+Zaz7O+mrl0
 fO+KW29xdd3qdcpESCO7bwEzLht15N9rQdYvxUBnwTQAO5jVSOew2zFK4VzIZoI9s+x0tEdCS/V
 Mr4vEX5GhiF/1jmDJN75k9vAXNVAopMXMBt+2oxGYiKdnQ2LLK3pCAlGmczc3Ub91hsegP0lCob
 RnLIDKjITkabaT866heTKJ7HJWWPnrLt0wDOlb3ChWD6epKpnzrHm5BoIQxLq4TkZ1eyKpNK37l
 afmMaLzg4f/o4PMiblO8G25hqPGbPK6pchqrg8eBFt8OuonmEPJ0zlG40v4VXFzW+0cu7bwymRu
 o8c0GKJcS/WkwxRHxuzlAweFe+YwRUjS72HnMTdOo8DXxminixJa0wyKUsUv3xMGNcM4+8/jBCR
 MZcZVKY6OEjSQEfKclw==
X-Proofpoint-ORIG-GUID: F46vVVVP6PpkWQ7spKCWyaEj98e0Kvc1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfXx3wQU2ANCR0r
 /tt7GrkPmClsi6wCkpEEJVt0cRgh4/vjp6s9xBtrhb2krm0+Q7TOWU/erTV7UIp9ERGAq1MDpTe
 MgoGaygkEFu3Dc+9+g/XEYbB/KygHQo=
X-Proofpoint-GUID: F46vVVVP6PpkWQ7spKCWyaEj98e0Kvc1
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a46418a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hhiJJhbhXc7jC-Wm4KYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020111

Add PCI IDs for Qualcomm QCA2066/QCNFA765 to the M.2 serdev ID table,
mapping it to the qcom,qca2066-bt compatible string.

The Subsystem Vendor ID (SVID) 0x0108 distinguishes the QCA2066 from
the WCN6855.

This allows the pwrseq-pcie-m2 driver to automatically create the
Bluetooth serdev device when a QCA2066-based M.2 card is enumerated.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e3ba9169144dabbf0c553c0a4302c3b511fcaaa1..7cb455569d8eb5da12e46606d9f25bdaeb8a128c 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -190,6 +190,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, 0x3003),
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108),
+	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),

-- 
2.34.1


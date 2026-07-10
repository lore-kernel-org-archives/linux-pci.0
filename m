Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3463FC5CB
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677477; cv=none; b=LMSElytgdB+bcNE2tFaM/a38tU0NyZtrvlMwqL1xKmQu4bpIU89YZPxrV3w8fuEga9fxATbszDO5iSJxTUISW/e+OEmFKV9pHMfPCBnkc0fcNuQVLbmfsFZcQamEg1Z3kPwxVVUGJkta5q9Ic8tevHdOLZdMWBWk8rFfR/RJs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677477; c=relaxed/simple;
	bh=8JpUJth9XTvH2/KUENAtj9vpf8EiqqScCzN/6TvG46E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVH4u/PK9vwmAAekNqs6c5dnyrVRc8JR2KPnWxxVlUBF7yMTeFLSTxGzNjz/Dqk1fqa9279XU6TvXtpDCwQyD3YjAtohiH39BS1Zt3jy+ViGEp2HrESWPLenRZ4L0xmzBpWKI+wuuPZ+3dm7C0sDGpRzPkl4fqfXOb9zIBzwO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drQdye0z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WbJgLcS7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drQdye0z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WbJgLcS7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7drXb188285
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L/+fhSSKhqNyPBIhKtJ3rdCectIRZdOdeDVvpYe5lcc=; b=drQdye0zyYR6/ADK
	eR60QZa7r+h5eWK8gLYEiTp+Om71n1v+Pq0B1n+psFTOnW336SERmkLoUkmukSqM
	stLkpzbs70Kv1wJ8ENJDyvS4IroFhm5204VewBqk1VH+roQwVH6pqsKTx1MTIJlk
	UYZHQVxH7BG8/6b9dOm/dMnRCkkNKs1O66lUiexHBuVodg6AIpKWxRGf8LKMGd76
	gUTKQFOQNmoVz/qiQbw1WolkOJUllEW9VWGeR3gXzPqMn2T9Df7hGWw63Se1URA6
	ecXpjcSqU4SN/QUe6gZqfsu3EU8aie32TihzR29lTYYTpg7JU9mHHV+x4X+EGr2Y
	l8APDA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesuvtc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1852a86fso7932101cf.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677470; x=1784282270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/+fhSSKhqNyPBIhKtJ3rdCectIRZdOdeDVvpYe5lcc=;
        b=WbJgLcS7eW+jP/21gcjR/0ZsyFQ1z+4OSqaUq34tt6yiT656lQcFE1ZSaxDfk+0WUW
         BVTGS0kxpVDzStHCMuOu7+LxxmfORyDGsaAd8OuPN1W515eNQR5i/PDGBLqkuZblvNFj
         ZG0tVlgPXFTttJ4KNcTiv/k/e/sM8S+1xfI+wq8OeRyfZL5vAf8Ek5/Iq53P0FSxAbNL
         m+IIFr47svXKFGR29iPtqIADjNJM7j5syHXAWXn7qXqP3TGoFXoVWVmus11P+31J6c/Z
         bWbbf+AXXpKo6pC/BTewxzmUc5yrD/AvDFBZybw9GCr7j3Iwo7uACf4/G/F0TlHjXDZT
         i1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677470; x=1784282270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/+fhSSKhqNyPBIhKtJ3rdCectIRZdOdeDVvpYe5lcc=;
        b=isukq5Kqj5pF59NRDBuAFULAiVW1C8dg3xuorqgXqbeanDToBe7WJCbfNfj8LRZt+t
         w595gNeeOZa3TaxHiWGYtzbIz1DgKEyTP2vlMoIdw7SbXyp8IhMX7soixxXnZt9Z7BWL
         dekFvltYW2XeeGDgTBmT2/yqOirQe1He1Ft8h/kYjGzxG6dy1veBl9RblsgsQzY7k4To
         LHNyD6wMmcjbClyIRcsjZx0lsDVufU82R+1XqjF2g2hFf9zfaADhGBaYVfGaN4423pbl
         8VJLAqH9TgHal2m0yRCrlioL/Yp5d2mzcVHUc/AYAJDN4Mmgp5EOjxsqQnj7Qg3rqYmO
         Eeww==
X-Gm-Message-State: AOJu0YzXvtAym3poOe7uq2T51RzE353US2rqGSiBJMA72VikthZ8oM+g
	liC+hJvc+Bri7Bi7p9RiHIWe5pkExM6GEANN6Agt9OZNQYbVbPvIuLxypD+FALRJowijMp5ynXH
	x7POCOKfZBxDNTWBE+UAsfmM9ciEZmxABe5uAEkI9hIB8etrCFHg+5IFu0KgBhfo=
X-Gm-Gg: AfdE7cmORkIQY2hqvDXIcPV17cMBKOZSYX5EQVL7gFDJf7FfsRvoQSmKgn357E7tZ03
	VbRufPlh2FZCrfkkUaLBOC3+grzG1/v2b17DWbz123Ond9WHhn+Z20v/sVfeXiK3hARUbLpXJ0L
	sImhwb1tDg3uJ0vMmev4fg8M4cWeX2gcfVeMOfTwZqXQ9hDj9plrlg7VzEriCH6y/jQIG6K6i38
	MUqmqJx854wBUAhAjZN0ToOfSyT3a/RVWa+DjY+KlDQ+Wi4o5Cs8qGssdtOzw8BNiL1vbi42bME
	gcJpaziAYGI7WeZbY8DuTAlXHP97swOuKPWbuSwnb/X/um0G9/4yzzPxWUFVzPxPyPXpNaMJNMY
	W0WHhnP3lUZOaofMgKiB0l9x9wXX60agWFYnAcTGZwXsSlZ2pPc28FSLq0iPXZXKQlkgbj7P3/b
	fitDpLaqb8uDWo1kQANB06uAiNpynSZZVV6At6DllL+FvLI9wlYtsFOutfvTPxdZmX+Dm1Nm/uA
	VOY4INKb6ZDnTcbwqsx
X-Received: by 2002:ac8:5a84:0:b0:51c:1967:5091 with SMTP id d75a77b69052e-51c8b3b4c44mr119708711cf.41.1783677470057;
        Fri, 10 Jul 2026 02:57:50 -0700 (PDT)
X-Received: by 2002:ac8:5a84:0:b0:51c:1967:5091 with SMTP id d75a77b69052e-51c8b3b4c44mr119708391cf.41.1783677469579;
        Fri, 10 Jul 2026 02:57:49 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:48 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:36 +0200
Subject: [PATCH v3 10/11] power: sequencing: pcie-m2: Add QCA2066
 (QCNFA765) BT serdev ID
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-10-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: chcoUcA9YXVPWhI7R12vn1JD3blKHzev
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a50c21e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hhiJJhbhXc7jC-Wm4KYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX8Oac5diWwjBq
 NywvETbCOaPBCINzUFg25luiiIYA+ikzn7MmsYkXdRsQiPKHZ4dddKWB8Bpn53xS15oeFOvKvF8
 0I67wR2JMvT/lO1mDS/QwI0i570hwOI=
X-Proofpoint-ORIG-GUID: chcoUcA9YXVPWhI7R12vn1JD3blKHzev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfXzT2n+bWl9nHG
 qtyLZyBO2nTgBiHD2sZQnwkgCPNnZ+JdjRLtGe41PnGT0KAaiZqD5AEFZjzWhkAMKiWTtzPLNHv
 yZaSbRTShQHR0oWyy3Y4/Cj3bJ/ZVGt93tnHzTDrYyBNK0Lulit75/FK5j3ss03coby/p6G2eqk
 YOHv0U/Z/NqvKXrg1OwumjqWNi/8UL792oSj0s+SDFhRjs67yO+ytX//+GtXUrZ9p3RtVHy7mM+
 bRG3sst2wvytaH9L+z8OVfoFl4INcwaaXQ5jen9Vzy6LVwkzSaN4tn6nLn7Yuto5gNlniXgpo0B
 6A2/u7fybRgPvgd9I3XZfsQj4g5FnGCiSMlHTBedI4YzXhTiH7bUhHCZtLKVAoUXxPVdw8uUZgy
 lWZhfU2LSQag/e/Sh5lbfLqa4PlQHCehsL7J07quoJX19zPudUGRMxLWnCajOhwC1gxlUCWCPlk
 p9Ifma33jcKvvSN+2Vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

Add PCI IDs for Qualcomm QCA2066/QCNFA765 to the M.2 serdev ID table,
mapping it to the qcom,qca2066-bt compatible string.

The Subsystem Vendor ID (SVID) 0x0108 distinguishes the QCA2066 from
the WCN6855.

This allows the pwrseq-pcie-m2 driver to automatically create the
Bluetooth serdev device when a QCA2066-based M.2 card is enumerated.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 4bcd5078609da1be966ab30c73cffae5e578934f..5004e70ebbfc370823098ff6df7b79336c1e6063 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -216,6 +216,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
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


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A337BE95
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218740; cv=none; b=X3DyuxDEU6ngqsW0yelk3qiB1MeFvZOkAZbcMN9FMPGQKdH/Zp/1F2M8hM7YEtZ4Huwb5Ugo5nsTSWMeHlQhw7nrZBXdzRXb2Elp7zOW7NzOuSkZWGtR5dVTmVdmXd/bKkYB0F38NdZ0MwXaHRBJguspeY6V4OQgV/OOI1eoZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218740; c=relaxed/simple;
	bh=Zf1cAa5b0bNP3c/K70OfmcZ/HBkFtBvo/OVNOd6Dz4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPGMKBmEDPmrFS/Axv2LRlyMaxbk4gcfs1gzcK2uYnahUFGHsnYAitEAIorGs4ZTKrx1PLcLZTk5pZjOPiLw+RPAA514IPyRhXgXFkOe+PRRo0g6olAGtxECw2/Ico4wDt3Odb1Y4olqAgWLP10JJJSBzKzJAiTjs0kQCe3tXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iMPASNCl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLs1F5sA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iMPASNCl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MLs1F5sA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJhPb3043222
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+v6DYK+7R/PwBLwFZrKIBzxEvo+v4Yk8qTFPX7MFv5k=; b=iMPASNClIiwnBUs9
	TLeukO+yIb2e0ANhVibK7//YIYfas5syQgkyc7wnsJQIoTvpZuYEOeHWBJu5VeY6
	9yogaFGiAWNTzGIMIIezHR11yGsQeL0YgmV4H5AEiZSn0xPzwCfpa79pEc8vxDOm
	UM3B3mozqhtGxFH4trB9B/GYLX3AfqAbkhH274guXhQi1qBlML7CKztgKSocX+Tx
	Xp0bgnLDMnNLUKU0fuwGkEALmg3qiE9mew3+NbFjyghRnqQHK7CYzyuV0sndEKxg
	Xlp7gXtKJteK8Kbso8RPx1ZJBUev+l3SIc9ZjDrxmrrv/gmkWqj2tRSlZrx2DyHD
	2P85SQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf2c6h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1c7f135bso65096611cf.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218730; x=1784823530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+v6DYK+7R/PwBLwFZrKIBzxEvo+v4Yk8qTFPX7MFv5k=;
        b=MLs1F5sAHKcriSWlp/x+WJuWMmih/wkFDJ4cFY2lJhsMFo5oyhrmcmqayG5nFgd8ve
         yr7GCMwpMdlOYsbPEpTsyw0nXc1Cs2EHVvPwDApaJEu/13kEsADCRQ7CS/9cjruc7rhS
         VvHAo54HOG/k6jS2Y3CL4SgymZ4+pLfSo2UrzKZZQzu7D+Ylyjnd4pGetKpOJ0uhpf+E
         hfAIrdeC+fdg2MEx0c1J3iQA9PKt8WDcAQj5AzTJy5hjOZtc1Nfci0RkLXyVdRL6/y9e
         sSokfaizZlB3l3dAqH2FsvS1HSEeRIsN3hl2Y44qGjzxI1iLfTRvXp7YuS7cR0pL/POQ
         HiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218730; x=1784823530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+v6DYK+7R/PwBLwFZrKIBzxEvo+v4Yk8qTFPX7MFv5k=;
        b=r3EkiuWaBZkTaOT8Cc/1sOp9WTq9ZQYv35YXbUdH4z7q6MVVhNd2catsVA+BMoV03b
         zb8enbu1qngi0MBoSai+o0692A3u6oaFsea4dnwzDR0QGNtj010kY4rzsFqMCYOidC9e
         zu9bmNh/nhaXS2hkNrxtIDSUPwuwsvj/7dS68azeEPP3V40rFyX6MTFWgs9Oxw9GLAst
         JyI5rko/sjUsx40WIqf2gb93Q9xmhsKwNwf0dJkLN8YQnp5fO4AcWrRlX51gsUsIjQnq
         puNKltQz0jfTQJPfioTzhHqwo3QSfqsS+yqcPCYyMEBFmzBF+zOZH+OGhHMMo+uPxkW6
         +IYA==
X-Gm-Message-State: AOJu0YzxZMeMfRuaxmCtOn+CFpR4aqRRdLAmUtQIgYEbJ0wmzjpurxvw
	sr9IniX2XdaRSyGoXBa/pyURg8PD5WNj9UM2WNcXqdNmQqDoziecQnoLVSHOy+BOz3C5GWSmRQG
	+TT1To9lSyWVeLLCtFUTbs1N3pnR6lDFBf26ZhFFAfKsPDAPaNVYQ/p/VEosILq8=
X-Gm-Gg: AfdE7cnkcVLOJmhi4LzSOLwV7lYeLmeWlQ35bJ+zTzWtMvppcqEgIBH22NO9qtlqgMk
	Y8LdryFqWwL9cXOEUw6Y6zclqgeJxGX4qwo42Aj2H9O1nslV4pxu7cpzbCHH3cmL9TQoie+MdkV
	oxvcS6kCxEy9v7delyQVdibNslyMV1eTp4EtwchuYyGT27UaKKihjZbs2wy1x/+EqGRjVRC1P/f
	UvkihM11n+2OAy3+8HZOZQA6ztqRCBr2vysueChrswFh6LR5z624L9K3X3kCrHSOTyhx0P/OWv7
	5qV2sgiY3QdYxiXfnYAL8VPBIFELAZ02hy3303826CpgNXmI2P06r0RADsXAg5G8WQhpIXz4MVG
	f9BiMCCWDxz4QQl6+TpQYRS+yyGRrkdTbrf0n+u1H6t6Bbvai3n9Uq7J5NJmkUvgNqJgQrWMsaK
	Y41DXB1JHf6O/rk0C+Ra4EGEKtJoLxlRrEclFW3Om90vHmQ0W+D7U=
X-Received: by 2002:a05:622a:408:b0:51c:7b12:120b with SMTP id d75a77b69052e-520bf276cf2mr2130611cf.73.1784218730169;
        Thu, 16 Jul 2026 09:18:50 -0700 (PDT)
X-Received: by 2002:a05:622a:408:b0:51c:7b12:120b with SMTP id d75a77b69052e-520bf276cf2mr2129611cf.73.1784218728955;
        Thu, 16 Jul 2026 09:18:48 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:48 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:27 +0200
Subject: [PATCH v4 10/11] power: sequencing: pcie-m2: Add QCA2066
 (QCNFA765) BT serdev ID
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-10-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: PhUvjpjYkwQhmFICQziqqgLUMsM-jlJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfXy2Yfnqday8bm
 Z+r9oZ/vQg93WQxweKz01LDx8EPOnkPdu009F6IcKk6NxNFV33+4I1rTbCKt0dHcGHSr+HkQ2Wf
 AKkY3+nQfasCgNl6RhLKOebcarD4AtfPL6m51yVL9JMcWtbCMLdXcxoKvZSl4odWyuKECCwYvc/
 KcquZxbkGpgjy5l5giMuLBuhDAaqbRwh+E0q+AWNG3LE3lDoF3P6v5W20n5b1nyF2Fn0F+Sfo2t
 jYIrznA1F3fPX4Ycbod6hacNPXGjlXLjM8gZ9fE1y+QkoguEn032O4iVa3n8drvD73VaMWr+oZ6
 yWFfQAkpdQo9oZSSGlOruwlUZn2GkmtptvU4YBvESLhiyEr36/luDWVY5WGmErzVN+ftK9jYMrC
 /UA/AtIhDdU+34BoqGFeyAzNe4/xVW3X95Q80NivWk999CYLwaqWv0s/uPgOesfJ4OdwQ3jbzPu
 HiWe++cqrcVcmirn89Q==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a59046b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hhiJJhbhXc7jC-Wm4KYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: PhUvjpjYkwQhmFICQziqqgLUMsM-jlJe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX+XFvmI//QLkK
 oGeUxw6cT2gjiLwImCLZMYeBguUmI87bxTd4oRDascOtVfhtLTvaDWz57oloseGFIocjRXL/GXy
 6ZacQ/WX1UhpHBs+FSoU1DEBav5ZMns=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

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
index 8e4cb778e31f66aa171ad9831d4213e17d2e6145..741bf593d1716d55494cae99d4452600555e53b3 100644
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


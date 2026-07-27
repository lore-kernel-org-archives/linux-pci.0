Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02623E009F
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167250; cv=none; b=PefWv4HgRUmkfvTlHrntCeAs4ZAXXbgaD2VVCFDH79AlgpDUHRU208FKlq/ne7pSeccdMv+OY6N1hEB2pEFpvA+EPGqR35xRSG7iZ2hMxtB1aCENgrO4HAKUH97kwX2c3w9TLAU1wdhECunxyjWP9rdLdcbe8qI6s3iGa/h5oQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167250; c=relaxed/simple;
	bh=Mp1h9YiBAPuohwfB0HWl+IqYzDtj7FFJ/tWPt3L6rJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+uQkltuVbWEWgmuo4EEFC+gMIN4RXLZhboiYL4kjXIFQPsnvUPnYDfQVc2duRth0tyUa+tHD2B47a1hqQPgta0Mrfw1oGKDHDOaoVdSONZ28OCemPRBUGfBMQD12JsTELWCtWHEqgYKDQ1c0fW1LPRDQpynOvegdQFHkteYqNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WevY7i2z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i04mAkT6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WevY7i2z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i04mAkT6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlb6C3905453
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RZgdZmBn3IQEwWFZORtGOAEY2N/1tVUq1A4uzZFbQxg=; b=WevY7i2zAABBesLe
	7rGFmi+HthAScB0HHbi/KEObFg0cCDcCiUO38Ppcf+bHzV+MnZbaYjvONcAMsN0y
	hETiNC6khYjFhS51asmK++wrql5mxeGNsVLUcEE5P86rCOX5sz42zfp3rIOv4sqN
	fcSlhv6zGO1d7/AnY8K5zKDHsJ4WSLpv61DIRuYf91s/2PkZjMFreAKGLNnBWm0D
	+zf+l1KU3FmHUY83T73wAHRMVSzunWR8UqtvnffCh90WCVUOHjyTXMYFX0rHeZF1
	02lE3H31IGnuO0xr5BJr0S9rxUXZhzGXUJFDv5FxNmLa4Jc+8ylBTz9bI7URFqL8
	lw5XPA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4uksfg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:47:26 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81eddfe28b4so74560297b3.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167246; x=1785772046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RZgdZmBn3IQEwWFZORtGOAEY2N/1tVUq1A4uzZFbQxg=;
        b=i04mAkT6PWJK7vllrFoWzje1GkOx+b6Hh5i7YVXbHCWgbNkK2XdmG6fZ4l2R9K9Azl
         hU6vAN7SZQg7WSD/QXbuAxBAgwM93kK0LEGIrEF0C0JUByiPxC4+5/3L4JVUKrQ7uAAE
         PZCfsLUFEcXT/G7Wx6uy+BB4viH4tmmzZhUc48htmovIpxhQqF7DEdQpNVtBzW8PZHzL
         GksYTUHOkIF5fFeXuUYSV9i0uedjKjaYYsbWAFeh7Id5LH2CqwVxfg9LZFFq5OH8HQoE
         8HJhOwoyNrA7VwLKUG4DP0Gee9DP2Dr68G6+hjvAIjxQ1qf618lzUqgEZYLri2nMOh0c
         dmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167246; x=1785772046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZgdZmBn3IQEwWFZORtGOAEY2N/1tVUq1A4uzZFbQxg=;
        b=Of8V89aYInGJ7OgaLJazgPJKNSgpgq4mqAOAvnNDTEpU8TZugZSi6abGRPBsQyXVOH
         U0g/Yv0eAuzxCQmlH2HblGhjCC3mG1B0+V8ApZJSsy/cYDkpTGc6vuVE0kraanLLWFCO
         Yqt3bh4lQyHgyrBeGXm12mpIsDUJ9dA5e/SiOAtiaM394BkR/2X29xA+wBYHgIDWZ0hv
         D+3l8QT/4Suo3haGw/KR0YPLRHpX6geduy8Qk8zvYTH1XKAVTFaX8Gsk4zumb2Q6b1l2
         wRgOQ1RMmdYXWBz/O0Ut+I94w32RhPXyOFdU9f80W4b4cMp4vaxoAoWwIzZ9Xr3BJWZk
         D7mA==
X-Forwarded-Encrypted: i=1; AHgh+Rry7PLG2hS2YoDML/ZbGgDxhQ9SCjpY4n6rpjW4nNhvsp/KgC8Lm/5YZzWlpBrnAQsGQjMZR5x6hhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzffr0Z0GmZT+6XYsmtWoeZsDbAS7vV0GHKlbKfLwtcj84niNFI
	QgJ+CNtN3edBrm7NKKGBo7SEbxyZXqx/ND5lhkW5g1EwQBu06aqCj9rc5poxBrQBM1Oa4KWkwqf
	LYvSLerKlpiq0zoTE2TKwDh9fVFy3ggb3mlt6TLP9Q4uzqn7oGGz4m/I6XMhVawA=
X-Gm-Gg: AR+sD11kjNlLUvK7Cr3UjHNj78Io5fNmzQuKYdtnMYMvQvAAqZSoMsW6jKuHXmcWVCf
	Jkru2bgt1YSRl1f2dnnoKvLigdJiXhI2MIlnLGrW+qWN17eycXhCYwSB/RHmipJOIX5hof+tzNf
	PIIVz8U0VnlWnW16GIMFHLcBFerhpsObi26WG1W2iQ1hblczCXJHGBoAMfB6WI9OCSUN+bIvOvo
	78NSmhO7o0W0gF9U+rKTAdnGT5ZbXWYBdxM6efBbRaA7CUpZfdZAjuIz/16oSit37ctajpbRrI1
	UG7J6GQuZrpmyutKsNbu7kQqSSRmYjYz4autb4MQOLm/ibpk44GembAuMU91QUT59Vw7GTqQcEI
	H07vDiDeEaaswfQkidtIrn9JV5CdyMQ==
X-Received: by 2002:a05:690c:4a0e:b0:81e:ba92:b255 with SMTP id 00721157ae682-81f93bda78emr55307b3.68.1785167245913;
        Mon, 27 Jul 2026 08:47:25 -0700 (PDT)
X-Received: by 2002:a05:690c:4a0e:b0:81e:ba92:b255 with SMTP id 00721157ae682-81f93bda78emr55157b3.68.1785167245485;
        Mon, 27 Jul 2026 08:47:25 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:47:25 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:15:03 +0530
Subject: [PATCH v2 3/6] power: sequencing: pwrseq-pcie-m2: add QCC2072
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-rb3-industrial-bt-uart-v2-3-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: aQdfIBOYyZ4--1H98lhSA8LpLthJyIYs
X-Proofpoint-ORIG-GUID: aQdfIBOYyZ4--1H98lhSA8LpLthJyIYs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfXy+PoW/0RWi+O
 QniIrtUwMHMe/aFNEpZecd9ABYsqT09sZUdrc+6KcZm3vO8S3U+IZ3n0oyt7XgNd10Wf8MjzjyR
 o4lMrJCMeyJH2OiyXPlmGS2BwnbTw8E=
X-Authority-Analysis: v=2.4 cv=PeHPQChd c=1 sm=1 tr=0 ts=6a677d8e cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HgvfkwVdxQqrXlU4ukA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfXxatRXYaN7EfB
 GredboNSFMS6vqW1J4acSsttwBwAT1cCKehXyQHi+hBNPOKkuk1CEdLDNicGxYvBcgyFIN2qPr6
 PUlPWSj28sp4kWs6K38NhNIlhEev2yElu2Nn87OttgrH4drfUjYZlIwuy/YxNbrZJEK/Lw26k/p
 z7aoI+oaMmBy5mbCzq+zZ+JJFDLXd0b3ssKq1lukBHl7R2j5fcXAuiEZ4pHUil6tYEV0gWbSppd
 r6RMaY28nLgzHRNgiwJEkhWgwC7MPp9779ZEQCJQuxO0cbY/Qk4CK72PC4iJIT16HQEicqq6de5
 RiH0r14bJKoAS8Q1wGiDaiUWh67dFMuHNycI//XVvC4uZfr5Wsl6ol4CzX3DLEO01RAqSMfNNGP
 8REGlPzifneej0Owo/HXaafcfCBrcHsZ+NFJNfzE5TR1Zd9AFWFiM4JIjIZESLI/ZbX4jRfWjUS
 OsSp05mZ6r7X9ZoTb1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270148

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

QCC2072 cards expose Bluetooth over the M.2 E-key UART pins. After the
QCC2072 PCI function is enumerated, the M.2 power sequencing provider can
create a Bluetooth serdev child using the documented qcom,qcc2072-bt
compatible.

Add the QCC2072 WLAN PCI device ID to the M.2 power sequencing match table.

This carries the QCC2072 M.2 pwrseq PCI ID previously posted by Krishna
Chaitanya Chundru as part of the Eliza EVK PCIe/M.2 series.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index ddfe6ca82494..b9fb10901b14 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -189,6 +189,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
+	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },
 	{ } /* Sentinel */
 };
 

-- 
2.34.1


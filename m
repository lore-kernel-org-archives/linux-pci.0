Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472459;
	b=31/vPwCSVTtrriIbBUhDKak44JJbsUSbxAvfOTK2RxhCVl0h4NMx7KcWwOL/WupJF7QR
	 5Lli7mTTKKQITMCnq2I5FeVjHIBJKAxaCNcU6wDYax86Nfe9teZVyw6UFqse0QRO3vA2N
	 TdU1kA0G2EEA7QveL0BA14VZ8g0aT0FirRmSNLeYs1JrdtCWaYyS6SQZJl6xO6Xrng3ni
	 f1qzntcXHeOr1hvcQzId4XzSXf4M69ipfF/oXsLwRdGBYpCoPXF03sivuMhYPmRGreSZE
	 UiF4ev3qoZzniDs1fo6AvVneIJ5ibWQfGj69OPH9incGriND94jdDjMc71h/VjfGB1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472459;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lCEAyTVsKfqf2TuD0MbUKn2c2nJtOpDVRa0HC47OHj8=;
	b=1i2ew2kPHObvvFzJVHECSY+1PVdec/6BUrBNjFv7Y7LybO6gen1E5VO3ilspQMN/fAqY
	 GmcgAtYCcNXZ2CbfmjwrH4Bj3dShM4FuSOBpW0e3mfEBw6H2HLjwVBeqE3XPk9CEhhZF9
	 ZOaP2yZ4nug6zKtFlSO3O8VWnYvpJHaDDVYHvbTPE33/6yQmfKH7i7MolNtcx+nlKPty5
	 CsGQ3OmugUuOdhVZV+dAqvxOqxpeIClDMG/T9Ej1gZZDIpTR37y/JyFdrAoCxtpnK7Oqk
	 bpLpC1X7bl8oTH76mIB6so+RB62oJ/J2YRX9DmFwsQHjyte8ygPNnSkTevnmO0LLmZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ebXST0T4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AflhbXMn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADA60A261B
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BADA60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ebXST0T4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AflhbXMn
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2Zom12514499
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lCEAyTVsKfq
	f2TuD0MbUKn2c2nJtOpDVRa0HC47OHj8=; b=ebXST0T4Q8PYIyuHJxnW2EU1d7D
	47DArYhnx2wuor8XCNT4mzvfpg9fY7gcClF6hBO+KGUy4WjBwcJqJuGCnE7LyGsw
	V0h7wpSQO9PhK7zYHSOT5rfQEdTZvoTC9Jc5A88Q/0HCxuiJyfDa9jlvzt3Cb5B7
	Dnsf8EDJR3JH4k3Na4kVfKzCCiTA/QbYhTDl+idNnrVMmouA7FL7PfrsZy7RLm0L
	mtg5E54RzNrs0XipgSKGfuvPRJniNxTqgZ5uZfOfIPYLKnjvgG58PInor4gW+Zes
	EF2k87vUVlcM+BdwICHsbVZz9cN4isdnPv6QpoRjJJLadiW22j+9jL7+2Yg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1tq4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 08:34:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9a4052726so3873785ad.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794472458; x=1795077258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCEAyTVsKfqf2TuD0MbUKn2c2nJtOpDVRa0HC47OHj8=;
        b=AflhbXMnSngbZc9iibNl3tWDyawGvcbezmok6YhLz3Rs96qfcRtIO/rJdoo3gsgKHp
         mqp23qu47b4M+SV/6ZFfnT2uNkRfG94UXgSjt6eHVp8k0AlzNzOxlyxiDTlvxnD0P8IX
         eCiP3LB0SyF/joWoBC1Rqx5VBig3s1QY+NXV7w/hQ4Px/iRwKyeEglgB6/Mi2NvjWuMD
         No/IBFQh6ax7hl4kcrYCVAGnqpLA/DQ86NRcZlvuW7W2wOu6b6U0kfJuZI7x0YqlFcWV
         esZq2ReVspek2iMXYbuS9DVa3EBP3rt0XVUDQ4E+n2r439W+k7A/x0wzjwMmVxqIfNQL
         ZmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472458; x=1795077258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCEAyTVsKfqf2TuD0MbUKn2c2nJtOpDVRa0HC47OHj8=;
        b=UsNBPx2GPdczKbE1bDgKb09xbMhO9xAx6YC7Owizeya2ISVNTKTFfmkOJJbstC0SzA
         mSu1xanyU7xtQ3KnmL/uogHmiCpUjq6ag/iFj9kd1L7BxLUu7eCEd4nlK7ye8vmGos+L
         H64yGiAU5spw7EwiO8jmriAOx8odAG4YXNYiXtBepKQEq3OmQC5bfcKZi+gUqeTNWo1A
         CavmX/Li3qIOjqS+sSc8TiQ4d59IkWcmCKZ4qgpjmkJrBMxi4yhWezu/UaXsUi3oWfmf
         afk0hNE16sQGHNXI2KK1ViuaAd+5jdgkB/Qw3HzMQ8uOhDdFMR2R+WSu4EqwAx514kWw
         t/Ug==
X-Forwarded-Encrypted: i=1; AL+hErHOl7n5ncCbMSXrgLGAHWJXUK39JXBOyVzkKi+3BFtnHVm3H8XFtkzXLAWD+Np58zeU8AUBZ0VSC9E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tLcy56klY8aqyD+nd/4FUdhXACAn66NaZtjUs7/NcsHplTP9w
	ogSRg4taz+iZOXVlt+nrBpZs2ipIqr0IssoVxBDtlLBW40siNnZ3Ixh0oXq7nm4OJ95D8KHFniC
	M4Di9qZZAfg5XXrmHqvpEeBsCbgpXOhzz5VjFr+WX3vj+PJEVfpbZSm3ABTNg2fM=
X-Gm-Gg: AYBFou2NzJbtX4TRifFdf0d+vcDw2d6cQlpiMwA30V5s5yq7FJnnGwhy9SMRlM8zbkH
	zVDZ5mpl0Yo6g2Gzna2eIVCPp07pHpVqUvgx1HcBCAdXmpps0MA0p1tOK7y6vZ+D/saoyGq8p6r
	rzhD7BaPjNl2S0ve9TyT/KlyRMui67wUJ7vg2LtqxEk1KHGlx32Wh0XiEyhwOq1mjCfRI5LjNIE
	M63/tssUk0oKDyYndFB+Jo1cz1HZoJThuepW80cddVrYxgkHK9PRHJGWMd0zF61EvL6zZHkBIaZ
	v4FUnwfpqy/fkMSBMqqg5m7joqZopVUMJIkmhiIz6i0DDx8IWEpqulKKiyd9zDvhHItwNTIVdy1
	U6Yp6YgU9mX+OVn+E6cNBDcwVU63LUWluKYZnABjXqBplgW9kqLHLY36Dgz4C7c+dDbiY6hFPLS
	v1OQ==
X-Received: by 2002:a17:902:fc8d:b0:2e9:5714:607b with SMTP id d9443c01a7336-2edd7146534mr83242345ad.0.1794472457703;
        Thu, 12 Nov 2026 00:34:17 -0800 (PST)
X-Received: by 2002:a17:902:fc8d:b0:2e9:5714:607b with SMTP id d9443c01a7336-2edd7146534mr83242005ad.0.1794472457290;
        Thu, 12 Nov 2026 00:34:17 -0800 (PST)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4b950sm29351705ad.13.2026.11.12.00.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:34:16 -0800 (PST)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] PCI: qcom: add support for the Shikra PCIe controller
Date: Thu, 12 Nov 2026 16:33:53 +0800
Message-ID: <20261112083355.3884737-3-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112083355.3884737-1-linghui.wu@oss.qualcomm.com>
References: <20261112083355.3884737-1-linghui.wu@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af57a0a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=OQKFvcYlbweCljSKIGEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: XQTAisNq6OqAS316pKUZyXQKTxByX3ts
X-Proofpoint-ORIG-GUID: XQTAisNq6OqAS316pKUZyXQKTxByX3ts
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfXwvou3m8YXCvF
 8LU3SGgUEfbc9HTsgJkQVhKpXBhxk93WhTdTYpY79x9be57VK5orbZUSrjDd503iopOYeFpBBOp
 fiGi9Jg9FJ+1JZfZ5hTJ9AQfH5rPJ2ZBt9hCRD6P51gwLtFb4uHRbkwpTpkj6u8Ykx5HiPso4Sn
 zdUm8JrTDINFuBchPl5f/2FlvfIlYEbOfpOYf7TSxO3PSfaWyGr9RJ7c3Lm7to52HEZyYLYDbct
 GI5NBOSdDU4tu2Lq8AiQ9Z4+a6rKxF0VEx0mCNYKNKSmMNimNs0DsesXd3z9qNikX02dWVXuWVA
 5MzkuEmZU4xOoC2MQTEYa8N9hmeDlXNCo7uSTd6LcIPcNItkV55cHOzvPL3qkUJZGYfkShboX4S
 Z9wRBluyDmQ645KWwWhNrx+Fy2wFxhfktRRLhaET8UmTuCJla6HJ79+OvuKCD6JR384AFdwvu5i
 N75i8dN524+O7gvzE4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX2bhRzuVIOeLS
 iFmmW3NtkSX/5nd8mzxQoI2O4td9a4NXovVlFhKWzMDBhBiNhYEZHBKqfKnlbB1e+HCIR+1RbLf
 whJWX+w/e7hdcNnqUPcBN7jsRxnZgSo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120033

From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

Add support for the PCIe controller found on the Qualcomm Shikra platform.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index eba1b2cb30f0..7573c509d7ce 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2623,6 +2623,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_sc8280xp },
 	{ .compatible = "qcom,pcie-sdm845", .data = &cfg_2_7_0 },
 	{ .compatible = "qcom,pcie-sdx55", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-shikra", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8150", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8350", .data = &cfg_1_9_0 },
-- 
2.43.0


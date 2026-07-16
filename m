Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898BB31714A
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218720; cv=none; b=VmjRVd0vUsloiyZ3Rr58/mrCJuHwigLrcYlf+4AHhDlVO6M4Uqni7BJ+OrpLctG/xF1UboCqXR763F3rTnK6q3AXBpvplDw+DjzStWaeETZX/9s4VHxlsziHTmM5+T9gp3QJxl2rwDpyuMS5olX03rdr4fNs8GiqEnADekFDVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218720; c=relaxed/simple;
	bh=axJo0QsdmJg35RBqGTfo/6nxaHHL0FSyQ0xk2oeWY4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlKB2jDW3TXN6G3+W3oEFY2BBElBe5kk1agRtterL0U3oUBV/eQfNJ++AXwSybIffpMw8t1iJC8CGtW+9NLFgDM2Zynt0QTh2kN1Tz4yYVCvhZJ2H9lY9MjF84jkinGJIE3e5zngFACAV60yiyouVHJPTLKp8p73VbnIKcCT/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZhImFcT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TdzOILi1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZhImFcT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TdzOILi1"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJpIA2972579
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fwGrtQXZOZLHM8CW5djIH+FZH0mzGoPJDhLtNrPv7hk=; b=YZhImFcT5m2pF49g
	syOvP3NGIYqkDogY3x5jnadc1wR06vX/bkETO3PenWTUjQ+T6WwEd2ZM+IcXWgyO
	zV1UAP2Yrn+gT4ODEp+2KZmDDaQJzmtbERrwA8trGQ2hojdEqaXMbjwsph830Qu3
	plAVXxqn7AOsHEhpPkLlrrWd0g4yx5jgw2tBaWoQmDnQypSCxP0SzK1zwiH14tR6
	nutMMBFRLxuX2ZPwLopXt6oozxhblP+pc4Dubi0IwOCXAWKs67q94CnKWHjtu5rp
	gefAZiXvinNRiqrR2yGh4pDiAc5JqOShuyEJNwWNTqZpEbamiCjWs5NJj5p0W5eb
	/6qZPg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10aa3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c110a3b6aso50049241cf.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218712; x=1784823512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwGrtQXZOZLHM8CW5djIH+FZH0mzGoPJDhLtNrPv7hk=;
        b=TdzOILi1SS5+kjWpoLo0A6SdOZ5VCR4BpHEuqyyfBTVi6SpB0o/n6Jp2MVENo7ddkF
         bA2VDq6YFjrC9mg5mmNL7bb9BK8dbCxjixlo1Da6UAS2hKRvOd8UfduqshOui3ow8rrv
         ZD1dcJlo54fX9DaKDw7E3jtbiBqSBbu9+3Q4ytl/TQUnkb7df1G5bS6heBAGAyoEmdWt
         X9Voy7gD1+mKCDIDfBKFegQCdOiL9wotJaFqPOPkfa/hj9i0TPApKIBsRx2GFh18LTOT
         5pQf9/d7n5bICzRlB7NJeMnTdW7Va1ddy/nrI3dNZZND21SLtGlLrA0R0GftQdFsDXc3
         azZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218712; x=1784823512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwGrtQXZOZLHM8CW5djIH+FZH0mzGoPJDhLtNrPv7hk=;
        b=LM1ANJTegHw15ey6jnMk3bxVTdy7JSk5+p70Ux/C5Ddn0+lwTmK972SgLXVgV8cvGJ
         UITbeky8l+eLbtmqVISkDaUyLSkjaMVVPq1PDEFvEvlgcjlSVTg8NEWBudlwN99qkYsq
         BFBLc5+QORAPSOusi1jQ6/cFaLnoT7q04r+gQJJiKSncg1q2LPNqieSDP0E8C8ZDBGL2
         Y4oE2AFDj31APH+Sdiij10XgJ88K58Qb32QHmAJTSTNm2tSKQcP6q8dr+z7g1V+iJOBR
         jLMNBW5N07GHRZgC7RSXRhaE1/pwXGvHdoci58pBRDYerVi6lmKRan7BBzASPzKYMM2+
         lGZQ==
X-Gm-Message-State: AOJu0Yzk3JENR3ncio+FwCDSRzdbyP8HylhIIJs6vBdj3qt7zgT7HwJ9
	Xwh038r1jovJIhcopohuo7nUUlcs7cTaSH8YJMphOjoJDrgKGnik2LLR/bmRwewrbuzJqYK3upX
	ukWRILjt9q3ApALxodFv7rcPz2pdzDv7jvC78eM4WTLXlgYVdxYT3dOVEj4zlkAg=
X-Gm-Gg: AfdE7clCtRasBy843u3OO4cpUxc1mTV1sqzi3TNPa3OwbG5iqSvImFxVk4qVI+A3251
	3EWdHtfDBk9jI5vppUqpp7yqtods06zvhvAAl3lYKYVerX5JyFkWsLwZMVewOUPRdDJOp0e6FQs
	RtYrBCT6IU+Tgr/oxvxE7viexnhUhfGZ5pcZMBXzmnXoATvD8owQn65rbPfAMh4AAuUyFhj1c08
	WxmROoy1T/NZPOe0YkenwN5L/qx50MXCoqSAH2EVORNfQSxq7rsmE9MErOUdDs/Pe9oHCcsukrt
	gv1pVvpUwJhsgHEieGd9eNy/4Hw8Lyo4VOD6pk14NcMCEQz996aijK6m6EbL37MjFBZrxxS68g0
	0S+ymBFz/Gpde87ApglMMUn95dfVaVPsQpVaajsN8wOAcMgoLHqD0xRYlbmMfI2IYLUVO0PHOwx
	ifNuveNwTyxvxfLoc6+EF9wIRUaaeSMZwEUNPTa9JLPvN0tD9y9Cc=
X-Received: by 2002:a05:622a:248:b0:51c:257c:8166 with SMTP id d75a77b69052e-520bcdf04fdmr2656411cf.33.1784218711294;
        Thu, 16 Jul 2026 09:18:31 -0700 (PDT)
X-Received: by 2002:a05:622a:248:b0:51c:257c:8166 with SMTP id d75a77b69052e-520bcdf04fdmr2655801cf.33.1784218710638;
        Thu, 16 Jul 2026 09:18:30 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:21 +0200
Subject: [PATCH v4 04/11] power: sequencing: pcie-m2: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-4-9b02e6f549d7@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: d8KlafrqzI9Q9-ZNOEJFge0kwLcYDD4L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX+Y5kYN8C3NRN
 00/997D/uNxTMtMuCpgy3yrrJXgUdSoJMjm6paKZVEQu2E4CbHPizZetIyz/x01z6S9oispymy+
 rWA6XaS/k0H9j6ofJ5ElbZjnM/YqyfT+6TflRAsn4Zm+1IOd4oeubBKApu1F9VqodeX9WzDL9Hu
 DZdhCLGo/7DwdKbh+xKg+4YZuzr95irajw8ZsNgXHKJvnMEO3idWkO3FWgCaknR1r1T7aAkhLHP
 +k/itEd5w8GsELHb7hvrLB4Wys2AZeX1+WC3K/+qt5y+EFrgMWMY2CSV280ybkXTEpnvVVyhEPD
 1txOKEZRh3Ssmg4iWOJkOFGz9JoZcck+uZTjxWN5SrwzA1p9w+AUc6dGcMUdOP3PZN7a34H4D3w
 82MNWqOH4LRNBRWqzdMoVJrs4fQG4PDnGH892Qe/ZRnXZamnEqRZdXVm2V9s2JfP0ld5QcYK5k+
 x1LSu//yD857urjoFGg==
X-Proofpoint-GUID: d8KlafrqzI9Q9-ZNOEJFge0kwLcYDD4L
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a590458 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Wval_j7vKiRkorSqWqkA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX0YCebBiDfrfa
 Hpkxc/fJH+g3VJB2g638WEkqKMnXKJcFy02o6Iumg2v3J2ofWtMu9rQ6ipcOiqRML8WlTg47fEL
 LhUTmRAMmfS9Vuki+QJOAxbI+DV/3nU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160167

The M.2 Key E connector gates/resets its functions through the
W_DISABLE1# (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals.
When a signal is not routed to a host GPIO, the corresponding
enable/disable callbacks are no-ops, so the consumer cannot gate
or reset that function on its own.

Implement the .is_controllable() callback on the "uart" and "pcie"
targets so that consumers can query this per instance (based on the
runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) via
pwrseq_is_controllable().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e3ba9169144dabbf0c553c0a4302c3b511fcaaa1..8e4cb778e31f66aa171ad9831d4213e17d2e6145 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -84,6 +84,18 @@ static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
 }
 
+static bool pwrseq_pci_m2_e_uart_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The UART enable is driven through the W_DISABLE2# line. When it is not
+	 * wired up on this connector the enable/disable callbacks are no-ops, so
+	 * the host cannot gate the Bluetooth function on its own.
+	 */
+	return !!ctx->w_disable2_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
 	.name = "uart-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -105,6 +117,18 @@ static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
 }
 
+static bool pwrseq_pci_m2_e_pcie_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The PCIe/WiFi enable is driven through the W_DISABLE1# line. When it
+	 * is not wired up on this connector the enable/disable callbacks are
+	 * no-ops, so the host cannot gate the PCIe/WiFi function on its own.
+	 */
+	return !!ctx->w_disable1_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
 	.name = "pcie-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -133,12 +157,14 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
 	.name = "uart",
 	.unit = &pwrseq_pcie_m2_e_uart_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+	.is_controllable = pwrseq_pci_m2_e_uart_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
 	.name = "pcie",
 	.unit = &pwrseq_pcie_m2_e_pcie_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+	.is_controllable = pwrseq_pci_m2_e_pcie_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {

-- 
2.34.1


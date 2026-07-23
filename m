Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632203A5443
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835334; cv=none; b=SXG3PzF6LqXgGZita33YCurCMHR50v7p75bs5SQbmRNLRvLVM4lM2oHNgcH97oyK12HcGBu/0hPzLUAO3cOirIyd8xSwwCGhrStKus0uiITwvh2gSrRpyVHfb8KvoipSzhdu9zMuJihodn1JVXTgoavXOVFH2UwmK1vPG2In7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835334; c=relaxed/simple;
	bh=tJrprejrY8l1UjpwCqwWq3AmQAd9qV4z6/2T7isrbJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dh3ITRpW5rDEvnQ+plNe9sXAyTP1l1Q04JamR3rCddgIixHHkeMojx6uWI6QWUSofwKkXaoiLLjXO8Qo4jshW9tioI8CXu06ALuCjMwH3tYHPSCK8MLA2Zu/B98sn0ndDCgUsE3pqvuAb5uS4PzDl6iANVPpYPVso1ynD+QWfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SLskVY3b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HexXJxv2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLskVY3b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HexXJxv2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NImAGc974742
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 19:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WrsIEgKJu1x5XHgLFDMvH5f6iCy+GXxJv6G
	sh8HHl1Y=; b=SLskVY3bD9tCsh2BB8/4Af2l1dGMsK71yWo7RNgzzjOZFp919ne
	ywb+ZYPbSsIx1QxLadmYubu0BtkxWZLczRZhYlNvfU2mxshGaC/Oav8Okej1MVa1
	izZyrSB9LjPugbQhI3skqhTow7ohpnaGP+eso44maNjezivr5J03V4gQzR6VAEqn
	vYfrEIdXf7xV+JFY40NOuKzDg5jSICUaxbugv6p+OjM/d687d6yVYYIDZqnPNXX/
	8KaIr/2CDtrgB9SWTrosITTugKDYnuDSYJ1uAELj89zYwsW0xYz6DRTphY5e+GeS
	9T8fqqxVEdDJsmynfUzQenNEsjJSSAGYFIg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa08gxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 19:35:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c12e43b98so20644571cf.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784835330; x=1785440130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WrsIEgKJu1x5XHgLFDMvH5f6iCy+GXxJv6Gsh8HHl1Y=;
        b=HexXJxv2J+r/X/lSxWuoi2lcU70sjnQoQC01jMQSWFZAJ/WTP06KEni7C6RFSXDT6Z
         2MAvJhVO769IvYbcjsweQiwA0ceiC1rI9xCZa6qPx2QNsLO6U2hef/KLedamSi5rja9J
         Bld9C5pethCBXsz6uXKlK3zW+B46U6ebNdhbvqpr/PSgbWj01WTwnGCQw8CqKZ1kGsw4
         nIEEU7DsHiGvIiREF1C2a85Qm0KuSlu5mvgw1BkDr6PcrIQvgpJ5r8kIi7UcXjE9ln8B
         87hH4ONJHHEhLre5GAQnImbllFKZkqdaI6ENPP/4SRShcb9n8FIAaxHR9faMsX0waU1h
         MNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784835330; x=1785440130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WrsIEgKJu1x5XHgLFDMvH5f6iCy+GXxJv6Gsh8HHl1Y=;
        b=ey03YMz5Qdg+iKRwiaNSgzWrKY67qCpMJDPVaowvdddZupBxLNR0QwVCWxpN0A1MiM
         XyINQ15wm+NcVZ5gWbNo6uQH2J8dERl+nMjD+izu482J1bUdtcaCOqTqAGFyERpI9aAl
         44fFOej0e+SpH6FX+f9mt62Ztav6YBQZ/DcgQMf+vP9yC1ydCa4Sar74qiQZlZLwG/iJ
         +Vn63fnPnYxx1IvyqPzFWckEhhscSk9NnRXpqSPs+iViBJtybhZa/2FoN2SscdDvt2zD
         d0SdxmSxTaLAkbVe+u/ygm9Vh99pgaiN8XnLh6ubi9velUJOM0ZKoDeLYrc7xddAQhs7
         bpaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpghlJSK1Gl7HVWZ1lKXKPThctDe7i+8SlAHP+c4OWiB1Gv2m+n8q2gCkedv7d+3DQPQj2ugh3F5o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeXnVv8VPtdlOxBZEWcMDaH/iIFNfE+wQ8T/JyMM+l6M+8CLzf
	BFKer6ps0lmu0ecwK0W9TJaROpIv2/AUnE1iM2DGlAuaRk5SMjMvsgcEMwwcQWQHjAxqNcTW5wG
	+xf9nZSNDx4OMeH1E1ZbywNN26iwSb9XkVdWlwISrQk5jcCzIeTmwHVIZO6DQr+x7iA038/Q=
X-Gm-Gg: AR+sD11svescFaniL6W8KlEBqPmCxchIcy+tXnQq8YoshEKkTYED4zqbXYnNfNQvu6L
	Xq45Bs5QdXfvd+yigko1aE44v4BM7B2c2TD+fXey10m8LZMK9cvUNvGr24w03v2+KIFjIbqEd6S
	CiVTXcaflKZuGmWBydiSBGoj8t8p+9VpxRx6TZO4B/LgQDklmZxkBZ+eSCSSk83UD5U7K+vLffD
	bQhn5gQe7aJ/o2tdzHAH2ZJiwLqP5c6axMoLXUCLbBHd679aJHZ8isKvOly9nUbVNKSWZbjPNeB
	RzEVRbSRjGsZUdB59iasnndS/W/Q0IQsmBxGIiEQlbgV4ME1iElFzVrF5wVZTrs4kNhDxA5aCEa
	VIPlQIeJXmRU0KTbI
X-Received: by 2002:a05:622a:3cf:b0:51a:8c9c:7f52 with SMTP id d75a77b69052e-5283df78e0cmr41422621cf.69.1784835330237;
        Thu, 23 Jul 2026 12:35:30 -0700 (PDT)
X-Received: by 2002:a05:622a:3cf:b0:51a:8c9c:7f52 with SMTP id d75a77b69052e-5283df78e0cmr41422321cf.69.1784835329705;
        Thu, 23 Jul 2026 12:35:29 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af914a9sm14828835e9.15.2026.07.23.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:35:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH] power: sequencing: pwrseq-pcie-m2: Drop undocumented QCC2072 compatible
Date: Thu, 23 Jul 2026 21:35:26 +0200
Message-ID: <20260723193525.319826-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=tJrprejrY8l1UjpwCqwWq3AmQAd9qV4z6/2T7isrbJs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqYmz9QdaqlWb8r/Apq0oPwaPVc1y4dSjT0IDL0
 +8oGZO3zrSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCamJs/QAKCRDBN2bmhouD
 18eTD/9Bb5rCRFSpgabqLKfHNZvx2rEm12Wlcb7bj8/u8IKnxyRY38DvkM527kXtdlxFSVc3nCE
 9AZmkwPJXeRSwVVZPqOGOqQn57jNiPWGo/r8kZFHi0qdSusexpTMXTdsJ05DpDSEGqenHqxJD+V
 P814eo4uMrUd1fH+s1XVz1cNb5SSS/v/BIFqRWh06QWKpN1mhdr7I0vFs78PZnjQgaEYgtSbH2E
 vspHRIfnSw0lcLz2WRb7Kmf8FGTQce4Ap+Plrv9jK0mCPtWmJRMwRP1NONNNaPm1UGjWkrpWVnR
 ERRTUaS/Nfn3XA2mo5/su1bbzbrByrnQIgZPDr1nPDPti2GdQAnBm2ONYFrhfkzzItc41ApxITL
 U82ML7A1z2NcX9ipYWD2/QlReEsrqJIil2SHykl8+DkQD3Cga3JURKDosrwe2cyW2RvhkQhgEpU
 rUWFM5BuRNcUDVPoezXJvhcjZ0PVI/kE95HNMfq7f/L+njLYvqCm37N7TreRm+wFna1r/pZA0kQ
 cCI1LgAi4VEKgwk168lIQWo4SxjfCeiqqn5NhzFX8FF4uogT1E/TESDDEcl17MPMA9l5Gkz8Su3
 ekA9+paThrFmZ4I1jkzQrrL4rxT1FCRf/oL1LX2xt5Ido5YoHoPsH01nmwAPtYhxxikDBxzyQOH 1psyDM0F2iTDl3Q==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: x4MC6FHx3oawrCL0M5xgrPokKbEpi24-
X-Proofpoint-GUID: x4MC6FHx3oawrCL0M5xgrPokKbEpi24-
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a626d03 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=QUvU_t21zGBOGVwEnL4A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5MCBTYWx0ZWRfXw7/PZzy7npX3
 6E5HodwPT3aVcXo9urT/xRIvF3ULTP1Mcnd2XPmmGaLI3cDGGix29g8067zrGxDPkzes7qBOWh0
 IdUIQzkMC0TokF7aJVmrtEohYuMAbqV8RtjaH4Qq+HmRCyB/25U1VQdH/UD+dq5rjhyFyD35zB8
 BqsPDeAfa5PAxGmTb/HCvptuGTayE8peyT1EeSjYJwGcIsey5889Ta4ua7SFZeZzA4IFO2sHK7j
 JXZpURFQTqotdjD6jjnd3P5VfpTatbbBbKSO0rd01ROPY7b1cm5THH0R/sD40Auc8tpvdKF/U63
 mzGDrqDKBeaJo6l3Zw2cpaSpHvv4GD18FNOgheO/WL+0/SM4GTcbwFb2HagOpSTHmtVJPc06nY5
 xqXusyjqwBidTBiORONn8ns6uejvSiy3/tV80DYSjgc9T56RM+7ZEoUEHN7aePB7hhtwOEa2Owo
 AIuOESZ708Lbbr496vg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5MCBTYWx0ZWRfXxVRjhYo7dh7X
 QsSgRaBYgjwb3px1luK9okea/eLfGWT0biWok/YQl5OARVQOGIarpwdc+ydBJUMLjeBpwhfkDDm
 n9PObP+0IkZ1UxcFDkH6XjVV7awqg4Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230190

There is no such compatible documented (thus allowed) as
qcom,qcc2072-bt, thus it should not be added even in driver match data,
which later is used for compatible matching.

Revert commit 162ea02941a9 ("power: sequencing: pwrseq-pcie-m2: Add
QCC2072 BT PCI device ID").

Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 83fe6a1396bc..168e915f2c89 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -195,8 +195,6 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
-	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.53.0


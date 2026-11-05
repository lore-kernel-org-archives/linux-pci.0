Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867327;
	b=ZaDwoImWZaKNOnNV7zITOo6ZtXAD8eSITpAoLCjlH2ow49h1R32cF+RaI6OvHCXWQhAQ
	 Fbhn6EaCjClKmqMG1ojhxqwS5dcxUWh1dvwE/BkMZoM0lXuPxg0ISl9yQ/nORxzjKENOV
	 Q07jXEkM8SD9U0VBlXdmuj9MPqZq6wMtrZbBboW82uskan9Ik0mGC9uliFGdVunadRTZb
	 HZ+AmQEMfAWGoYhfPRg2BjH3WuNqYnfrYyKPql0DrKvx+za2QETsNs+VmXYfxzUxLI+zH
	 h3ExZKqqveobLHeJuHCeqRJuPbssP4wpWS91SNVEqunwB1mugGZ8zyh/QW3VdlHJnvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867327;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8S9aOO2EEWm9Iuhm8V4mTtS5AaGJ3AEgVMfCGPAWGsk=;
	b=2lkaKF8oHyNZsQyhNwfzQzE1Ikme2C8HnKwQ2QnKFga8f+T2NFZeH8j6T+FQv1mMKD7U
	 USexrTjyQ/sSCDena7Tq52qiO5oS5oVsJzcutny9QM3Q2tdrhJgzPJtUTrC2SkenUHVPm
	 ZHMl666And2KWAN8z5/hn8TWsXtUSHLXDFCJ6qKcP0VoSn2/utFEHQVtzHEA1uYU1eoyT
	 /HRtptiTCCGWjB3FOsaSVH5FOezzdalnt5sbig43L7SNevxGcPuCLsZs2Y8UHNUyuk/EX
	 PgdU9IQUhi64qBXMaVHvE+TR6+9sjdHNTjg/ZrPXQF58e1Notw2nI6MiCLVeM/Pu6Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pm9BRPCQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VQwlpjw9;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575A606A330
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 08:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9575A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pm9BRPCQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VQwlpjw9
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56ToCR4138150
	for <linux-pci@vger.kernel.org>; Thu, 5 Nov 2026 08:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8S9aOO2EEWm9Iuhm8V4mTtS5AaGJ3AEgVMfCGPAWGsk=; b=Pm9BRPCQ1BYidALm
	LITCB/+F1RLv+O51ejxPLuA8bqU8QjGIHkhJ82XUyUrdzLA5Ra6COGHB1S2E4QIg
	SWEm6Hk+Gv/rULZ1fFZ3Ypmckd8fWA4qd3VUEgLfsWI2VDWO1UOq8xip85gRIhjA
	v6LIwoONco+x8HzFTEtCgdekE/cl5bGtlkH788JGUQC2fqmwyPLEg3XdYMqKPB9S
	zhS+H3UbAYqIbTugXEKI/Q6DPmOuZIklqVWULQakLZRhymnyNb2Qr3WbL65F0ZDV
	JFsW5D6F/lfLtSyweD+gTQZl23GmD4CINf+UsRcoj5bqENP7mfIQ/NgXyts1cELH
	7FJsQA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrm9v0hkw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 08:28:45 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7d06f3784e2so429423137.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793867325; x=1794472125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8S9aOO2EEWm9Iuhm8V4mTtS5AaGJ3AEgVMfCGPAWGsk=;
        b=VQwlpjw9VjKkicY3K9BUWO0GqcprF1EDRK/30IKU9FZzzSZN/1ci1EExnUO7mU8HGL
         v4M5XRHvTMQEMQMaGjNyw8r8KeauNYMnfQkFUG/a5gYZcfJ4JAyUrQ4WLx4PoCucI5+g
         Mmu/l2znoMJgxNC5nmta+Vyjiy+RAZwmnHIouDXCSXrT0ESvWRwPmgp40Xoh2ofoJLIb
         /Vka0f5iGAT9s1CvWvlDJtaVZj5NCmrdy2XYi+hiQRTd52koEgD5y+l+Axf55MycaZl0
         DVtZrcBIb6Fg7WrWVs4Y88uGiZ50Rn3a6oOX8XOY8tTDUhdNY55z4TsUBOjFtjfmaruK
         dWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867325; x=1794472125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8S9aOO2EEWm9Iuhm8V4mTtS5AaGJ3AEgVMfCGPAWGsk=;
        b=gtBUpYnTnmSGiUf9xCWxNfeiuy+TotoUi2lnBGUbY5OVIf4EzOHDWtfrb7JvIZyNn/
         CA0Adp9EPQl/4+q11UjZll/lm2c8Awbmwnx/5LXU/NzVPLmGhJm9HdwWiXCjjMO7V2wA
         HjM2OmChTOcYQuQJhBEOGS1IUWXfyX+b2jmiDT8phkoB5YJTG4D215o7yDCHta+3M7UC
         iPws3FXNf1nyPdIjxR76xxA1fSjzEAw1j60LbdoAb2Q82EMT807aahLXouQpROqX90fd
         Xnuq5fiSki4O38pcAimPewQ11+FbG+lDfFT0BktEFqKnz6/l0nBI4BJDmBi4MVtIOSuI
         x9Rw==
X-Forwarded-Encrypted: i=1; AKwUvBzUzWfg2fSGEMXcwE4z3gt3AYGESu8Nlpod05lx8WAgll1sX/Nw2e7ywOB0sSQ0KnFSlFHTuf2931A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WKFRNSuhluDuoiY9LDV2TSd1UFe+m3PBxbDVl3v/IS/Rb2wPX
	YVDZD4Bazn38hRDaLZufmNr0Ov2ZfC5vHXh1c4BBc8oX9/IVp1SsDo8avvvDJWVAqsxcx2dG0Oi
	MytbVUFx5pZF7lqpk82BX0xGKgWvvELn8DBiWM0wvPm9/2IxOqkLGO7RkIJOPHOM=
X-Gm-Gg: AYBFou2lej0Lx83qGPe3UWRzlsE1QgSbcEBAFEFoqkhFRtroKKSgnvvO11g71FmVYKJ
	sxmARRlAa8m48ZqzwwALbu7bX4LICNh7jTpg0pl2hFzSeB0h/ihE4Z9wL7te9iItkowYWgOsr76
	VS4FbSfbVilrpBkKg5jt8S5Q6AjORvpgOH4Xcv7y4kSgHvKp01cH5RkGGeE+zurbGkPJTg8WciS
	41UMKqVStPs+m9yi34nGClYzCbw0DSq93hIDFG4sCX5shhUeuiSMEGPtyt4S2fcScovPju5EJr8
	q7S120yKeuXZM534NM5wM6S3mAJ6jXBQ76sbJ90qaa9Zjnm5lhr5cPx1PswaSWUQrsBjeDK+xyj
	hsjRMDe9pZrVHObNrY33fQa9XC3zMLnoWV5MCAaNt16LniQ6GQaIYwuSNAevMFPscINVmPWywNq
	OC5A==
X-Received: by 2002:a67:e106:0:b0:7d2:7f93:7708 with SMTP id ada2fe7eead31-7d27f9383d3mr1921422137.8.1793867324821;
        Thu, 05 Nov 2026 00:28:44 -0800 (PST)
X-Received: by 2002:a67:e106:0:b0:7d2:7f93:7708 with SMTP id ada2fe7eead31-7d27f9383d3mr1921407137.8.1793867324353;
        Thu, 05 Nov 2026 00:28:44 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed55249csm7406821f8f.35.2026.11.05.00.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:28:43 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 09:28:36 +0100
Subject: [PATCH v2 2/2] power: sequencing: pcie-m2: use devm_mutex_init()
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
Message-Id: <20261105-pwrseq-pcie-m2-uaf-v2-2-3e1dd415af9a@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
In-Reply-To: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=VZh8aXZyr5sjhB5ZdfUSMMRl/sDHEV/BJMlTnMg/j+o=;
 b=kA0DAAoBBZ0uy/82hMMByyZiAGrsPjbIo3riAGok+LWsCI6ouC8rZbClyzAiUTPvBICS+BIxJ
 YkCMwQAAQoAHRYhBJHlEy3ltUYde6Jl/AWdLsv/NoTDBQJq7D42AAoJEAWdLsv/NoTDPwcP/3s5
 41gXz0Ap6CofQJZghiKj9pkfEgS+Tu4Fpv01/qreaYxl9RnkIL/RHA/A528JlT/HJdumv86o+vq
 bfQckiVjjflswftkCBBZKLxBMUJeBb6yrb+GNxIkKmRpBB/RI44L8usDMLYwWxfpcylW0sfI2In
 iezZWx06H05otZCwm90D92UD4u8tqx+3Mh7hBQ89KR9Q8Z+xjZ/P6kcDnyUbkVYJXAuBTda6l7q
 irETCYuTqdnr9WcUQS0KZ3sHxpTvgOlQGhSP3zYVXOwl3/liUodMrNlJDhTxPTA92fnt4iRqZJ9
 ZBoIACPzFEQSmLlvJJg//WFlc/ZWaUUZRpwCxC1DbRAd1aHJSnPr0BNbhCtJ8J+zcLcqHbOzc7Y
 NLlWK0t/nkj+K3/jzlp95d740fgEgqwssbBYoznurQQ/CS769dfXpwlkv4G/lckm23IH6M53eOV
 hKreNaMprWrLbk0bg4vZgF9HhmE4wCoW1D0l47lyRHYx9Uc98jfWJQEVly5F/bSiSAjlrQtArhI
 BFJ33TDSn3t78DlxMJw3A/9G4qeDHrYmsd4FXPBybKjytPjM/zASQ3p94wVEr4jPNyf7gVhaw7D
 eucgsTxuS99axiCU3LM/nTDyxT82bqLTOGNDbbZK1I9tKtpmla9yWtL72bDzIIKxaAV6y1VPip/
 39sOQ
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX7js3LffM5Qp/
 HhTebt9Qc9Bi/o97VCUuUQSA5TPhjn10LGBocH+ZbOUiqnfVfaPciYRLlrJN4965UyPs+ROJpad
 rZePoaOwxYUnsKXO6woIoB0MMdVSO/k=
X-Authority-Analysis: v=2.4 cv=KrHYSmWN c=1 sm=1 tr=0 ts=6aec3e3d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=biZV0kq_lYyrW_oFkQgA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX8NL2SASsFzgu
 vWdF4XMvHkP1kvSo+EOTS391pS2N2VZmsq3DkZJdu3Pw8RqiqW/N6JaaXLmaS6Fzpcd+gEZwCzi
 32DySBIGtbfFw+OPsJzSspWCWMwSLLArcZpPlJoiky85SKtnF4Cg7D4wjEuca+oB287YDTzy4ti
 jqCDc1Gpskqa5CPRcqCz6NTkc7Wwi2XV4s8EWC5E/wW8pNLNtJME0G25A31Td2clyNwbuRupAnP
 HLiQFJGV91UVe482Oe82eEq3m5Z7ablPgqtWoCHNBJj8rIq/ERDORiqv/B/7vEuxtCWUTmu5XFz
 osBge5slBXxx2NKyhkqKXLUdJI10eJxDqDFC+FHUeKNUrYTn4hkOqhvm2Z0fuiFrGB829LCv5kg
 JYODQ26Djl3ly6cJNl+PLSqJh+Enp37n3UhqRQ3QUV3/VOEgIzz56yQ4mlg8cpnM2O9/i4xVBMq
 npteWlIHCzhas/IYrWA==
X-Proofpoint-GUID: FwoAJJbswr-xyJsJ-5xUpy449x5q_mUr
X-Proofpoint-ORIG-GUID: FwoAJJbswr-xyJsJ-5xUpy449x5q_mUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050033

Shrink the probe() error path and remove() by switching to using the
managed variant of mutex_init()

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 60990760287fdd51c29ccf0e3b97a244669e4837..4f283af8b0147a3eeb322b777f5e52e7d1c3d753 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -596,14 +596,17 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
 				     "Failed to register the power sequencer\n");
 
-	mutex_init(&ctx->list_lock);
+	ret = devm_mutex_init(dev, &ctx->list_lock);
+	if (ret)
+		return ret;
+
 	INIT_LIST_HEAD(&ctx->pci_devices);
 	ctx->dev = dev;
 
 	/* Create serdev for available PCI devices (if required) */
 	ret = pwrseq_pcie_m2_create_serdev(ctx);
 	if (ret)
-		goto err_destroy_mutex;
+		return ret;
 
 	/*
 	 * Register a notifier for creating protocol devices for
@@ -611,14 +614,7 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	 */
 	ret = pwrseq_pcie_m2_register_notifier(ctx);
 	if (ret)
-		goto err_remove_serdev;
-
-	return 0;
-
-err_remove_serdev:
-	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
-err_destroy_mutex:
-	mutex_destroy(&ctx->list_lock);
+		pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 
 	return ret;
 }
@@ -629,7 +625,6 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 
 	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
-	mutex_destroy(&ctx->list_lock);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

-- 
2.47.3


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843527FB0E
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754415; cv=none; b=XgQ86ZEc124TBKYFPsXUpdPDuRLKfL5ltdteW0ROsJsuwl/CKhbMgwfDrnC0EjLKk3EkLg7KCp9gzHci5Luup01Tm3fvLgX4P42UmfSjnC8GN4ZVZvenF5aoql7PfO1o0wzjEE9o+GSwDkEauHbWjeWx2/zWl0jE2nZANwWPKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754415; c=relaxed/simple;
	bh=ov8hIF8M1z6R9wDtFRkRAkC1i3judy0L71MjXuy8SHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6f04VgDrkOC806m9WfPBcXdDqtUNxRhZVb8kg3BXgOEuQWzG+2S64vxJQpVfrOYxrRUgJIhhXtjMGVMWg+ac+pejdnrX3v0ewI+TLvBiWanYwQcKsPnnYqkDkqlZze1rVXuKPP+S4BdbWYRJMgl3ovri3tJU2eFBFfOABqW5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WviHE7c4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h/GWHjuU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WviHE7c4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h/GWHjuU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HAjwlM254242
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wClwdHi//EK
	ovApGGp/o1/cMKxisBXL2sxG8w7zO7Fo=; b=WviHE7c47v4b8vtDxvJ8wLNIoZF
	wDW5J0+PHQkkFtKsjRWL3zkN7SZtLJ6uZGuM1pjHLf3+EQbVbopONeHZHLTeUtsW
	ypqItiR0/MKI4R2RNqxreyLF/+GuAYYXjBxFsHE8kuPCyBJ1tuKJpheINGAwEF4r
	5vKMn40mnMB2FpSfLO3eFPO0H5cBGJbnvf3N72eXOzQshVmWE0VGoCZknvu6D2ON
	eyqUvSl1Gx8wnL186Cueb/cKbzRTcN9GDK5DPo0+9whQFGXfNlmvg7z95qzQdYdW
	VBUM341PVCfGFAf7vc6iOc3Lu7MP7uExqa1xeQxE9VTuok1K3Q7+2fz+hbA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy5g8ghmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:33 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89c56a7e610so67012656d6.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773754413; x=1774359213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wClwdHi//EKovApGGp/o1/cMKxisBXL2sxG8w7zO7Fo=;
        b=h/GWHjuUg+QQjmvgrh1P7sNotuT+FqzAnjLXcYqNnOIUEHJhNQJP66BfFGpNBsrdIx
         oip3R5KfOcJRjdZD5ArsWXXNUvdUgs6wqv/gn9Fg21rYddkWTQsT/xpwkCoukzMqylaa
         B2s6dDru4QNg3gvFI4WwC7p3wGXLfjex5AozncZIMIUpIfC7Abe9TbP+pTXEginb7/zs
         ri0mhZgs8evUpQLlaWnaTu0DHhBZr4EB0T5wvaJM2BuajYehpE9a8eXH41wAFSl8hPmY
         EUrsPdI4cmWVnOzGqf3yZ0G3HIXe9GKAAqmqfbwrgqMXVSq1yuZVPsHPy9JZZ6nzVsIE
         J6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754413; x=1774359213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wClwdHi//EKovApGGp/o1/cMKxisBXL2sxG8w7zO7Fo=;
        b=sknfXui5Cy9AQuHSC63oMfLRPxjgUgzYHhuioBiD0MJy5ZVM66KdrILFekBWcfTrJA
         OmzUstEz3+hKWhLXw5F1pSlwOGcHSJISlnbdo3Hm3emo8q/fBVr3p0IxU+Z30dWvcORR
         Plp1dyv/dERYeQKJaLYO0E+NFndgKlQTmH96KmBqqjLzkWpzQZJnCT875mCWsqcrEtlp
         Fj5hqSEk78mkTNKKQjFY88biQQlGPi99F3NXkhFURxnWBVFI6QalYzkNdclXGX4BfY++
         q8y81XE2fVvo8RGRBXWmPbgenv7Q+IcgNtitU0fFHsC4RsMJBTRvv0vwyI/qe16p2Kw+
         tqLg==
X-Forwarded-Encrypted: i=1; AJvYcCUtmSmuwcUFg2Tir0zbfMAGhifsBH/Ve9h97rUooeQuapJZwMoUQ8ms7/1rdSKG+hKy1YYWMZpPJpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvVS52Kkfzk5WLQyN38Q/7+0//Vl9pt2jW96I97QgmOlda4PS
	FWUjz86wwlQow/daGYXrhI7MzlpHzxY5khJ/izbV8TCPiQLIPd5SMtZSRPpWY8H1AsQqG6yAl/l
	NhI3fJGiACW8EWaNZbLBlSP10qs4Jz2zUC2ZYpSHBCWIFXZcVTbgQjZQG+5CAvsU=
X-Gm-Gg: ATEYQzzpn8AxPpYOgWP1ktL6kIQaiAu5A2xoXBTlcqKnAJ4vVsDYFB73N31rnJuaViJ
	NcG3S6ikoK0f0Q1V5DKmhCMGWZs2UTCZPGw01792kcKedCipF+1efs8vmzu2tbV1GB2rpVrmp+G
	bdAbTJqXb+1zdifDL1s8MrqODpq7uLlQ7gDd4LWxXvgiK2EXiGZ+RKRmVGV2GAaRc0dzGj3MCZ5
	wSj+BqkUqbXTJbRaFr8EOhzNUCEoJpFSm9BcE/crsN/zwD7Zeq6LVCR1YbZbt6YaoJAMvhlYn2d
	G2My51KBf4miV8I2jb24HeG5nw2PN2MLmpgYMujwY05LOgeq26qTFlblxt1xnWehaj0gWPFTYM7
	G3zn+GCbYRHEPf1H1cNNWQoWG53j7rSk1gvtP
X-Received: by 2002:a05:620a:4415:b0:8cd:c239:12d6 with SMTP id af79cd13be357-8cdc2391360mr1562498785a.57.1773754412715;
        Tue, 17 Mar 2026 06:33:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4415:b0:8cd:c239:12d6 with SMTP id af79cd13be357-8cdc2391360mr1562493985a.57.1773754412127;
        Tue, 17 Mar 2026 06:33:32 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm51358613f8f.4.2026.03.17.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:33:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 2/4] PCI: mvebu: Keep child node refcnt for probe duration
Date: Tue, 17 Mar 2026 14:33:24 +0100
Message-ID: <20260317133322.266102-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=ov8hIF8M1z6R9wDtFRkRAkC1i3judy0L71MjXuy8SHg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpuVgjxjL35h3b9GCXehstfFtvOosrOCx8JxD2V
 bgJIU/Bh3aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCablYIwAKCRDBN2bmhouD
 18tgEACBChVuehaRRjXAcrbdPTAAOq8QiLCEu7p6Pr7DdrcGnP96ZGP6kQRDGpNuLliO0VXS+yR
 jNn9sk6o+QZGrTtyvblDWjoNzUVg1prOXD/W8W7Bry9CbI7qYGRRiurn7iXRM/N1+jM9CBgkeuZ
 oyAMsnTFxY4y1mejiT6HJHuhMAGiE2DPMPCiW22FUkHEty5cDdGNg64oVzKdjjgFVIEOl52mVQe
 n+gfhwwGT0ymaijzo+fDLlae47j31+DioYBLirU3ZNoUCRfYShYjCSm7wVqq1G4HTEVJTTNHHzn
 xr8b7d4BK0GKo0W6IqD5DnL/lDkb0XcENij1mjljbeBd0A/E6HD1CpNpWdLyMuZjCCwpACAjTum
 cXCmlQpySC4nsMjGvAOhmfpQzDYR8XAW9R4fGlezSXROFZw33Eifcmd6yL6PWmh6KIqBeAJIh97
 3ydvTovr/VBY4XsM5Jv6WNkJOZ7OyvJTU0YklLgXfuPQHHSnzzseaAer8RfmKF83jNJeu4lVVwI
 hBYIbU7FlkxAX/l5h1h8upvYM3lB77DeBdfScFy2FYWFg3P6J43T0yEoNfikkNGYV0jBXmzsSfU
 3FRhfSjASj95faSgWbmZEahgvCFpZIBzGG+/C6vtU40xTJzA+Ye2HMwtKyBzV3s4sq8YGw0PaTm zYDaS/53uZbqY/w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hR_3Y2FZMlApz0YTIdc_1AAjZ_JOWZf8
X-Authority-Analysis: v=2.4 cv=EeTFgfmC c=1 sm=1 tr=0 ts=69b9582d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=pABr9VbpVV2WwmlfmZwA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: hR_3Y2FZMlApz0YTIdc_1AAjZ_JOWZf8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExOSBTYWx0ZWRfX6mxa+Z7tFHOc
 +1woErrYosCYxCxu2tPigYUSSYutvD3G6bdBCtuE3/Uwyn179cB+1wRe6R/M4WxUryYiO1xCuQO
 3LC/dsrTGU3SXnhqVA0UzfoyM8giw1f/jexsU92gdlz1/V2d3K0F7VlByk2RmCtVK6Y9XcpeBCL
 50pnBPHdg/SFylcezHPHRn7SqxaTxPA4NRQUur93iSibwiPl5DMrTRw9gPSU/jUvM84ZaJqNxT+
 rytHQfugYZITiNUXC0zrm2XcX4ljrXZfEhKS4MTDA9fXi6Z7vPGeZGgbag0fMuowCZa5secRTp3
 mEh8Vo3yXA30fB++2R4ZtK4C8QmIsXBaYouRAHJAhRgxU8fgb1T/UwixwmpV0u6C4bBWySX3qah
 EPlqL+jdNroRFyod7xRRLZKjDvTa+D/xUxh88L/5MsjOqxApXrrz7bf7S0866S1cavg8AAEcxVL
 YzVFnWfUGVm9HBAOztA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170119

Driver in probe() first iterates over child device nodes, storing the OF
node pointer but does not take the reference to it for the remaining
part of the probe where it is used.

The pointer thus could become invalid if children OF nodes are being
removed from the Devicetree, e.g. by removing OF overlay, while the
probe is being executed.  That's is highly theoretical issue, thus it
does not look like bug with any effect.

Nevertheless, make the code logically correct, so acquire the OF node
refcnt for entire lifetime of the device, since the pointer is stored in
each port state container structure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. New patch

Note: Not a fix, because practical impact is absolutely zero since
of_node_get is a noop.
---
 drivers/pci/controller/pci-mvebu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 4d3c97b62fe0..7fb9c7393588 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1236,6 +1236,11 @@ static void mvebu_pcie_port_clk_put(void *data)
 	clk_put(port->clk);
 }
 
+static void mvebu_pcie_port_of_node_put(void *data)
+{
+	of_node_put(data);
+}
+
 static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	struct mvebu_pcie_port *port, struct device_node *child)
 {
@@ -1482,7 +1487,11 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		else if (ret == 0)
 			continue;
 
-		port->dn = child;
+		port->dn = of_node_get(child);
+		ret = devm_add_action_or_reset(dev, mvebu_pcie_port_of_node_put,
+					       child);
+		if (ret)
+			return ret;
 		i++;
 	}
 	pcie->nports = i;
-- 
2.51.0


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CC3F787F
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818937; cv=none; b=VCjcUoaI2JcrmH4m1V1Tszq4qt+xAfTH/y3+Yro4k/cnJLYK7o/4NwEn9ZI1UJZxiew6DOBqhLHlCAHFz25DjBTb/8HDU97tq0u+oTHtcx/6osWX5bGNu5/IuhTSyU0SBJc6l3I2HZn91NpSUARMWGUCiXvD2XvKQf6P/Cttnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818937; c=relaxed/simple;
	bh=ATn0Fq/lS1bN9hofJynNIPKr8l0Co9dGEIDrCdUa4g8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q3EnjFDiUQPVRDrKrL9mYObndTlEDIdNQ46dAL3cafrOPBMZqBWzquVtwhm1JJrQPbHyVz2DnQm9W5BP/mSj0nTQ2PhtXkVGo0ly60CwVrIFVVMvFjOT4LkWWsPN2NgC3PqNat6tJyPQXgfbdf8BhqWISddwdoO8cZBFUNVEnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jIvI+h5d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ThuLzmDO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jIvI+h5d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ThuLzmDO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mptI1602584
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 11:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+cD/qdB4qLo7t24V1HoY2mhI5/c5P8R7KcWgHdIvodg=; b=jIvI+h5dau62FnVJ
	+ceUeR3pIvghdyQb72ZrWn3ExB2KV7pko6NOewt0MuaLC/5682f/9U1HBRyDNClc
	vfOcsbkdj3QXDxc2KG2XS1eS/6v7KGkb3JTZNhjD38868jBp8OHdT93MZjshhmCJ
	cx3H2Qeu3/rn7o1/DCJBIPFSINj+JKiPfQpNA5jNOV+7T5oSB1mXlinNSrV6RouU
	mR1RkgGKjlZRVAkiHJ/kBjSagsQ5/21TU8QDKwZhUrnDJ32D/A659lCfYmribO4q
	q0afVARwI8CHWCAtX2IrJYXZqTvPX/LeQMLj9nZe7oYC317TBUYpjm7Gocq3ebhO
	sMu58Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4avprn08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 11:28:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so19331526eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 04:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782818935; x=1783423735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cD/qdB4qLo7t24V1HoY2mhI5/c5P8R7KcWgHdIvodg=;
        b=ThuLzmDOBu/UnuITrkUBhg3hNNN/NRvRtDOhwxXtzohluYcbc3s4K9qgiKvMyanPn/
         2y24Q1odurXy1e1k4ZDAFCTaYwTkHdX5Wl5KEGInfxUU8ee0nCiygbxKGuLJXKIukcuU
         kBoGw247RumoPREWbpJMdI5VcrBuARvKzoaMJvZPGpRjDFJngA2nDDx+egkiSkgyaZoS
         9YIgOz62jcgyF6rfoJRQ9+uxPYgwKyN3VLJCqukg2pFSPCf8Yf0l1Z03U84+4XaqrBDn
         OVb5WOAw/iHwC4/lquINrmLiey0uOa6huWSNsvS0DGsuBV5gIZeKt8hme2LBIdV1V9z7
         953Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782818935; x=1783423735;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cD/qdB4qLo7t24V1HoY2mhI5/c5P8R7KcWgHdIvodg=;
        b=QZgKEBBhSZhB68WGgto40spYU9/+sC7NQv/iUbgKppftPozmOiXzybwZbxxxzCyQ6g
         j9IDIhg+z9x/1r0DOxFcZbtQliLtekAqH9HnCiZwZiFgWyqahzIswKyPRjQWzsCW2KCd
         qdhjmTa4cZmqa3+umuFv/jc86LTbs7BC+o++b3tVhoLSn0DV+DMBJtEbMdnax8gnDRGT
         DdG4i4YSM6djiPp/tvRkiVh/QIpt/IoXQEHTMRwrmW7hJkc2agdVBabUHUgZeHXT1arI
         XdR0Z/5e1C+tPDKomGuWZJNja4+gk5Zv/GStAOIMJltOq0Iyd6ko7U3JN4ig/FQA4dpb
         e+vg==
X-Gm-Message-State: AOJu0YzkbLOAcpULU14w8p+2vzkt8zgmSUalQFggu2DfhtN3JKWGpnzL
	RF5MVVA19JSF9Qrgsz1APiJWI6E/PpyUK8WvvgF+8RxfQ9PlpHt15duD9ItEmFe1YKkc14K7Q5C
	kcPAL1qYckB4zbfSQvoMP3zgs87cZ+Fny24rU42MQ7Vlbj8TO/Rx032Y9JB7gJSI=
X-Gm-Gg: AfdE7cnWJsR8qRh6q1q35u9bE9UiVoonluDTlDE9bm8iLrWRegk/AjzZtmb4M9vdqtC
	tSs0xRr6Pn/T7V73vp7gxJQY6g97W8IYGp3ICHzGFANYtnvVfE1sFoN4E9jQU8OP0MQUkTJg5iR
	JQOfwkyoyICEQwltfn7Pgm1QbONAZfxjnUSB8TOekoBExnFEMAWViLGaZr/fjjVi6xDaLBbRjp2
	N/rZu8gADkeiC6T5vSls5TtVVJXZ8gnQfcMFpOG5H4FZYO+imFOmOQdX2ZZOOcwLPnNHTc+ePb0
	Qa+Z/ouqzWexycFL2vdCRqCDDlmrCoMQOLJAvbTFxceDom3w7bqZ2iTASGXXKeTRp/p3uj0VCNk
	enrHUDg2kqZyGCZYK2mK3OvOw6BfY
X-Received: by 2002:a05:7300:4303:b0:30b:ab02:9e52 with SMTP id 5a478bee46e88-30ee13d61demr2319260eec.30.1782818934564;
        Tue, 30 Jun 2026 04:28:54 -0700 (PDT)
X-Received: by 2002:a05:7300:4303:b0:30b:ab02:9e52 with SMTP id 5a478bee46e88-30ee13d61demr2319229eec.30.1782818934035;
        Tue, 30 Jun 2026 04:28:54 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.56.202.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3264f52sm7541784eec.28.2026.06.30.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:28:53 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Yue Wang <yue.wang@Amlogic.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260616-fix-meson-pcie-reset-gpio-v1-1-fca404b4c8be@aliel.fr>
References: <20260616-fix-meson-pcie-reset-gpio-v1-1-fca404b4c8be@aliel.fr>
Subject: Re: [PATCH] PCI: dwc: meson: Fix reset GPIO initial state
Message-Id: <178281892763.291682.17352622719357029190.b4-ty@b4>
Date: Tue, 30 Jun 2026 13:28:47 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: fMNjPaYpml1ABB6q92tDu-pucwMom_X0
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a43a877 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=d0NiXODO0fVjScRmrPHHeg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NGquYU0cblXHf0KasdsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEwNSBTYWx0ZWRfX0nudzLo24bXO
 Nn8kOrDjhaG0YnYzOqQzdBGWgc8c5go1gxxcTNfGkGscRwPuRWv2zwLEUmCmBT2+H531SBp2WG6
 Mx0LhQus4e8h/ZOe/q2ojuLu/3sbV9f3VfNIed7Y4V7HB8wQvvI+/ivC8xyam6ApUYBq8+Q2wpV
 jZ0qLZ8GUrS89hxEztvFsaWJMugL3zyzIiWE03zPG6b59+2NIoZg7wwY5LxJLxyXQsXTQcDDygi
 ejNNhIIUcqRJYoujf7Q8/9j8qyiLXFVnC2z0vFnOtH9XeSxOvgc4g1hRiFb4f8YcYajRQFkJ3Q6
 NwJ5Qi6YYlrxIxWlV40TrjCvUQo/UFoLCevJPzHSwBKt5ppjtL7JDbv4sFkbOT3McbcppZNV0ML
 nbjRq231zQ1jvX6YLNw4qMrimWEL4uZC5hdh9Pf3e6KwMSt+Wq6g2qV2t4bApC/Ry+r9tNGc0mO
 zUlHurTgPE1GcQa3ihQ==
X-Proofpoint-ORIG-GUID: fMNjPaYpml1ABB6q92tDu-pucwMom_X0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEwNSBTYWx0ZWRfX4zBZoM3xZvQr
 8Lsx1Tvk7vtHahiZVjQZhCxkbpFiCOiIjcKkPPwroL1vaoJngJNVE9gj89ZICVnmrtwBLeEBxJ7
 FLP/AC7/JqiYaVjUpaktDSVWT8aXh10=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300105


On Tue, 16 Jun 2026 09:07:25 +0200, Ronald Claveau wrote:
> Commit 4d3186a525b3 ("PCI: amlogic: Fix reset assertion via gpio
> descriptor") inverted the reset assertion logic to use proper gpio
> descriptor semantics, and moved the polarity configuration to the
> device tree as GPIO_ACTIVE_LOW. However, the initial GPIO state
> "GPIOD_OUT_LOW" was not updated accordingly.
> 
> Change GPIOD_OUT_LOW to GPIOD_OUT_HIGH to get the right behaviour.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: meson: Fix reset GPIO initial state
      commit: 702c89eec25a10932bed074cb9adf0fcfcb6652c

Best regards,
-- 
மணிவண்ணன் சதாசிவம்



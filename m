Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E1441600
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067200; cv=none; b=N+XVPjuVGb6fXefciJ1tAncJ3Vtbteld23LbYzfq+yB7s7m7TQkCUugsZ/DU2kkToCY0m7VJcHRb0BzKHXqy578HN0WJSEo4EIDtGysukFdMFWcK/owdO25A1DrNxllyDXHZOtdvKL+ymz6XoiAiqzpi3o36UplQwrAwG5gQV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067200; c=relaxed/simple;
	bh=I2JRMPVr3nHR3zuplvqZ7DTDb5odemX0IPdrnYGeqe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECFel4HsFTbwPGN5UPVHhH1PTwk9Mjt2/xfXrziwxxbKhRXjSsipaNiS0ud8gF6ZiM794CeYH2AyNvGYYYIzpAuLLa2RpOo1d1bECB83bs4giUd+rZMQhAkcXj70OQfhJR3Fxp6Y7GbOhWAwnQqbOyiEPG1bGETnWNavcVK1DBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X3DLA54i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fi/TR0OP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X3DLA54i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fi/TR0OP"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M4N5jr3383722
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 08:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xnc6jTGctPVsSGz9lBRdlGXpkuVeyawg5glHzY7DM1o=; b=X3DLA54i9cE/Yl/U
	ccEGr8/tKOWhVsj+bOt4aUFbBwhyF75FH4g88Sd9KtIoORorLiJ3CVnvWnnjuJoK
	LfX5bj8p0Wi9u0J/SS8ANRtOZTPB9QiXXf7aovIh8qoGkmy1gyRi61Po4H0mxC8i
	Gyg0gL8itp4WjoAm8YhGaptJNtZ5/gEHMvfsLVc+Ipkg/4oXwke1luVsQC/3ri7s
	klm+wWs87rclhvUuGf4w1He2QaQ4/YysyiVtSUQuxCJo4p/qGa9ao3dODa+yCMZ2
	Q4ZP09FnsPMtVugFc1h25SfaAsohcgjC1t2WJeyhgFawuNPgaJAG0yx0r461kqDC
	fG/7yQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gujkj90c0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 08:53:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93bd22160bbso355508585a.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790067197; x=1790671997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xnc6jTGctPVsSGz9lBRdlGXpkuVeyawg5glHzY7DM1o=;
        b=Fi/TR0OPMc7aia93LkSqKL9M7bobCaWJO3xphzM0N1Bp9GlTAX3hiCoi8NDE0xcjD1
         oVENspzgwfuQFSDAkOZzQFuDNez8BNtWS5GXkP/x2eybhUWT0eK63Idl7ussx15FVR/y
         mS+uqRvaiic05AnyCyURcgVjLnPIayFUFgY5LlLPQUrvsZ4xRTs3ubk7hAW3PM8uPEbd
         i6b2PN1yuELxW3ReuhGwlCFcBKi4PxU/G6aeotw7baP4a/fkwtncV1JsPRyyZ8jmYjp0
         u/OeUTNU+JL0269l4k8lAluABIKH/fAaQPWKpbPH4uUiri+rFfDfI+hx2kjzfCzdocyR
         gLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790067197; x=1790671997;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnc6jTGctPVsSGz9lBRdlGXpkuVeyawg5glHzY7DM1o=;
        b=OJdy011jsn/sSC+PVzK3MZQRAFqkzpXpVof6Di0UASa401cXhO3XEiJl5GIIqgHFt0
         719TSrdznTs+FPZggch0KyDCrCSeN+PyI5bIIUg1FG3w4crTOS1neqNabsHj8WKdX64Y
         qcRcJeAzcaQAZtpTLy395NC6yx2mIfLrmnkzMP2E13R9TP/Rl1cD5LEkLwWwpACTiN7A
         rQWZzGthm2+jpVrwJ7zv0dNDGsDNr289Ia+sZEpbCkEqRxX/8RJ2UXyuBOqfMDjTSJfB
         B1tZgGRghIYODrkq9iqjgAfHYD6ooMMMEWVS9QV6UV+a9XDZ3XtmdXbtH56cnB3Cxw1o
         F6eQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLerejh7gNoHCaTOaRp0lBBYVI1sGpQNXCPSuBEReti0rsLSnyS5n5qmNK9ps52VGiDKZITh06Tac=@vger.kernel.org
X-Gm-Message-State: AFuF++md4vazi59E6KVuE6Mwk0fnDzrIeUXdYjsXCrrPFkTYprodV8DQ
	yKMnNlUaSVZA4DwzDH62MBuE9uikeK8utz4FMvag7dJj2Wm6o48FzYMRvi7N+9Ik6Zi3vQW4YpX
	K1hq54asfmbYJozSJhYSeEXG1AgahH9s6A3MbT/2/MUxtuEA5MqFiSC8a4+Ghtlw=
X-Gm-Gg: AYBFou2wHVh2qFFW90wRlPZHGQALzAqJ8ncpd0kWz3quXjaSGCmp2krpPf6AGxq2ZnV
	UqO6p12JtlBtpyu/EALiarrJGAewCloSfWCBANvyFE75OJYWttAmUNA//g9NIChcVQCeh9HCez9
	iIIkoQ7SsmlWB6c8RLoUv4fvAjWtRRMOT60kkt5piXsF/jx/W9tfMZEtFk5Fbv0qt1IkzeoG2hy
	YsRMfe6zu7x/BhPA9Qo8mPVhJWrDYr20jT6l0BN5zkhp6qWBuryHplPZXwCl89k2+KdFajIRVNV
	45c45cCwkepSXCz7Qm47DI+B5f5fLoinHyY8SUILgSj/A17tNgtBIJod6AFtV4BNP8/wRroF7YN
	UfZyBIEMg1Xsnf7SZhjrKgYfGcQ==
X-Received: by 2002:a05:620a:2617:b0:93c:e83:6ba4 with SMTP id af79cd13be357-93c15dc15cbmr468080885a.25.1790067197545;
        Tue, 22 Sep 2026 01:53:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2617:b0:93c:e83:6ba4 with SMTP id af79cd13be357-93c15dc15cbmr468078385a.25.1790067197170;
        Tue, 22 Sep 2026 01:53:17 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:5105:ff9:e148:c440])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdab8ae6dsm76956285e9.0.2026.09.22.01.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:53:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Add Lenovo ThinkPad T14s gen6 WCN7850 subsystem PCI ids
Date: Tue, 22 Sep 2026 10:53:14 +0200
Message-ID: <179006719183.26594.10755646806419123465.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918093838.6645-1-johannes.goede@oss.qualcomm.com>
References: <20260918093838.6645-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: B0P-h27zzjySGM17ehbYQdVRP0dzZp1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNiBTYWx0ZWRfX3QqlSQz6uKmQ
 8bR6CZj9uui7IVI4GKXGUUEzcHDTuI1/KH6k7LVUpwi86m/z3aBxFuOP9/JOgZQuG1cFSu43m9O
 bW6oJqexIwCGn2hjd5MuOSVzL3jY9+1OHOHUqRexM+XGBu5wmsjFulOGxsX1erTbgJ+BOWOj3fd
 uEF52IEVWT1p3nVjl7EHgpv6q4q+6FWWN/8TjSj2CVVaRMJu0rXdilzHVnzBIN60blCtjmPl0nV
 M2pQgdRLizCEv5uDjHhpFckeQuqPLpERGpbAiVwx6+dAssHb125CxJbSnotYe7mFzYcL1W2AC65
 /hLXW9SydzQfmkkZLqhjxAstNNdOCZK10KsTV4LKql+xjfK7eqykIQDUhC4C/e/oLI+xpOCVfmR
 IeUkI3ldo0SKnZSANxAdvrxwZNdR4VCGbSkQaFhxpLgS5JAMUnHsSX1ST825wkIbga7RTDrcCjU
 7Lv/DpDO2MdXh5WMaTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNiBTYWx0ZWRfXzx87st79nLnl
 2Rozc23MEsiVZigT13KtAL128ECUl/fy8kgLueLtf0R2bWmmvw4XjKQxzS9mdTzqU8dHf6uuN4w
 MWQ/dcZAy5gB1jXp4ggXE/2zt+jtHk0=
X-Authority-Analysis: v=2.4 cv=SuAFe/O0 c=1 sm=1 tr=0 ts=6ab241fe cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=enETrG2LyzngRCULhKsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: B0P-h27zzjySGM17ehbYQdVRP0dzZp1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220126


On Fri, 18 Sep 2026 11:38:38 +0200, Hans de Goede wrote:
> Commit a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN7851
> UART BT variants by subdevice ID") has caused the serdev for the WCN7850 on
> the Lenovo ThinkPad T14s gen6 WCN7850 no longer getting created.
> 
> Add a new match using the PCI subdev ids from the T14s gen6 to fix this.
> 
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Add Lenovo ThinkPad T14s gen6 WCN7850 subsystem PCI ids
      https://git.kernel.org/brgl/c/58a00330248154461c52a6f3bd5c01e5b67f9560

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

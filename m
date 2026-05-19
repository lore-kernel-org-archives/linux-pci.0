Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86281348C47
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197712; cv=none; b=AONoC/iepPcCjFwVNKeA3Bl7PcQF+Ygu/GVH1sdFq5K+aq6szfGeG7JUUHALsdaPTG1roIgtBpEIz/lS5y2UbEID02OIDzgb48TICrNPeJV/myINU1e29L3MsvwWuFhM3JGAblsR8dW0tK1TFfoJVn3zkcDPtRvu0deBNpmSbMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197712; c=relaxed/simple;
	bh=1vt65SonRjB5I13bFaqNtRbsosU1nL1qjT/ksFq4wjo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JyPjCPh5iicuX1MIGfjMc2L4N/vNBchSnfti1knjVH+hoLTyWQTnpzjbOGTCaCjHaAeS2snsSfQgsUYoj+IugLg+0HHY6xAEtkvZ7cBm42y8BWTIonfZvYNi0cIBGs9q1AaC/IHkFDbtFT0ZVfdQpY9Z57m9Umh+1lBeDPwv/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dX1k0O2L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gFmelKF5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dX1k0O2L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gFmelKF5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9l1M81257629
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C9Ydq0M+MzNsQ5cIKKsYhIPa5RmSGO4h96Yn/64fPfA=; b=dX1k0O2L3Pfabhpe
	cNoyBcI9/SWkRpzboSQK9B4Ccmqj5T8eGSBrP5Yg0llOfHsjOGT54/rXdr3gY5tf
	+igSciUvofs8v7Bn2RkIaPauFbUwR7MIqQjcw2oyVaqH66VuZGH6T3DbIZtkMbsp
	tzvNCg+wUvvqvqJVf3Pj5EqH25FCyY+5INmIkfYOUA9L37ilN1YpOzixB+Kq8rzb
	nWFjS5ROD85KE+iiRZ2GqF3B/l64zZppxcELiUl/PiQGArlmr+3hxhOESGl3autr
	qbXVUsk1FQ6wjaC8O38o/lgSdN82dNWDQTDDPrsBgzGJVXmFq+qbVzF+IrT34yr9
	DEWT0g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8nhj8uuu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:35:10 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c82ac893940so1679831a12.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779197709; x=1779802509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9Ydq0M+MzNsQ5cIKKsYhIPa5RmSGO4h96Yn/64fPfA=;
        b=gFmelKF5V382X1M0y+I7IPnpec9sRHSdTM2TteBMXVRCJLE3DwUglCk/DjK8pSpOm1
         fIr+bl/IdBTF0jso+Wq9Du8ilzRAvbvBt2cgVkRaAfMN8F/0CMb3da2O2nU56GYgsgvh
         7v2B6iULooGzDHR8i4lGYDX/R1J8wEFs30uWUlK9ZjwTHwwmk1Y69bvhQVw06Vq3ZXzy
         WOHSpLAo3CdQMkMSdcN78mVlXH5VA9n4o4P29wI3c2rjqAZC/NPhjyzPIZXgToavVycr
         l3DltbtHCXeiBPA2+sv68plHja1EkLU1yxn1T3SnGfuVpsUplm6/khiWngYKFctV12Ue
         eAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197709; x=1779802509;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9Ydq0M+MzNsQ5cIKKsYhIPa5RmSGO4h96Yn/64fPfA=;
        b=gm7vK+01cg52C9WNteVaxjCMIKwc/Ook5H0kSxdGtGawx3DUqDeYr09+jZiHKS06S8
         0v3mSZe+I/Z6PbIpE2VbJReA96wSfxVa/m5z3TVNvyGtwj/psBVbiNy2K/53jOzX9Wok
         wA5Jqo1ttDygf6J+5slmO0jHBC+3VfH3uy7mcqmP0X5jnsoU4sPT5ilUq/wC4EGRSSlt
         Q+uvpu9lsSMhVAFV867D8uuVipToXGOeHJ5DiGtD5n7ODghX43nIq91DLs+5T7LkKWQE
         I30StZi9VL9VmwkWXSdTguPYzYLrUwiMUPCUiUd5DccfU4ejbxX5ITAiQAGYDJ9mEdAy
         8c2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8zGtrqC9JSEiR79duZWlhPSIE4v8TXy96XjZn8aeD+dGfVlnqiX2sHn9/L+KoHeG3wvhNPPESYxkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNSOLlutjoM4S5oBbdWwCl0jFQrDQC0MG096Vs8UEQjab7+/dE
	k08GWdqM1qiFB8Pnvwh0oUQvezpQu71onyjJp7wG1H1mo1v3AdWZwsUtkCslSmgkdCGI7x/sYSN
	RZDkWZ7HZW0aH/34RJX4gDYIqxDb/DAl2sI2Tv2a5uJYUhgK2WCQG8R8g/Ky34j0=
X-Gm-Gg: Acq92OFtZFvTJ7isLS29+0TtfkdNry7YErNg4uw9k6mnxJ4HAxCD25uz08uVG4nyF5p
	o6Pte8iJCzR5hQ5m1DDOs1YjgfNyag7l5CwGJFr6cjvNAXE0Hi4Bwj7chPmmhi3p/lUuTe6FT9D
	QA0j5mf4hGCz0SB+E6utNJMTSTQ48GbGsbmip0/xibjYpI0i0q2FKz8CNysniWlftr+hMwHxxn3
	SpgmqBFMt/osXF6M9D2bCDXxZKembZjOi1diK58krWxiCZcLlPnw8tGt8W4QyTBPubrYnjktjVG
	0jSM8NXZdlyuF/NNjPieRErJQVzhJ+tEa4jd2I50YJIFTsDaijF7HvL7XsAECoKL+dSbKwL4CfB
	9hah1zsNwEawgCyE4eu43rpty2HymfE8=
X-Received: by 2002:a05:6a00:2293:b0:835:3f51:72f8 with SMTP id d2e1a72fcca58-83f33cc3a52mr20591139b3a.18.1779197709279;
        Tue, 19 May 2026 06:35:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:2293:b0:835:3f51:72f8 with SMTP id d2e1a72fcca58-83f33cc3a52mr20591078b3a.18.1779197708637;
        Tue, 19 May 2026 06:35:08 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.207.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19794e6esm16803015b3a.25.2026.05.19.06.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:35:08 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        jingoohan1@gmail.com, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260508133432.1964491-1-18255117159@163.com>
References: <20260508133432.1964491-1-18255117159@163.com>
Subject: Re: [PATCH] PCI: dwc: Use DEFINE_SHOW_ATTRIBUTE for ltssm_status
 debugfs
Message-Id: <177919770551.94171.9657222291391625414.b4-ty@kernel.org>
Date: Tue, 19 May 2026 19:05:05 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: ZzRGsKik-IL-N6UX9dj3MiWCUTzgLfq4
X-Proofpoint-ORIG-GUID: ZzRGsKik-IL-N6UX9dj3MiWCUTzgLfq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzNCBTYWx0ZWRfX7yaCEFyvZXMl
 uuU8EXAZLQFSeTozyWTryrrCEJtvlK6sJGB2Y3u9FM7bCvtBB8+U0mEJA4eDST2myQYhLJfaV28
 0psOW5q7cpP7ZNehrinbd9Axoc5dGNPnOUXc1bCVLV3UNLE1xlW4q2GuCqPvOBc/4yRwJeWZJNd
 3dlM82W3tTiOZBEdRpeSWpIQ59VqVXCLKAo6oM6SzDDSQUVGc6hTS9jjmy6mva1237+A9tpbVW2
 iimzxHEVvR9cwL3rSHFtWT7sBs4Ser9zYdA//5KMQteS8TB8RVqgMjlCj3xg+7txCC3n628tGkX
 qWVcDN7U8RsphKbwsWe+oSKS0zdWXT9NDYCpcBCsB8FQxP7QDI84RtyRdOFgLfIzIe+HCRbTAzk
 zlERz5nFb9ASP4cJypuUqXeWgoLGP1/bunzp2iVnoKXj6Cw96kF97MJA5NA/CIY336XTgiWqjWA
 A+Aj+dXfZiQNH6Jawog==
X-Authority-Analysis: v=2.4 cv=ToTWQjXh c=1 sm=1 tr=0 ts=6a0c670e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=1gRTTRxgmbTSdBvl+srOOw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=a7PuirphCRRO6lzbkukA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190134


On Fri, 08 May 2026 21:34:32 +0800, Hans Zhang wrote:
> Replace the custom open function and file_operations with the
> standard DEFINE_SHOW_ATTRIBUTE macro to reduce boilerplate code.
> 
> No functional change intended.
> 
> 

Applied, thanks!

[1/1] PCI: dwc: Use DEFINE_SHOW_ATTRIBUTE for ltssm_status debugfs
      commit: d25f1dd6b986070e2324bf373097f0fced1e57e1

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


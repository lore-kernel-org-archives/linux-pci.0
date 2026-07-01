Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57C2F8EB3
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782882589; cv=none; b=WYbmEYnDbNQ9kHkjMGilN/cccZbnqJcZlqaKjLqvxFIy1W0V1bvaMw67GUEkXnriw5oM+Qsk1sLROd1XCBnVUq8ydlKsvXRduFR39/TtFyG7aaZo86fWL8eu1NtFk7Qv38C0xIzwqMTYRUWBlTd29GYi/uptb/p6xfJUjzkNwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782882589; c=relaxed/simple;
	bh=5enehsYKoO8Z4s0MG/3SASIZX5GOFw2kAMzZRwPgbck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oFf2oPv8Dt/bZmuxNtQxl3aPofI6B31FR2BavJ8A2SvsHi4bP/JIv9gghMEdyhtJLETC8lTjQzLL2gLDBzZwU9TCSppZsmEtAPEj2THrVLeENy5drEspqzk+4HQzrzkJz3Dbf8nn+RyO7jvQERXwCcKveZW+TnUc6U0i2ySUnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bFtnOVL9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MhzkNLgH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bFtnOVL9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MhzkNLgH"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612tetf3940931
	for <linux-pci@vger.kernel.org>; Wed, 1 Jul 2026 05:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/rZhuGK9eKbfT1PV0rW+sKnzgsDncRypxPV8HJPHHOw=; b=bFtnOVL9EP7CbM/T
	lk5mCAHeGZ0+hRQI2iE37MAt7O88/EromztYvte+k9gj1GF4fXIqtUQMvYZ30iTo
	PiA4fFj4FwPcumvLRSyeTgVVU5c8m9a4BIYh2hUiTINqp6Qa76Vtfdba6mS1JDnV
	zoM0RYjx34b+/mLCarMd0plCYNwAxDErpraJuiJ1TRtEfIzjVHh/V1lOUBoy3nvu
	zKYJB4qLKwXR/VdjlvusVN8FTAmKzx8YEVvrtbl34cNPyL0sbsCj4DwzRe0u8Ka0
	EEyFp+UKcHiF29F5lqTEVFgmNuzTDyM8Di5XdftD4UbHedMxxA1oxCBk79Dh+8Yl
	q7SU9g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4rsy0ra0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 05:09:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30ed664e368so294340eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 22:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782882586; x=1783487386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rZhuGK9eKbfT1PV0rW+sKnzgsDncRypxPV8HJPHHOw=;
        b=MhzkNLgHfAyJvrlFbCkmEqSeyxI3RrEMZDaVm9LjbLfwKmMBMz59f0AFKCY1QMnbpQ
         s1CJB5ZjrlzMymdaVYHCl53uqS9XaxUdKBI83z7zQd2csQasK3R8z4pzbvBGUWuRNe9p
         BdVYzDj7lMku9p1i5eGDsSowygW5MJzwa9jawJEjR0WZDSdNqPkXtiqNN+vmjCvlXFd2
         OTIhzUboXBvYLu+WKbJob9UPzr4GPDnSNzEcFJRDLev8x0eT87fYnbP5hG16xedMJD0/
         ZXSoFzPkzo58RmN27VroTYeJ1GPW6EuLlgfg/P/l6GeFS2SU8k/ANasAF6BZnfHcE5Vd
         XSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782882586; x=1783487386;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rZhuGK9eKbfT1PV0rW+sKnzgsDncRypxPV8HJPHHOw=;
        b=UpQcye4VTnkLeRMifoO+m5XM/ZZIg/Hv1X3OLU/eGDiH4Gnnl3V+TOAgueGpPcKDEY
         IhaUbMGJV2TrtY2bG2TVb/GslzxG5o7dEKTir3wm5Ccr9oreNhRqZSXDvpjKN55wHh9C
         0gjL1Vkc9YvKYKVQTPF9z8BnTe//V/LiDooOaDuQWKeLvtJTqdoHXS4Opg8MfAt3z3na
         2C54KajY+BAMp9A9HoX9GjfnqxgZx+4YqApcpO+pjoFU3z79TkyJtHthjzfIZy5qTHHN
         ooWV58nsyI/tPLYn1A4OGeZPdN/sNnOashFKPWGPgSNcNoBgpTp/o3Ryiv3miFejO2Cb
         eaEQ==
X-Gm-Message-State: AOJu0YyJCT0xoQIFYAM45qcQXznMQJaY+eUSe4+J4UBL65QpcxWHpw0Z
	tnM2z9zb+/KGNOrc0D31pQj1AG5M2jXlOmP/BnZX9ixrNEQLENBxPeQjY3dvioiMCz8xiwMwyit
	r6l6F2Av9I5yRFCWVOSLzwD1+zOk4e3ck0GAOOgOcwHtE0rQ+s/D+K0jeEeR+BeaW6cdEdAE=
X-Gm-Gg: AfdE7cmgM9aA5vp+qbhc9PmcXukuPpylPY/R4D4NuT/FD6Gm85S0QX6lzy9lCSAW+yH
	S6g9sN7mIWh347Q0Tl3xgwu85uU5wR8sfCGMphuneAJK7VsG8iCoM6FBNUhAZOzGnDd3G20oo2H
	IcNJKSnQATX8rzwhqxYetOl1OAmkgNAV2/0rr4n5QUZsLCgKFpzcoTa5ySCXcb6xtypFOG/G9fO
	34DV9c893NCFifbqXtlIpupx+ybU13Ct2/CbYrhO7WzozT5EPRQ0BRJNGQNscxqE7TbWwIdBmbi
	9gRcujA8Kv3PmCstvigkS2VknnX8e0FxTl63oskKykqe6Br2O4VENLd1/Mcmb52+3yh6iRrusb/
	tIEDD2rmSb5pe9DI1F5eg+4Cn6kWhDw==
X-Received: by 2002:a05:7300:ea18:b0:30e:5de6:a464 with SMTP id 5a478bee46e88-30eea0d8832mr2712514eec.12.1782882585733;
        Tue, 30 Jun 2026 22:09:45 -0700 (PDT)
X-Received: by 2002:a05:7300:ea18:b0:30e:5de6:a464 with SMTP id 5a478bee46e88-30eea0d8832mr2712491eec.12.1782882584889;
        Tue, 30 Jun 2026 22:09:44 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.60.61.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2fc12e7sm14556106eec.8.2026.06.30.22.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 22:09:44 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mitran Karthikeyan <kmitran@axiado.com>
In-Reply-To: <20260618080811.26337-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260618080811.26337-1-manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Drop Karthikeyan Mitran from MOBIVEIL
 PCIE entry
Message-Id: <178288258234.309464.3851851961009909953.b4-ty@b4>
Date: Wed, 01 Jul 2026 07:09:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: zj2HhTOsnfzHfmuZ0QDDO5NKpfjbwtLv
X-Authority-Analysis: v=2.4 cv=fLgJG5ae c=1 sm=1 tr=0 ts=6a44a11a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=H7IkG6lIOHbWVTtTQWLpKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=hi8qWFcJo7Ki0p-HZGoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA1MCBTYWx0ZWRfXyduPeLCu90iY
 8kVJc96uExNmkFZ/IzwVUaIxCDtoYoMc0oFiu4OtNVLMYplfWSu1pKKYqqL/iGXWlb3q5bC0CJh
 1mGniVu6B72fktk33Qi2XDxk5csHmrdpAuUDOpHsZ+r5OEHchM/ntPls4AqfDsCIS3z+f2nTm23
 LBHGuMTLj2Zk9Earu+cis/1SR2YawMXfYyz4fnkN3WoVERbBdA5aABx/E20s1A2vxw4avpxICD7
 H9gesOSjPgx/izTVBtu5RcsgHXVbsgTDd6z4nsb7ljd27vnST/bOknl66Jbr0QaNDg+L50B/cWC
 MNDdWfTYvys/ThKlui8Vey4SDY6pTmlbmGXO0pOl5wVT6T9gNKWI8qxO6nLRhY4hlsYnQuz3a6S
 9aGeXgh1IPBFO7yvYq9ELjR0ulcQHnc3cf7r6w1Z2xCqqffRAx4q2EuYBRpUbJmUmTacKnLhj6R
 +mfwXj2b7r2Xz3l1NEA==
X-Proofpoint-ORIG-GUID: zj2HhTOsnfzHfmuZ0QDDO5NKpfjbwtLv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA1MCBTYWx0ZWRfXwkz3hMiigOgL
 X3mRI4XDkGZQkN1ZvwwbewSKWwqBH+GHk8ekmMvibqKItivXil83J2nk/Ij65lBzxuLrf8J7Bl/
 Uzt7T9fDhsEOu2b0v2l8heW9dgUWpYY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010050


On Thu, 18 Jun 2026 10:08:11 +0200, Manivannan Sadhasivam wrote:
> Karthikeyan's Mobiveil email address is now bouncing and there is no sign
> of him [1] willing to carry out maintainership duties for this driver. So
> drop him from the MAINTAINERS entry for MOBIVEIL PCIE.

Applied, thanks!

[1/1] MAINTAINERS: Drop Karthikeyan Mitran from MOBIVEIL PCIE entry
      commit: 8fb2ca9b9d3c82b8629c7331da6684bf269c60fb

Best regards,
-- 
மணிவண்ணன் சதாசிவம்



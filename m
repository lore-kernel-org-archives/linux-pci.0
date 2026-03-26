Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201F3921E0
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548675; cv=none; b=JtDlXqJHqCZ6F48mWJCiVrSDDL8hx0euRj0i4G8BTNuFA3zaLRXpVGSSe5rx9B437kNqTVO6FQUhCRo9s3AkiT3hU9yB88GMMbDhid7I1RzjMkeihTR0D4jWzR2n/KsQHIukHXktJOhI7SfpGjfPCmTAHSLpALrO1IKzfDfuyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548675; c=relaxed/simple;
	bh=FdlzGSM+3e3vvmm6YXIt1fJqFvrhyBufI338LJAwgr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WnPBnm5/grm/b9nIn07au+HnyxXu4Egr7ib5hvyGKZyD6iwRo/3ZH8Jh1+tot73N7AOLjB97lehm8KETteHlFHA5E8ejmXy1QE8V/SowRpvYKhkgCMtLc/uzOfW90w3keEOQYwCnOFYOdAMOgK+x41vBgMUqsvdl8zx5a8u1+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LPmeKHRA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Db+fJpg6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LPmeKHRA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Db+fJpg6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFA3xZ335501
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 18:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ixvrTBNY9GHwSPAloK8a/BvBA3mSBomlRngl1HTLv4s=; b=LPmeKHRA5FXgxLGM
	qvjRi17ntKLGJTJ91MNq/Tb5PReh9HgWHrObWiixUwlNAP4Ua825L3MX2wLgSUXN
	paXCK+/DfRJBPRbc/hlfGOK9YbijOlB7BYkSNPLEs+jkVcFSLdyc9kyfJh/0N34z
	QcIr0QWmBbvW9EMNiCY8b43z46Qj7MGhKeJFZ87L3jgCiTisbBfAYKJYFKTFqNAi
	I8dOBN24DbVQP8nyp1y3MmoGe0JT0Vh1tDHp0cO3O8KAB+ito00SOiCpYsElXrM7
	c9jFTBkr0IHe9KB8hy/dObSUpUmekrEgXseZwkum0uaHPC9Mjjsy/++4lkQRo+mO
	GdbC/A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d527ysv2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 18:11:12 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7385a1476aso999358a12.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774548671; x=1775153471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixvrTBNY9GHwSPAloK8a/BvBA3mSBomlRngl1HTLv4s=;
        b=Db+fJpg66o860o5DdzEryI6pZqRfLh/80Y8C2ikL+CzryLLUUQxcxM7im4ShPYx9o1
         L1d492HDZSggGUMYmKmzTNKWm52h09nPxaL0RYikxZ+uBJvGnH0LHy+bq/8BiSV9+7bq
         aBriReVKrp2JR7F27k9cBxhfBBcrYXBnFAETA/23+GEnpqxwumvOMBO6UGazqCBCW+de
         6jSMo4D2F9hidDPz7gBLcfBos3Ww5cwHDzzF9scwtVibxKLM2S/FEUE8BebJYi0ZLUpQ
         aumLJ9Qs1hItnnWwiA1wP7Ri17YYbwcqpQraj0qBWW/Ewme2i47T3MYz/lIBN0eLBC/y
         pslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548671; x=1775153471;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ixvrTBNY9GHwSPAloK8a/BvBA3mSBomlRngl1HTLv4s=;
        b=hnbDiOJxNd1z0bTIYMmW4gjUWFlXt1L/AqS3jSwt1dREzpgDzJH8i2yagoT3egnF7o
         zQ3cmGmxJ5oHiUvAqdl22lMx3+H6waJfyCs4s/XNI7+8qxeS+vns+QjeB+6libemJnIc
         e4LSqUj7hI+A3KJsUp2wbOdWA587xMrbEojqiIl4Rp1pEU3ZJcMt5VBNjQC524RqqVuH
         d+7sneTlzISAbsujgn1N3wRUGqJCgTRoaSvImsA8kqFAtmnkVvHuRojsxsILRq3itmpu
         izZYawNVZt1Hzd5PG433j1pH6iOV1p4jEOoDiUNJrnHyceRihwrwetwJGvRGBzt2GDZx
         3R2w==
X-Forwarded-Encrypted: i=1; AJvYcCX+jreXVvgtfJVtIHY9K/eq8edGGDd9vy6ckXf3PXxZKKX7yaKhsiWvJKb8ynqwg9zCtC5QbCyn9+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpBAK00olR88SbaTx7+ALwdlyxxITjePTn+wjpnQ7OpW2l16D
	f4NEJSOuZredkAZBQUrv5adQEN7Ybkk5YkUcxuhaqshj8x+Potk4bXjDHns12V/WvwYNLyvKETO
	DXCwHk1a517prOW/zFMY47nTyp8289mgdcl/I2dVwb9nvuTcmK3tcSxHcFM+dMIQpnUAer7U=
X-Gm-Gg: ATEYQzw7yBn+9v5xYBGUE/eFbLGs/VPIwesX1VFo2EExRFH72rtJIRMbmW2BiPca3qW
	bkygd0tsVUdMXKhPKeaOCp7yG+CKSTGYensAQrmArp8Aw6+AtynRucJULMEgsx3Xg5kWWUXS5L1
	Rd9lTnPaB2DJdDvC5RqaQV3F8q9PbU6GA1whE+hvMbATpF/w+BOZAx5DtOrFb+I6dbih/erQi3t
	5VI2IDQCF8BakviFJ3A268btzkBY9WvS5grRPRarWUTnB1Pb0Q93Ev2lnb9ZnheEVRLXC0djqmH
	gw76JDt5LNeRU64Ka0G9qp0BSQyj8RbQBBg825J9LvW5foVgOVY24LkbSU2vQNLXE+ShA2ia6rD
	MdQGJu2q4ghQP3wlBYZs1ZtY=
X-Received: by 2002:a05:6a20:729d:b0:398:7912:cb05 with SMTP id adf61e73a8af0-39c4ad628e8mr9525405637.38.1774548670823;
        Thu, 26 Mar 2026 11:11:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:729d:b0:398:7912:cb05 with SMTP id adf61e73a8af0-39c4ad628e8mr9525376637.38.1774548670335;
        Thu, 26 Mar 2026 11:11:10 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673978668sm2869369a12.27.2026.03.26.11.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:11:09 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        hans.zhang@cixtech.com, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260315155351.127078-1-18255117159@163.com>
References: <20260315155351.127078-1-18255117159@163.com>
Subject: Re: [PATCH] PCI: sky1: Use boolean true for is_rc field
Message-Id: <177454866717.467578.1151707360952437325.b4-ty@b4>
Date: Thu, 26 Mar 2026 23:41:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=dLurWeZb c=1 sm=1 tr=0 ts=69c576c0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=l5eruqvvfEhLEhicd70A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: qcHlVzn0lq1w0Hk-0J5QtowuyfySSHCm
X-Proofpoint-GUID: qcHlVzn0lq1w0Hk-0J5QtowuyfySSHCm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzMCBTYWx0ZWRfX6AMOZE7640WI
 di5acCjTOHEev/9arw5EgOZAy1xgENVW0Q88ny1b46VjnsmPPHB/gkZqU4TE5NDw+KqieHvzlEO
 Mn7UUEFjWmqX22o4hMPyEzmbCxAU420zLsGIE52TmGG62MEBLCzaEdlNR8oSfDngumj8e8ZQO99
 Gm1SqyQ/OMEMMNok+4/B7eoEjZVix6rLd9gVmbtS8z4OLotylfsvR18VKaL028e+ByNlJXXculc
 SA4P25IR3I+oAGUJa4oDuPPR/ibYYrU7rELi9P5H4CuEtvuRQRALPiQRROXBd+SSYrBSGKe+g0C
 LwMicH5m5lO95bDVAPfyQa/sXLBTDxlMYhO3hkj1RzK1W3FOo7OdL6MFFBS8WPYxWNYTtia94c/
 URZq78JA4rGMz/9gXPv9U0tuxVMJZ7wl/G4AqZDE3uA2+nWyKa5PAup79qqXNR4mVQfvvzmClsc
 EO1EyBgFXR/FgJraYng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260130


On Sun, 15 Mar 2026 23:53:51 +0800, Hans Zhang wrote:
> The is_rc field in struct cdns_pcie is of type bool. Replace the
> integer assignment (1) with the boolean literal true to improve
> code clarity and maintain consistency with the type definition.

Applied, thanks!

[1/1] PCI: sky1: Use boolean true for is_rc field
      commit: 99d986686331ba3fd58dffb312e282d2bf81ee72

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


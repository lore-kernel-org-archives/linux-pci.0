Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F52F39A9
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783656; cv=none; b=fyWhSM1027VRVuxR3pkHgkR4j/SxZy4SFVItCFBcfZEHMeEgW1mvmhq1FhBEgIUP1E6k/JEQlprVboJEyfcChD/fexPimRTnJCdRFf3ttU0QHT6LP4k/SqfXEFSakbI6RdFKcXh5vvYiFse+5ptPjt4SnW5Mh8Gn00kNrDDCflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783656; c=relaxed/simple;
	bh=89NQKAWa6MgFEe8NpCIbcPTTpdMuEfZWM/RlOJPVhoQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VryDnl+uwaKb/xsm3nN5/DHTfw7mm3v0urWtitD0qmZ4ZYtTUY/07e/SNv2F291KVimRHoPKvHLe9/Mu4j8KK1zI7Uz8u8H7+gKgjJrWD1zcoNeuEwyn7sDyNb6rmIOMKwjdNVAyKpEQZIVzamfEqi0fYVnmF4WqK+vsf8ZLpXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WwSQOEV6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=blcvwqN+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WwSQOEV6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="blcvwqN+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UBa8ch996159
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 14:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2grdOmc+WrE3A43oNA23XYMog2iZpiF/vmtiR4MozLE=; b=WwSQOEV6aktNA7O3
	3QnplKg5QR70Ql91Awx0dc4aGkkXivM/rvBxgGUd0wIamwn3Ye7GgBULlEN3e8W8
	Pdd9lmLk+ycXcd3Kl88lLXpPizE/0WSJumNfJn2YDhtLCgjDG8b50JpJAudbYHjl
	DDBLaIEBSkIdf9mijhaEoVBUjnJzS8YKKBehZCT72Jm9NgIjvoQuWM7nj7oN3tYI
	eA5voJP9yok/vKZSjGNV2If0dGi0d50lhxUkBMng6wG4umimpcNEZLFPqdiZtTdK
	KDCuoncx5hxD//eNHh7wl8JdmpCjtBnu90Hlmt1hW5sh9NZOTvswY5tGwep6RNJA
	CmaWOg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bvvkf8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 14:34:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c65d08b623aso1199559a12.0
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 06:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769783653; x=1770388453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2grdOmc+WrE3A43oNA23XYMog2iZpiF/vmtiR4MozLE=;
        b=blcvwqN+AKwUknyxR2ao8SJOYhLBRdt4mneHIYaTDoBTTJ6QBpKsscDnsdSaACF87m
         469CT4g4ekstIElnMIsSERCH6xc1M6qSJQ0ITNLSFIzM5LAybQIzg71809uBYN60tzUG
         qj22pys8Dv+DnPgFIcEHQBn/Q0OCVAv123fVqeS3e8dpZ0L85Afm0Y6xWVb+JX8RZXT1
         8Lo3LJkWbgmyce1OTpOLGkqxlLUVcp0sw1YpackGRYoEKFCfpSuvKDr0Ul3deOqjff+/
         9gLX92ChYtQnXQ9+tw7oyMMbXaCHA/GCX/2C0b1ZHB2wuWasYZFIdZC/5POmstmdorWA
         xy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769783653; x=1770388453;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2grdOmc+WrE3A43oNA23XYMog2iZpiF/vmtiR4MozLE=;
        b=TkgyjuzHDKg0p505y6gF/0SZeS6NeVgbgrm8RkuMg7qi0hl338ZJIG/eoNrqrscntZ
         EjsXNUnSlIqGhcEAnSewcgx9DwJ+PIIs6ZoBGh4C/ktAmBwVY2qgn1tC5+uLLBBeaQoH
         VWc3kYG0ArZcW+RzWT+lONelKpw10eJGzLNExdUlyifCvTHgT2pdT8+dc5A2y6gvCCQ5
         MHcIwbfXhY5z4OLjyHcZtcCLVO85OOB0vWT6Id3f73qw8jlksY4/IKHSfJGDKo+Ij/Jr
         Cm/V9hWwqelb1+f/8IfF4Dfppw+TnTB6I1Ae3eh5m+MuAW5zK2B7x5jzZhHstNBKdhml
         cRmQ==
X-Gm-Message-State: AOJu0YygejRvtF/SfdiGVgel66MF4BmrK7NVFAMKN6mMRI13+xpE97jS
	v7A5CyeLTD3JaON6h6eiQzK6iLD1w7c0xZPfFaT2CywhOM3NfSpKlas/KVhEcRR5Tm4Zedg/m2Q
	aG5CtUGP+P4XE/zCKWDFfshzGUvliXxDthI85jkNN013jTVVQ1C8Mk7Y6Z6kATlk=
X-Gm-Gg: AZuq6aKsFXr5no3f70Vx5gsUlNIL/Rw59Fg61mPWbsSHy4h3EEQxQYXMa4odiMqoeTr
	F2wOTcqjiEqUkRgsOKev7QtqHviELKJLvXnvpfJjqM5bsNrJYFKOvfQPCLaxEiDY1DCjU4TyJ9a
	v3ufkdCQ0aZH5fEIHO3vAbBQ7Rg4wkL4rpURbvQ8c0I07B9rAdZmuiu+ObSFB1MQKWLADvstzAE
	sr1/WsCU5mBII0vqLep/naw6TR0X7SQ08U73FUqkckDs8D80bU+taul8NM1UFultqB1InhHr5gV
	vwE6D9d0oJA0U9ahTDUnOnzr5C25VGUSyTy2QuFB0VgNK6LAPPU3qt73uaSjir2bSJ17ZlDrQkJ
	M44oY
X-Received: by 2002:a05:6a00:1d9e:b0:81e:af19:34ac with SMTP id d2e1a72fcca58-823ab7304bdmr2881204b3a.29.1769783652695;
        Fri, 30 Jan 2026 06:34:12 -0800 (PST)
X-Received: by 2002:a05:6a00:1d9e:b0:81e:af19:34ac with SMTP id d2e1a72fcca58-823ab7304bdmr2881174b3a.29.1769783652155;
        Fri, 30 Jan 2026 06:34:12 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:d344:e8bc:3382:4c2a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b4c197sm8650146b3a.20.2026.01.30.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 06:34:11 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        cassel@kernel.org, Zhiqiang.Hou@nxp.com, gustavo.pimentel@synopsys.com,
        den@valinux.co.jp, Aksh Garg <a-garg7@ti.com>
Cc: linux-kernel@vger.kernel.org, s-vadapalli@ti.com, danishanwar@ti.com
In-Reply-To: <20260130115516.515082-1-a-garg7@ti.com>
References: <20260130115516.515082-1-a-garg7@ti.com>
Subject: Re: [PATCH v5 0/3] PCI: dwc: ep: Enhance multi-function endpoint
 support
Message-Id: <176978364717.10338.10972030482439729641.b4-ty@kernel.org>
Date: Fri, 30 Jan 2026 20:04:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=ZdEQ98VA c=1 sm=1 tr=0 ts=697cc165 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=9HOm7rsiV38g5QrxeB4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 2g7NS90nCzGeta9VQr3xh9Snesb0hF1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDExOSBTYWx0ZWRfXxqgeNUdSnXv7
 UogSm/g7l4bnEIcEesUtyZVSg7P2hSo6OIU+k7xGkT7iwUFuEUinzee2VYYOcJHknYTCyql0DPb
 vuZbJ+oTsDbYy8k6RZBv95AMvy0oW9/0J9W0BDbVVqk7gqVoU6OgD/anogCjb5hdykMc7twIQUL
 WrBHf8jcM+PrPr2UH/4mXHKDbbXkJKpxyGIBY6sbdjMlIGYfU5pFr/U11uLs6QP6sKDMhbA1W+z
 RaQL16hhTEGKHTVXKcBOKxBqjCBYfasUmPQEAhu8xqE/peHghIqEgJHJWN93VE/9VfTssoZqHRX
 pHe1YCwsJh4rBhlpabsr042/aXBiBDa2dqM+hjxU3hBmuNTDbAIQ2Cr1vu989ZhM7wViLEp3lCv
 7/0L4Y5KT2PTbxRBHnHFNHn6GjMcjUhypaRaiYgfe45js5iTqAdgj8pgpyBeFbQoFBr9xK7JVY9
 8qq9ogVRUnEA+OQZf5g==
X-Proofpoint-ORIG-GUID: 2g7NS90nCzGeta9VQr3xh9Snesb0hF1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300119


On Fri, 30 Jan 2026 17:25:13 +0530, Aksh Garg wrote:
> This series addresses multi-function endpoint configuration issues in
> the DWC PCIe controller driver. The changes enable proper operations
> for physical functions and enhance the multi-function endpoint support.
> 
> Changes from v4 to v5:
> - Added NULL checker for ep_func in patch 2
> 
> [...]

Applied, thanks!

[1/3] PCI: dwc: ep: Fix resizable BAR support for multi-PF configurations
      commit: fdb213bcd508a0a81d2b84f96cf96e80a173faab
[2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support
      commit: 47238c9e4c9b707c88e797ba8f1f5b32a7dd4c27
[3/3] PCI: dwc: ep: Add comment explaining controller-level PTM access
      commit: 0e2b9294512c140576c340b7ccd24230a593f30b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


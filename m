Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EBD2F39AB
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774394278; cv=none; b=mszzvKrS68B6zmgMFdDELcYCpeuEEFB2MQcTlPxce7JVxyNmYYfdirnS9OkzhhBngnKBFwJ1cl+dIV7FEn3gg8yQZkqISbedtLb3++AK/WdUiCFZRJrxZyBRD2XcR2uziCnYtDnOehs4aX6KKiFljaMst2wdy+m9nc1+Q7OePXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774394278; c=relaxed/simple;
	bh=pE7oP9GMA+5Msc58ZMUaHgUyNlMovSG6AN1Nw70TWW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP75vPhV4hRB5rAVcrNn2TO7FUSrq1t/HBRKcvN6PrDi0eETvwdjBdj3+7k9Gy+oNsgGDZyFChW2PEIb5ZMi4DBu3ZEjQ7YPexNNx2hYkOicFJRS28Wz9Us+rciSIGYW/OsZipkd4DrqzuX37jsFEdsj7nxcG+iKDkWJ+NlploI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=btU7iNDb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DLCKJ5vL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="btU7iNDb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DLCKJ5vL"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJCf9p989030
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 23:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3It4PEVy+km3wKWvS2USN+N6
	bgWyxf4GAl8CNmjXKHM=; b=btU7iNDbIn+XICdGqWd4uUtBGaqIJLOJtGhXwtJq
	Z9cHFsMAL66L2rU/LF2hfb33Dso5bO2cCbnZ+73wB9rqB0qQhOEbckb/jk/TPfKd
	JmkA1kQewK0xLyRRXLJyJ1eSczNPVXFahHxL5HHm7/iwYNuTpatjaajVq1kU0tIS
	F76g+lrwq8s9zQpcdprXGvBypqKYHVUm7XAxaoXcPOTJjTh9iR1yWT5q4Lz3PlET
	RlGUnXY0R6/gJ2Albe0RPKgvtfI3mEkNZXxKkP7WTHze8IRbHQipEgUtLji9O0dR
	mxkcQHahknwzAlj8mRh7HsAp2RanJMkGpqyuIkQikknVPg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m27qg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 23:17:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b34223670so1445881cf.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 16:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774394275; x=1774999075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3It4PEVy+km3wKWvS2USN+N6bgWyxf4GAl8CNmjXKHM=;
        b=DLCKJ5vLxdUxZIkrcKwE6x0cErFKwociAEYWT0bf1qO90hMQGO8pcmyQv7snBS9X34
         /b3U+UBZQcsz+v1ppVfw0qwf7IYtYqDBEzEstFWbtUKGP1hLTJCLZQ1f25GIG9EsVut1
         BJ4Dsf+TDxTjAPsLSPpcrXItXU86QICP52KMC1j5eTf244T7iUWVLHF6uwm1YZHuThKO
         pG4MqUg1M/SlkTAUg7c/+XZDm9DT6hagS+sxYAJjVvY8Muvmv3+v6qRtDeiREu3nFRM8
         nQP6VuNCxryS/FFf5XxXBpEERFhXXrTfyiyEK37HJpnkiuYh1nrzwHjs07PyEcxvfxZ4
         eHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774394275; x=1774999075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3It4PEVy+km3wKWvS2USN+N6bgWyxf4GAl8CNmjXKHM=;
        b=BjdxgyQO6dm+fd5DyOedyZHSwDyGbemZvMzya+S2v/OsBBy8MeRBWkYr9rFq5iNhfv
         0AQg5oohdaOBKjZtuDxlXSXHIcovu3hgvhIVBW3BLStj/hthMwf/cEz+WLV/zvVfoDWV
         hOEmVoIYC4m4Mky3BO1MQC0HwAyC47HbpDUkjrI0/XaqZXRK/JMKLFnd9t7Z6gABR65W
         rIYqKPADLzYLXwaydkxYGCl7RBtZMdPV8boXPZCHJUL3cQaBN5D0OdAnlQ5uZsNRn17M
         yv2b+1a/iOwfH0eVJkohl4PpviBheSEMgHxIZWOsiiIe8qwrIjIqJ/KvhVFNxSom5I8W
         XW0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSffbVlmM9xVC5az48HI/cAtVnwofxUR9CP98ecwpcavwiilDAnqVUqKse1x9xgQket/3yhbcrzEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMV/AfXBRn7LF4yTpv1i1knpAIp8dgaPvMPJ+5JvPSiCmHxRH
	0xKENXCLnqY7qr8LsBNsKWo0i4Q6e6NptlZsbaN4r0JHLLAJhL/sRzFzK1o61fDtzKkcGuBcqQm
	05Bw9N6T+2Itx8MQruEi7GHJoVvNjwM8HBmnrFW5maRHvQz4PGNMFU1+fErq+AKw=
X-Gm-Gg: ATEYQzySifd9rIjX+a5XyYYDVU5kuRveqkG1t4+0kMugBMm9gnzFd7OpDXq8M88OzZh
	n4KSRmeFtVH4oQiF2i9PHdZ/jYjuN7pml4NF49dyYpri0YjyuUWhV+kZWvlnmxHc598FXzbbbHz
	qZW5q5gtMuHLv9S/K2J5tRaBOLgwBxdnU3kNE+mMhxuOqBhd3MYFXhGmsWmgOtiNkRt4RqP1bwn
	PYoChEBxYoxu0BJrp8ENjb7GbHLuy0w9oJ2CqziVRm/NoDfW4DSADbkXXddPFJ2e652VrV4yKei
	RmOs2UFBnQxOmVqMMXOh63oL0my8i+aqJvxd/hiBCNiThQPLHsFrZVb3bYj6oBspQ9mCzK5iKQe
	lOP+mu0rrwa+4n9k1YwX/FDT3oVD+TqrSejPzAWV/EfqnLmjSj2GFKIo4iV84xHuuWeR68GVo8c
	Uumr0CKIr+bir3dAuevJb5SX6xo2GNvzDWnuE=
X-Received: by 2002:ac8:4993:0:b0:508:ff31:47f1 with SMTP id d75a77b69052e-50b80e27924mr17236531cf.50.1774394275272;
        Tue, 24 Mar 2026 16:17:55 -0700 (PDT)
X-Received: by 2002:ac8:4993:0:b0:508:ff31:47f1 with SMTP id d75a77b69052e-50b80e27924mr17236361cf.50.1774394274817;
        Tue, 24 Mar 2026 16:17:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a28530cf93sm3387648e87.84.2026.03.24.16.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 16:17:53 -0700 (PDT)
Date: Wed, 25 Mar 2026 01:17:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: bjorn.andersson@oss.qualcomm.com, konradybcio@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, wenst@chromium.org
Subject: Re: [PATCH] arm64: defconfig: Enable Pwrctrl and Pwrseq drivers for
 PCI
Message-ID: <ctxo5pd44amrso2ece3mxvfiaz6piv442xgywywryvmowx7lrf@cwwkbosppc57>
References: <20260324073931.23739-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324073931.23739-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c31ba4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=vI3K0WheX7ZiOrKn820A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: QQzkY4ne-RSAehXoNVKiwi6xzDA2ri1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3OSBTYWx0ZWRfX8bJ4lBlPVoOz
 B//8MnXTNRGUy4G6iKV1ikTucXmgPEodLOtXr4wGm9MMTk+ZlVBJohnliJu8OcEuot3dBKJc762
 lW84LsCukNqOBsyjp6TsmAykiDB31EkhuSyVQbN8lkP2Ya59Tdqy38mbs9s0gUyy0F2w/VxhZWL
 WwXcMTQU99lp/zW18dYmlUKciD9IcblRG44ag20gFA67HVopCAZpKn/c3M0EskAHJhC52Shwli0
 sw/eH3GaPuhvgEU9l1NRCV35bWXIdUXvrEHH5DWA8bTN+NXgwTgsZWBuR+iB3rFvsjg3ZdpXg3S
 TP+6STtvMyE16hQegx4JuyOsOkWGsyEz8WGa3Ipb+WfkFR4sFpxLY5574IcM0zIDLsud3OK09Gp
 uRAmNzeSe6A56Z0fk6tTtPa0GYbRHTuoqLmIPlz94cR660JeQ/2ujiVYoO6l30uZKjn5Ak6vcoE
 WJhYES+ENfBmvUrVkHQ==
X-Proofpoint-GUID: QQzkY4ne-RSAehXoNVKiwi6xzDA2ri1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240179

On Tue, Mar 24, 2026 at 01:09:31PM +0530, Manivannan Sadhasivam wrote:
> PWRCTRL_GENERIC driver handles the power supply to the PCI slots and simple
> endpoint devices and POWER_SEQUENCING_PCIE_M2 handles the power supply to
> the PCIe M.2 connectors.

... which is required for a wide variety of ARM64 hardware, starting
from X Elite laptops...

With something like that in place:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> 
> Note that CONFIG_PCI_PWRCTRL_SLOT is renamed to CONFIG_PCI_PWRCTRL_GENERIC in
> pci tree. But I presume no conflict since the PCI controller drivers themselves
> select this symbol as of now. I plan to drop those selections from controller
> drivers after v7.1-rc1.
> 
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8a5309bb2029..597e013f709d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -259,6 +259,8 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
>  CONFIG_PCI_ENDPOINT=y
>  CONFIG_PCI_ENDPOINT_CONFIGFS=y
>  CONFIG_PCI_EPF_TEST=m
> +CONFIG_PCI_PWRCTRL_GENERIC=m
> +CONFIG_POWER_SEQUENCING_PCIE_M2=m
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_FW_LOADER_USER_HELPER=y
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

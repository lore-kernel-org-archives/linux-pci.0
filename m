Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB36DCE1
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792269453; cv=none; b=XR21DUP/4dbAhggjPaj7acOxYvwq6JaatpJy1L+a+R+jq3kUmuQxFNLKP9rjWMuroOZ6yJlmdoC89ZKmWFRZKRBLXAxd7o1LXG6cnsAEzE+2KzGdafmXot7vBw1GtPGvaA13eCHrs/R/j5KZpRk4AcESe+ov7M8TcPgaZ+oFaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792269453; c=relaxed/simple;
	bh=YE3Ieb6f4ChXxRyMzhHNyWmrcp/krGzNxi1z4AiztY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSIrh6XtVCZJIRTKE19sXBAAwddkl8En/UTdRoTp7j7Ozzx8j8qvjhob5ZE7N5A7Hc18/CJHv6ZEPXUuDilhXBBrdwCNgoNUHAdxLjeef+7mu02P4ZTgkziO80IYHCnBXGfHajbve0/OW1doEzmRhzgiAg1UKbH7+u1SWsdLrPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K0krEDSI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QkSIjOtA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K0krEDSI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QkSIjOtA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HJ0euk368710
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 20:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MJhLBMHk/ItFuz5dehzrpc+coad7k3fTUmxn+/Q9g68=; b=K0krEDSIL6zHn2lE
	yoKUGHiT4EKqE5+ouunqQbWLzZMk4kU8DxJ3k3tLIZYxta+wQ58t3amSWt1+JXz9
	qpjvcnfRiajr5XUdiPj/5/6nFOcpiX5bGXMtzte9xdsMQ4l5kxltvLYyjxKrYlEn
	AMX//nKa7MiMaPp5bvE6LD95mNtWTzAKa19T0W5s17opSnJneoZqIlL1Wdp+RTt5
	2QzCN94UwSt2PN9xnnulxNEaJruI+Tev7ioMY0hTSANeHtj1EDJdvN64TSyBDspw
	ZxV4wMiygxrP/7XiZ2LTwY0teuYZw6Q5EB5A9xOUEaylj/4l/FAYP1a4QlAiP1JJ
	3XYyOA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k1m2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 20:37:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e92aad34aso204758185a.0
        for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792269450; x=1792874250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MJhLBMHk/ItFuz5dehzrpc+coad7k3fTUmxn+/Q9g68=;
        b=QkSIjOtAKIoNYCD2oOf2z+JQKNZBCRBe0qzbM9fOqqUfxJJsQccu9tXPTZVJJaQUjk
         2SASjcDnsUG0rYVsgqg8m6i/B2tFb7D0o3onk0zmtYoIv/cnXw92BqT8pu5sGGH1h4c8
         GzH9ZMZ8IBcxsJJx128TXRbhthTvXDH7/ZT3egXwXHCgKKb4OtOX4m+sBxwus7Zdc3AB
         XT0boOCh3Z0D2X0UwE04c82jeQ1yhjsjGTR7WTIKyiMgjEtGY7YMR9g4tFKOeuc9kYgH
         OPhZC4B6onKcXZrmqf9ru/3bV3A0DiOBozgt5x3xtp5glhd7eGKZl2DP7rmPVBOBFN90
         grDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792269450; x=1792874250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MJhLBMHk/ItFuz5dehzrpc+coad7k3fTUmxn+/Q9g68=;
        b=XNBKq5SYKDLl1NXBJG15Eaqn2vBdat5ZysEA3SzfQkt9KFUir61rJosqPZchMQXk3i
         RK0CofFLIOx8nFUmnkpWtPNz4MqPld7rLSIBi2sWO4L0VMxbfO0xYk2elCChAjSPAV6r
         35Fc8BYVwxHyOf0xdpyIKzUdN9GxFtyvKMpO1d8CsTkogxoknllLa28z97mZhlERHnVD
         dOErRwaed5DzPyba+TQy28ADT7vtsZlMGMoA+AjZJIdz60qGATI0oX/bNMnOXWdpbW7k
         LHgsLodxLXIkDkJr58cJIm39rCSNsU+4i4S6bvXc0RNGLWlNRFXRTLCci/5fc2iG7TX7
         /5Qg==
X-Forwarded-Encrypted: i=1; AKwUvBzMbgVmVtNqER3Vb8e/wXNgP6FMi7En2B8REAzSuh490Q+Rodi4mOn2f7UAb+nAbL3ehp+iSm3vdvc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKX/wdUoj/X3aldwvrZMav5ZUXViN0aDKReruzOhDPKpx3rRqF0
	/KOKyfg3tyVkDkR9oCWJpg2cv0rrL/znHO4/nwUdHq/Opm0qDiiRtIVSGeQn216PlMXaBzMzHat
	dKcFbgngqYimiP8AtoTNgeoSa8w1WC4dqvGfAXp4DLYjRPt8dg50j4bROREHOIfI=
X-Gm-Gg: AYBFou1po07XDEed+A8CK4thpxzqsIukpjQUS3H0GYImZk0x+x1sL/gIUepWmqZYlQT
	nLVPZmqGFRKj78FMQcB92cdv8tvHsYyDkTAq+7dDXQMuTbx+KFwrYNJ7aGohOrc17w/bq3YLPgF
	oTa0lHxrimhghKe2spvboTn+uPkjyI68KTPQb/X7lSubGaVtst2Zfg4Ca2ZbpaGnM1l2pCJeUc+
	FmjoEPUQgLf/MFVT/H1ju+2x4nUvMYkauU+IzGcYsyZVQdsWDJp68JSug3xxOTGzjOcoFBCIaYa
	6AVnmpM/NbOio6LyLsySh4R6Ex/UyHKF3Z2csgyeDnH33vR05VswcegkPXSZMg0H2E281qXWi63
	1dbZ/xplNdWS8p9pgDvvr5TlgKloTsQALz2WNOeVjMNZoBCqNit9hYnjzfHRlVIKeVVTSkBQbBY
	IrvRySL54qomLF
X-Received: by 2002:a05:620a:454a:b0:93b:c58c:d3be with SMTP id af79cd13be357-93f29d42f1emr640284185a.37.1792269449753;
        Sat, 17 Oct 2026 13:37:29 -0700 (PDT)
X-Received: by 2002:a05:620a:454a:b0:93b:c58c:d3be with SMTP id af79cd13be357-93f29d42f1emr640282485a.37.1792269449235;
        Sat, 17 Oct 2026 13:37:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab16e6b861sm15582451fa.21.2026.10.17.13.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 13:37:26 -0700 (PDT)
Date: Sat, 17 Oct 2026 23:37:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-firmware@kernel.org, linux-pci@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] rockchip: add PCIe3 PHY firmware for snps-pcie3
Message-ID: <oafuwy3x5uybkcmrmk7nbtnakbbt4aiiyrduqalhifai6f3prf@cjbg65wpvly7>
References: <1792049275-83785-1-git-send-email-shawn.lin@rock-chips.com>
 <cff4d453-2662-4f6a-9bf7-cb6e34df640d@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cff4d453-2662-4f6a-9bf7-cb6e34df640d@rock-chips.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA4MiBTYWx0ZWRfX7tApc7IUP+Ba
 gAdfHDcADj8+YMT8dIvfFHS+uDPE44+2W/vsEWMv788RAyV4FpLdR/YTbxFqL4J6KZhz/WxF2FB
 CRnWLHc1jnKe+2/nzKisgNYeErgXq3Vsu5/IkhzlRtwtFicwlrqiVnST/mLx0BtYyYGvO+0h/eM
 ONMYcdyk/bV+KqfmJfJiVaV1wbLPjRpnjf93X7yy+zrerYRUnggJT92JcN8JebwDDasu/G6JttB
 jlLydOAP9xQ2k/1FlC2NA+06uABb7tXIkcHjl2G3DXKGIm8I/1Q4bOjHbj8dub0ryRyF7dymS+2
 +9PlD/6PCqynoBTQNZYJ8y9m7cFsDAewj0sJrpG/bNd+Z3sp2XHYsEa0Bo5OMUcX/jv1+UmRJRM
 LoxHpi1aszDy3VNmmvFlrmuvsjHtmN2ZpiWZ5DMJbjKRDbmT/BifIr0H14m+bn+JbSDCqbNv+gP
 9HYiR6qZh9D3xSxTyEg==
X-Proofpoint-GUID: vJiJqrd1drkKtyFJDfeUc7UuOhm8laMZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA4MiBTYWx0ZWRfX+PN72HCUUNR0
 FMfCADb+sYkhP0O10bpbp62Zf3lrg2zx962R4EeOyWe5Totir1u5P3xiMFM33wJZT9BQ8Zvnsu6
 +ppOAg3tyhFgbmQs5VChobtFSQ8FC20=
X-Proofpoint-ORIG-GUID: vJiJqrd1drkKtyFJDfeUc7UuOhm8laMZ
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad3dc8a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=s8YR1HE3AAAA:8 a=Fm5Bng6jeHhnGR7Go6kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_06,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170082

On Thu, Oct 15, 2026 at 03:31:53PM +0800, Shawn Lin wrote:
> [cc: linux-rockchip]
> 
> 在 2026/10/15 星期四 15:27, Shawn Lin 写道:
> > Add the firmware binary for the Rockchip SNPS PCIe3 PHY, used by
> > the phy-rockchip-snps-pcie3 driver. The PHY loads this firmware into its
> > internal SRAM during initialization; without it the PHY may come up with
> > a stale microcode and fail to establish a stable link, especially on
> > RK3568.

Thanks, merged and pushed out:

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1306

> > 
> > File: rockchip/pcie3-t22-c8g2-1.6.3-202a-p7.fw
> > Version: 1.6.3
> > 
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
-- 
With best wishes
Dmitry

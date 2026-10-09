Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477B4DDB4C
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552238; cv=none; b=ZK//nj4iStRmgRfgpJFz204JPzdKo/7AE2kIVQfxeE2ITaf3Y8ngGNfH78qerNqS3Pfa3iKv6M4EsGtTASm8c8kgCp8x5lYnMV4xwyUuyNr1wDxK63U0bckIHI3w+U9usTHmLyByjv/7ABXWQGj3ncUe5168f6CSXC386E8lBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552238; c=relaxed/simple;
	bh=RDoVcNfYx4gWnIuXkIiuuDySeKt6FSVcYGy5RTL4yVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUZSziWM2RwrciN6P1Fgq2Q8PKoHuuSh3yJjkoIAnes3crWpT9IgfCEXrXQui8qaDe0+vBchCD9p4eVBPfh5jiGIgzaplWIGrb2E1gBAQwKL5FSkoDdG2FILVZc+33jCzo1NL+xugJA/uJ4Zm6wF+gyC26rVk5ovq1pmYg/SbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAodCrab; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hghnHY6a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAodCrab";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hghnHY6a"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DKv8B2290235
	for <linux-pci@vger.kernel.org>; Fri, 9 Oct 2026 13:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pTb/nAfNcf8kmDxbDKy+Ovtj
	nlCj5G5u+5gd5OlFFHo=; b=ZAodCrabe3fUrhjjoTHdRkIIE87+b2J+h/B6Geh1
	tmMSwvyuWk/IZnKg80VRBHtUP0RGB5IICsSGqhbUNxZCg3meVXqjUv/vyzAuSfen
	qRIwkQLhnCEbkulp70eSu36zEg4UXkthNNn+1HQHbRZirJuWG9zEDQYmXi05uZRW
	yp9125PWxK8dR5KwYaAXqCcdhXaTtZvBipdEdYsaXUNWa6tWu8Vd7b7u/hRS+/iC
	feKdKji/X+1y8JP2m4ZCPQyumYSvSbQYn+I5Pd7M3hPWX8/cQYUplxrgkj1hic1C
	K4lmOk2/oxUB59s7Z+iU/BH4MtqZwZW8eae8MNXySAwVSA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fyj3ssq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 13:23:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cc359d9easo1075599385a.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791552236; x=1792157036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pTb/nAfNcf8kmDxbDKy+OvtjnlCj5G5u+5gd5OlFFHo=;
        b=hghnHY6aU/io7XZYXfAwv/vwENUjMbD8HmBeMxvSPvo2HW+PP0/70j+1Sa/T5QsjVa
         Co+N0C+8q30GnnYEYQLfUbWI+tKuvGNb8xcLs2GI6V7LfjeKGaJrlL+mfPwDtXgy1+2U
         KvSoZrpHPlhb1vhkVwEasb1uG2b4AZa7CXYo/r7uwTMPpK+kJfyOovzvHVXd4gTCsN0N
         DeetdCuzej9wVTiP1Aqu52upy+OKM3Wn+b28D4OmWg2IJCZvPqz17aDluHrzkHxVmHo7
         YGTC2jZCigT4ZMCUE7j3jzVrifrDYb3iJXDl+nackGjzOZMKMQIJtB18l6xYaBx4c3iS
         euVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552236; x=1792157036;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pTb/nAfNcf8kmDxbDKy+OvtjnlCj5G5u+5gd5OlFFHo=;
        b=G9N6LEoVztftDXWwrqEZc2uFrSFMH2Adpj5/Nwy/RkgQdhfGwL5FJbNX3I8mbCHd1g
         WO2Qhh4/q1aB5+i9cs4i1q4ICQmvQELhJyrwLzQZRSSstPQyq0IPqpyJxSqrsDBlH/CA
         R96/5mcbVlxAVikPdi1hsixFOYabO5Ii56NNZytdRj19HQhrWJDFX2mu6nwX86ZnlWLr
         w4vd0xy0kehK+DCICB4y/pEBOTLzoqbi/5WdjVGAc8+b4HivPlRVJjgYgk+qC3GkJAXy
         +KTxPHPvCuHXTY7vj100V5qWRWMwU7CJyRF8+Q50FemEGpaeJyexEyShbb9ze4+d1wKF
         P97A==
X-Forwarded-Encrypted: i=1; AKwUvBxHGYs+rfdXKbLvEoIYryoCdm4WhPbulEIY1kszwOP6dGgdTbVMMGWNSCem14xvEeVolcwVrfEYfOk=@vger.kernel.org
X-Gm-Message-State: AFuF++kAnFhF5sd8zBbBMtT2b+H65wzvFtV464q34/vBH2bTuBLr3wgo
	OmpjFD0fBxlCuWxtQZVt2XPWFIMajBAriZ0v8uVYTuExD5I1uQg8rSyLStj59o/X3yRhB0IE/0S
	PssEor3hi3R4Ua22iBJo8IB7yf4bIb13DEyneQPAM6XeeDYi94ghqiy9UyGLcfqA=
X-Gm-Gg: AYBFou0IAUGgzMdGDe7oKE5MbZX5vYn6ve4puzUuogA5HNGZ+Tj6N/G8kP0niC5qtFE
	ok449QR2aBAzTAMJPVPNL9D5kzQdwR+alOL2shoyOtEmfuqo8RWM6KuBAyiO8pWWbv/kIDsb4MZ
	EhdjZTfXffQwXlGdfOSWKMn050/qSjaUgeuRaSaZ4o9wcRT6J6/J1trRVtH7OmHvYr61jq+n16O
	aphZfasbNLIL2xqPPJf+q7rgC9sGjYscdfSJyzAwpKGBNHiVilkx18UACvBnd1Por1sIL0eCeD/
	FJ+SScfV2b9S1c6GfVSb8yRRw2D7iNzUbtmAPJxdNsWeEiHOyPN0GUYtgqgtT6G1pZ633VUmzAY
	oGVERjusI8dgUhiSF6SvHF92faUqyceC2rTbO945TxCrDFg76FE3WRprhKR9ZSjL/2opgxCUsC8
	S6oI+2EVaR9XiZ
X-Received: by 2002:a05:620a:4586:b0:93e:7ec0:7c63 with SMTP id af79cd13be357-93ebd2751d8mr253000885a.57.1791552235223;
        Fri, 09 Oct 2026 06:23:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:93e:7ec0:7c63 with SMTP id af79cd13be357-93ebd2751d8mr252993785a.57.1791552234456;
        Fri, 09 Oct 2026 06:23:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcddea81e6sm634124e87.46.2026.10.09.06.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:23:44 -0700 (PDT)
Date: Fri, 9 Oct 2026 16:23:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>,
        Junhao Xie <bigfoot@radxa.com>, dragon@radxa.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Daniele Briguglio <hello@superkali.me>
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: qcom: document Radxa Dragon Q8B
Message-ID: <kzqftw7lugumzzkafcnsa36n6nix3kmwee66bzlv67aoqrkovc@7lbdhwfchvp3>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-3-eda11e5dea8b@radxa.com>
 <cd97e6ab-eac0-4482-8b85-455ac8730241@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd97e6ab-eac0-4482-8b85-455ac8730241@kernel.org>
X-Authority-Analysis: v=2.4 cv=BfpNQbt2 c=1 sm=1 tr=0 ts=6ac8eaec cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=CDNH-pee2JQSj4idvpEA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: VCdZcMfsa7O5Z4xq6mG4BuGpvAzbYMq7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1MyBTYWx0ZWRfX2N7d4VrfIu1Q
 4Fn4KlLAo+4WtnmkVPkZYVwkrVpoPJXpUqCJdGYRVKkoCJZRMzwwmh70vvsJ7JyheV52Mm3PWgx
 dt7AWUgDER57escVK9NI00UCUu12N9dM95IwxFI5IFIiBerSuIge2bgPo5FxqBUNsBD8N8nuhq2
 ozZeyeYxi0n0dLAlS8+z3NTX2Fs21e0acl8lwWTQKJMBbVm9CbXu7dwDav0pOQXVS6plr5h5JIo
 xtg4hBb+UzmApBSM+duMvSAGlS8auL5oMlTR+pNTrcVNY16ABpsR/Y1KVOrMSVdEQaoH+f7HNj8
 +qBaw/kJomDd95O1pcRIFT8PV2zW9vOM+5z5TZ/W+PPYk0RJDBf3JA8kQVlRhJ2pUzDLXCCCZei
 wZVnPqbi5kpK3leJVgDpJ3p20bGcg2J72uHQBvTCDImajZ5FlT7HNJQh9Z73CNFrPceh8PM0vO1
 YenCP7tAzNHWqIxqYog==
X-Proofpoint-GUID: VCdZcMfsa7O5Z4xq6mG4BuGpvAzbYMq7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1MyBTYWx0ZWRfXy5SdYJ35lRBU
 6aVF7/QIBNGVXhoSKoRlutYz80t+zhiXe0PNNGop79g54+su48sFiQufHODdKQUhp6ytNSvJ6wV
 3hJ03++DcDNHOf3Dufgp9XmQbezld0U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090053

On Fri, Oct 09, 2026 at 01:42:11PM +0200, Krzysztof Kozlowski wrote:
> On 09/10/2026 09:55, Xilin Wu wrote:
> > The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> > SC8280XP platform.
> > 
> > Document its radxa,dragon-q8b compatible.
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Tested-by: Daniele Briguglio <hello@superkali.me>
> 
> Fake test, drop tag.
> 
> Why is this so problem to provide the tag ONLY to the patches which were
>  actually tested?

Please teach b4 to skip to skip Tested-by on dt-bindings patches (or to
have a flag / config to achieve that). This would solve 80% of these
issues.

-- 
With best wishes
Dmitry

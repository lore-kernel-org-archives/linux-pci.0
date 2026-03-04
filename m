Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7483384247
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668420; cv=none; b=LAlTfYOdCcc20AchXG3ouGfIhGkijfWmIiWi+FKTgKoW/3LYtAk9/74D5g0PnHasXw2vZVmSGsk6mfc6i4eTeZ3Yqnn4XwUSjjGeijsmi0Q0ViziTZhIySLrEL/Wg/ENAUMZl7aI3FWOsVePPguQIz5ZK2VtKz8ivRJ/Lqta3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668420; c=relaxed/simple;
	bh=hM0fx+PufUG+eR0kIJ1dr4h1ANr/zb80CpZtG5LPG3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH6DjdPSSLf7v4BoX/3WDAwj6JOA0YI0WN50x1MXbhk3r5xajl2fmuFFuhiDPxEtN28MQfozOd1nSO5LoVzC1ZY1xvZ17dKlaSE+qgxKd55xKSfHs9FE2xXqCDr49gJHIB27g3RcBlxoJ+bEajSnoBcjZDZNrUZYNYLuDNYdzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bHnTZhnF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BsK7qQ8l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHnTZhnF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BsK7qQ8l"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624E0bo7029448
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2026 23:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V50tlCURGOSWEpUNVC/f5JBG
	lAu9WVw1+uCs3+cXy8Q=; b=bHnTZhnFYn/tiIi8J4ULThpsgbab7UrmgW5OOJJi
	m7XwaAv8gzL5i/PPJCFmKWpARNfKhBWcj2eQ98Jty0ias+PktBjqdKCkXAPaELNj
	a0Gl+BUEEowrMPAKllx/ORmbxKvdbnv06gsWNMRC4vNwMWDRsN+/Umbybcd+e88B
	r/+5sfU/Jr5rGByjhLIWV29LUZnpLgy3RQf4wS6C8MkG2aHm4Hpng0Hc/lXMymq8
	+xAymHfPQW0I/zSIuwudwEu/Xyt9EGrksONWTgra0NIIeQgGca3xHZntcQ/B1uyx
	S9yybI9F7OtwJgszxO8ID4FgfjHXJVcqqpvfDRNL7lu1yA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpp4fhqw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 23:53:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-899f1c1e4d6so296712346d6.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 15:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772668417; x=1773273217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V50tlCURGOSWEpUNVC/f5JBGlAu9WVw1+uCs3+cXy8Q=;
        b=BsK7qQ8lpgf4MccOs8W7P4/DhshR1Te1sl3mDVTFek6FHBU+SP+YnG91rAsMrSiBqI
         9ZI/l49Go+6X2HLBzEJuQUMqPhS0X21IMF5frdw7o6p9+WiUwihLtOucPB4UwcVB7gR1
         /TDtEKV+6eRrKNTjJVjUEslUBQ5NnWU/e9vVl9ATl97WjFl5qiYxpUVMnoDmE3yXf8Fl
         yGu1qjp72SH1jaPwdnfGvB4t6p8C23m19vvnRxN28ms3opiktg9gf7H+SBz7N5rm2EmS
         oZFO6InnfnmC0OlubIJXakoZV9aFBjmrxoeKGbrYw3Fk8nbvhs8RM2xp5cTA7BfjB0Ug
         XpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668417; x=1773273217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V50tlCURGOSWEpUNVC/f5JBGlAu9WVw1+uCs3+cXy8Q=;
        b=QW7owmTUdeuHT1y/3X5+lcallbX131KrUDeHMMAKik6HSKYpwz3hra36vR3wg5omtW
         RhcKi/u8F280TUlUq29sjySPJjENdgOna+POzHoJSGdricuwUbl6siY771i5b9oulOnn
         BnQPtCaHG2B0qhCHgmOOMD03h+cTUWNpNsuL6tt/21Mn5qJYI6DWE5rlPRxaRVRoAx4M
         olZQHLPClfXqfdoV1lNVbgYKcMxjHe6nFu8TtrODUHS3wpeod7kP1jb7EiMkPzeqwxXk
         WHkTc/UObOuljp+tue3+gd6pp31krYkEfnqBcDjac0eJ93TK/jmvh+zhxCahhL5WR68R
         AJAA==
X-Forwarded-Encrypted: i=1; AJvYcCWbvok6Zjzkmgr2fRXgIYWvlii12q+8yFclXhGlXfLWb7vtMuPmRunUbiT4RyLGuvzXcdQC4qe/mPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJxyxLf3nzEtLnfga6w9Tk4MLtRpq+pUxMrHlDIkOoB86HdLl
	5fSqg0bmUF8GGqZKhFb/AmEkapn7AeyuSXPcoJO3gU+6JRjWoVlJyhxNHPs/bB9rWMSp9dJRbJj
	QMbWPe0YHT66wnQ8RVSu2iu/B6yQW5wrIv4ebZbdSyfq0J5s9oJ1hwmoMdYcjhzw=
X-Gm-Gg: ATEYQzwBRrComJVlji9+y/qaSFZQVtLXwHcuhRjsepMrz4WSPdTdaC41lksnCyYs/Mn
	wph6Myr8crZEsECiQSgg5IjayR7hvhEBRlBXRUEm0qqR+soxBR9yoJmEDYlMlc3ZhS/fp1JcdSz
	28Qgd0AZvYSKUSZbmaLPqJ7V1/lSQO8rvRDNbi3/OkAGL9ysTHgGvaHiK7hRlecD4iQ3O3UwayD
	OYCg+8gu6lR5Gli1NYayar4cCundgSQMXZ93cu6M58mzhv7PUekvFYOdvT+ok92yFquME8ryShq
	N9B4thlFA92nmri6dx0IeAFT8mm9c0pFljyGRl8zp1OXt7OLq4oMD8UwlPXKGQv4JMGXh6RMRRi
	37easgz80hZEFenvzBO4QE5uvI20mawkQVB/rqTd4pkkkqkMvkCbIBk9pfkwv2Y94eDdJrFNHBj
	KNhl5FhnnvklRmUgQbOgFvi4MrsMOTM71IaJU=
X-Received: by 2002:a05:620a:3727:b0:8c7:c25:9e53 with SMTP id af79cd13be357-8cd5afa6707mr498608885a.59.1772668417061;
        Wed, 04 Mar 2026 15:53:37 -0800 (PST)
X-Received: by 2002:a05:620a:3727:b0:8c7:c25:9e53 with SMTP id af79cd13be357-8cd5afa6707mr498604985a.59.1772668416537;
        Wed, 04 Mar 2026 15:53:36 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1296993a0sm933837e87.31.2026.03.04.15.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:53:35 -0800 (PST)
Date: Thu, 5 Mar 2026 01:53:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH phy-next 11/22] drm/msm/dp: remove debugging prints with
 internal struct phy state
Message-ID: <esbforcln7bi4e5enmgwqj7d63usdyoobxyo3hwd4paou56aoc@kjlizz3ubksd>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-12-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304175735.2660419-12-vladimir.oltean@nxp.com>
X-Proofpoint-ORIG-GUID: tyQwgHhl3t3y8a9hpuFLuWdC9Csnm-Lw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE5NiBTYWx0ZWRfX3+41HRzxC5Bv
 BQsbQrJ9fMMpQsjtvxJut13Pc4DBeY2ctFQtCoFX8rpilEtdLPqTxbHiJgMKwhyC3Lw+QS2jhfp
 wPvheZ+BZ/o1pOKeJdO0WLPxWcwhdQit8jtPY63rheF1ky10Hj6ewMivzBl6IqfzSNG/xnBnrJR
 Rf91YUMsSI9vslOjjHdIdjtqsqU7sXMD6SfBzBQ7vi+reuaLG3GsYInII9k6eajXT4ActYc4i7Y
 PxTt9JGVmuV0NZeu5sp+7ZBYEflNbIEI3HZ0smY568A6AIyXmx8lyP5CDxWdFSk2UwKjIRCl5l3
 2w+c8hfdn40kmjp129GsgCh5gQJRNofHNkgcR6CZdHYB+otHyPK9E9/9ViSgrF67t1cxLRF0pPh
 Ec/cVjI7Vg3kxub4xwj0bqaAdEW1TIYDt0kkVEnVBzN4+2m3qvUvIYslrwDWTwwAVlkSXPU2fzg
 ND7sP2tJe/BlfGIJmYw==
X-Authority-Analysis: v=2.4 cv=CdMFJbrl c=1 sm=1 tr=0 ts=69a8c602 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=8AirrxEcAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=3ogKHO_BN1K2bhpmqR8A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=ST-jHhOKWsTCqRlWije3:22 a=-BPWgnxRz2uhmvdm1NTO:22
X-Proofpoint-GUID: tyQwgHhl3t3y8a9hpuFLuWdC9Csnm-Lw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040196

On Wed, Mar 04, 2026 at 07:57:24PM +0200, Vladimir Oltean wrote:
> These do not provide much value, and will become hard to maintain once
> the Generic PHY framework starts hiding the contents of struct phy from
> consumers.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

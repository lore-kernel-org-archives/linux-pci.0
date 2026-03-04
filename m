Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0914388364
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668483; cv=none; b=hyquS1dQMTuoa9TlB/ZkdOUP5VDwbjcfUP7rhknXJO4qOPzMT1oEUHuqeXf0KXXNKrkxFFWe/YRmmhZYz722D8Vh+Z9ayu7kaIbHJj96cuwjigkYdzRYosJ1bZKuJlvUBzL4/H9uxhAA125/9z6ca+Bc5tDE0J3oQstcYKseOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668483; c=relaxed/simple;
	bh=EHwy5JNR4+Zu1tdmuN78UyKkfOq13HkK43t7lUXN9Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaOMc7/KNLb0jxVP3y5U/9XyU1vkrxeYOQQho0jNk3i5b88GeNfv1ZvKXjskn6jOXLLG483DMCQlXk/EAS5IT5t9iQ2IRoeRZeADh+TwL+l1l/jCJDO5EkL2lNeRFPvvn2LtIipI8KKr3XcmxEVMlwMcGp6ojtIHKTxszNwlZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YDzVpAV3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNvDKJTH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YDzVpAV3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNvDKJTH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624HHjY62494780
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2026 23:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=D9sak1pWhxVBrwdJ2BGlDRM1
	u4FQCLLwnOBWXp3tU8M=; b=YDzVpAV36G9FJiGclgosp/BCt62vM9M9b056E3f0
	U+5xxlejiEUamIMH96BixcO5AaY77ZWBlSAKvu5XqmjeqoAku40urrsPuKmmnS9v
	3OkMLayFRlSKj3dBR7WZsu0j9iU2lRzpg2d7kLVS9w5ZRVAO2FJ6BsTzjCt69c98
	JFzB7UN71X/+3QF9qLWJGMzkqHwQXXEY1ttgq+wcei0KjxR3Fsb0D++XmNf1CbY5
	5aKHM5x6QqkmdYtjls//+oqXfFNFmC5IchUi4ZbV2wIf7afsnXeYSOnIz5G6c9dJ
	RXin04p5y380S3mSuZNgncUGt9sD1j/T6Lf+R7oqd/C+mg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0wh1ge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 23:54:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89a15bb70easo59796096d6.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 15:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772668480; x=1773273280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9sak1pWhxVBrwdJ2BGlDRM1u4FQCLLwnOBWXp3tU8M=;
        b=WNvDKJTHZVa8Mp4K+8jW++DoQh14uzwuQlv5PUa0f7Qt86EJ0u84PflnnNH8oGtKGh
         CXPz/YYX8iN/nrjQiKR0Y5bCySvGeb8CD0pdWbRckB8rhjQu32AbdhnlSYx8LYfmn/ip
         +ByAldFvFHz0KBkb/wGYP/DBk84lW9I0qOvfQvTseAlkjZSLmaFHEJ9TQjRjNa19zFys
         WHOv9nKepKkNCEhkPNxRCaR7c5f+J7pNpZGZdWp5dmW+ArD//1NzgLPq3wss2nE6L2+c
         OBTGOIK4b5HHN5l+EV6RL4fgwEzazA1f4SGEcNTLWAj7P+G90VGRzfZRllBituq8aa8v
         VF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668480; x=1773273280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9sak1pWhxVBrwdJ2BGlDRM1u4FQCLLwnOBWXp3tU8M=;
        b=jhYFP47EeIIaeZQPN2Sr+a+8Xq8ngL+jXD6Tj/W/ql35FgC7UUYdiNVVxGtkDM+OLh
         umqJrCrz5uXYK5nm6sVa4oJoy9s646ZNCFfNSumJEmZ0eJhQquBZwJ/cE9hec6/dfKBK
         c+x+2T9cAF0ihdxnHEGqfJbXJ54ZurTuNegaS4ly8/Ty1PJjsPuLZ/6W3YY1RtqBrdi9
         9npwN6yKVMrfGQc6RhILdVQBtp0wBo/yigvvLp1uin0Qi/1oSrUJ2Rmv+VgH/FwbzQTx
         8mGg28fC1bQA3lylRb3xRrJwrPUeKnaaclb9tnsz0QbuVbBAZaegxoTkzfPkOA3C0ZxX
         PUyw==
X-Forwarded-Encrypted: i=1; AJvYcCUXaURnYEDAI7hEfkbISvPkcYJgFSols1JGzHG66PA4ztmLaI4Kx1Goo7TXYu4fZ/gz31gXDFqqABU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Yw0jWqC+R/FSaCQmUq0Ck8ClfpU939uBJafi+3OAMO75/Y0d
	SIFxJ+nOHaawB4QYB4Oio6G0/Fbnn77po5ifKwuYN5UKact0YvcXD4YEvEVplZsmk9ojT/ikokm
	VCQjKAc48uG7KQlwz/Fy8iXK8Q7XSX3lJ/XMo+Q/nXzGf7BTIx8vddeRxQI692k8=
X-Gm-Gg: ATEYQzyXHs2MhV5YShtgNWR0GIx279wuwpyO/Ut+FVb1QEN03oJPW9tgRlTPVsvaIJl
	YLWCiUANWk+A7bGVy7rZlzCB+iUqRt46q0SI2Gnr7MgN//765SI2tQ3StQO70ehWDh1fTsTwI+f
	WUr86bqDrRvH5AdPVrXZPSqflEpbHS7lqTXMv+2lRKcwK1YfiJsZN4x2W1cS4hy0PXCrqV6va7U
	jJOVP83bPKA0MUgP8FvsXvX3klYR10nIFwqik1aLoURUlFZdlCEECEjsaAojAUY6tOxeeegWrvM
	RPV5puun2c2nfGcYyEP2lac5SAg6sQ8G89RY9jFTLDuASWLy1XbKR/OHOiVLQyarOoTKoBSyfbF
	FPSkWM/gcYZq8grAxtuqnz5FbzAmiK59/z1t7RgEa8wM3efkn/4YOMddOUa+dDREK/9ge1dlqBr
	VdvXPiR/eJJ0bqZ99FmN24vcG7wwSzQFbdYIY=
X-Received: by 2002:a05:620a:2986:b0:8cb:5442:d537 with SMTP id af79cd13be357-8cd5aed61e0mr519315185a.12.1772668480070;
        Wed, 04 Mar 2026 15:54:40 -0800 (PST)
X-Received: by 2002:a05:620a:2986:b0:8cb:5442:d537 with SMTP id af79cd13be357-8cd5aed61e0mr519310585a.12.1772668479418;
        Wed, 04 Mar 2026 15:54:39 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a123573c42sm1615588e87.72.2026.03.04.15.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:54:38 -0800 (PST)
Date: Thu, 5 Mar 2026 01:54:36 +0200
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
        spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 12/22] phy: move provider API out of public
 <linux/phy/phy.h>
Message-ID: <cleew6tvum3jnflztfcqfwtafu4hjizjvebzr7qrsbnnp7vvrx@fjqhyh57o5hw>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-13-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304175735.2660419-13-vladimir.oltean@nxp.com>
X-Proofpoint-GUID: XmzyjMWQNPjBqTfG4FZoUT9a2K1OxcSc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE5OCBTYWx0ZWRfX98JG5Vl+QBjQ
 QrzoEQfEvSuY12qhx/zu5JeWMP2bdbnJfj+WrWngGuP21c4T/UNalvZEFIZa5IHX5xSgNdclyp3
 lqH1LjzQQ/7TXQqgHiZP9sQNWpmkTthnAKBoPTs8mqBype+O2UoU0ik6g2+Y3tJZ4tdAtSfwAbc
 s1mt4EWBs495vM/sSLgvWD7AuJ5++Zvpj/6XXcmPpxkRp2tBOz3xqJghPJjtf6ISK2wrqKbcYQY
 gont53VP5tfUXwEvxqIBLnH9xYEqMqsC5AcVNbKWgUkpgveAQMwwjmbh7URNL3EOZC8giGHYeh1
 thlzmYLZAiwTMnksx0+UtACmJ/e/3wjkD8wnKBI7Y5xIeGGu+/TlwESwoj0fAkNKoAsoXpWS5G3
 XhbWxAZ34vfZLOvXtvdUx51rCLXbLaD9zwXgeIK7R4VY0yZlK8SsCNkoe/+gs/gkeOj72d3Zbwi
 bdP0bwa2+WqXhgwJ42Q==
X-Authority-Analysis: v=2.4 cv=OYWVzxTY c=1 sm=1 tr=0 ts=69a8c640 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=8AirrxEcAAAA:8
 a=EUspDBNiAAAA:8 a=lO4ColjPjyWKUZOT0LYA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: XmzyjMWQNPjBqTfG4FZoUT9a2K1OxcSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040198

On Wed, Mar 04, 2026 at 07:57:25PM +0200, Vladimir Oltean wrote:
> The major goal is to hide the contents of struct phy from consumer
> drivers.
> 
> The idea with "phy-props.h" is that both consumers and providers make
> use of some data types. So both headers include "phy-props.h".
> 
> Two slight points of contention.
> 
> 1. phy_set_bus_width(): Vinod explains that despite the current caller
>    situation (9 providers, 1 consumer), it is a consumer API function.
> 
>    The use case is that the controller (for example UFS) may have
>    limitations and should set the expected lanes to be used and width on
>    those lanes. A number of Generic PHYs can support multiple lanes and
>    multiple width so this is way for controller telling I am using this
>    configuration.
> 
> 2. phy-provider.h should go to include/linux/phy/ or to drivers/phy/?
>    We do have 3 PHY providers outside of drivers/phy/:
> 
>    drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
>    drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>    drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
> 
>    but the practice is not encouraged, and with time, these should be
>    moved to the subsystem. This is not something that I can do now.
> 
> For temporary compatibility, keep including the provider header. This
> will be removed when abuses are all gotten rid of.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/phy/phy-core.c        |  34 +++
>  drivers/phy/phy-provider.h    | 256 +++++++++++++++++
>  include/linux/phy/phy-props.h |  75 +++++
>  include/linux/phy/phy.h       | 499 +++++++---------------------------
>  4 files changed, 458 insertions(+), 406 deletions(-)
>  create mode 100644 drivers/phy/phy-provider.h
>  create mode 100644 include/linux/phy/phy-props.h
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

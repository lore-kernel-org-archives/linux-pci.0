Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A0D49BD79
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538236; cv=none; b=rl073gbERelbtbTW8TxKGuac2Ap/0ld0HK2pxuXueNlCTfXqDUvwNjI3lfYY593TJvJIT2ODS45Ic4zOwIYnBySGCDDlhNOL9UB4HYq/LvEx0Fu3LRnEgI5n2G19Nv7JbmqsGDfzFO2a0C3uvAeJAIo0fQDGaGKUdUrvysVyQKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538236; c=relaxed/simple;
	bh=0fZcDdjzml995T9oZE7SVaCVuqTaThJLBP842zH3xww=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IbyIuHd7RQnB+Co56LS7pSOLqRHtrT2lXcPYHC0bJPaMIZPnrCJHHt82bEpZhA3SHLw8faJ9tpv6u9LWIA/JzD6dvaru69StZOBTn9QwMdFbhcyZJgU/KjzK7T5LyKIIcdf8IEXKJfoO3+1locdRUDGmkTcO2QfAROCmBfp/+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WT5YmW+C; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WT5YmW+C"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so33049115e9.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791538233; x=1792143033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ySxG2l0k4bpp/Tb+8P52vg4ThV1MvpjerUMZY+o89W4=;
        b=WT5YmW+CZri0kY3T6LyvGNKYhdk4kRw0luCH+HrEDUL3TcZPuM34HBrW6iX0I+Oide
         JRys8xQCqUPdQJwT0w998GuJFLJHAX+WTEG4aNjjVxeFXJwwHb9ozoc5fRvTHpdQ/9Mk
         91EM40r0e3ShZy4FAiV32Ihl9k7aHOTZhOG08vmb4Tx9uU/5esQnBpBBf+2dFxeOGnLd
         gkkbuO7BfBLE0FOUP96+n7IrLT/Q7M7HlJdeHZ+z73M2ExX5ZPXjHSK0KUEnDO4+3TXZ
         A79XEpizubWC3sm0n4EkJcITztUww0ZWNBNIp2ytYLAQLSj4WGk+tVTcc9RAYT8IXiYp
         gIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791538233; x=1792143033;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ySxG2l0k4bpp/Tb+8P52vg4ThV1MvpjerUMZY+o89W4=;
        b=vF7P32tvxYkrwmzfodU8jIjG8XLWvMNpaNcyBF8uCI+XEYsAjRZHyJoZ4PY0RMMMpA
         agos55SmsSJkYjZqfQSRjXap6k1xCxxoxmJA6m8kK/V0RDz8+YqD0liDxXFSYVObGLFd
         Md3az0QpWwT3Xt9wNDuy6NgRFrJW5XOyREnTiR+2cYOXh6+N/vcv6oHHW6dW9xVdMij0
         eedrCvS//+q6la0j2uvqNQ04G/ABFxVmxWB756+Oi4Iw59OWcu5SI96hRjTdj24lokNL
         sTyM3L/mJR+DHiLNmAIwy8xzlyZgn7bYz2CWGcD993dJIjiemsNAz0yhSi01hHijia5j
         em1A==
X-Gm-Message-State: AFuF++nG1X981TKwf8H3cTD00cBlREL2LcJoAloAss90l2mXY2WsnRbt
	E4F98N7Zy6vuG5MLhkm/NRDmE85I5CDO2taYI0l8BywwbFQ7t0ptPYh2O2FVIyPSv70=
X-Gm-Gg: AYBFou1NuDoz8mugOG5ONq8JtIiD5rn9iFvKDnWFHKIg8cyXLth7qRySqQo618Wtj/D
	edVoO9FUDClGIuqnK9+hdwyJ5IK9H9EZbKGS2A89luIOL91keKqyZfmuilo3+FDptnKyFkmGWFh
	k7AY4vgF7H2H62/MEzY1kK2w6ozZpLKzlrCKH+ZpI1PeMfY6fEztvB/DaChUiQDs7f0tR2U0Oc5
	VfGGPDOfUKcHgo4zs/1ZEBCq6qZDfsGeP8eV2Mugp8+kV3aMipXY5HNYSujjN57v+9VP/4Gw8aW
	XZ1LFpEbsCluhesTKis4FBaDBz/wKyYtetjpIp3mxCvR4eJq2vUgmIR+jcEZeqpaYLAX4uav/Tk
	StQd7N4MY1kb1mFSHdYJaK1SP7ym23NCIg5u0/yYCNb8LPh1RM4nyVGnvqvkTcQeRWi8BPyocUP
	Aen+OLfviNrd9MNymmQ0ulBUMTJgjhdTXBMxsNrESOKYlqyrVl/2Z0KvJJXQb8x16osm/biSqUv
	hgAV6xQEdG3aGzY/477g5WgsbwQy2g=
X-Received: by 2002:a05:600c:46cf:b0:4a1:7e1f:21bc with SMTP id 5b1f17b1804b1-4a18e4d6636mr23240285e9.29.1791538233076;
        Fri, 09 Oct 2026 02:30:33 -0700 (PDT)
Received: from [192.168.151.76] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm43922135e9.13.2026.10.09.02.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 02:30:32 -0700 (PDT)
Message-ID: <6b9cdfd7-9f01-4ed9-a4d7-6b2949452b6c@linaro.org>
Date: Fri, 9 Oct 2026 11:30:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/4] drm/bridge: simple: add Chrontel CH7218A
To: Xilin Wu <sophon@radxa.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com, Daniele Briguglio <hello@superkali.me>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/26 09:55, Xilin Wu wrote:
> The Chrontel CH7218A automatically boots its embedded firmware and
> operates without host-side configuration.
> 
> Add the CH7218A to the simple bridge driver and expose its output as an
> HDMI Type-A connector.
> 
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>   drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 3fba7002322e..fab793fb12b5 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -275,6 +275,11 @@ static const struct of_device_id simple_bridge_match[] = {
>   		.data = &(const struct simple_bridge_info) {
>   			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
>   		},
> +	}, {
> +		.compatible = "chrontel,ch7218a",
> +		.data = &(const struct simple_bridge_info) {
> +			.connector_type = DRM_MODE_CONNECTOR_HDMIA,
> +		},
>   	}, {
>   		.compatible = "mstar,tsumu88adt3-lf-1",
>   		.data = &(const struct simple_bridge_info) {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

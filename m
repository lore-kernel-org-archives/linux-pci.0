Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206240;
	b=vKiY5ovT6CT56KWBPH9t/3aRuGDYWCDrNZBJlTCSb+wF0IywiB87SPxrmAbIvUmy7rBo
	 9bggcMp+veVvEpmRhDECPoKbVL6O+njx75lEodk6sWZ58G0iekzw7avX6EpMMT84GYgii
	 r/VMQ1WAtZkVrZuNadFylp1P9YNGaya3bL0UuXGEOppXUtotAl39N8afIk6NSzrETs3jl
	 u3McaZsCOZcS8mfoJwnriVEPSkJK2pgqfOKUDDCKAfjlYNuTRXl6ozxUeJFzs33YM5UTO
	 RLq5umxriN+T3pJm3hW0pv/wvHdyI1L1FkPEHOwCdybi+v1llN3/FeaQCc23LTGdyRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4bFPaFC4sn5I0ZmpvEnIMtoAAhYqi+gI/vKT8dEg8LI=;
	b=zC3jRczaIkxCVrs3LjQfiHLA3oJUesyfQ1kQOBDkoeglhFoiCRMVz5aD6zDXDcd7h/Fa
	 gDgsqZRlKrT45Y0dhYYvI73j33JAAXfd61oDYjLdLGa+t2nF/hBwWVpo90LSzfrAeZtzT
	 4XfA1vwHKUI/jq7KK7mGfe3QGGBHEEtmq6OxKPuqZR6S4NlS+yr9kOYgSbnXRihhyHZGU
	 5y73U2mgiSavfDY5nPP9f7WjYWJJ9JAsceKI2Ea3upp6yEJgA8efe0jdbThabyzCCCY2j
	 kgkp4MmZJFwhxxJH4rnJndlFVR4TxNzsn8HK9CvUHqfF/rWLc11hdF1gD3/P7bMl9Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bvVViE7s;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D9606A32C
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 16:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 428D9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bvVViE7s
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso11173195e9.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206239; x=1793811039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4bFPaFC4sn5I0ZmpvEnIMtoAAhYqi+gI/vKT8dEg8LI=;
        b=bvVViE7sfBqKWfi/kLDJYlnvzOUXPLQxwi7WE8YcmF6ZlMSeeXt5LVtwTgYjpBwkt8
         SYP3vMcQXr/owFcgMM1gE2QwZ/DTceP96Ogemeuc3wSVYptLjbh5WQ0zOa/QFUl5Bsyv
         t91KeRJRSejTTfSC30ERKT+SYsNtmNlFP19tG7VGrb/Fyrtxkv8HCWTMM4co1xxufiUC
         fsayYomNX2KXae5ip40Tnzxu0+b09pZZ8pnmB2UJbRFHhmlzRF7my1fWETNYJaMtDwI5
         xLbeFqSzSFzkr23lLp9iNBgX8plx3P3KNsPgixIQp18S34Dqr3UjM2Pb0SImAbIC4Wby
         52og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206239; x=1793811039;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4bFPaFC4sn5I0ZmpvEnIMtoAAhYqi+gI/vKT8dEg8LI=;
        b=ByoMTKXpdx7XvZx60vCGiaE/XjfItcPbDpR4RdcyNyAO73JE5ryUgJmgyy5e+RXVe5
         NPzLTW5BoBdmWYbw9jgImBGicUN/flzyn4i4bLnf18WgD52CcPhP7gw3e5Uwe+lq/MDO
         yr7xWsm7pTD5R7bQFmyM4ZrnBYx+aZwPzA9x7g1iBD0WD0nvI/CiLuH9Q1eHwssk2q36
         P48DPNHxAjD8ysMmrehys64YTMFXFqfaLkhGlsyoY3dm07FZxH1gL/J11jkQEn2RCzbd
         1Zjj9ZG8p/h514HEIR5f9xdi16AxVc6rIsWdyrTeF+RJDZwditUtLcXQ+SnG5JIkWMRc
         RNTQ==
X-Forwarded-Encrypted: i=1; AKwUvBymEygJKd0wlAXAtNuYTBaJ/BctWw3vKSi8YYCNH86sI0KvmjVYlAD83pJ3ORL2y18inaqTcyiI5CI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPmL1rO3765pZz1raChd/SmLKPIymLcQCyKe4hbxRYkXbCA6xR
	GhxoYHrHMUAx92RYLCzgTtpGZ97Glvc9yCsAagWkuiV62p+Dpd896FMM
X-Gm-Gg: AYBFou1YUw8TxTXMnZPvV6RjcTJelGTTsTphhSvdDFnHUADBvgZykMQkWnOFzNcO0Fy
	1P7Fth7V6o7YibDyoWnvB9ar191Ssu012XV55Se6EEf8FSciYOuvXZ5oAER4diAt38Vf9yU5vqu
	ikZPPboF9M2ona+RL4PUVrg6MuK29ucOw86kYxtXsClUSGFetdC44bjh4xpvjcOpE023GXf/dmI
	Z5d+SAl8xDcj/aaSR+BGg2MszIVZkz2ahUewO0k9mDwG/ErdLzH+MK7CTbtWXHJk9ezea0Yp7aI
	+uxniVl4cxcBxmVTchLmc7dVdci/ZHANb5bUaZ26pBwspSogRm8i96S6lh0L9fXNY1ngJUfUTvK
	0/lRd/ooycbGIU9erL+Z0bpSppx6j8uqmonPogw2gA125bDfifiz3zooZ/upakOMSuXN6krxPYh
	UoolEcfsI32Q6ssz+Dtd+CcTl501rJ10iPalNzkWTdMAe4sE/LB1a8Tj3ZnVTw5RY6Wdn7V/Nlb
	r7zPbFU84RDQZkSn/YMO3faQLuiHh9wFulT5jCYtgMmHl9YrNFR4nPLNqd6d4dHsWBD2ciAVvKa
	WKI6cn+mraidNsFOo+7R4ifUmu2F0LEsBE2VBHCm7ROyGx/B8SVBsLCuQEskaUZfQB9/cODFgbB
	xCif8oZh0Ew7SCBWd
X-Received: by 2002:a05:600c:630e:b0:4a6:7d6:821f with SMTP id 5b1f17b1804b1-4a9678bff9cmr62960175e9.29.1793206238343;
        Wed, 28 Oct 2026 09:50:38 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc4d76sm29895785f8f.12.2026.10.28.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:50:37 -0700 (PDT)
Message-ID: <6ae227dd.6c7231db.220083.ae75@mx.google.com>
X-Google-Original-Message-ID: <auIn2SfzeFL2CJn-@Ansuel-XPS.>
Date: Wed, 28 Oct 2026 17:50:33 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Anholt <eric@anholt.net>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Peng Fan <peng.fan@nxp.com>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	freedreno@lists.freedesktop.org, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
References: <20261028120216.2657397-1-robh@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>

On Wed, Oct 28, 2026 at 07:02:12AM -0500, Rob Herring (Arm) wrote:
> Property names within if/then schemas currently go unchecked whether
> they have a type defined or match what's in the top-level schema. Adding
> a check finds a number of instances of typos. The typos result in the
> schema having no effect on constraints.
> 
> With this, fix the mediatek,vcodec-encoder 'clocks' count constraint
> exposed by the name correction.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

For KPSS:

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel

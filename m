Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9D37EFE1
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704943; cv=none; b=GEAgtbqqrcLDRpUSX256vn5ZbJGoKRnA20AQYAXoYHLSUCLmECJTvQ2tPZcmxoXc35c5F5PHWmr32Vg1Y2VTjaAp6iYIZEdooyI34Jk5yXyKXKeaDXe01bgI7XMPMDHIyvdnSFwxrjRGLO50Ud9krWtqQ22cAn43Vb6YYdwIaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704943; c=relaxed/simple;
	bh=PLN3jU+WSp15lmHsKDg7F21c9tIpGoZokDbnzqxSsGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qs8DZSKl9AcGifDwFOiz37rcfRsuTiwc6x4typyGeYD3fNXwgUNA8wgkcd9oy3p0dyhu86Kb1SBra6s7gKImeyzScnmyRoC0NT4R0cEQK71ijQE7h55tkKojESVyuG5d9wcdY0kq5B7a1yGiTElFssjq+VRm5y/7ebFR/He0kuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cD4UFgoA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cD4UFgoA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48371bb515eso116816495e9.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772704940; x=1773309740; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PLN3jU+WSp15lmHsKDg7F21c9tIpGoZokDbnzqxSsGE=;
        b=cD4UFgoAocJuZT5S6/FT4tLvo8eHic6win/PVVlM7THi42GfYkSi1TmQKp9oFjEvC9
         4DuAmh8ioVJ3l0t9cfDz1F4uH57IMEgeY61EKqf0J4hgzotd10bzAWeqkIY3qxwq+gtt
         KyD/BEhAcZymLIC+jEV+iqZhfRlSpIO7G5fxOWyrn6ZeoxUBzXJNaGNiXGXdwAwygc++
         SJ3ShMbEL/2wC0WJ/VhDdOAftX90PfAz60BcupIG8OAGaPrCOCMIA27aaK++isLH44Iv
         ENO8y4ePFW102JPN00G4qmjO8l3H2KXaQyAiU4DD52kTRmizIQUzeyakkq8kcPe749lH
         0MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704940; x=1773309740;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLN3jU+WSp15lmHsKDg7F21c9tIpGoZokDbnzqxSsGE=;
        b=c8YfjrRLzf3S+YeJrHg1a5nwSmISfPV1puR3nugL5Tvo1F7Zr1f/WclCJRgDRv6rLC
         NTNC2H/+L3UW4TUIqly10uhQUKWTwpw2jJjioXe/5dvUZMGIZaABD5cG/wJ6C7vDc2fe
         W+7cSbiBChb9khcwheDelVI7ZuxylbcaCf3koZsm896u7rcph6hk7nHWc0+ff9x1Cz1F
         nOjIuzZKeh0VO1jD7dYFIieiXA4OxD1LrHDvV5nIllrNoMoOksr0rUD397HlLkhDRshE
         /U7MbMSt/V0E3rBDgcgd5fPec3gfw8XYWs9gyPE7M/dAeDEcQvO2t/Uxl8Ua9ELvBVKh
         dI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWp3Y0/Vw1xmOLuzDJQs7v5jYGSe6nyYHu3cgbQCCGZDhtdD1y/kwjhACRKU9kBfRm2k2YK6zipyHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIEQerCe6Of8nmAWpjjKzYOFpjjtRtyEkSJl177Gnf33n2psX
	twsPUhrVhCJx0ADzJN24G/Awv8UsZFN9Gv3hq3ST0tH/qNBJLYu0hXsTrV4FKHli8hk=
X-Gm-Gg: ATEYQzwhPoM5Z8nYUgz2Yzy1F43NIPmbCmUVNzeTS+4cWV6+xB5LTIgalA9HoxaZ8sP
	KY4DeIru8pVhtVjt+/72dsWfpirLCohGNq60iTcIlx1nwnuhQgUQEFCUD71QB3VuMLUZA0fj9LT
	mwPh9TQlrIagc67xaVU0x3Svr/+GPEXarf+qV9qsWF+BOwhepCuGBsncx5HzNP2tQyEUn/X7IuZ
	gXYLDTvgSo4UkO+iCG86D2MrkUUP0cQ1yD0u0Cg6ccU/D7NBK0VvAsOWYNl5ecZWsgBglfNZ7pO
	A3pkwhcKXtRW5lIxUOzqi0GIGCUqCI23Km3WJfXwJEs/Iok+HDYFAabjf01oo8tGRSNTudKGt95
	5UL2CUTnsV8FiYcRsiFFpoZzfk8rYnmLOGPkwpXODDgOyoI/xyRg6FyosaECi5VW4kiVQWFQTEA
	rcnLKZOkieS4nCQc+VHogkCTjyPx47
X-Received: by 2002:a05:600c:a07:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-4851988f31dmr86977045e9.23.1772704939633;
        Thu, 05 Mar 2026 02:02:19 -0800 (PST)
Received: from salami.lan ([212.129.84.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fade9fdsm59453655e9.4.2026.03.05.02.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:02:19 -0800 (PST)
Message-ID: <030737fd255a49288349f06e8c1217a126ea9081.camel@linaro.org>
Subject: Re: [PATCH phy-next 05/22] phy: add <linux/pm_runtime.h> where
 missing
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, 	dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 	linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, 	linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, 	spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com, Peter Griffin	 <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Heiko
 Stuebner <heiko@sntech.de>
Date: Thu, 05 Mar 2026 10:02:16 +0000
In-Reply-To: <20260304175735.2660419-6-vladimir.oltean@nxp.com>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
	 <20260304175735.2660419-6-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-04 at 19:57 +0200, Vladimir Oltean wrote:
> It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
> phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
> call runtime PM operations without including the proper header.
>=20
> This was provided by <linux/phy/phy.h> but no function exported by this
> header directly needs it. So we need to drop it from there, and fix up
> drivers that used to depend on that.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

> =C2=A0drivers/phy/phy-google-usb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +

For Google:
Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

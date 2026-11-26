Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702714;
	b=aI6RY/woUlPCXoFnlCwn0Fyxl0feB3Y3eLo9bjZXvE2ZTfySMGTZg9k1WRePO0tzHuct
	 DdLllQvs2snZ2asvO5VExhCu+rbirsKUVrGj9ymjQ33gcAN0E3hw8Ki3LQLjvuHIROFFJ
	 7dCo0Cz6YAiMg62UEQbm6vd7Tgmk4x6Tmsq4Kpa4w/b4jG1e/fvD8c+5KVUlJ8iMtsBLI
	 aul1+U/Bd1RuLKuB1B0H5U/eBdKp5oeO/UVwZh1VKXsvF1C/w2YijkNtl+Azj5F79ttBU
	 ZLF5h90icICSNSlCvZLHKHIn5qKS6fW1mXmtcLhV05TDYNDHcXC6kucLtqoxxvySOPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702714;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NyKzTXadaH80KPU41rwaODjR1cCn4hE+RiYMnZpd86g=;
	b=hnPWp49HbeFGWBNcRo9l0LOoTO84syeYQWFcpKNmOEVx2xPBNP/fYy5/dBkfrWby5CJb
	 LgaDu0gKk7a9X27sGnF5ekP54KeolAVEVu9N3QVTDh42NgWdcnQwEWH1axWdXT2QsnWdD
	 m5BT03zvEoWouwJE99G0LaUifClHFYaaLpebvrTgz7L64hEENxBDWFcz7XVcHWhFpmhoM
	 b3qgjuywwkZonTfI95Ugl9Nw4sc1PXD1dZaiWSP3bFF00KVLXzF9F3Vm4LRu0nFTh46vu
	 teT14Ack2A/y+H02vQ5hPeU0kAlm2cu8CatUbQzUhiCvxTUWMTB/IuF4WgA4mWsT38Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKkG0YX2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E62DB606A31E;
	Thu, 26 Nov 2026 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKkG0YX2
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0721D1F000D1;
	Thu, 26 Nov 2026 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702713;
	bh=NyKzTXadaH80KPU41rwaODjR1cCn4hE+RiYMnZpd86g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TKkG0YX2wb7BkJBT5asY8jsFXrQuwOipsZzhH1M+s97eq57mxGxAVspA9aqxFr0Hr
	 9neyTwJY+BHUAYaaHfuU10yUrLzQGp7ycUQWDNTFUyhxVjmfdz3iggeF3XU8ZB4c3f
	 pZUQ3eICTufypMiM0p/bNzAbXp36P8eamOlf4ImvMPz6awcJ1DjPqsnGsiSyGwKpbh
	 P2RFvo3LeHh+dMgbhDrftSeP5hZpl2NeCw45q1OU/44oI2PPlxw631sma+ciNlTA6F
	 6umxiR38hL4E1QuAlqx3q+5NAVSIYOyyoog8HlNZF+mpB9wA/UbqqOcqdVBDmSbKND
	 2M0+hbriCKn6Q==
Date: Thu, 26 Nov 2026 15:18:29 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
	dragon@radxa.com
Subject: Re: [PATCH v4 4/4] firmware: qcom: scm: Allow QSEECOM for Radxa
 Dragon Q8B
Message-ID: <p3kffrgkkxa2gzszqa73rro6vcxtc3aho4srjvinq4cxfbierh@xm3esomojnns>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
 <20261029-q8b-dts-v4-4-e8e7438f5545@radxa.com>
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
In-Reply-To: <20261029-q8b-dts-v4-4-e8e7438f5545@radxa.com>

On Thu, Oct 29, 2026 at 06:13:38PM +0800, Xilin Wu wrote:
> Add Radxa Dragon Q8B to the QSEECOM allowlist for enabling access to
> efivars and uefi bootloader.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

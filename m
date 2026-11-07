Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071155;
	b=m0SngaprfOFVkRFnc2BmDKwU6rI+QMIgvR5pmwIyOLebCwrv3fceMX938PdXZwqnPg8G
	 6xyNORfbA3tl1RyeXyETlWE5t5g/Kgwl52lQEFy9fzMSizTvndo80FqEM3+L/UErIBAHM
	 YDs0pNQQ8a7eLn+b3whYhc02XT+mjQ2PuXpep0HF00bn3/UKHNy4PuipjLJIGZgwE2+sN
	 vRER87mpnNc+NUyE9J0Kw42Lf60y6vnslWLNYRKCqTq6yTBEFNxdXXbjFoILvDJG7Vw+/
	 2lsgf2xDXWDC/dCmh0IfLBVBOQmiZwLl7Or1lhS/PapR5LzsiwzkfKGNLRHpHJPyukA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071155;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=FNKUE9KN5gqUNftHqErKO4XRPnmFTGx1efebnCS4O7w=;
	b=bJ8FVG3u2Dm0ZugCmmsoK07FeopryExGhTWs1RnEJucbiHfCpT1cmvvESoLz+X9AWsW0
	 dSfNcq9kzXXpYQL3lYMuzidXkK9Zah/LrmxEutfCplgXrCfyt8zGoN/86HlDJQaZhQsz5
	 Yh4mvZ91lsG1UZnRVEEeRfkEOvKFQUSXWUx3DdGc2dhGcXtZAuWobSgMKtUfQYZ856Af6
	 yoQgVfUJhFt7dbmlYqJ7buRsbZSz2uf6Joi48peJHR3CyWoOVbNIntzvjYKptPE3hVkfu
	 NrhpS+H74cpuJV6NbNlnpe3LEWH/iRdADH6mhvTOZcLTHXwIIv1uQ8ARkSyk29F5KXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHAhYTR1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00B606A326;
	Sat,  7 Nov 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHAhYTR1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AC21F008BC;
	Sat,  7 Nov 2026 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794071155;
	bh=FNKUE9KN5gqUNftHqErKO4XRPnmFTGx1efebnCS4O7w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BHAhYTR17CvWOCfIwPyzFwTvS4Xhyt2C7Cyt48wzNl4x++bt5Y/f54VkWLcidgVr8
	 V0i2qp2vOufmVhMtRaHkoH/sgowjTTLQsIjo7KOCwDOkk+GJSVd8OMueFNYuX3h+ra
	 9eBGFiXJgnUH6E3JunuVa3x5aoeo5vUEsImDF0K5ZHfyUVYUxyiiHLU6pF9vTz73Lf
	 LFt5/5Odk6GEQY5NVOK5H07sidjGPyXIHh+y0OroHZWYyrG//o9H6jtCauYds7dm5+
	 JHY9k8tsru965IG8JjeCkfk18/bCSHHT8tBlppx07+Pu0zH9UifgvX4QWHaE9O830e
	 cGf8na2IgzFTw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jingoo Han <jingoohan1@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
Subject: Re: [PATCH v9 0/9] PCI: dw-rockchip: add system suspend support
Message-Id: <179407115382.87267.12160393716568806842.b4-ty@b4>
Date: Sat, 07 Nov 2026 22:35:53 +0530
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Thu, 05 Nov 2026 14:33:08 +0100, Sebastian Reichel wrote:
> I've been working on fixing up at least basic system suspend support on
> the Rockchip RK3576 platform. This series is a follow-up for Shawn Lin's
> series with feedback from Niklas Cassel and Manivannan Sadhasivam being
> handled as well as some of my own changes fixing up things I noticed.
> 
> Tested boards:
>  * Sige5 (RK3576)
>  * Rock 4D (RK3576)
>  * RK3588 EVB1 (RK3588)
>  * ODROID-M1 (RK3568), Igor Velkov (previous version)
> 
> [...]

Applied, thanks!

[1/9] PCI: dw-rockchip: Fix LTSSM set functions
      commit: 46d1b4f773b3a8d640c4cb44ccc2daf60043b737
[2/9] PCI: dw-rockchip: Restore vpcie3v3 regulator handle
      commit: 6c57adbbae715f91455c270e397cf8a604e27585
[3/9] PCI: dw-rockchip: Move devm_phy_get out of phy_init
      commit: 1335c85fdd3ae2bf118bf345e456f4f472ea0dc0
[4/9] PCI: dw-rockchip: Add helper function for enhanced LTSSM control mode
      commit: f266f1b24aaf63d33995ae81c54d903391f416b5
[5/9] PCI: dw-rockchip: Add helper function for controller mode
      commit: 301d905b81c16409a644a9bdad37cece03d5ee9d
[6/9] PCI: dw-rockchip: Add helper function for DLL interrupts
      commit: 7c7fdcb6bb28d377fba5be67d9672384081c0ce4
[7/9] PCI: dw-rockchip: Add pme_turn_off support
      commit: 7bd39e56b21329d99e59b7eb7dff760c2280d1bf
[8/9] PCI: dw-rockchip: Set broken L1SS resume flag
      commit: 39365e59ffcebbdf910935875a55af9bee83257f
[9/9] PCI: dw-rockchip: Add system PM support
      commit: efb2c00e3c47895aecee624d039473534764a6f8

Best regards,
-- 
மணிவண்ணன் சதாசிவம்



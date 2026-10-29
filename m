Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263049;
	b=Rl4DpNZjcCbt9JfILlieBJpIJmvglalidErLG/PN3kBCloX9cE3Zk9zdBlI414WJPDoZ
	 +zatEkgl46c8efSeXC81eoWH73uUJvc9hwt3NWEQCOA52N3iaTei3Nwck04Y/wUkopY70
	 UMGyb1z5QATEWhSf0sX/u/AbjeC6EOpMqaeUOsdvBEUFmlGmJBPUQtQ9k2rNcunDd0w37
	 4wh6iAKEcHgdo7iDLDXOgSvATcO0p4NBuOhy1mGhgZso0f2qh8Q4WZKEYM3fAqpYjVMqE
	 /oGXipVLOhsK5fk5DEIlW4sv+w32HTgsNDHegTCWVzthy2xvc6gM9n6yqrFVhcAL8og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263049;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cbM7UI94oFkDkCedtoVdzhBNwgdKQYGC9IfVn2/SUnE=;
	b=taeEZH0hIFffcT+eKuODUILwqVtilDsn47TmOUW3IP3XHoBPbF2lE2caIWczHdLavtep
	 fFOjwEeW5rQrlDEwjd6SQWbb37b555lg+JyahHjtj0CO7aIoiS1TNFuIGAf3k+ktqBZEA
	 6sAZv6dBFcd90EgqGi9Kpr2ge4W017/SRs5I2oUixtcJSDZ2VbqGl3gLK6XpeX3+9gRDB
	 jG353RTgkbWJwBrRyAcefXC+870RwtPLjop30oTdst5Xh9guvOY1CveFHkuxd2a6Z/q8G
	 wAVJqD4mtwZuGtd6oL3VwJXS4frd44UHQV9IF5Ep0umJ7fWY1Unp1SySy/H7NV524ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+PtaMf6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BF606A322;
	Thu, 29 Oct 2026 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+PtaMf6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A304B1F01829;
	Thu, 29 Oct 2026 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793263048;
	bh=cbM7UI94oFkDkCedtoVdzhBNwgdKQYGC9IfVn2/SUnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l+PtaMf6G0C1re4g48P8bxO2ioCbBo21oUaJpl07ZRCHqyJp3kZVrnZoECvLVUOb0
	 ILGmZx5XGoHjGVLVerodJJsFnP6DPn+qojNzaYoTJRcJeaIucbfOw+rTWGB2epn1pM
	 +aQrlQW4XtZTnLkWlemfEqJtr5Go2RYomGgUjluOXylt0sisSA16aVArfti+VOwc8z
	 MI2P42ZWroEJg7Auzpp3fUNX1yujMNdRdugTt+P5oKHDu+IjHditoD+0Zbh/sdF6Qk
	 S3EBgjI1rJSkb+QjQkzIex0dnn+aXvdAK37P5OxU8XPox/v7+hM2FUlpaIstiiDT/+
	 upKnuMwue8pUw==
Date: Thu, 29 Oct 2026 14:07:24 +0530
From: Vinod Koul <vkoul@kernel.org>
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
	Frank Li <Frank.Li@nxp.com>, Yinbo Zhu <zhuyinbo@loongson.cn>,
	Linus Walleij <linusw@kernel.org>,
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
	Christian Marangi <ansuelsmth@gmail.com>,
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
Message-ID: <auMFxC1-5rBvL67e@parshuram>
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

On 28-10-26, 07:02, Rob Herring (Arm) wrote:
> Property names within if/then schemas currently go unchecked whether
> they have a type defined or match what's in the top-level schema. Adding
> a check finds a number of instances of typos. The typos result in the
> schema having no effect on constraints.
> 
> With this, fix the mediatek,vcodec-encoder 'clocks' count constraint
> exposed by the name correction.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/clock/qcom,kpss-gcc.yaml     |  2 +-
>  .../bindings/display/brcm,bcm2711-hdmi.yaml          |  2 +-
>  .../bindings/display/msm/dp-controller.yaml          |  2 +-
>  .../devicetree/bindings/display/msm/hdmi.yaml        |  4 ++--
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml  |  2 +-

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

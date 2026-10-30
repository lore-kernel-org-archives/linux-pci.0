Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367508;
	b=nfmM391N8RjLUmUaQ49LmyknHTChGbXk/aJyO7nw3rO6XJd/g21fdDAPBHBXcDnzJL6N
	 e1eFd8qvooCmvAPjC1EL6OdtJM/yMjRDQiGqkIIK8O2ZFoQfOlbXiOp8BNIDNDg+DTNzE
	 cZBOc8g6sjBW83K4AWls3pDZ65PREu3mTEgpfeWFFE9Nqb9Oe4hqhaFuGEA8uZBiO/9nL
	 MgmtD6Vhgi0czRspyfO7bl5zXi7AyqOudmaKk7Rre7vLPS9unP+P5+bG8K2fySteTHYM7
	 bNefMkM6R66bEmEvyLEKztcpgbeQcA9h3EyrSEhDc51RGVr9hvQ/7QUerk1RIF099pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367508;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=C2S7rduE7F27e/ACslqZKocTp/JTh21Fn7y8iprLI+s=;
	b=M5k43/Npz8+9mNuleljK4fSEgP3aQTtD3QJXk8vpKiDqdcXehn3OvBx9Qt/rl0Ti542E
	 yOgqYsBCdIUTH6awikQ3KYv+pZ75axb0i6nsbJq9qFVYC6OV1xouG+ac36Swv1+mGnwm5
	 Q95BUGRezRkqeLnBC0exfOAAbO0slQuwHV70fedY0gV2WPMHv7uqXxmTvUJWH/joP6MTD
	 3dhuUyLv+PfLdF6aXnScUhdMqoMw0I/NNOm9e3PDYsxhTR6djkZeYfFG/h9L7BeUO963l
	 eq0+PW6ESXbMjxEpU9AUEPrjA3DoHunGRriJn9YuqrB5doWz3AeNyZ6icmxtIs652Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6pwSGRN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D7606A31C;
	Fri, 30 Oct 2026 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6pwSGRN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B895D1F000C1;
	Fri, 30 Oct 2026 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793367508;
	bh=C2S7rduE7F27e/ACslqZKocTp/JTh21Fn7y8iprLI+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F6pwSGRNK0eicHwv4sWaVzrGABaI7Kcr8UwklPuzziX/9g4PceqQiyip94FKU92Sn
	 yK+wgRrs54sOD0/Afs8KSLgbc1XHhfMD1sTCAMKOEVOXBuRidENzicTpRkFwC5Drsh
	 TFqswhNmzAyPeXj4y0zDecf++b1piEtnkJVqvpF+hLWG5sAGP2AiJZL9e47EBH78bW
	 et8iaI4wnqFB7A7TsU9/PFkQ+NhS0+9ztnNFeU1IgNWoayj62P723V2TXOXccc+euZ
	 SmtChrl8Mr0i2fvr4iGY6GeHD6WAKK/fYcDPPFkt/TeYkC0lT16nSZhem5wJfjJcE9
	 /A4du6Xt6WWNw==
Date: Fri, 30 Oct 2026 08:38:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
	David Airlie <airlied@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-iio@vger.kernel.org, linux-pci@vger.kernel.org,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	freedreno@lists.freedesktop.org,
	David Lechner <dlechner@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Peng Fan <peng.fan@nxp.com>, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>, linux-gpio@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>, linux-media@vger.kernel.org,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Eric Anholt <eric@anholt.net>, linux-clk@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-rpi-kernel@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
Message-ID: <179336750291.3442134.12651355159128189290.robh@kernel.org>
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


On Wed, 28 Oct 2026 07:02:12 -0500, Rob Herring (Arm) wrote:
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
>  .../devicetree/bindings/gpio/loongson,ls-gpio.yaml   |  2 +-
>  .../bindings/iio/adc/amlogic,meson-saradc.yaml       |  2 +-
>  .../bindings/media/mediatek,vcodec-encoder.yaml      | 12 ++++--------
>  .../devicetree/bindings/media/samsung,s5p-mfc.yaml   |  2 +-
>  .../devicetree/bindings/pci/mediatek-pcie.yaml       | 12 ++++++------
>  10 files changed, 19 insertions(+), 23 deletions(-)
> 

Applied, thanks!


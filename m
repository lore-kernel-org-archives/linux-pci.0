Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17238E5FF;
	Thu,  3 Sep 2026 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438579; cv=none; b=k5bB8UghUNCP4sGoSK95FFbX3Js9d7BsDPFKRBc2qUnJEGBmM0X/+Z6NyWavLnKlj4OHCnymOldt9/x25zx+9ibVd9O0hFKK7Mdz6ZOYhZZY+vN+jxlT/NEalDdgQfp2UfmWTSTvq9eRel39cY/VqmHyJOBnZnMKfnFJXcUdB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438579; c=relaxed/simple;
	bh=taYCNE3A/cg+QcAGbRYXuu/J3YhDCzaw2CbrT8phfwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn0cgxIfHe6KH1fGUHO8ozMt+Bwpo+xEs3p3QC3EgIEP5QS6vpI4Z2NDrPky18YHt3Q4kG0ejcboM9qpKvJjbpvnV88XTXNRFcMZwejs1es0xeMmb8EC2c7Wwgl/toJ/nkC1R6v4DPwFfYnhc/ei8MP3KfPfqPvw+qwYXkMn/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgpe7be7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgpe7be7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFB51F00A3A;
	Thu,  3 Sep 2026 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788438577;
	bh=wCXHOPjY6k6UIQDduJFqwM5ycSoiURySLqPJjkIRPw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mgpe7be7S3WPXQ2VNZ2ZLKyQxx9cz3JZIKYqeWpB3IaUfjc+MJJUZ7prmJnWUctRD
	 wk4RzXQbRdgIGX7NmilunN8FlQKtB84d/iWs5yYWd9wzatktwIDksrupN5byYEwpfT
	 EBUkzX2htz59wop0OsmDI761PnMrTx5LNdJbOLvVIW9HsWnuN7XxM+SIArcuvxUgUd
	 2O+0huu/ag3RREggcw0yOJkj/eAr2WngpMYG+YXdob/Lm9RrVLcPfdwDDRJvXvv4FP
	 kVVQttiYv3qGGfEy61ze0IgF+YRzo2oqvSZ6/PzGVuyAEbfa9WE9rDddqcuVGTnIyI
	 sfv3TVWW+WQoA==
Date: Thu, 3 Sep 2026 14:29:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
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
	Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
Subject: Re: [PATCH 2/6] dt-bindings: display: bridge: simple: document
 Chrontel CH7218A
Message-ID: <20260903-petite-charming-echidna-ccfefb@quoll>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-2-7de0b6a73d08@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901-q8b-dts-v1-2-7de0b6a73d08@radxa.com>

On Tue, Sep 01, 2026 at 04:47:55PM +0800, Xilin Wu wrote:
> The Chrontel CH7218A is a DisplayPort 1.4 to HDMI 2.1 protocol converter.
> 
> The device contains an embedded microcontroller and on-chip flash. It
> automatically boots its firmware and requires no host-side configuration
> for the on-board use case, so it can be represented by the simple bridge
> binding.
> 
> Document the chrontel,ch7218a compatible.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


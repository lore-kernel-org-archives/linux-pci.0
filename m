Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E374A484E;
	Thu,  3 Sep 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438996; cv=none; b=Eev7e35TjOFR+zz3QQkfgKDji9XkNJFP3/XoFrqrINRiYq71SYhzzKyjCCAJSxpa8plAr5jdFR1p9agkbJA5wuiIzFgb5zvmlUMGg0BcnsiqflDqDYgCKAn/5WIyWd3V2jO7NLf+9JDud7PS9C4eTi6f4LuL32V2amj8YQeniZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438996; c=relaxed/simple;
	bh=5wyqrPyAIsPudg2hBxRTbF79wa8Xf+nafl6awjDjsOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2KfG0roGfDnwqRkxH0yo1NkJpz8nuyglBBOPSSOLrMyDxX4oLzR3eMo7ZxHQTtmkGSgz3eMknJqMylfUtDAdYvq2Si4Uw5wRmpf/FCOYB73/X1ReAZzEa5sHGrv/5HP6X5ioqPU9z0OY1qreySfXfwZuYQozDtgr+62ZogGYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xje0YJg7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xje0YJg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435141F000E9;
	Thu,  3 Sep 2026 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788438994;
	bh=4w6jf87vafgM99bg9s6kWCWTFKCA2du6LEtWeZQAPcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xje0YJg7/rQdGmYKvRqh8OHMnTgXxL9lxMK2WYusyrfjvyCj1P42mpgdm2wfxtqTb
	 gF5oqbwataixl0q9rm01GE677vb2RjMTPMx1RLto7UJrhdmRSjsj9aIGy6iINWnvPf
	 EsmOolg65pC/cvHw/btvFoxVERH1ZBJRV0MzqhohlEceM+vVB6Z8HnGGfZOfGA6K7d
	 B6YOhzM/QaMbq8GCHHiWPXcDu87dXXF7F6wltT2R4XnYg0takIbWaSsyLat8Cujv/a
	 s2eRk9Z1fS/3OQkNm/62rFmfEQGeLqKtEtbipr+gDQcjK4BWcp/Z5mVJrK8tPHwP1M
	 tdEHNOR9RMlQA==
Date: Thu, 3 Sep 2026 14:36:30 +0200
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
Subject: Re: [PATCH 4/6] dt-bindings: arm: qcom: document Radxa Dragon Q8B
Message-ID: <20260903-corgi-of-splendid-defense-9c8cae@quoll>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-4-7de0b6a73d08@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901-q8b-dts-v1-4-7de0b6a73d08@radxa.com>

On Tue, Sep 01, 2026 at 04:47:57PM +0800, Xilin Wu wrote:
> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm

"Document the Radxa ....".

> SC8280XP platform.
> 
> Document its radxa,dragon-q8b compatible.

No need to repeat the diff contents.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


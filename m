Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6B35DA6D;
	Tue, 15 Sep 2026 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442153; cv=none; b=Tv45VRygeSI4L6RHm12zwfCcUX61UZUriuB0MaHGjT3ElqaiuO74TX2/DcNPzsdv7qyu4JYZUJM9gwzco6rfBmG/y+U2mXPIm+5peKmTSASzDMpjZuoUTISt4yBZYKVyCSfSltA+J8Jx175bWM9WYH/54ZTiLny0okcaJxiPk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442153; c=relaxed/simple;
	bh=N4pArJNJp+xXYm8hQb+Jtidwbsdb6Xo5FYqL2FJR9lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZwBf3NNJv77t4cTIVefN+9vh6RdZ5KI1lP5Lb4HsHFPf3/3/TDH21h2SX4mczdgU6u8Cv7RX+RhrD8guqtHlHXPYwFkJI8N0Jxl3O1R8XrP3u9NFlq2h3bTjRE4sD4n8ufsQlKW+HT3x+VEiKWHVrlE3KYFIWGxe3uZm/9SzJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeH55Ot0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeH55Ot0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179121F000FF;
	Tue, 15 Sep 2026 03:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442152;
	bh=IEM3JJms0G5xtEIT8UGUtvbS0HoqoxO+SGfyADnCcuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZeH55Ot0NxGITkJSG7w3prGCkLQI54Yf1NNzum18ngLFAV6uVE6r0a3jgulLOWkSe
	 Gj91/GPmJn1VpBD2UBmgppRuftlZzTANqifGqOIsWghEva5HyT6h9r9Big9CWHl10t
	 qb2OTJYwksJRbjvLuoqrMCX6Hl1LGPRElZulsP+6nEV6R9KL/XgO31psxt5zG38yOW
	 rPaiMBM803dzEJaROqM16HGLVoTNLHNKOwaZeok+XH2crYH7y3rMU4UPOGOe1V3avu
	 AB2NjN25dq4/KDxAwATE+BYun6ZejXP8DzpHeQ+VBKQaBhraNY2cUdnJnZvnX9B5lM
	 Ffj5HTAd+6R7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: misc: introduce pci1179,0220.yaml
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260915031038.1087264-2-elder@riscstar.com>
References: <20260915031038.1087264-1-elder@riscstar.com>
 <20260915031038.1087264-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:15:51 +0000
Message-Id: <20260915031552.179121F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: typo in compatible comment (TC9654 vs TC9564)
--

commit 8118db85b05b7b5ac32fd5abc0d4c0b807fa8de2
Author: Alex Elder <elder@riscstar.com>

dt-bindings: misc: introduce pci1179,0220.yaml

This commit introduces a new devicetree binding for the Toshiba TC9564
internal PCI endpoint function device. It uses the pci-ep-bus model to
represent sub-devices accessed via the function's BARs.

> diff --git a/Documentation/devicetree/bindings/misc/pci1179,0220.yaml b/D=
ocumentation/devicetree/bindings/misc/pci1179,0220.yaml
> new file mode 100644
> index 0000000000000..fca3d331097de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml

[ ... ]

> +allOf:
> +  - $ref: /schemas/pci/pci-ep-bus.yaml
> +
> +properties:
> +  compatible:
> +    const: pci1179,0220         # Toshiba TC9654 (a.k.a. Qualcomm QPS615)

[Severity: Low]
Is TC9654 a typo in this properties.compatible comment? The device is
referred to as TC9564 in the commit message, the file title, and the
MAINTAINERS file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915031038.1087=
264-1-elder@riscstar.com?part=3D1

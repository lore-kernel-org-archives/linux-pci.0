Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303700;
	b=RGPrEbE3OF/PaLfFjxLyAGmKaU6toBcrhUf2VgMAlI72btXVqzkUgF22O0VaYItNKiNU
	 RQRLsa3FOaa94EVp5DdWLeW4Mt9ujye4GSC7ZO4oaa508gsCbCU54MGsQah2vhm8s/DWg
	 z22aDRFdUYj6V4L/NfiNdqQUxEsSVKhpOCsmE6GgXFcyad+UX4xLAbcVryF51+h8nrfv+
	 a2GagO+6v97S0okyZwGbwuKpgNp8FfCVwu2aMRiwrLoAl36ItCdMzVa1RNbV+YlRN4zU6
	 Gp61ReU1K4udCfne6TqF4/AiiGTLpvm94juX2hFsoCSFpT5/k5+Fw+zrBvsZnL5Xw/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303700;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Elfi3sE5BgVj1t5gsjBEELA6hJDkM91cQD8viQnP3Ug=;
	b=eidfI17JHSWtaZuk32cqzj9clnic1Lm+UG3y0KFDLfcboYwwII4jx6Piytuzh5Wol98U
	 20HgJ0Q8AiSq5uPUcDKQuprLXoZ6jWT0umPoVdG/+OlFbwaZaVnWZIJWHU4+erMNBMXDR
	 xaQlkt+MoBvRW7wpW633hgac/HiRI19Ju2lgReqaXgZanDvWm2vFhQgRxtghBmK0ij1V1
	 9XAYXFXecE2/nKK23VuCodIS4ybS+jEv+wM0WA6JHBoyyvgYu6z//rPtsbNv9aFWxrLLm
	 77DVMbMQiNZ+qJbyS5NQcfKRfYVYoX82uxnpMshNLH7YDXFXAFlhZ4RDRucZLB7PDkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACTTAg5j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C614606B175
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACTTAg5j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047DC1F008A1;
	Tue, 10 Nov 2026 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303700;
	bh=Elfi3sE5BgVj1t5gsjBEELA6hJDkM91cQD8viQnP3Ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ACTTAg5j6hq1w1CJGQdx/npCrK7w9oJy06f20fuJkvrRgHmNrDmmTgXRUOz3Cj3nr
	 RJqFkmeXqriLI2/RvyxDCXuvOLF1PUR9lOsfAIPCIwMQSpnQcdP3LZT3+mKyPyOm4U
	 zKK+93hfYn2D2jR4xP0oO/yID2s0DM0m1Tb4sJRbfY3Ep5Gc3FG0UVT0y4DDxj1xiv
	 FBgRj795Skjdb5jI8dL5mtMgkamB/qq0xByP0S2mrlh62ZMm/oBXjLOFi81WQIqw23
	 8ReMji8SPMXsa9iMqTKT9AFLmMJqlfWewTKI/xuu7YhH+wXlr5sptpUcm6+92Vhj53
	 CiZuUGw6CRgPA==
Message-ID: <sashiko-outbox-206793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] LoongArch/PCI: Remove vga default device
 override
Reply-To: sashiko-reviews@lists.linux.dev
To: wuqianhai@loongson.cn
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110090203.2631481-4-wuqianhai@loongson.cn>
References: <20261029033440.973077-1-wuqianhai@loongson.cn>
 <20261110090203.2631481-1-wuqianhai@loongson.cn>
 <20261110090203.2631481-4-wuqianhai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:41:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: wuqianhai <wuqianhai@loongson.cn>
>=20
> pci_fixup_vgadev() forces the VGA default device to a non-Loongson VGA
> device whenever a Loongson display controller is present.  This was
> added to prefer a discrete graphics card as the default boot device, but
> it makes vga_default_device() inconsistent with the firmware boot
> display: the firmware framebuffer lives on the integrated controller,
> while the override points the default at a discrete card (or leaves it
> unset when there is no discrete card).
>=20
> The fixup runs from pci_bus_add_device(), i.e. after the VGA arbiter has
> already selected the default device through the firmware framebuffer, so
> it overrides that choice.  Drop it so vga_default_device() consistently
> reflects the boot display.
>=20
> Signed-off-by: wuqianhai <wuqianhai@loongson.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110090203.2631=
481-1-wuqianhai@loongson.cn?part=3D3


Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF07381AFF
	for <linux-pci@vger.kernel.org>; Wed,  1 Apr 2026 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775019658; cv=pass; b=iWt+HbbyL/ef0Jju2zbAxuZa+ctqFSaWeNFeGlu0W26BCGEstc7NRXg9gf/n0qwhSbJj+f/TkdwJ5XwjmyIvlDRBemErKTtmYqvf7Q1PZAVbUqGPXNuzBn/wFflarhMmbM+s+OdP/Ajx/rklXOg26K6PqugG7PgfYK6vZO7B0BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775019658; c=relaxed/simple;
	bh=OqQ601QbL/y+YrmVBidvwxw5csxIEjRfbUIlqPG+O5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3hdYxWRe6rRKbVGap7IuzbKvFsC5qmT9MEWwQ3YMp5UXchCV116qZKZ81l2rD2tWqxrMqsObzpNCEW2+dv4U42KMxBdWVe8m4Reuc+DC6SjE4AVhTesaloRUbNuq4u0GJuJh1kZ3bB2MKBaorMA12lwpQIIgj9Wfb/nP683/UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IECvBvtg; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IECvBvtg"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a1443780c4so565612e87.0
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 22:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775019654; cv=none;
        d=google.com; s=arc-20240605;
        b=ewKONDC4bkpoDYvSEZoKqRVR05Uj3xfLVuuhVinPOjNApdDsr4KcEejbBFx6oktFDF
         cmMHPNeAoa5zovTWmLw8Ey7YKPEHfXgGcT64o1AIfFJ/OGiBqymoG/KIXfgbgI9TYioO
         6/hGefK+kIxUlmReWI9s4lkxzcGByxnNUOef76xPeG8tcYWe+grF3joozgB2gugmfp5y
         ujuYchAXbVXxf03Gpzx+5wtEtUOy/m7ZcuX1ZV05xPHqBN+XICXJpVujYsVHj11YtSU3
         KUOSnVNEk9fnrItntJIH1trkv2K/2Hk4e+L8VPnH3F6vh5/H5yQqpzG9iLW4zSD5cj9V
         kf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OqQ601QbL/y+YrmVBidvwxw5csxIEjRfbUIlqPG+O5M=;
        fh=qXSjn4nSVX/gvu11Brp4JLEBMRYivRGzDs8GEXRr9WQ=;
        b=HGbbBjUJoT1P7zN0UoL+jnyyi5eukF4IN9TaXvDE73iOBzwRwgHoYsz1s7OsfKlKqL
         EV8zRs8gPGVHhnNUXhOmaFiu004BJTNelEUoZgjIrf32gPjyM3Q9KnroTvZl99RendGa
         ab1Ib/jNTCcULdiqVg/0f61hmPIoDUTmI+89Y1TAeCBQHtZQvy3UI9k4GzlN8IeaMZyn
         7/35oHtaYxZIHO06SDZ4YBUkGb0BvLVug7g4o4FgxFL3EyYmPTYPlFOQ6yL3hDGyvxoc
         i33g80jSEkFEsMu28xBxBMEaDdX3J4bFdVuZhJ0HpWrvb6R6DNpKBmVl9N0ZpzhXvEJ2
         7t1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775019654; x=1775624454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqQ601QbL/y+YrmVBidvwxw5csxIEjRfbUIlqPG+O5M=;
        b=IECvBvtgajJ4DrZgVl7s5vpVy3QH7nCqLjNpSeWL9ZqxY/18csVQR8lYdHVmSnchPX
         HEJTUblMsyOlCiQTKEPpLMGrI8R6QyS0EU3qCcv3mX0dw65sY2Yb4LTVy+7dlVrGBG/g
         kcqtf2T88qtuq3KkVmVxKPW1s870wQw5llKG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775019654; x=1775624454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqQ601QbL/y+YrmVBidvwxw5csxIEjRfbUIlqPG+O5M=;
        b=lz+YkGrYNLWVtxJbc19EXp8KnNKoHhjJXYUowqas7keIwh3763yBy3nbj6vyhKpa8r
         KzqIq7lasgQWVXoJPso5y9RvyUuN9U++3PzYRz3Mod47XlLx29E4zYtPNEdTRgK2kit1
         o5KHOmFzxzii022gOuvnEnuyezQGLPcNzcNJV4/TnU3Jzroa9W+jvXTX5lSoW2KIr6yV
         GcmGCllnfskUYCSb0xuaXmGvMJvPfpSL/+ih+UWtQaI4YLScWnV8ZZzChyHYcdmANKXT
         2Fn6lLu70FseKkwI0U+dnejtxnVrVl79VlAaUrfOHcLQ2rmrD0yseyN0B7MjRiKUqd3H
         IVDA==
X-Forwarded-Encrypted: i=1; AJvYcCWsFU88GeH1wQ/tkUJlOU60bW6BWjf7ghgV2nAd5qCtT7lxL9BXMgIJHGyi1mlP22ruKdbBMcQaPEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK6Fo0oO1f11uXJw71Y9EKINcrTHBu/FZRkHfvt1VZboEdlQGR
	B9Y0Z7dpRhPrtNVdHVuO3RwaoeP9brV2UO6p61ZyJktlGPP9RlxYERxts/xymxlSNizkdWxO22G
	khf+yS0i97SNhERCkTh0Z9rOnuYNnIQmNfEXJKK4Y
X-Gm-Gg: ATEYQzy+5PPRtaFi2mpVHPtZ8cOTDw2pKtkxA479G6FZbomXLHuPFccE77tdwz8QD7E
	rsf8RmWwb0plHY1E2/YgBvPNV4mkQ+3NDAHO128ccMak2x/opmGjwxTH2ks0HiowGBt1sAil0dx
	DL378hSdadB4Zulcnx785+slk/0VVkD+PlRZXCAjX/9vWVnAVcNvdY+lr/0Ea1F2JvhumnC2fQ1
	GOwwOy+sswhQb0Xqs49ceZosvt2G8a4VTw2IFwnkdjZBdVsO5xqpXhhLVS/SW7xWSq3oMKYs0Aq
	OmRjca2+S96aFGB4lIAfpxqdTrAYVGtL+Oxnkw==
X-Received: by 2002:a05:6512:3ba1:b0:5a1:4e53:c68b with SMTP id
 2adb3069b0e04-5a2baacc775mr2863990e87.2.1775019653869; Tue, 31 Mar 2026
 22:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401031917.9108-1-jian.yang@mediatek.com>
In-Reply-To: <20260401031917.9108-1-jian.yang@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 1 Apr 2026 13:00:42 +0800
X-Gm-Features: AQROBzCjsi0xnmIJgMsX3J2duHUIVsuutzrB8RxL3Ea321MAwxUsjyebvjmh5A4
Message-ID: <CAGXv+5EJ5rUVdnJZKwLj_NLQVtn+8TE4+gEqt1=LQrD28pA-eQ@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: mediatek-gen3: Align PERST# sequence with PCIe
 CEM specification
To: Jian Yang <jian.yang@mediatek.com>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, chuanjia.liu@mediatek.com, 
	yonglong.wu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 11:19=E2=80=AFAM Jian Yang <jian.yang@mediatek.com> =
wrote:
>
> Fix the control sequence of PERST# during system bootup/shutdown to
> meet the requirement from PCIe CEM specification. There are two major
> changes in this patch:
>
> 1. Some of MediaTek's chip will stop generating REFCLK if the
> PCIE_PHY_RSTB signal of PCIe controller is asserted. We have to
> adjust the startup sequence as follows to ensure that PERST# will be
> de-asserted after the REFCLK is stable:
> Assert PHY reset and PERST# -> delay 10ms -> De-assert PHY reset ->
> delay 100ms -> De-assert PERST#
>
> 2. Add 'shutdown' callback to control the timing of PERST# and power
> during the system shutdown phase, ensuring that PERST# is active
> before the power on connector is removed.
>
> Signed-off-by: Jian Yang <jian.yang@mediatek.com>

Seems correct to me.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

If possible, I think we would want this merged this cycle together
with the other pwrctrl changes.

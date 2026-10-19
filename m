Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78E376BC2
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392930; cv=none; b=hsorB0ZSgvRGUGBmHXw9F+v6qiFUUULgClyKPDBA03xRtsqS+PWO+bOZr8zfDt30wbSUxJ03qUl7fDHGzAXySUpBpjXgDd9fsKGqfjHEkTTfg0XpT/HU5XPt974cKfiUetcG3jxTB83LXz3M/hDQj2fupQoHMHr5MP+XZ/lTGj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392930; c=relaxed/simple;
	bh=Ubs41DUyBoPmDPCKJRrMMvdmbW/Txkwy/rx3UihzBto=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fqHQ6YqHHeSKnzCYpLNAqvjxZ1TO5tzdOnrkeyZEQ7RzBUl1x5KLXO9+fqdcYDwuOUIzSh0889XAwYj9cZr9msFsCSjXtGmrkpRVrUyL57Der8tLjBUGZ70qED+WGdiaEAl0G1MFB8wDxzrsxY8jCNkuaeGSCCW4phHWnhZ1j1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaDD4COe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaDD4COe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346621F000C5;
	Mon, 19 Oct 2026 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392929;
	bh=Ubs41DUyBoPmDPCKJRrMMvdmbW/Txkwy/rx3UihzBto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oaDD4COeXbkwKSNh0bq/Xwsfd2q29zJIbUD1Q4K9gle61Me/EiLPUYHs0IXAEdRaZ
	 YcSm/I/jZC+TzyLdWMLZzXEmbN24OfPWyYjFE9vUAyikgIqRXF63ERCpulMthB1/ms
	 VaNw/fxgLGzUURYmB1lsrX5FryFCRabTIfmKcWtmzWoVg4Gh4MrDQxdwf/jvkglO45
	 YuM0bf5aE9m2mKXm+6D1qVFLpWg6655PzL+fpUkdzD8PTZ2k2gitNFNx+Eksp3FRPM
	 xPObXZxz7CUkewQvc/C+upgn8cgS29VOd0HUwVu5f68R4ZMMVIbmy1bsQ9izRTiYOo
	 dUz6WZJJX4Apg==
Message-ID: <sashiko-outbox-176715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/14] PCI: rzg3s-host: Add helper to wait for link
 up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-13-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-13-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:55:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Factor out the link up polling from rzg3s_pcie_host_init() into a new
> helper. With the link up/down event handling added by a subsequent
> commit, the probe will no longer fail when the link is down, but
> continue and rely on later link up events to detect the link becoming
> active. Having the polling in a dedicated helper allows the probe path
> to treat its failure as non-fatal.
>=20
> No functional change.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D12


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB366271443
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640249; cv=none; b=RD2Hk5qlWVo5RmMlIGKxIfc7G7xrSKXF2lQcu38HjrYDH1l962jbeo0pUR4vYpy9wdodArs54MPD0BupoI84t7d8hPMyvQfutsHR1CeyFiXDRDYpK+nrWMfX75wUD/a7ZiJWJekAlSCwRVcDX7lIyNGKrQZpGYYnQpi1BhLzjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640249; c=relaxed/simple;
	bh=biZf5Fy8CZGLSBBbYbyjDp/fPpxSusx9n8nRInPLAik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lOuO72uYp+UekU06T50neFpAZfjArzpfEzFeT5gp/czcMQDfef+PySeX5cscYwkQa4/kEb135NDYk2PpvkMDdPggVHmo24IXaAiNibeJo0Rytr1I823Es/Yu9jTgyuJHLX9JLDNTX3sQefzTuErBhoTSQGHZvd67AdSV4BpQtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjUKE06P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjUKE06P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E0DC2BCB0;
	Wed, 13 May 2026 02:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778640249;
	bh=biZf5Fy8CZGLSBBbYbyjDp/fPpxSusx9n8nRInPLAik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EjUKE06Pnkft/9HFwDDD54wMA3fFEWXFYci/gK+XPKbg+LIJQ9Mev6pwVWlT3ATmD
	 gnuGa8XjwNLnRWKT53A/h9tgEqdw3GTbG487jSDo0DAlZJUhiEbwidawW3qufIokm0
	 KM3jywyuKf7mgRg/pcZFC2R8txBAFIRNT+qyCpA+6EQUdwBWr33Xuo23UC3NwSGZH7
	 DHYp31Zhejyi1aZSY3pG1WTkbdzRsGSeD/GUcXWW5BDCA6gcJkPnGgtYKDnNZU+lGe
	 YY71G3xDU3NmJhh1wDm7xJ/jUxHAd/AeXHskEDlCQ/dn22YJsDlMb5L7bZMDGBwdES
	 s6xON5MsI13Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/16] vfio/pci: Register a file handler with Live
 Update Orchestrator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511234802.2280368-2-vipinsh@google.com>
References: <20260511234802.2280368-2-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:44:08 +0000
Message-Id: <20260513024409.29E0DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The Kconfig symbol VFIO_PCI_LIVEUPDATE depends on a non-existent s=
ymbol PCI_LIVEUPDATE.
--

commit 0dbf63e191b4b1a239db36bedc83313305585f3a
Author: Vipin Sharma <vipinsh@google.com>

vfio/pci: Register a file handler with Live Update Orchestrator

This commit registers a live update file handler for vfio-pci device
files with stub implementations. It also adds a new experimental Kconfig
option VFIO_PCI_LIVEUPDATE to gate this support.

[ ... ]

> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 296bf01e185ec..c12d614fc6c4a 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -42,6 +42,18 @@ config VFIO_PCI_IGD
>  	  and LPC bridge config space.
> =20
>  	  To enable Intel IGD assignment through vfio-pci, say Y.
> +
> +config VFIO_PCI_LIVEUPDATE
> +	bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> +	depends on PCI_LIVEUPDATE

Does PCI_LIVEUPDATE exist in the kernel tree?

Referencing a non-existent config symbol in a depends on clause means the
dependency can never be satisfied. As a result, VFIO_PCI_LIVEUPDATE can nev=
er
be enabled.

Was the intended dependency LIVEUPDATE or something similar?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511234802.2280=
368-1-vipinsh@google.com?part=3D1

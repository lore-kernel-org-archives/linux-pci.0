Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE18569F32;
	Tue, 29 Sep 2026 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711258; cv=none; b=brmCh549HawiH+fEyxF3qsP0D5+yQIYfswA1G9Hw/T7eF7/5yS7LZdCYQS+W3UkOQBK1a/m78/vSELm341t20e0wBvWddTn8cVXzdoGahoDJpAT9c4G2isQ7fcROc1C3504P73rlmZ10HeXLHtRfl/S1p/xIq0EfBZgLOzBVNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711258; c=relaxed/simple;
	bh=CH9vKNvR0x5N7Cb+XuIDmG08jgy9Rx3wgR1CIEuZGO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mLM1s1JGXTQB7rVo991UVbAVr4AbkA+AT9nhqnBu7W37RefE6eTFRKYM/mAcCA0qNremlL56IRSsRiTOeqAK0e4Rirweg8fqadJx5mr3+VkWp6WS2gIqD/r44yy9OlgXXdfbOJVhC8kwwQggvU6dmwWHTXNjgvVpq8M6RTMtbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E90jhqCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E90jhqCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9671F00893;
	Tue, 29 Sep 2026 19:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790711255;
	bh=4lTnb6dLKOMMUYniqUMDLwMAcEnotkSjXO3jVri9qCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E90jhqCKD+YUP64S4EoVruYTvfw/rUVuZv7jPSKHTbqc4hh/Vlh8Ke5s3jXkJc8CP
	 QY8dZ4ket7Cf8+RIh6rvr0Lzh+XIqZdfbIDGF7ajf7jIUGhIPmslhsvMlLYGOyBnaL
	 93J6Vo68z1jLtuZ5lfrxBt5QlEZ3ZbV8nWpggPicLQhuygeVH1Tth5hUWxCRsTc35F
	 X3ERNZZAOxpHv4SaSHOlsI6x0lbbtD5csLEEzftsZoe/ReMPjiVtsJ15kH9v6vdiAQ
	 oympEnpu4v5GonJM2j+W9+gr5IdMV1Z1qvoxhHhp1TNC6LnNXLs1tK/3kIT3xB1/ll
	 cky9rd5Ts16UQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: layerscape: use default error response behavior
Reply-To: sashiko-reviews@lists.linux.dev
To: jeffbarnes@linux.microsoft.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260929194339.233271-1-jeffbarnes@linux.microsoft.com>
References: <20260929194339.233271-1-jeffbarnes@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:47:35 +0000
Message-Id: <20260929194735.AB9671F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
>=20
> The Layerscape PCIe driver programs PCIE_ABSERR to forward errors from
> outbound non-posted requests to the internal AXI interface.
>=20
> A PCI configuration access can race with the link going down after
> dw_pcie_other_conf_map_bus() checks the link but before the MMIO access
> is performed. When the resulting Completion Timeout is forwarded to
> AXI, it causes an asynchronous SError and kernel panic.
>=20
> For example:
>=20
>   Kernel panic - not syncing: Asynchronous SError Interrupt
>   ...
>   Call trace:
> [ ... ]
> ("PCI: layerscape: Change default error response behavior").
>=20
> Fixes: 84d897d69938 ("PCI: layerscape: Change default error response beha=
vior")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929194339.2332=
71-1-jeffbarnes@linux.microsoft.com?part=3D1


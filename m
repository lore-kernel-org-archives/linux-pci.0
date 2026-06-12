Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF336B07C;
	Fri, 12 Jun 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282793; cv=none; b=oKCtsP/qxE2zFzv5bbN6jvSDYZo+5UShBAs3GDwOT0zPHEWyzUiiS9Jrs2gYhdWbLMoQfwu/5RjWhMDkj9CA4oT6XlQslmebNvbrrs6FSfNgEfupxqM9gDhnpSxhqahuCMVGoAnuu/nqehh0vGnidbGkzBIwGa7Gv16gyCz0uSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282793; c=relaxed/simple;
	bh=xlJzuU6TmaTLYEzbxxkSEEA1MjWF3vrZvIvvsp6g9LA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HyFha/7AOIytMWR2B4RtDZ8srrYyjXjz9BaIp3hUXA+oFHZa1jfjVTFyxRabvSIft+wB+2+BvUpjMwvvsSc6rxfe/3v+m0Q98k+qR/RWX/gV4hVdfZCP2eJ6JQn0HlQ+i2WlnaQXRsMYAkBDTt36iVgk0j1w4zubUtuasUfvdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSmGtymw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSmGtymw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101121F00A3F;
	Fri, 12 Jun 2026 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781282790;
	bh=xlJzuU6TmaTLYEzbxxkSEEA1MjWF3vrZvIvvsp6g9LA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kSmGtymwTPk7yibzEMj4XckFr+ejhnLcHAUdL7SaOYU+QVBMjtCCpkUWadBbsXvXO
	 16B73Dom+xa2vJgFhaPfHLjLe8WUF5igAuyKnvOcUy9rSDXurzmya09yyDqes3obUW
	 DK9WTFKZ3hGunfOJzS86DkHh5GP6S6I0yU9aMeRxlUX6lyo4gRAvaPKjEs9B7Lg1/g
	 OcnmlDKhS/QBNQQKyV6cNfITsv+yPCTawZLsln92nZ6qsMcBd1nYql0sTbwgQq4tOq
	 vsxbm4AXa2a8i7iRxZlAEBtTqQ4jFL4vxD3Da4J5OugVAgIAI6uv0XMe7uvXzPQICT
	 5BLNJFt0XsiYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260611161546.4075580-4-zhipingz@meta.com>
References: <20260611161546.4075580-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:46:29 +0000
Message-Id: <20260612164630.101121F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
> wrapper for importers.
>=20
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
> the importer requests the namespace it can emit and the exporter
> returns the matching ST/PH tuple or -EOPNOTSUPP.
>=20
> dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
> when the exporter lacks the callback and requires dmabuf->resv to be
> held while the callback runs.
>=20
> The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> mlx5 as the first importer.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611161546.4075=
580-1-zhipingz@meta.com?part=3D3


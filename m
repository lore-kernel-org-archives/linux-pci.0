Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7342F8E98
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859859; cv=none; b=ic3U+JI7Tyx+B1wZuZxiEStc9k6lvvb7qLiJ9xzywwqcolEpPUUsrG1kMZcnuL21Fc8TU0A+40w8N0YBmSVHMBt4u3Ne5xhdMpY/rFMnEJ5ZTy1mCFLXp6YVlC9CqNpq84gZ2gJiSVycyK43SJaZemL1hu9RCNJO6ml7hbijhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859859; c=relaxed/simple;
	bh=q2SkXWCo8d9k434V4b0fBm6Jti6eNZuoNopVpLdaEPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LLagDbTYt1WcMQjUFxR3L9RtOD5Ua3W3k54EbAEplzVV2drcyyH+XD3u3k3y/WT1WzElrV1DFR/3m4DnUolba/+ZvVGvjhyjgOxIuH+cS4ADqG4AGe9T3nWH2Yb7e4VYrjBnt7DgMX7kLLpu5veCk7N/yQttUan+AGLA3ziylgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1uIgQjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1uIgQjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B2F1F000E9;
	Fri, 19 Jun 2026 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859858;
	bh=q2SkXWCo8d9k434V4b0fBm6Jti6eNZuoNopVpLdaEPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K1uIgQjDaGnJaaZ3UKCRlt2nPkqNJ6UCNkW1AMaTjtq8bfqQQbGeNtPkWnyQIIA7s
	 JvfQ8ke9kFA/TyayDb4SU8yGUhlyXWC3Mnb7bpqemUVpAoOnn/njGlypFEAlPFnUGP
	 8gI+KmVQZEE7gUZDzdlFK+n85AXU0E/ZzZ7xfDn52gUxsuKlQM2sI+8lwv6v/Wmbvn
	 jJSKR4ayRfqbB7WL8XC3QAtQy1grfnYLyshFeLTvIpSPRnCKJef8N7tfubPEabdppw
	 GEdm6zAJx+ei8QA1cRn3M9QNblX6/gJI1ITI0MNKGVpKjY3K5ddiGFth7C8bo+SBMq
	 5KtzGn8ys5tJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/25] alpha/PCI: Use PCI resource accessor macros
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-14-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-14-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:04:18 +0000
Message-Id: <20260619090418.87B2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Replace direct pdev->resource[] accesses with pci_resource_n(),
> and open-coded res->flags type checks with pci_resource_is_mem()
> and pci_resource_start() helpers.
>=20
> While at it, move the pci_resource_n() call directly into
> pcibios_resource_to_bus() and drop the local struct
> resource pointer.
>=20
> No functional changes intended.
>=20
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D13


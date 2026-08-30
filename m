Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E835A398
	for <linux-pci@vger.kernel.org>; Sun, 30 Aug 2026 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088854; cv=none; b=bLjvmbM2FuphLEKRX1nYtrFGonUB2J3WXiguCQ6V6Sq9pcLNgCdGk9osvdhpT7ztQrXqzG9OFhZaZPlXARPZz/IqF/8wY3cHuwFYfBjL4b7YskT6WWtwAiM6iSFp3aYqEpuv7sO4noUzThqOhKbZhgb8dq4Y+xEa9oQ+QllPabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088854; c=relaxed/simple;
	bh=Mk8u01Kj1bvss55Vzvrk7fnb2KgKXFTlmxBlYenSe0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O112Bocwv9naoyVFkbeVgYQVOR4Rfs+wapqW2dghO4usNEWu0TsWAq4uVzFd9It0kP+eHOXl4s3ttMdXAz/x4fTSS5rjeTD2i/bfp1+sFllXUEg8bTU0g6dH7g/9pntVrWZczL0j5lAGGdieEB4L7e2n9njLmS9iOU1IENjeFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5kIDplk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5kIDplk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E251F000E9;
	Sun, 30 Aug 2026 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788088853;
	bh=Mk8u01Kj1bvss55Vzvrk7fnb2KgKXFTlmxBlYenSe0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S5kIDplkZKh9Uxf6UUTJtCTK0ZKO5wTt8hzCVv9WTxbXIXbhuTMF2nfBEn4+jtfU/
	 8euJF+7j0pAK2D7HQhQVe2d+6ug98chfyDtvv3dwswkckH0z9UU8hGkjlqPwT2vJJh
	 jMWfWLxAGNlLfMlNqIu3tKUQ5ql+jjnMDyG1l1jtdjrop7j8DS2eXDSzANrcidqSdk
	 U8DZJB/Yq9xnDUNrtQq8CnSBdPGapYP5ZypXt5BPNAzK1ghTEM7/QIGfbhzmmiN0O4
	 p6sVQN8GEPe9n1PNPYeBparyN65bnkZ6nl4Mgs5TElWGTpp2LaWJW9RtJMMBIqoQEm
	 Cu6H/VUxiRSeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] PCI/P2PDMA: Gate the host bridge whitelist warning
 on verbose
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260830-batch-p2p-fixes-v1-5-5044e8dfbe2e@nvidia.com>
References: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
 <20260830-batch-p2p-fixes-v1-5-5044e8dfbe2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 11:20:52 +0000
Message-Id: <20260830112053.12E251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> calc_map_type_and_dist() prints every other diagnostic under its verbose
> argument, but reaches the "Host bridge not in P2PDMA whitelist" warning
> through host_bridge_whitelist(), which it hands acs_redirects instead.
> A caller that asked for a silent answer still gets the warning whenever
> any port on the path has an ACS redirect bit set, the CPU is not
> whitelisted by cpu_supports_p2pdma(), and the host bridge is not in
> pci_p2pdma_whitelist[].
>=20
> pci_p2pmem_find_many() is such a caller. It sweeps every device with
> published p2pmem and asks for the distance to each client with
> verbose=3Dfalse, and pci_p2pdma_distance_many() recomputes rather than
> consulting the map_types cache, so the warning repeats on every sweep.
>=20
> [ ... ]
> Fixes: d1b8dc09dd71 ("PCI/P2PDMA: Simplify distance calculation")
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-batch-p2p-=
fixes-v1-0-5044e8dfbe2e@nvidia.com?part=3D5


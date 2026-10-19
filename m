Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44943481641
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399282; cv=none; b=k7pGZqvefQjr+YVvVsbk6G1eHXTGLR303H0r9J/lBzm0iGe8AwPKbYVnFFeb5Y/ZvplWCmArbS6h9ZMrsJ5hca/Ahc43OpQFSpdn/8akCLKB23LpHkgzYqtDBPvSJHhMMGaLkOEPgeTbJSd2xuGTPQ9o6SJIBz+PA6oQG0ILzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399282; c=relaxed/simple;
	bh=mdHE5ccaIT2PPur0Nx+t3kQP4Zl3XTt8pMInlDACHCE=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=KBaUgxBZnGUf8czwKQsp1CFQ6hx5+rAdlER3Eh/BpvlrdCnwC9OzPzamt9Gg5VADw0GrxuPQgotKylg2jh3R2S5/shVuFmCj8KREitPoq0RqGnw4r4vfCeKX2q4AI78RU2Rc+CVYBmSbViWNyUuKClaoH4FakhtQDiHLQg3wLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIm7dITB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIm7dITB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97B91F000C4;
	Mon, 19 Oct 2026 08:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399280;
	bh=mdHE5ccaIT2PPur0Nx+t3kQP4Zl3XTt8pMInlDACHCE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HIm7dITB4i8x7j2JXvlk7bKvfL3nwp3msAq+JFDGyQOkJOq9UFtgyQnICqwVQ8p4j
	 wGTzQciqbnw9wdGQ14slUvJODDTjvHuZzCjSL1Cph7/GFdlnGpYfWOVdePSpWQrswo
	 ScZHNs5rIOs1o1paSP9aA/0+ocL1qzJQwXF0Htkp3D/9gtwajGHm8MOe7FcrhNjkzN
	 QOfZ9FVmwBUesmPwE8y2qgD8KJqRZ9rdfXRd8mfE1gDMULRNoF7vTxRF5Ex/kxN7aL
	 k0/a2NV8mU29eMk2GHUvU1FOBdgtpP8ZhbcQaciObJ/7teMVQ42JAk7rATx1QtPCEF
	 4txMWNsLTsAxQ==
Message-ID: <sashiko-outbox-176824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/13] ixgbe: Use generic VF iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-11-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-11-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:41:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> ixgbe_get_vfs() finds the VFs by walking PCI devices with the VF device
> ID and checking that they belong to the PF. Replace it with
> for_each_pci_vf(), which iterates over the PF's VFs directly in VF ID
> order.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D10


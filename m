Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F22E8897
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311994; cv=none; b=E+ZRklI8Ph3apkLGMd5K29dcvNVnMN/mNIopsNzgVsDQ/W42C92Wf70f07FcoKeNHnqpLQF3l2PZfQp3TPIPLeWEsJkGStPe39ME/ZmDzy9bxqBSefX82C2uXQCB/iYlgJNuROss4pC25Pu7qHHIV17qGLaOuVeUxUe9El0ssxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311994; c=relaxed/simple;
	bh=x73gR2CwWud9dTiZYwdzTQzd+qAJnskAtlkJ30Lo3k4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OR3SAyZFdMsLbWRmqH7KGxFsdmlPL/6PRawN+SA3kiGwWvhZgh5DwHqYRvq1A+bb32xnyTQrJkghdt0sDQhF2HYW4awe7QxpFDqW5F5uLM9azgFDBKho8tFKGeVEVXRFx3WY6BbfqCru2r4YgQtMRpWIpTXg7TUOSPwU1k42C4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvxP41RQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvxP41RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D861F000E9;
	Fri, 17 Jul 2026 18:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311993;
	bh=svTq1hOLnUGgpAnikrWFcGyj/f4ke0gfPSZzIsaHU8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvxP41RQLMmeet0qHke8Hlm5cTsiRRt9dYAxCt4cPByYbcdKPW7OwDMo3wB1jAL0R
	 b1mwrS0UJWmtksd8l6OdBOdbrSEW7EUgWBWruJZ/kS5QUJKn5F1BFQWJDbqbcxVaB1
	 CSo/vqP0wYxY6J8l+9h47YH2ze9b9+NZzRxAKWkUiRsuQIMCaGadsrjmhC09wRitUP
	 vzPxzl5I1hg4UaU5M1znCnOkpRBmTPmIeyb6AgwmF/TQHMbaK1lpKhI2Os58kRPrDY
	 viarQv2DRnjcom7tCQY/oQ/8DClvC6LjMSOnxx0zSOlQb2NersvCF6rBrUOxnx0Gkn
	 cnHqQfvGJSyQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Don't report fully optional resources as
 assignment failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Pighin" <anthony.pighin@nokia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260717180029.1829888-1-anthony.pighin@nokia.com>
References: <20260717180029.1829888-1-anthony.pighin@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 18:13:12 +0000
Message-Id: <20260717181312.D8D861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A hotplug bridge may request a window with required size 0 plus
> add_size headroom.  For example, the PCI core speculatively requests
> a non-prefetchable MMIO reserve for a hotplug bridge even when no
> downstream BAR currently requires that space.
>=20
> reassign_resources_sorted() temporarily grows an unassigned resource
> from its required size to the required size plus add_size.  If
> pci_assign_resource() fails, the failure is ignored because the
> additional space is optional, but the resource is left unassigned at
> the enlarged size.
>=20
> Since commit 96336ec70264 ("PCI: Perform reset_resource() and build
> fail list in sync") and commit 2499f5348431 ("PCI: Rework optional
> resource handling"), the __assign_resources_sorted() out path
> unconditionally adds every remaining unassigned resource to fail_head.
> [ ... ]
>=20
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list i=
n sync")
> Fixes: 2499f5348431 ("PCI: Rework optional resource handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717180029.1829=
888-1-anthony.pighin@nokia.com?part=3D1


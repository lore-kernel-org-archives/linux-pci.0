Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F167175A93
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685859; cv=none; b=Z+PeULAbB8p9JOH+axSq/VvfGF3nbcx4yzFaF1EnzWdI+N+V1ndiFt4hv0qy9tnZAWPQdlawP/OVcw3ADv5IJQ0GNX+iKyij0z3kRvoz2E+2WSdlMZz+fJ+udx9hAMEZHnvIQpZP/8Ffz9eAlyTm5f5VTGwvSCGgXDR4n2cj/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685859; c=relaxed/simple;
	bh=Cj6AtewkKw85rTbWhr33A9XpwqGAGk1Dpt1gzFye6WU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DByDGdtK4mdZkMRVb/kZwqyEIAIMhKpkaUKJvNaGK4qqpkGc2bWSmLh1Q/Nc1uA7B+SDpony2jgLwpIjg+lcKtxpQZLlMt2OIr9WBk1wJi8qDNrvCanbMfqV/o80TqEX3TGNd7cu1P8c4bfjy7BdsrQzlgiLHRzPT4fTiFgigGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph4sdwYz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph4sdwYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02241F000E9;
	Sun,  2 Aug 2026 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785685857;
	bh=Cj6AtewkKw85rTbWhr33A9XpwqGAGk1Dpt1gzFye6WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ph4sdwYzFPKZMy9da6nT0lzjgHtoyg08PhotUyCDqvoJzdxTZ3GlJcitTARF2kv2v
	 MmD91/WktRSMko3LJUlQVCxZmT04r4JqXz0ZhD9mRKyo+XEiWUQHiGsYzmkKY3dPyd
	 Y8qACTvIvz5Dz6+RVpw/mjL2LHCK74Occrb6RSTKmnYVRdv+nYFSsY8pPYG/BJOy6G
	 qw8MxwoX80OTt4Czy9BzokZHSNKZvAK+pashB5sMIgVwSRydg28VDUIIRFB81Tc7bH
	 vL2OY1pleyvUHeHeVQiQOca9jgYzU0q3uhQ+feJatECQt7jdN9ua67+Vl30ngJvfKH
	 Fgi1qCbVzYExg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] PCI/P2PDMA: Derive peer-to-peer routing from ACS
 control bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-7-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-7-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:50:56 +0000
Message-Id: <20260802155057.A02241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The redirect test reports an upstream redirect for any ACS redirect or
> egress control bit. PCIe r7.0, sec 6.12.3, table 6-11 ties the outcome to
> the control bits and the target vector, and an enabled egress control bit
> alone does not redirect. Compute the result from the control bits so the
> vector can be honored next, using the host-bridge route while the peer
> target is unknown.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D7


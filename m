Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818CA45D19E
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016094; cv=none; b=dfatK5GMB/Q1cUaM5svJIsvWXRnvn9EpQFk/KYPCBiyxCc0sVuj1tK80Hvu5P7ow4GdNricoSmpJ+uYWOENmCDHhQbMjFYnfxDJKXiJ3P6p59rSpr3PXsLWTN4STPFZYUTsIuIf/1myuahWqSv2j9JQjRW1CTytxI9gfMIVS7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016094; c=relaxed/simple;
	bh=mbTnNZnFSGOc09lWvv5b4YdN2rcq/uKlyND2QfECEmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=os+AAaUhOz8HtgcWUEKIaK4Rih8edDB3PHJ57SGVxB3PqOKgcD/EOWVgpS0nddvT1o4IuNOvkInPxV5zljtGNYa0xp9WYug8MFOnIr6RZNpkn/W6FvsF6HlsrfpMvnAqa0bzDP8hVYIi+HflCidp28a3nCpDgyND8IhXGzK/Ud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDpJzxl2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDpJzxl2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27C91F000E9;
	Thu,  6 Aug 2026 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016089;
	bh=hl1hMkqKYkll9iwzl0qrwJsd7X42VnhIsyaRkB6JZrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nDpJzxl2zgP90f1SVPOv0oILCAuB5ow/3h3cU47svxPi2tvKg2EcKDiNTKuQDVNjv
	 sfo6d3NEJUjpD12M4v3vNkjsftm9PM2GMp8Mk/eeLdl8wV1LxLcfLHLCToNCoOsGqA
	 0xdBXrBUrBH/ddrAabS3R052EhVk1dwwBCsMeN+WptM8As1vGf+PflzWAhVfsMKInc
	 zwumZ1r8AD/fXv8ZK73HJBynihb4ecsoN+AoooiIFs9SjS7+1j7niMV4rtMxQZhbS2
	 Q5cKwrBEmCp1vrRETSsAodrIWi9iSuZ4d4uhIELo/TodBdOITdcGx4Ewe7rGchesfo
	 zXE7cKzxbMK9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] PCI/P2PDMA: Add KUnit tests for ACS routing
 decisions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-11-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-11-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:34:49 +0000
Message-Id: <20260806113449.C27C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Add a KUnit suite exercising the ACS peer-to-peer routing logic:
>=20
>   - pci_acs_p2pdma_decision(): the full PCIe table 6-11 truth table,
>     including the Egress Control Vector branches (bit set/clear, with and
>     without Request Redirect and Completion Redirect) that require a
>     switch implementing the Egress Control Vector and so cannot be
>     reached on commonly available hardware.
>=20
>   - pci_acs_egress_port_valid(): the vector-size boundary, including the
>     "size 0 encodes 256 bits" case.
>=20
>   - pci_acs_egress_ctrl_set(): driven through a fake pci_ops returning
>     canned config space, covering target Port Number extraction from
> [ ... ]
>     --kunitconfig=3D/tmp/pci-acs.kunitconfig --jobs=3D$(nproc) pci_acs
>=20
> Assisted-by: Claude Opus 4.8 <noreply@anthropic.com>
> Reviewd-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D11


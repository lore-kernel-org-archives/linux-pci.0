Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110E45EF5D;
	Fri, 16 Oct 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190156; cv=none; b=cR63eGJ6sRULj7zLtoL8aFv7/Tq/BfilUg3dXys9hLei/+g/1VGRI4DzNF6zFM/AS/E4LTeKW5k+EVnJMuTiyC9YZYRlXrEavVg6X+KfzJ5T9DSkSRVsNRnVr5xbmd3cxjBbKPZwxjbsh2O5K0lD7Ecdbgon087KWaxHdmm+jxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190156; c=relaxed/simple;
	bh=nMz8CfTznkAaUKWgj9faS4i5NX2Ao7g5/UlPRhx25B4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AtElr07c6ubUO4L2DYSiB7NRbcnLEoXOOfMWsPcrCbxRdgC+oTFv1zlz60AmPU0FCiDxVWO8x/sL3PFZV7ADiGpAtxsL3SAdVgog1VNPyqz7MYF7jvdeL0XUvE56Tm62/2tB1qNpCqj2gOwM6oQPU1yINhHof1JGfYzTcKJt+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdCRqBGi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdCRqBGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72001F000C4;
	Fri, 16 Oct 2026 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792190154;
	bh=nMz8CfTznkAaUKWgj9faS4i5NX2Ao7g5/UlPRhx25B4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdCRqBGiBDqwLziw9VBDI1ifk6InJHUx+G6U+PcZZwi7v8peA5IsJrsQD43W8heLc
	 qWH6f1cPlj7Rk4eX5zRVgi8LH26Lj0HS9qfvztYvTyklyIZHzVnL+T34xukz+nTKdU
	 AnWjAlwRc1ctzGM5wQIE2n1QBynrgnacLdGydgmmYdWJ/un/Ec6Kzn/3MOTUp606kb
	 A6I1Jt571LihJaRAmFwuOMn3r1YZqag2qhB+yUwU6inz2StHYNtf6Cwgb7Rbv+xgEz
	 lV5l5AM+nGt5ZjFBLrn0CXG7kQlOBhNxgvrhZ1Wi4culXsfy4TzSJqc71bPuwEjRPU
	 NlAo8b1eiuYMg==
Message-ID: <sashiko-outbox-175022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on
 Intel hosts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: virtualization@lists.linux.dev, linux-pci@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261016223402.19991-2-pavel.e.popov@intel.com>
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
 <20261016223402.19991-2-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:35:54 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Peer-to-Peer DMA (P2PDMA) between two devices requires either a shared
> upstream bridge or a host bridge matching pci_p2pdma_whitelist[]. In
> VMware guests, passthrough devices appear directly on virtual root
> buses without host bridge devices. Consequently, P2PDMA checks
> evaluate endpoint Device IDs against the host bridge whitelist,
> causing P2PDMA requests to fail regardless of host support.
>=20
> This affects discrete devices such as GPUs, NICs and NVMe drives.
>=20
> The P2PDMA host bridge check does not work in a VMware guest. Bypass it
> for host CPUs whose host bridges are in pci_p2pdma_whitelist[] without
> restrictions. The list covers the Intel Xeon server generations from
> Skylake-SP to Diamond Rapids. AMD Zen and newer are already covered by
> cpu_supports_p2pdma(), so only Intel entries are needed.
>=20
> Tested with the Intel Level Zero P2P benchmark (ze_peer) on Arc Pro B60
> cards in a Linux guest on VMware ESXi 9.0 (Emerald Rapids host).
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016223402.1999=
1-1-pavel.e.popov@intel.com?part=3D1


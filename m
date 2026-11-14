Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618234;
	b=v97OmsRMMzox0BDLofflFymcFe7rC9LGhSk3XLEpb+oqrfbO3UdnBxLCCK6PV5ijDtgZ
	 Q40zMNk1D3cp5vpRk08WyUqf7KhoCs3nH12GUi/DVCmzzXKR8oG4LzcOp9RfIPFuEK2sa
	 TqhniDoShiAK7+ID45Vlv3WRwscybIyTcocd1ij8djCv2EYkA3UsKKI3taKv3q0rg2M3e
	 GearW5O9PzXRjosqMLu4DfSVeq/4kNgc+gcTTIj0ro8SP7Im+slIGMHuDPdRhmRQ/FsW6
	 tQeHKH/QE+I5l43HqKEYZaygKjNe5AelryGmVoUKzEFDdgc2OFvraDeo660WqIC5ljA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3beF5xCwefki1pNo7L6accw5Q63lKxsdlp33ixj6N0U=;
	b=RUTNFVJeQGC1dNRLx1G0Eoxv3GCHJ0rMuPnhcexeJj+ci0/6t0975LYNb6hJtndIFW25
	 hM/AR6mRdFgDS8IY9N498Ge3Q1HneNnf5oG+Ovn8pjj5geYvGod9d4RABBIUhiUBEV9Xi
	 bs57wWCnzTRvqUYpc0BuK6MDw+whsrbVs+2/xCNhRWGQjruaa3PpHhj2cvp1jm4THLQUd
	 kTKXlOtkguqulGxO8bf2Tx9UN3CUtJ6kzx976vvdnUKzwa0ld17/Yr0TpeutdDxoD3tsz
	 u+e74Z1aSHQ/YocmZNo416x/khlVdNdsy4iK5uKuWjOa2xoiNP6V70AlHCOPf0xWiKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzO20HAW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF40606A33F
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzO20HAW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4FE1F000C4;
	Sat, 14 Nov 2026 01:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794618234;
	bh=3beF5xCwefki1pNo7L6accw5Q63lKxsdlp33ixj6N0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CzO20HAW1vq34dzNHyBEYMMTB8irMGDIRNQW0Niq+/tXAtxZQy26IRJ3ZmKe1LBu4
	 ficWK/mewlKQZ6kN1VHdvYiKGCAscWavZe2x3W4hHQbKmGXULuuErhWYMZHmsWow7w
	 9GGx6BDdedAPdNQofI7gbRlblHBDAIhz+7Pd5o9SaMoLOBFmwGYs4jISvIm0rnxKfr
	 3Zx3Yv8TfiAB2lurh50yLp32Xu0roY56vOQy/BJT/+OLkBeWZuPMiOArW72DoSrYgu
	 Q0P5L3uFxiZ5xbpiwL/QVb0ZYYKFA0OPQWFA0E2o/nqHmjGu4FeYfhm+bfAbw40vUB
	 ncbGHJg+4jI+g==
Message-ID: <sashiko-outbox-213976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 1/3] PCI: rockchip-host: Skip downstream config
 access while link is down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113-rfc-b4-v2-1-d6b14f95c1d6@boondocker.io>
References: <20261113-rfc-b4-v2-0-d6b14f95c1d6@boondocker.io>
 <20261113-rfc-b4-v2-1-d6b14f95c1d6@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:03:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: rockchip-host: missing Fixes trailer for link-down config
  access fix
--

commit 776ef94e954858f6a44d96ce2b3db1d4c94ca081
Author: Matt Thompson <matt@boondocker.io>

> PCI: rockchip-host: Skip downstream config access while link is down
>
> On a RockPro64, a PCI bus rescan with the downstream FPGA unavailable
> faulted in rockchip_pcie_rd_conf() during a vendor ID read. The rescan
> task exited with interrupts disabled and the watchdog reported a lockup.
>
> Check the controller's link-up and link-training status before issuing
> downstream config requests. Return PCIBIOS_DEVICE_NOT_FOUND while the
> link is unavailable. Root port config access still uses the local
> controller registers.
>
> This check cannot prevent the link from dropping during the transaction.
>
> Signed-off-by: Matt Thompson <matt@boondocker.io>

[Severity: Low]
This fixes a kernel fault when rockchip_pcie_rd_other_conf() or
rockchip_pcie_wr_other_conf() issues a downstream config access while the
link is down.  Should this include:

  Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support=
")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-rfc-b4-v2-=
0-d6b14f95c1d6@boondocker.io?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381E4AB3B8
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573905; cv=none; b=l9ZNzGPKcINLyExJoeot3jXRpGv4iByXKf+CtxkKfNcy6vvHkWDVrbezRjZq5Drs9t4Z1tJI+XmEA8NN02nEnCPoBHoTNhWiDdPOP1jJ8ChAFKpdxv04+FRdlYE9csy/gFQapyvmV5b7Pj+yG09hSllJDjybrJr54O7chHloodk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573905; c=relaxed/simple;
	bh=0VKIpwuQ3AwL+JjrP4+jxN6vHpcGkh6g/hy9NL+yw8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VQ7hsDcxf2Vp2D8biIsZhW2sOzfX6vMzxq8ltbEEOxWRRrcEOtRF+AhFvQCimd1J7zNba7wYsEToTwhneKIA1hO4LAILD3yK2uSJ0m3/eRsXPNjonbXh/zuKRatu05/RzVeisMd2bv3CCwC18OCtWHrg33kR1drtylNPeXlYKow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyc8dCCj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyc8dCCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E31B1F000FF;
	Wed, 16 Sep 2026 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573903;
	bh=b4FyhyhfUaP4sm+2kO3ESyfPhYqENbC0gRUrFsvBwDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cyc8dCCjdSa7wYQIO9oGvuHuzVkvuIFljExONEsG5S7HHwgMh/Gjafi0EjiGDe627
	 63eAvnd/D0j67wKhf9Y+PbTSRa9qetnGH6W1bFR+XiH5+tZYiC/BVuJGODT/9Ek3Ke
	 8F37pQO5bLVIzEom9ps9rbcmJDoQGQrINpNxmMG+WBR0J1RdkjSObPVgVKVjTdZIxc
	 MU/vT3PTeHZxbBEu/H27wUAklNu8GnlL1QOp309SQLL8JPrCnaeQP9UGqprumaRYs8
	 dlFizNV39CVljBRNmeDEc3j7Vmh+PAHsZOK+QCLqtWKq4yeX8GKdZyaC4TSmcYoMNb
	 d+SuU2nQcjqEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] PCI: Configure Root Port MPS during host probing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org, linux-pci@vger.kernel.org
In-Reply-To: <20260916153907.60344-3-18255117159@163.com>
References: <20260916153907.60344-1-18255117159@163.com>
 <20260916153907.60344-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:51:42 +0000
Message-Id: <20260916155143.2E31B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: dangerous dynamic MPS reduction under PCIE_BUS_DEFAULT
--

commit 32945143b32b8b42f1dd3e1f419414a5bf8f9acf
Author: Hans Zhang <18255117159@163.com>

PCI: Configure Root Port MPS during host probing

This commit updates the PCIe initialization logic to set a Root Port's Maxi=
mum
Payload Size (MPS) to its maximum supported value during host controller
probing. It does this as long as the MPS strategy is not PCIE_BUS_TUNE_OFF =
or
PCIE_BUS_PEER2PEER, meaning it applies under the default PCIE_BUS_DEFAULT
strategy.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 232bce2819f06..08af75aa7366b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2248,6 +2248,21 @@ static void pci_configure_mps(struct pci_dev *dev)
>  		return;
>  	}
> =20
> +	/*
> +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all) or
> +	 * PCIE_BUS_PEER2PEER (use minimum MPS for peer-to-peer), set Root Port=
s'
> +	 * MPS to their maximum supported value. Depending on the MPS strategy
> +	 * and MPSS of downstream devices, a Root Port's MPS may be reduced
> +	 * later during device enumeration.
> +	 */
> +	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT &&
> +	    pcie_bus_config !=3D PCIE_BUS_TUNE_OFF &&
> +	    pcie_bus_config !=3D PCIE_BUS_PEER2PEER) {
> +		rc =3D pcie_set_mps(dev, 128 << dev->pcie_mpss);

[Severity: High]
Does this code introduce a regression where active downstream topologies are
exposed to dangerous dynamic MPS reductions under the default PCIE_BUS_DEFA=
ULT
strategy?

By forcing the Root Port MPS to its maximum supported value here, it overri=
des
safe firmware settings. If a device with a smaller MPSS is subsequently
enumerated or hotplugged, pci_configure_mps() will detect that the downstre=
am
MPSS is smaller than the Root Port's MPS, triggering pcie_reduce_mps() on t=
he
entire hierarchy.

Because pcie_reduce_mps() modifies the Root Port first and sequentially wal=
ks
downstream without quiescing active devices, this creates a dangerous windo=
w.

If an existing downstream device (such as an active NIC or early
firmware-driven display controller) is actively performing DMA, could it
transmit a payload exceeding the newly reduced MPS of the Root Port,
potentially leading to Malformed TLP Fatal Errors and a system crash?

> +		if (rc)
> +			dev_warn(&dev->dev, "failed to set root port MPS\n");
> +	}
> +
>  	if (!bridge || !pci_is_pcie(bridge))
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916153907.6034=
4-1-18255117159@163.com?part=3D2

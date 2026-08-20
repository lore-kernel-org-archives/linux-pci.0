Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674C339375
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199017; cv=none; b=fNdCDl/Qb/qyGT6++Zo/IIxoI5tdiU0uWxviYaqkC8TS/DVCatU4vuvMUq86AWYwN9oFnHk6KJp0BCZikShMuKJibWmyEpzMml1SNNHgMCo0gBZ0oGk6AQ1AUAShNCS+HGSXTGOTNKB4bhAw73/r+Xnog4CvY4Ed6DzhUF6e3yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199017; c=relaxed/simple;
	bh=KgRtSJB9AnNnETMQA3nwqQ2SUEp8NOJccvkccV6A+/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EAbCTXGSGvrk3yxdH95KNc8zi9N4a6EpWY7r3/hpa5oXQPpqarPs3Z/XUdtgKpvn6nj/aa6qlirmzIjCzqYpSCjuVQka227ZxngUbEPafwal8FRkW8MOP0XKTio6mD+85jrP4lwN1jSWtde7CvZQsYnx2DDsHIIVw7EjSX1ponM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4qPuhic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4qPuhic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DEE1F000E9;
	Thu, 20 Aug 2026 04:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199015;
	bh=rQpvpmabBiEIz3CIauapWkMgJQTN4vUK6ABp8Gi42pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G4qPuhicmkAG0nLOvPVBbfes/j1LCoGBkLOOoQaV5D6d5GC90y2eM6esQsfyoeFvq
	 aAuKkSdXCyuZcss3anEuFJZlZYI4lZ4/FEAE4st9nbyFLa0RkJDQ0sNOnjCJCsTI8x
	 iOIi4nnD3QeXWNscCDHLJ840BPXKlFtTnVyAe03prfKcnuesGmz9egrpbiWgIsoxoa
	 Hc85d/F70HSr53cACMxE0szOCp+cGUDXl2SS6ceQbjUqSlNlGBl0hPYUEuFu/Y6YYb
	 2CYofJq6OxoEbyDvYb0ag86KN51pIm8t4olIu4YjdXolsizv80Pwc7V7xGRBkVpAlo
	 WqXX8py/qwtvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dwc: rcar-gen4: Use .post_deinit to handle
 dw_pcie_ep_init() failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260820035944.163472-2-marek.vasut+renesas@mailbox.org>
References: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
 <20260820035944.163472-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 04:10:15 +0000
Message-Id: <20260820041015.90DEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing early return in dw_pcie_ep_init_registers() error path cau=
ses EPC to be incorrectly notified as ready.
--

--- Patch [2]: [PATCH v2 2/2] PCI: dwc: rcar-gen4: Use .post_deinit to hand=
le dw_pcie_ep_init() failures ---
commit 6071cb241e93cb3a6592fddfd5caeb02f9e49fac
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: dwc: rcar-gen4: Use .post_deinit to handle dw_pcie_ep_init() failures

Implement the .post_deinit() callback in R-Car Gen4 to cleanly stop clocks
and assert resets if endpoint initialization fails. This prevents duplicate
cleanup attempts by removing explicit deinit calls from the error paths.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -570,16 +576,13 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen=
4_pcie *rcar)
>  	ep->ops =3D &pcie_ep_ops;
> =20
>  	ret =3D dw_pcie_ep_init(ep);
> -	if (ret) {
> -		rcar_gen4_pcie_ep_deinit(rcar);
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	ret =3D dw_pcie_ep_init_registers(ep);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
>  		dw_pcie_ep_deinit(ep);
> -		rcar_gen4_pcie_ep_deinit(rcar);
>  	}

[Severity: High]
This is a pre-existing issue, but does this error path fall through and
incorrectly notify the EPC framework?

If dw_pcie_ep_init_registers() fails in rcar_gen4_add_dw_pcie_ep(), the
code de-initializes the endpoint via dw_pcie_ep_deinit(), but seems to miss
a return statement. It will unconditionally fall through and call
pci_epc_init_notify(ep->epc).

Could this cause bound Endpoint Function (EPF) drivers to receive an
initialization complete notification on a disabled controller, potentially
leading to an asynchronous external abort (SError) or kernel panic when they
attempt memory mapping and register accesses?

> =20
>  	pci_epc_init_notify(ep->epc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820035944.1634=
72-1-marek.vasut+renesas@mailbox.org?part=3D2

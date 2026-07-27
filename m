Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618393F58D4
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147353; cv=none; b=okfqinc3bguG8/5F7tZHNX0WtSy+bwuFzsal/MPU5LO/dvhuCY1vDiIx4s487QFiIDax3PiwYSyjG8Uq4WXzfpdvtpbceb1p1VXDmMU3q4nr1qvIt9GLSVyNYe5EKFuoOAoSDE71k4t4b0DwW4pu8baC7Lc5h6WaalJBQOVPpjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147353; c=relaxed/simple;
	bh=FPMeJ1a5WJ4BSeAqhaJWNzqg2Le2xYdmMgPykz06R5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=quf0S4+EfWQZQmRn20NrKQz9Kw3KDtkOlvc1sPDemeO2goCmhXLIICiKO3eb6Ob7N+QvnUofM32SUbJVOrTT+NfgHTf0YYcF8ybVHw1MBCM8r9gxWI/8SxGm1FPVOpTFGderXv8uzZbgSXTKKzxktYO8TlZFaTWp6sL4jeZButY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVhtJnr2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVhtJnr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4181F000E9;
	Mon, 27 Jul 2026 10:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147352;
	bh=fCfSmrVF0OoIi/ETvFPiah53au9UpK5BhJ1iHRBLAFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OVhtJnr2aBwVWE12be/VliA0Fh/ykO+BotVDA1VeSmzfnTVqlQDwqV+A0Ir7GAjLN
	 +z92B9ltt5xBtxFb7sNbo5lsGJFgY8SMr2MaZzgRZSxX2XmdQ2WupJgJm+CXBpiMm0
	 UNnTEzkKqm/ZZ4OlGHXQDoK9mYd8rZSp0EHvef0SSjDhIUEXnesRPnVCiLUsbWCBDi
	 7WEs7yGeOVmOkxavSfk8tn3c2+070aZstABZx2y4Nf94NODNBhO0ZzT/qW8/YMGPFG
	 0Q90JG9WWuDXlXirR54uzDCVK91Y/ddUhAm08mw3wkx+5arrl9HYCQI69RX2AvL7Pe
	 OVBJz/aMRPjUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] PCI: rzg3s: Disable refclk on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260727095843.116950-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260727095843.116950-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:15:50 +0000
Message-Id: <20260727101551.5B4181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing teardown of chained IRQ handlers for INTx on probe error p=
aths leads to Use-After-Free.
--

--- Patch [1]: [PATCH v2 1/3] PCI: rzg3s: Disable refclk on probe failure -=
--
commit ff6eba030bfffe106a9c1c6eaf5347fb573ec30c
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

PCI: rzg3s: Disable refclk on probe failure

This commit balances clk_prepare_enable() by calling clk_disable_unprepare()
in the probe cleanup path, ensuring the reference clock is properly disabled
when pci_host_probe() or other subsequent steps fail.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index a1a78bdb7af11..01488660ab081 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1897,6 +1897,7 @@ static int rzg3s_pcie_probe(struct platform_device =
*pdev)
>  	return 0;
> =20
>  host_probe_teardown:
> +	clk_disable_unprepare(host->port.refclk);
>  	rzg3s_pcie_teardown_irqdomain(host);

[Severity: High]
This isn't a bug introduced by this patch, but I wanted to ask about this
teardown path.

rzg3s_pcie_teardown_irqdomain() removes the IRQ domain but fails to unset t=
he
chained handlers via irq_set_chained_handler_and_data(..., NULL, NULL).

If rzg3s_pcie_init_irqdomain() successfully sets the chained handlers using
the dynamically allocated host structure:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_init_irqdomain() {
        ...
        irq_set_chained_handler_and_data(irq,
                                         rzg3s_pcie_intx_irq_handler,
                                         host);
        ...
}

and a subsequent probe step fails, the devm framework will free the host
structure.

If an INTx platform interrupt triggers afterwards, will the handler
dereference the freed host pointer and cause a use-after-free?

>  	host->data->config_deinit(host);
>  rpm_put:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095843.1169=
50-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1

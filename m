Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CA1248896
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351979; cv=none; b=Ch4IDqWshGODCTmeqaSl5flYtfzzxy51O7m4ezefem5FMFgjB0rz1dTk/izQBbEkgNrYHyZQbGQVO53RBXGy2uQml5xQyaclAM0gC5ZJPX9j7cpo20YOvoqDnYBW0KBipx91t+RamELoR2a2XM4gPvga5MUy+U5P0sb9RSHB8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351979; c=relaxed/simple;
	bh=OV7aGCjBkF4RF6gyUnQieG7jdwJk8xnVog22PSrfHQs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=c0/OwfOHFEu3c6s6ZOJj0ne+3itoE6PiWuQEBHSDzZf8wdi92yioKiT2m7O2elm8d37eHhOYCTxgA/t6U9WSKGCD9XkHnW+kAm2wPfxSQpRzBsDXguN925FSaIWZm49XOCJh5tjXQFOGw9m/cWJ4a/kmMsSCikbpanzxHnkqahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMzwl5cL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMzwl5cL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E951F0089B;
	Wed,  7 Oct 2026 05:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351978;
	bh=/VMBnxVdgNZxaxatCPGe4g9nVPf5kg18OOyLaaMQovM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dMzwl5cLOxolUhUatFmXaxsjMh0+QAObQC0BJcVci8/vnFiOu2998i6a6NL5M+UUJ
	 m+bioPHn9U0Qm+mpJ4Ny7YI2Qxt6N++xUyWjogmukKKAWKu3bMlPp8gfNHq0PFtt3f
	 IPydkv740MicWVZATMdgACcMTvtwYPIHDm7HnMRnllCNCI88/+MY54ka69meUS8iuR
	 bPaQ7adEJOOUw3naIMTmyyS2se66URJEasGWr72xv8NI4TypTrVJqvD1shYQtPyGSW
	 IxOZGNbwlRarfwObm+M2TkigUt/2rWhanL07IYN5CMmXkd/ArOvdlLnMQz88dwY/RD
	 FkFgBbUFhlF0w==
Message-ID: <sashiko-outbox-162647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] PCI: rzg3s-host: Drop nop instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261007053645.1391545-4-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
 <20261007053645.1391545-4-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:46:17 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: rzg3s: dropped LNKCTL2 write leaves TLS out of sync and bre=
aks retraining
--

commit 82580733205489082c60a7965e3e79b44492b4e4
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

PCI: rzg3s-host: Drop nop instructions

On the RZ/G3S PCIe IP variant, access to the PCIe Type 1 registers requires
setting the PCI_PERM.CFG_HWINIT_EN bit. Since this bit is not set on the
code paths where rzg3s_pcie_set_max_link_speed() is called, the writes to
PCI_EXP_LNKCTL2.TLS are nops and are dropped by this commit.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 0ef49bb5ab1aa..362aa923978f7 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1144,11 +1144,6 @@ static int rzg3s_pcie_set_max_link_speed(struct rz=
g3s_pcie_host *host)
>  	    remote_supported_link_speeds !=3D max_supported_link_speeds)
>  		return 0;
> =20
> -	/* Set target Link speed */
> -	rzg3s_pcie_update_bits(host->pcie, pcie_cap + PCI_EXP_LNKCTL2,
> -			       PCI_EXP_LNKCTL2_TLS,
> -			       FIELD_PREP(PCI_EXP_LNKCTL2_TLS, link_speed));
> -

[Severity: Medium]
Does dropping this LNKCTL2 update leave the standard capability register out
of sync with the hardware link state configured via RZG3S_PCI_PCCTRL2?

If LNKCTL2 is not updated, lspci and generic bandwidth control logic might
read incorrect values.

Furthermore, if LNKCTL2 and potentially other standard capability registers
are locked behind CFG_HWINIT_EN, does this mean that standard PCI core
functions (like pcie_set_target_speed() or ASPM configuration) will silently
fail when the PCI core attempts to write to the Root Port's LNKCTL2 via
pci_generic_config_write?

drivers/pci/controller/pcie-rzg3s-host.c:
static struct pci_ops rzg3s_pcie_root_ops =3D {
	.read		=3D pci_generic_config_read,
	.write		=3D pci_generic_config_write,
	.map_bus	=3D rzg3s_pcie_root_map_bus,
};

Should the driver temporarily assert CFG_HWINIT_EN to perform this update a=
nd
provide a custom config write wrapper instead of dropping the write entirel=
y?

>  	/* Request link speed change */
>  	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PCCTRL2,
>  			       RZG3S_PCI_PCCTRL2_LS_CHG_REQ |

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007053645.1391=
545-1-claudiu.beznea@kernel.org?part=3D3

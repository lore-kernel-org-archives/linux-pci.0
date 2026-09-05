Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A758472;
	Sat,  5 Sep 2026 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644337; cv=none; b=RgLeWCfXkip1DA1Jia3QG20A96yJ2iUYcchIxN3XG4y3+6YQJBD80LW6ih4sFReUDvJdySO6PLfmwPQoBlrLqajCbHeH+278OTmFvP/6UBG6JtFzx7bEvFbkyzbTOlu+WQ9tjrU8F7zBtLNs7z6bSChFmWLCJwLfTPqNlZGK6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644337; c=relaxed/simple;
	bh=VXv+ZMOtn1yyZ/jtX1iu33GKGSbRisHHCpHGvsT0baQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FDv4tsMyWdZIbBE/XKcVA5o6TY0NCF6N14LEQSjjnzEA1u1bjeqRPcD1A6rFcWt9jfwVq3TElU52Bu912G8S7Sz9g/wVKxHXM2+AkbkCDuIT/Xl55F5eSU6Sbo5wE2bpGr/9EFOun+5te0+npvdLlhn5777Js2tSALgwxNaVdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lACNtZvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lACNtZvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6671F00A3D;
	Sat,  5 Sep 2026 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644336;
	bh=c5bRq7gK9VMV/GJ2cBcNgJbjzfyx6bAKsR5eW5cINA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lACNtZvg/YkdP877tTzjaH/bzqwAd6gt7+12h/7gxBiosJvS/RReko+1Da+0+M/lH
	 QqOL1NPBcEbIovDuYjP+zVH7mAxhvmAUmZkhsxQP4uPt2qwpB2rVpuMHeXBHT3hwDx
	 pCIENE6kxwrz6xe4XjKiPbz3vaQ9YAU1HzM3/Vd8TVxCcK48ZLvJP/klIrvYSWdvnu
	 tTXUF73VE8ftb/t6xoPH0wjJDgX7uq4e6Vol4XdvphlWV6MCPpiAHo4UvV2j4mO626
	 r8TIdZpvWfvqId1Fqo2Sic57nlveMsfv4BiCLujV7uhRxRaEeqvPsT1MSfBZljeiaw
	 xal+MyXhfUeew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] PCI: dwc: rcar-gen4: Handle PERST via reset
 subsystem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260905212649.360498-6-marek.vasut+renesas@mailbox.org>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
 <20260905212649.360498-6-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 21:38:55 +0000
Message-Id: <20260905213855.8D6671F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling pci_epc_init_notify() and returning an error after deiniti=
alizing endpoint resources in rcar_gen4_add_dw_pcie_ep().
- [Medium] Missing of_node_put() for msi_node obtained from of_msi_xlate() =
in rcar_gen4_pcie_host_msi_addr().
--

commit d2f3f23cb3b48c3f0a77ad5561fa549d03ac01cf
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: dwc: rcar-gen4: Handle PERST via reset subsystem

This patch supports handling the PERST signal via both GPIO and the reset
subsystem. This change prepares the driver for R-Car Gen5 support, where
PERST might only be accessible via an SCMI reset.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index c768a9c7b3b76..89472a4becc46 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -494,6 +510,22 @@ static int rcar_gen4_pcie_enable_device(struct pci_h=
ost_bridge *bridge,
>  	return 0;
>  }
> =20

[Severity: Medium]
This is a pre-existing issue, but does rcar_gen4_pcie_host_msi_addr()
leak the msi_node obtained from of_msi_xlate() on successful return?

drivers/pci/controller/dwc/pcie-rcar-gen4.c:rcar_gen4_pcie_host_msi_addr() {
    ...
	of_msi_xlate(dev, &msi_node, 0);
	if (!msi_node)
		return -ENODEV;
    ...
	*msi_addr =3D addr;
	return 0;
}

It appears the reference count of msi_node is never decremented on this ret=
urn
path. Should we call of_node_put(msi_node) before returning?

[ ... ]

> @@ -747,6 +782,7 @@ static void rcar_gen4_pcie_remove(struct platform_dev=
ice *pdev)
> =20
>  	rcar_gen4_remove_dw_pcie(rcar);
>  	rcar_gen4_pcie_unprepare(rcar);
> +	reset_control_put(rcar->perst);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can rcar_gen4_add_dw_pcie_ep=
()
trigger an initialization notification on a deinitialized endpoint if
dw_pcie_ep_init_registers() fails?

drivers/pci/controller/dwc/pcie-rcar-gen4.c:rcar_gen4_add_dw_pcie_ep() {
    ...
	ret =3D dw_pcie_ep_init_registers(ep);
	if (ret) {
		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
		dw_pcie_ep_deinit(ep);
	}

	pci_epc_init_notify(ep->epc);

	return ret;
}

Should there be a return statement inside the error handling block for
dw_pcie_ep_init_registers() to avoid calling pci_epc_init_notify()
on a deinitialized EPC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905212649.3604=
98-1-marek.vasut+renesas@mailbox.org?part=3D5

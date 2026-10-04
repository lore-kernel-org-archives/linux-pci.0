Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017D3B47FF;
	Sun,  4 Oct 2026 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791077495; cv=none; b=ZFtBvQuFDNrjVaogsxc5rOBZ01vzqP9jlSb4nxSlr9ECRJoLRgtyRS8Lwf8usKZH3zufVDf3rQM91YVwYLpTeg5lyZSZdf02bu+RN2u06UTXo0JlxgOo1eW8zFWvBhDz+SLjFOxYetU3l/ZFqZJJP/p+dR3UtDHlAO9kbo14h4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791077495; c=relaxed/simple;
	bh=GAu/qkk4NMWCfzhG7YrjTLVvU8pmQ9+5juGI08BfvDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=elbUKcpbTmEwKT9pQgmFJIDDttsfdoo3l+4utE5rni9FAE3R2izGCZgYKX9Zow9Q+rIisNLsAcY1E78Ey9LnKLkdhRGn8geyV6k5z7qr5UubttpxpxGEAUI9+eMt0X/o79nPA+QjlLsGTplvqGXI0U7qNCqjXd29G42mhJnnBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBTd3P5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBTd3P5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7D81F0089B;
	Sun,  4 Oct 2026 01:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791077491;
	bh=or2/ek13si0PXt7ia7yLdvnbUtjo7sLI0UTSolZzA/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LBTd3P5axHClh2bNi0k2HPqPO/14Oky/NkTHdamy8go4HPIQFnhHbvmglN3exXkWF
	 dlg2yQR7eywrHWsXJyLju0U8NXrMhVRKAbEDtjIf7LeudfAk0Fke4l760mDIYqrS5/
	 Y2Sz6YjSJu8+2zo0gsrzfobZMIjgb5HB8xPOf3X8wy/0erMUAfD2rA3/jZYBvJXmJW
	 5Ayv0+bgnLfbxuJLQ80+ahPjoYC1DBiGxkoH0z0u2ZBIRWShkj2NBDB5qVOejanQi8
	 TmqPkWnyCVFK2Y0EuBPQNi86zsZGv8iDJOGyw9ZTj0jviMDCqhtDC4f2BTSShLGVoT
	 N4QyCsu4WWrsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI: rcar-gen4: Add missing PM ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261004011851.866833-1-marek.vasut+renesas@mailbox.org>
References: <20261004011851.866833-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 01:31:30 +0000
Message-Id: <20261004013131.0C7D81F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pcie: deadlocks due to ioremap and request_firmware in NOIRQ PM ph=
ase
--

commit e6c055f1eedf6bd5c13e231da24f0c6a76a24ba2
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: rcar-gen4: Add missing PM ops

The R-Car Gen4 PCIe controller needs to gracefully suspend and resume its
link across system suspend/resume cycles to support power domains shutting
down. This patch adds suspend_noirq and resume_noirq PM operations to tear
down the link on suspend and restart it on resume.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index 2e7a8d85c0060..fceecbd16355c 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -1062,6 +1064,26 @@ static int rcar_gen4_pcie_ltssm_control(struct rca=
r_gen4_pcie *rcar, bool enable
>  	return 0;
>  }
> =20
> +static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(dev);
> +
> +	if (rcar->drvdata->mode !=3D DW_PCIE_RC_TYPE)
> +		return 0;
> +
> +	return dw_pcie_suspend_noirq(&rcar->dw);
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this code trigger a deadlock or kernel panic during the NOIRQ PM phase?

Setting pp->use_atu_msg to true causes dw_pcie_suspend_noirq() to eventually
call ioremap():

dw_pcie_suspend_noirq()
  dw_pcie_pme_turn_off()
    ioremap()

Since this runs during the suspend_noirq phase with local interrupts disabl=
ed
and the system frozen, ioremap() allocates memory with GFP_KERNEL and may
sleep, which is strictly prohibited in NOIRQ context.

> +}
> +
> +static int rcar_gen4_pcie_resume_noirq(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(dev);
> +
> +	if (rcar->drvdata->mode !=3D DW_PCIE_RC_TYPE)
> +		return 0;
> +
> +	return dw_pcie_resume_noirq(&rcar->dw);
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Will this result in a sleeping function called from invalid context warning?

During the resume_noirq phase, this calls into the firmware request API:

dw_pcie_resume_noirq()
  dw_pcie_start_link()
    rcar_gen4_pcie_ltssm_control()
      rcar_gen4_pcie_download_phy_firmware()
        request_firmware()

Similar to the suspend path, request_firmware() allocates memory using
GFP_KERNEL and may block. Executing this with interrupts disabled in the
NOIRQ phase is unsafe and can lead to a system panic.

> +}
> +
>  static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004011851.8668=
33-1-marek.vasut+renesas@mailbox.org?part=3D1

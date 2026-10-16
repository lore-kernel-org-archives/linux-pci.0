Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1C4AB1CA;
	Fri, 16 Oct 2026 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170959; cv=none; b=gz5OUqnznKLIcuAjlD/GMA+g4Pz7gRqKmszwERamOJiyqanMPBB0ypul19QOEtc1zQ4tWyKe+2PNKXgh/9JiLrMIns7yTnY1goPFXCCzcVa1MABqa1OjznvD8/v6b0BexxINLm9bqdDSwtz/LgpuMq/fGF9XtAixDlNR83w2XHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170959; c=relaxed/simple;
	bh=BOw5miibhYa6y5iW7K3MQzzhkYfcdzxmYu3wZGKeALU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kluTXF/SOBojNEKH4pCBV4X1cHmkPGw4x5uss8mPKRf/24IVtZXeH5HJFi1l2yRojhPdViOprXeIbSWHesNi4Q6rSO9mIHEKx16p5QzNc8t37fuA61Qsp9tGjtLhFj4z+ITjV0oW/dy31Bc2sSbSU3LPqEgzwFqb4iN3mgAGMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic4+wB9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic4+wB9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBA41F000C6;
	Fri, 16 Oct 2026 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170957;
	bh=1ygOFDw20tv57eftFx/OywoOkXdBvhlYV4RYTr2N/+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Ic4+wB9IWzVX8uH9KV2wLu82B4IwhbxYEnPcaxWIcyQh2pkhBPqZ69OTkqmWkTM9F
	 0+WzsUDQCg+9jRBuBeedECNK3t8qy5h0uA4pxefvIM9DP6gEqBoIXnirzauo9Dn2n/
	 3T2/7xCilcDWTEirxGDDauRN2SeM7g/Kin4DvxWczQhAsO44aptfxTlc18naah0tu9
	 TPTiDN13o/973/Z0HQDNF2qQWdMZ0vkRnPJkkRmDhPcF4MQCmAYuMWu1vWDl3q6aq2
	 /gvinCcOGjREHZE+AKsGe5aeTrxoSh0MgXCOyxY895GXc5bbpZ4puov2EltTTREkT6
	 8uB1aVU3WvLZg==
Date: Fri, 16 Oct 2026 12:15:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Gruhlke <gruhlke@mailbox.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH] PCI: Ignore Immediate Readiness on Samsung 990 EVO Plus
 NVMe
Message-ID: <20261016171556.GA1880496@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016102042.641801-1-gruhlke@mailbox.org>

On Fri, Oct 16, 2026 at 12:20:42PM +0200, Alexander Gruhlke wrote:
> Like the 990 PRO, the Samsung 990 EVO Plus [144d:a80d] advertises
> Immediate Readiness, and VFIO passthrough of it fails since commit
> 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs").
> Using a bus reset instead of FLR works around it, and the latest
> firmware, 2B2QKXG7, is still affected.
> 
> Ignore Immediate Readiness on this device, too.
> 
> Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
> Link: https://bbs.archlinux.org/viewtopic.php?pid=2312085#p2312085
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>

Squashed in, thanks!

> ---
> This adds the 990 EVO Plus to e6111fbf0c ("PCI: Ignore Immediate
> Readiness on Samsung 990 PRO NVMe") in pci/for-linus, and could also
> be folded into it.  I couldn't test it on this drive; the reporter
> confirmed Status 0x0011 and that reset_method=bus fixes it.
> 
>  drivers/pci/quirks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 15f083b6b1..0d8c47a46c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5623,7 +5623,7 @@ static void quirk_no_flr_snet(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLIDRUN, 0x1000, quirk_no_flr_snet);
>  
> -/* Samsung 990 PRO advertises Immediate Readiness, but isn't ready after FLR */
> +/* Some Samsung SSDs advertise Immediate Readiness but aren't ready after FLR */
>  static void quirk_no_imm_ready(struct pci_dev *dev)
>  {
>  	if (!dev->imm_ready)
> @@ -5633,6 +5633,7 @@ static void quirk_no_imm_ready(struct pci_dev *dev)
>  	dev->imm_ready = 0;
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80c, quirk_no_imm_ready);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80d, quirk_no_imm_ready);
>  
>  static void quirk_no_ext_tags(struct pci_dev *pdev)
>  {
> -- 
> 2.56.0
> 

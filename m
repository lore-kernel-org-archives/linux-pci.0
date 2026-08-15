Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F623B6347;
	Sat, 15 Aug 2026 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776846; cv=none; b=Vj/vo8IhXLi5q+WH0JGyiwdznlQy+Fzs7o1/jIqmX3wTQ5vYCT4wduCgEI+xi8u02yoQWB4LHacarj9S+9U2AUg8UqLBr9JLvsucvyBFlr5uWx4rwI/azWXMXWt16eiy8SaLdzecc/9gcspCaZxZwLuIfxeHrzDM7oqzcJpblJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776846; c=relaxed/simple;
	bh=6ekjXufBxgEusOcELDG3gUtE/u23WJYsVq81nN7zk0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK2sMU1fHyhBlWVm7EX2KgHpD5gC8oNp1pW9vsCiePQh0yVvwuJv4gEGFpzkYLeabjAsw07Vq5fk8Y7awqfc2kSblQSOFdo/Ie+cbRAEUx2BJuv45ITsF3FD56pJxeGtC+wvwHdVFrJSTeX9Zp6TPV4KJj8lR7kytEJr3jvBCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 8C720C2D;
	Sat, 15 Aug 2026 08:53:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4494160A8DBC; Sat, 15 Aug 2026 08:53:39 +0200 (CEST)
Date: Sat, 15 Aug 2026 08:53:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	kthota@nvidia.com, mmaddireddy@nvidia.com, kumarahul@nvidia.com,
	sagar.tv@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/5] PCI: Save and restore the Device 3 Control
 register
Message-ID: <aoAM8x1JPzCDTaBf@wunner.de>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
 <20260814201621.2281245-4-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814201621.2281245-4-vidyas@nvidia.com>

On Sat, Aug 15, 2026 at 01:46:19AM +0530, Vidya Sagar wrote:
> +static void pci_restore_dev3_state(struct pci_dev *dev)
[...]
> +	/*
> +	 * DEV3_CTL.14-Bit Tag Requester Enable is only meaningful in flit
> +	 * mode.  On devices that advertise 14-Bit Tag Requester support,
> +	 * sanitize the saved value before writing it back, so that callers
> +	 * that issue further TLPs through this device after restore see a
> +	 * coherent enable state.  Every other bit of DEV3_CTL (DMWr
> +	 * Requester Enable, DMWr Egress Blocking, L0p Enable, Target Link
> +	 * Width and any future addition) is written back unchanged.
> +	 *
> +	 * Only the value written to hardware is adjusted.  The save buffer
> +	 * keeps what was saved, so the decision is taken afresh on every
> +	 * restore and the originally programmed value is not lost.
> +	 */

This is quite verbose, can you condense it a bit?  E.g. it's not
necessary to say that every other bit is written back unchanged.
That's the default.  Just say e.g.:

       /* Clear 14-Bit Tag Requester Enable if link is no longer in Flit Mode */

> +	pci_read_config_dword(dev, pos + PCI_DEV3_CAP, &dev3_cap);
> +	if (dev3_cap & PCI_DEV3_CAP_14BIT_TAG_REQ) {

PCIe r7.0 sec 7.7.10.3 says the bit is "VF RsvdP", so you need
to check !dev->is_virtfn here.

> +		/*
> +		 * Check both LNKSTA2.Flit_Mode (link-level) and
> +		 * DEV3_STA.Segment Captured (end-to-end); both must be
> +		 * active for 14-bit tags.  Refresh bus->flit_mode and
> +		 * dev->fm_enabled in lock-step.
> +		 */

Why do we have to check both?

We usually spell out the register names fully or leave them out.
Using "LNKSTA2.Flit_Mode" and "DEV3_STA.Segment Captured" instead looks
odd to me.

> +		pci_read_config_dword(dev, pos + PCI_DEV3_STA, &dev3_sta);
> +		dev->fm_enabled = !!(dev3_sta & PCI_DEV3_STA_SEGMENT);
> +
> +		pcie_capability_read_word(dev, PCI_EXP_LNKSTA2, &lnksta2);
> +		flit_now = !!(lnksta2 & PCI_EXP_LNKSTA2_FLIT);
> +		if (dev->bus)
> +			dev->bus->flit_mode = flit_now;

When can dev->bus be NULL?

> +
> +		if ((!dev->fm_enabled || !flit_now) &&
> +		    (val & PCI_DEV3_CTL_14BIT_TAG_REQ_EN)) {
> +			val &= ~PCI_DEV3_CTL_14BIT_TAG_REQ_EN;
> +			pci_info(dev, "clearing 14-Bit Tag Requester Enable: flit mode no longer active (LNKSTA2=%#06x, DEV3_STA=%#010x)\n",
> +				 lnksta2, dev3_sta);

pci_dbg() please.

> +	/*
> +	 * Save buffer for DEV3_CTL only.  Every field in DEV3_STA is
> +	 * read-only status reported by hardware, so there is nothing there
> +	 * to restore.
> +	 */

The code comment seems unnecessary because that policy applies
to every other Extended Capability as well.  We only save
mutable registers, that's the default.

Thanks,

Lukas

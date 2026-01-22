Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8FE1C84DC;
	Thu, 22 Jan 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040609; cv=none; b=DGbpnYkonf8mWet/Q0BvYs3CGaUCJmsSnkvnCKWfH0dtpltzR1HpiEDzJO8IQ5yB+6Yl6algx5Dd9HhVtOVsUObwtMO603TkJ0nEtoijhQ/8tn+kHflpqVpRNpg//ltP5AQHZYEwa93alGJ0St4QiVWRwvflmwH++WcmAkzG+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040609; c=relaxed/simple;
	bh=p6jTPltqyi6CO00kOm7xo600HOdPLsIjsOTrNopkzb8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PfnTibUsJGaUxJfJyRYyK4sb/qIp4TzenqLOF/OXyiIQYbsXtjWseOIhy/QcuYhmwMAIB/trPK+r6c+odk883CcR+rO1VwgWN6wsqwUUAhIW4I0rriePBaC4JyETGHEJN0vRiJPGXJtBspsQJfTWYL5ra/J3dmPlDRSW4294zqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvohqRML; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvohqRML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A96C4CEF1;
	Thu, 22 Jan 2026 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769040608;
	bh=p6jTPltqyi6CO00kOm7xo600HOdPLsIjsOTrNopkzb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pvohqRMLri2cZhsUaa/G6ogHe2myRgMt24fzQdWNjMRmBytDDdEMHllPL9QsI/DE3
	 QM1R8lJx48L3hUeR7umc8No5YqxCWzTE6TYezSDiFHFYe37ktsvvQZH+O5xDvpAt3b
	 fkq9WuQbUjOLcCsRH7awGxhZGFYh4HPZuW4HGUnX2ae7EjNYks0mog2jn9WGGtQEb/
	 Tso6nDsa/ugDIB7XCZ0VYuKBIh6lpwc/VMQg/mE111BCWdpDpHUAmOLKj6xMwwj88+
	 Dkak5097AGBPyue/aND1TR0JfuehE8agDpnkMpHFYfCbjTTtqH3/SF5Lsun5ax2LZH
	 h7fTirczJw2xA==
Date: Wed, 21 Jan 2026 18:10:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
	Nathan Rossi <nathan@nathanrossi.com>
Subject: Re: [PATCH] PCI: Add PCI ID 12d8:b404 for Pericom switch ACS quirk
Message-ID: <20260122001006.GA1224778@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119160915.26456-1-nicolas.cavallari@green-communications.fr>

[+cc Nathan, author of acd61ffb2f16 ("PCI: Add ACS quirk for Pericom
PI7C9X2G switches")]

On Mon, Jan 19, 2026 at 05:08:33PM +0100, Nicolas Cavallari wrote:
> 12d8:b404 is apparently another PCI ID for Pericom PI7C9X2G404 (as
> identified by the chip silkscreen and lspci).
> 
> It is also affected by the PI7C9X2G errata (e.g. a network card attached
> to it fails under load when P2P Redirect Request is enabled), so apply
> the same quirk to this PCI ID too.
> 
> PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EV/SV PCIe2 4-Port/4-Lane Packet Switch [12d8:b404] (rev 01)
> 
> Fixes: acd61ffb2f16 ("PCI: Add ACS quirk for Pericom PI7C9X2G switches")
> Closes: https://lore.kernel.org/all/a1d926f0-4cb5-4877-a4df-617902648d80@green-communications.fr/
> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

Applied to pci/virtualization for v6.20, thanks!

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b9c252aa6fe0..c462d0ed3fd6 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6188,6 +6188,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
>  			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
>  			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
> +			 pci_fixup_pericom_acs_store_forward);
>  
>  static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
>  {
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> -- 
> 2.51.0
> 

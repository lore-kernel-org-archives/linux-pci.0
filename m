Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2A3B05AB;
	Fri, 31 Jul 2026 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513781; cv=none; b=brRrqznU/ke4M4CrL0jBfccCwzGrwyfx5hR/Cs6XTSVr3p7OGsF0tV4fE+r6dmMNMC39Sc15hviReFuBZzYrO9FClWXoLJkjz/fNMA0Tlwi38Jg9aa/5UQuuGa3hdFF8bsYG55jFdCvdDNXUJQq4W/B2LPJPMD7xkWRDk2NtcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513781; c=relaxed/simple;
	bh=NgPVAqh+X4SWDRXmLaP48VkiEwYwFxllFUXPgG/iqu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EIasJ9xVA+bJ0lDfnlnDmjFg1E6dkkTyV6Tc6ElqIuthXIrDCRzLhh8bLrh7GgR/2OyO/+icxd7ULTjdtWdG9F/Z2xIbEFh2+AKksgH8lxw9PnSuP5u1R5Z4jtayOts19EHn7NZgQOPH3zEpVxJH46OaECgX20yCOrPEDG0L1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/EpjkAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/EpjkAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CFF1F00AC4;
	Fri, 31 Jul 2026 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513779;
	bh=V0cx84YDl6LOig0HnLnRYdR8vDgzvhQjJIOIpIIfTbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=T/EpjkArdt1UgrmZZjFVnYZknZPxp8v78vrWDVYTN/uHtZ72MakLbuKPkn1azv3kl
	 FaKNPlBsJharLNGbVsO8hm1vaji6oeX03r2KXZCcZtPmdwoQsZiOmka0om6WfUNgRm
	 tkeg48/USHInUNaOpqDlJdUkzVvq50aADNBz++Jcsecaj4SXhqUfZJDJW5MVhNcc6R
	 IALqTbNkKO0M/VE11ldTpe0YLG+gf413/B6dyGukXy+zeSy9x1Fkop1bW11U18b9L8
	 9cLhOXgH+S/PrAGfEVT9iR9seSc7hP5FIxMldcl+gfWPSAZBA2lQhAaC9zLXVmIc9T
	 0KyiTzxyyNIjQ==
Date: Fri, 31 Jul 2026 11:02:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Message-ID: <20260731160258.GA1571469@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731030546.850457-1-hongxing.zhu@oss.nxp.com>

On Fri, Jul 31, 2026 at 11:05:46AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> the default MPLLB_BANDWIDTH value (120). This margin degradation worsens
> across voltage and temperature (VT) variations and different test
> matrices, potentially causing link stability issues.
> 
> Testing with MPLLB_BANDWIDTH value of 140 (0x8c) shows significant
> improvement in bandwidth margins across all VT conditions and test
> scenarios.
> 
> Implement PHY register write helper function and configure:
> - MPLLB_BW_OVRD_IN = 140 (0x8c) for improved bandwidth margin
> - MPLLB_BW_OVRD_EN to enable the override
> 
> This ensures robust PCIe Gen3 performance across all operating
> conditions.

Thanks for including the previous and new MPLLB_BANDWIDTH values.

I'm fine with the patch, but I think "bandwidth marginality" is
awkward wording because "marginality" doesn't seem to be commonly
used in this context.  Maybe something like:

  We observed poor bandwidth margins during ...  The margins worsened
  across ...

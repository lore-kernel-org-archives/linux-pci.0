Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ABD261B80;
	Mon,  9 Feb 2026 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659470; cv=none; b=iy2Jnj4r66cesrrBoW9Yw25YLtow/QPww4+0aUsrfWfShmOYSX1fg7bkghIH4Ull7HHuC/fq9lqrJ6Spa0qXdQJyXpNK9rwZXDTkpdjUHnKsutD2fS5WA/daal01L+8nVASxWsvOef5z/5KJVaGb3bGvkJmL+dxkOFwLXjXPZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659470; c=relaxed/simple;
	bh=D9qye8Uxudw7pba8RqAtU3SE9Z3U0zqyBMjr9Rjbb3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5/9ID+xSubDhh8sQ40VrJmkiwCoJwPIyjJnBI4A6WbvzfI9qE9zphWx/qjgCnnvgFdUngxrZrM6glaYzXTm3O9mGO6CqTKTh6N8te8fMmGxfiT849WqhwNCVP+Gn3WkO+j/DABQSwhhm11VXPNCkdTkQh6fr1Vx0QTG1ZgDaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2m7mGrT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2m7mGrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA89C16AAE;
	Mon,  9 Feb 2026 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770659469;
	bh=D9qye8Uxudw7pba8RqAtU3SE9Z3U0zqyBMjr9Rjbb3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2m7mGrT2s/v2PNVkLTc/ISc/mS6/2Hhzv0zKgs/tRU2e11MLHHGO668aGke642TV
	 SogB9zhYGTiRo/lAxsYF2jej8BVxCLjrFsOTFwuyHwhdbs2i1l0uAEzBZKM3mM2w18
	 hzpfFaD0IgGO25BjDJt690y9BTJT3aURMN3udd/FOV34iZZge4MzEZ0cDBt1fgOh+i
	 Bql5IH3oQJKFF/zQBrhh8muw4+ZetYG9yB8xHdR7CNvLR8DU9dVxi9Kd3NvK2G2uxd
	 UHKIM2prdg/1g15fWKrQXsMCds4jdID2J/KChGfhdZA/mNtB4jmEIp2d0TlBi2Eh86
	 hKw/iPycAey6A==
Date: Mon, 9 Feb 2026 11:51:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: john.madieu@gmail.com, linux-pci@vger.kernel.org,
	claudiu.beznea.uj@bp.renesas.com, mani@kernel.org,
	bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, linux-clk@vger.kernel.org,
	lpieralisi@kernel.org, biju.das.jz@bp.renesas.com,
	kwilczynski@kernel.org, geert+renesas@glider.be
Subject: Re: [PATCH v4 06/15] dt-bindings: PCI: renesas,r9a08g045s33-pcie:
 Document RZ/G3E SoC
Message-ID: <177065946815.1483460.5325418308441015245.robh@kernel.org>
References: <20260129214130.16067-1-john.madieu.xa@bp.renesas.com>
 <20260129214130.16067-7-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129214130.16067-7-john.madieu.xa@bp.renesas.com>


On Thu, 29 Jan 2026 22:41:20 +0100, John Madieu wrote:
> Extend the existing device tree bindings for Renesas RZ/G3S PCIe
> controller to include support for the RZ/G3E (renesas,r9a09g047e57-pcie) PCIe
> controller. The RZ/G3E PCIe controller is similar to RZ/G3S but has some key
> differences:
> 
>  - Uses a different device ID
>  - Supports PCIe Gen3 (8.0 GT/s) link speeds
>  - Uses a different clock naming (clkpmu vs clkl1pm)
>  - Has a different set of interrupts, interrupt ordering, and reset signals
> 
> Add device tree bindings for renesas,r9a09g047e57-pcie compatible IPs.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> 
> Changes:
> 
> v4: Fixed clock name constraint using enum
> 
> v3:
>  - Moved interrupt/clock description in distinct PATCH
>  - Fixed clock name constraints
>  - Updated clock descriptions
> 
> v2: Reuse G3S names
> 
>  .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 73 +++++++++++++++++--
>  1 file changed, 67 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


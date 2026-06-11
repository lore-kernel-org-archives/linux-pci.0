Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420E4ADDB9;
	Thu, 11 Jun 2026 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198588; cv=none; b=rAF4/9rueOrZsixeXGgMf+H19RENLk1+z/zjihv6IbslvVNUZ3qqEVoDDVyViu7p5CPLXO33G6z62fyZNAlqxwl5pAHM1r5LSkycKxQ88HuSFC/IpB9qBkTLKVUzR3wmjbPDYtevj09/MRTqHJCE976PDjzOX5ZbdEYa19gZX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198588; c=relaxed/simple;
	bh=PQF24pANIIlUdea43pZeEcaW5G2dK6cqwZGax+BQTTc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dyvi4NDBZN0KU71mush/GVPFg3Ve7RlYyuf8iwOV39RnaeldNTXo3ouHi48bl3GEhSkdcaS9HJpla4ZO7qhaLR97yNLUXHHWt1iWwqoyI7FJq1HQF09pSGTV7wUci4BaZ2g4mRpDFCP2yxEpqXTAqh5t24QPXlbQY1yKA3QwEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQz/slhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQz/slhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2CD1F00893;
	Thu, 11 Jun 2026 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198582;
	bh=R0nEivy3sDm9vo6SdLB3m04pjfu3eTJ/XomD+o+aDHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=GQz/slhyHKMpP/3BqvntudLfgVQxvbXwieD2tpp9wkrqQBaIHcYrufVEb2jempOaY
	 k7cYl+xw7gS1E3Q3mJrpwxs5H9Cr3rfWx1MFJspx0cgJOtQkwSbIhX6o+EsEJu+fKR
	 LD/DPoeF0/1CZlYBZL3kFnji7Ebbtn9dVHY/hVNmzxz8SNcFbFQHCJjLOCzreYBpYC
	 j+0zfZus+rbey2lOdVSgj9DjKBcQILe6+jh+8ueW93aYvWhwvoc+IHPhKFUijbGgJ2
	 HFCl66KlMqjc0DdiM1H+SRsnurUz6x4wVH5v46cUG/dw0PVg8646/Lf2IZihrDqQ5X
	 qHF0GmluHpwIw==
Date: Thu, 11 Jun 2026 12:23:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	kwilczynski@kernel.org, mani@kernel.org,
	ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v7 1/3] PCI: Add public pcie_valid_speed() for shared
 validation
Message-ID: <20260611172301.GA490724@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407130450.1489318-2-18255117159@163.com>

On Tue, Apr 07, 2026 at 09:04:48PM +0800, Hans Zhang wrote:
> Extract the PCIe speed validation logic from bwctrl.c's static
> pcie_valid_speed() into a public static inline function in pci.h.
> 
> This allows consistent speed range checks (2.5GT/s to 64.0GT/s) across
> multiple drivers and functions, avoiding duplicate code and ensuring
> validation consistency as per PCIe specifications.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Any objection, Ilpo?

It looks like 1/3 and 2/3 are pure moves, and the interesting part is
the use in dwc, which I'd like to be reviewed and applied by Mani.

> ---
>  drivers/pci/pci.h         | 5 +++++
>  drivers/pci/pcie/bwctrl.c | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4a14f88e543a..f0a082bfd6f1 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -606,6 +606,11 @@ void pci_bus_put(struct pci_bus *bus);
>  	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
>  	 0)
>  
> +static inline bool pcie_valid_speed(enum pci_bus_speed speed)
> +{
> +	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
> +}
> +
>  static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
>  {
>  	switch (speed) {
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index c4c8d260bf96..ea82e326f164 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -48,11 +48,6 @@ struct pcie_bwctrl_data {
>  /* Prevent port removal during Link Speed changes. */
>  static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
>  
> -static bool pcie_valid_speed(enum pci_bus_speed speed)
> -{
> -	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
> -}
> -
>  static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
>  {
>  	static const u8 speed_conv[] = {
> -- 
> 2.34.1
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F1E4BC005;
	Thu, 11 Jun 2026 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198594; cv=none; b=da22iqXHK3rIzU8Loq5InG+ktTek2R+vCDkRjXnaOiO7/XZhwv7cLvVPV181WmaQl+KOk3MMHPagU0se7+C6cJbioip12w/HddwTpS1twiFbv7zPFnKHXS43hCSo708yG8i6SMzcTeuMpFC+3o8QUVioZARMjniRVUuKw+fu1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198594; c=relaxed/simple;
	bh=h5h6m7py3Ra2bdIpVLeMkKVZJ0Tof0q5sGBYkcLHCkw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rk10jAQMxtPwXQB/yI1Uf386L3SjDwSdR2QF8/o8er+W5R6PdgmtiAxaRl4rIBvQEihK0PdAw0YskEmxc4ncEi1jIUf04l8l+eZRCkLIlH9L2/cqokWIrknosy+9GrJPScM6IikBGqJhuR/RyN3jDvaD6AAipeHpw1fnvXvXAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5cK4F8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5cK4F8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174011F00898;
	Thu, 11 Jun 2026 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198588;
	bh=nyfHyL15Z9mN/om2Dga7wLackCgtBFscvDgew8LCDoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=E5cK4F8bdIFJX9fox5NJwKNSMgri6rzSe99b6JAij+aXSWXH7mvoK2mtAWwYM1Lgz
	 dMSv2xqVCKUCcKAYpJG82skoFpooUuU/W8N+R5K2btNZj9lgqrWdxLiXeyAR702lk/
	 MX4baH+BkfU/MNaOzmVvILEQL2dXeCrUmGurqF7pMOLUw5fgK7JXdcQQgHJ67deIY1
	 XHf4V3LMY+mKY3RMvQl8SwEt1Rr1kSM4jGCHyEfbpguOR1U+M9C04I8a0UMZ9NsgOW
	 Co+BTjC0wXBWFqVHbxdzQ8YP/TATs9VKUwNEkeT2mKvEJ5nzXXA1dWjlIzjQa9w9ij
	 IBkJP6LeRozIw==
Date: Thu, 11 Jun 2026 12:23:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	kwilczynski@kernel.org, mani@kernel.org,
	ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v7 2/3] PCI: Move pci_bus_speed2lnkctl2() to public header
Message-ID: <20260611172307.GA491728@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407130450.1489318-3-18255117159@163.com>

On Tue, Apr 07, 2026 at 09:04:49PM +0800, Hans Zhang wrote:
> Move the static array-based pci_bus_speed2lnkctl2() function from
> bwctrl.c to pci.h as a public inline function.
> 
> This provides efficient O(1) speed-to-LNKCTL2 value conversion using
> static array lookup, maintaining optimal performance while enabling
> code reuse by other PCIe drivers.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.h         | 18 ++++++++++++++++++
>  drivers/pci/pcie/bwctrl.c | 17 -----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f0a082bfd6f1..e0c2630e93f2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -2,6 +2,7 @@
>  #ifndef DRIVERS_PCI_H
>  #define DRIVERS_PCI_H
>  
> +#include <asm/bug.h>
>  #include <linux/align.h>
>  #include <linux/bitfield.h>
>  #include <linux/pci.h>
> @@ -611,6 +612,23 @@ static inline bool pcie_valid_speed(enum pci_bus_speed speed)
>  	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>  }
>  
> +static inline u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> +{
> +	static const u8 speed_conv[] = {
> +		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
> +		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
> +		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
> +		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
> +		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
> +		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
> +	};
> +
> +	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
> +		return 0;
> +
> +	return speed_conv[speed];
> +}
> +
>  static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
>  {
>  	switch (speed) {
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index ea82e326f164..d48021bfd844 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -48,23 +48,6 @@ struct pcie_bwctrl_data {
>  /* Prevent port removal during Link Speed changes. */
>  static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
>  
> -static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> -{
> -	static const u8 speed_conv[] = {
> -		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
> -		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
> -		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
> -		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
> -		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
> -		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
> -	};
> -
> -	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
> -		return 0;
> -
> -	return speed_conv[speed];
> -}
> -
>  static inline u16 pcie_supported_speeds2target_speed(u8 supported_speeds)
>  {
>  	return __fls(supported_speeds);
> -- 
> 2.34.1
> 

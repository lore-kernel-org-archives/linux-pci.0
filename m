Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52859483815;
	Fri, 25 Sep 2026 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365332; cv=none; b=M9E64OjkZjTOtaajCEFh+eu0tsFt0FWGJ7Kk6wBGksHUNuL6pRwcPvlsIGTbEOSwbS9Tr9vruD35A/OjaqLEn8iYx/OvgcoudDjhedkK/0aunw2I5wavtBSbdeFmapq7E3w5xDje4lgRp0HlDyLLmi8ohNx2iQWfdJSFhZ2wkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365332; c=relaxed/simple;
	bh=5hp8KrXDqdBntqhblDhTZU7jIodCL3GxH2httSOAw3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NwUd+ZUkEzni15FiS364UFXq+yBI9spDii71NDqJ5Jz5pHxllcKDQp1+a5H201Bn26c3pwbkjujuPdL9Hqgj8/SqUlKdI4yYrAI5BP1ESXoDToWcAzVaZqdJ8MgUF/cs5A6HQxUyLcEF19wm2EALr7aFoE/1DH6hCpUOIhXg3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDDWkQNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDDWkQNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9806A1F000FF;
	Fri, 25 Sep 2026 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790365329;
	bh=dfXt9qaDcC/oPAvJye+3wyvTWiD4tmETUwkn1zkGmw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=YDDWkQNB4BuOPzPzydlyaW7BATamkuHlTAeSRrJa2RK4908o5hlkIBo1l7GCL/F5y
	 GVvv6O5TC503897TpgyT5NtIlcgFwWKqtgOtrSirs86MRjHvMkUYmRZhauTQ4qb/op
	 3XGjf/jg57h2g042vlOSAy8tc3HGscM/qhBVBKV1llBWSj7w9le9MQkStTxuy/vC6K
	 62qS4nrh179L+pD2y/vAKLvlQmHMYkZS98RVa1IVdaM401QmJGTcLxUVgLOM9bR2Ik
	 lJdFhviN9Hfdnd/nYf+bJwIAGeBpcGIc9+uEJEi08H3u7g35UUkr17IR6qW1EzebTH
	 K3P6WmbUOf1EQ==
Date: Fri, 25 Sep 2026 14:42:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	Arthur Husband <artmoty@gmail.com>,
	Roland Waltersson <roland.waltersson@netinsight.net>,
	snoep <snoepke@live.nl>
Subject: Re: [PATCH v2 2/2] Revert "ata: ahci: force 32-bit DMA for JMicron
 JMB582/JMB585"
Message-ID: <20260925194208.GA2072993@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908190600.226485-3-mario.limonciello@amd.com>

[+cc Roland, snoep]

On Tue, Sep 08, 2026 at 02:06:00PM -0500, Mario Limonciello wrote:
> This reverts commit 105c42566a550e2d05fc14f763216a8765ee5d0e.
> 
> The issue is actually a problem with BIOS configuaration of PCIe
> root ports, enabling a feature that causes problems with 64-bit
> DMA.  It is fixed by adjusting the kernel adjusting the
> configuration of those root ports.

I'm a little concerned about doing this revert for v7.3:

  - The AMD issue should affect any SATA controller, but 105c42566a55
    ("ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585") is very
    specific about JMicron JMB582/JMB585.

  - The BIOS configuration change only affects AMD NBIO 7.7 and 7.11
    but the original posting [1] of 105c42566a55 ("ata: ahci: force
    32-bit DMA for JMicron JMB582/JMB585") mentions Raspberry Pi,
    which isn't AMD (the Raspberry Pi mention was removed before
    105c42566a55 was merged).

  - There are reports of problems on Raspberry Pi 5 JMB585 [2], [3]
    that don't seem completely resolved.

  - The revert doesn't seem like it fixes a problem, so I don't know
    that I can justify it as post-rc1 material for v7.3; maybe the ATA
    folks should take it for v7.4?

What if I just merge patch [1/2] ("x86/PCI: Disable enhanced atomics
on AMD NBIO 7.7 and 7.11") for v7.3?  Would that leave anything
broken?

[1] https://lore.kernel.org/all/20260403050225.50186-1-artmoty@gmail.com/t/#u)
[2] https://forum.radxa.com/t/repeated-ext4-metadata-corruption-on-raspberry-pi-5-with-penta-sata-hat-jmb585-despite-healthy-ssds-and-raid1/31393/10
[3] https://forums.raspberrypi.com/viewtopic.php?p=2386959#p2386959

> Cc: Arthur Husband <artmoty@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/ata/ahci.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 9b8c0935001cb..bffe50a109b88 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -68,7 +68,6 @@ enum board_ids {
>  	/* board IDs for specific chipsets in alphabetical order */
>  	board_ahci_al,
>  	board_ahci_avn,
> -	board_ahci_jmb585,
>  	board_ahci_mcp65,
>  	board_ahci_mcp77,
>  	board_ahci_mcp89,
> @@ -213,15 +212,6 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_avn_ops,
>  	},
> -	/* JMicron JMB582/585: 64-bit DMA is broken, force 32-bit */
> -	[board_ahci_jmb585] = {
> -		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR |
> -				 AHCI_HFLAG_32BIT_ONLY),
> -		.flags		= AHCI_FLAG_COMMON,
> -		.pio_mask	= ATA_PIO4,
> -		.udma_mask	= ATA_UDMA6,
> -		.port_ops	= &ahci_ops,
> -	},
>  	[board_ahci_mcp65] = {
>  		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP |
>  				 AHCI_HFLAG_YES_NCQ),
> @@ -954,14 +944,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  		/* Elkhart Lake AHCI */
>  		PCI_VDEVICE(INTEL, 0x4b63),
>  		.driver_data = board_ahci_pcs_quirk,
> -	}, {
> -		/* JMicron JMB582/585: force 32-bit DMA (broken 64-bit implementation) */
> -		PCI_VDEVICE(JMICRON, 0x0582),
> -		.driver_data = board_ahci_jmb585,
> -
> -	}, {
> -		PCI_VDEVICE(JMICRON, 0x0585),
> -		.driver_data = board_ahci_jmb585,
>  	}, {
>  		/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  		PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID),
> -- 
> 2.43.0
> 

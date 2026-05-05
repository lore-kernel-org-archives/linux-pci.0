Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339E48B380
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000870; cv=none; b=o+BtDqbZAHpHww0xmdSbaKZSb1IjJGidvcETeB1JVDAT1IYnXhFeGtp9Y4uQg+uMLI3VF9JCvzvYBbRw7j0jCNdsK6HIJQH+5QDweYCssR4xNrzehrmWHITD6aTC1GkmLSMqKO5pgyRBJMmKW8/0bpoSFvcO0Ei5ZUoBKXUuQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000870; c=relaxed/simple;
	bh=ibHJ3v1wkq18eO2fzTrbgY0pKPDjYzgQkM9MkS8e45A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BNwnVnYJbQ5OhUblFGaugpLjuHGDJNXkVoH3UpAQ+YrdzJoIx+8curSbtV+uMXMBYl1ZG4ESQnXfMjt2XxffAoXYHigrrTCcjxZJRpSj6dNl8SUKp/2MsWpbEhqiaymNCDwt8FzxxkKBA1SOhTkvc22WFwtoUeP8CSLNkf04rpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlXjRW22; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlXjRW22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F8AC2BCB4;
	Tue,  5 May 2026 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778000869;
	bh=ibHJ3v1wkq18eO2fzTrbgY0pKPDjYzgQkM9MkS8e45A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JlXjRW22SpkfixBF/jNLMStZITeFDhvCC8MhFedyn5RiRE1g8fgEZiouh4SWk48Ew
	 OD9ZTM+pqc17JRB0VHO/Y8CpUvwcfpJtWqOV/vmpeib6Q6QJlfgqm6imH1ryPA80LD
	 dj/YTFdgqlyvjvEgRwcBZvWxU/70E26Sf8tGr29tHK0Y1KcZThSGRE0zoZ8pppd4Ao
	 Ew5eYzR8vXsuOYXn+fmM8ItVf/duW54sudmv/2IjLNaW5m4eYbB43sikt1TOV38yXb
	 LX7dQJez8kC/ZrGbi3JybSvHOP3d09UYlllfbtIEkItJ29zW0nOrp36o3c6Z7EO1d6
	 aTGjeU9vflsnQ==
Date: Tue, 5 May 2026 12:07:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Ben Reed <Ben.Reed@microchip.com>
Subject: Re: [PATCH] PCI/switchtec: Add Gen6 Device IDs
Message-ID: <20260505170748.GA739551@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505161633.67454-1-logang@deltatee.com>

On Tue, May 05, 2026 at 10:16:33AM -0600, Logan Gunthorpe wrote:
> From: Ben Reed <Ben.Reed@microchip.com>
> 
> Add device IDs for the next generation of switchtec products.
> 
> No changes to the driver were required with the new version of
> the hardware.
> 
> [logang: rewrote commit message]
> Signed-off-by: Ben Reed <Ben.Reed@microchip.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Applied to pci/switchtec for v7.2, thanks!

> ---
>  drivers/pci/switch/switchtec.c | 16 ++++++++++++++++
>  include/linux/switchtec.h      |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 93ebec94b763..41fc4b512708 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1852,6 +1852,22 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
>  	SWITCHTEC_PCI_DEVICE(0x5552, SWITCHTEC_GEN5),  /* PAXA 52XG5 */
>  	SWITCHTEC_PCI_DEVICE(0x5536, SWITCHTEC_GEN5),  /* PAXA 36XG5 */
>  	SWITCHTEC_PCI_DEVICE(0x5528, SWITCHTEC_GEN5),  /* PAXA 28XG5 */
> +	SWITCHTEC_PCI_DEVICE(0x6048, SWITCHTEC_GEN6),  /* PFXs 48XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6064, SWITCHTEC_GEN6),  /* PFXs 64XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6044, SWITCHTEC_GEN6),  /* PFXs 144XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6060, SWITCHTEC_GEN6),  /* PFXs 160XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6148, SWITCHTEC_GEN6),  /* PSXs 48XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6164, SWITCHTEC_GEN6),  /* PSXs 64XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6144, SWITCHTEC_GEN6),  /* PSXs 144XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6160, SWITCHTEC_GEN6),  /* PSXs 160XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6248, SWITCHTEC_GEN6),  /* PFX 48XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6264, SWITCHTEC_GEN6),  /* PFX 64XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6244, SWITCHTEC_GEN6),  /* PFX 144XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6260, SWITCHTEC_GEN6),  /* PFX 160XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6348, SWITCHTEC_GEN6),  /* PSX 48XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6364, SWITCHTEC_GEN6),  /* PSX 64XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6344, SWITCHTEC_GEN6),  /* PSX 144XG6 */
> +	SWITCHTEC_PCI_DEVICE(0x6360, SWITCHTEC_GEN6),  /* PSX 160XG6 */
>  	SWITCHTEC_PCI100X_DEVICE(0x1001, SWITCHTEC_GEN4),  /* PCI1001 16XG4 */
>  	SWITCHTEC_PCI100X_DEVICE(0x1002, SWITCHTEC_GEN4),  /* PCI1002 12XG4 */
>  	SWITCHTEC_PCI100X_DEVICE(0x1003, SWITCHTEC_GEN4),  /* PCI1003 16XG4 */
> diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
> index cdb58d61c152..724da6c08bf7 100644
> --- a/include/linux/switchtec.h
> +++ b/include/linux/switchtec.h
> @@ -42,6 +42,7 @@ enum switchtec_gen {
>  	SWITCHTEC_GEN3,
>  	SWITCHTEC_GEN4,
>  	SWITCHTEC_GEN5,
> +	SWITCHTEC_GEN6,
>  };
>  
>  struct mrpc_regs {
> 
> base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
> -- 
> 2.47.3
> 

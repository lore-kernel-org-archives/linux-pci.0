Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109630;
	b=q6FRX8KhYrWA76C6Y6ggThbFrx3+MIfo10P3tT+R+8sb70RkA2b+wG7EjrluSfnQDD7C
	 oeOZjTdWCGSOPFNt5TrbSUMhkZvskJnpOiRnZE2+g4YmK3cie0RIvJTQACOdPcOOIGmMu
	 ErxG7EcRiONwY1coTf+qLEccnw4K/6DCduy2WC8M5wdRKOvR3B1+CnYmiNs4y/OT/vPkB
	 8mjAVNF3m3NFyKcqprCky+9MmLj7TMNmeYdzUhITTqojx9VDEbiayc2qiXNbpUAftgXqA
	 kUjrMR1V5vtpou+oq/yk+ogF1eQAKB2Ob2xSlhBVLmlIwBD7+RzWm7xsUHDDXa7OdUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109630;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wvwVd3tHy7bv/RkSCLKDWLT+1vn5zHbPuogKcTwr6Hk=;
	b=EvwB9s8TEA8gSRaRzKLQIBwHgQ5l4nDYpMgHJmmw1TS1Cv0ReQ+pXp0OTdKtbLYnvd5d
	 ArXT+qqnr0LFmfvztQhKLU2WWq4+tRK6k0S1/3eMp14GZ1Uyw9D0wjPzTdub8fkUuoFnN
	 g+n+nIWH32svtl092hTQ8OIAP5omJuL2pG7Bat3MGk6//I9mQsskO+TnQGgZ17USBIYs1
	 HHG4DXvt65dMQ5eirCDDXFKjOQCZuMs0WDottLHiurt4sm+2Qum4HMYIzMPd8Z+9idTsQ
	 XukNvTakB8K1RUb/Qy4fZA9CoTVAk8rsAYwPBjJRnkLUPVKfobv6uh3kwsov19Rb/3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m21lOo2Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6B606A320;
	Thu, 19 Nov 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m21lOo2Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F321F000C4;
	Thu, 19 Nov 2026 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795109630;
	bh=wvwVd3tHy7bv/RkSCLKDWLT+1vn5zHbPuogKcTwr6Hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=m21lOo2Z9pnh2cNaBhxA56SCaixYLhLqsyOqnE/NGBRUUWEKafsfjMk0zCGoheS57
	 W8/LA8W8MHLZxoiY7ASuQNGCKCn3u4IjiBI7cS4gd50t2BZ8aMi8qhzG9xY8icQ1Lz
	 lXQ/Vtp5kZTudljlsdtv/pXX1D9gSIpmM5Ls9mFVDAbcVCjHN3+VZPZ7ge7I+0pAI7
	 vhBXH8M2fC4WDLoUmdZUikba/ykniR4P0D8P71aufvgKZhKXXtvNMWoe1yWuWdeZqq
	 DBnQPyy69Bq2CaPiY+U9nkZ92XLd6w9n5rSAR/7DEODtDqSEmrJDC9w3Pbh+USTGgh
	 I77l+TvVFfsaw==
Date: Thu, 19 Nov 2026 11:33:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gokulkrishna Sekar <gokulkrishnasr@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org,
	Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [PATCH v2] PCI: Correct PCIe port type field encoding
Message-ID: <20261119173349.GA822885@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119121947.204565-1-Gokulkrishna.Sekar@harman.com>

On Thu, Nov 19, 2026 at 12:19:47PM +0000, Gokulkrishna Sekar wrote:
> set_pcie_port_type() validates PCIe port topology and corrects
> invalid upstream/downstream port type information in the cached
> pcie_flags_reg value.
> 
> When performing these corrections, the code updates
> PCI_EXP_FLAGS_TYPE using PCI_EXP_TYPE_UPSTREAM or
> PCI_EXP_TYPE_DOWNSTREAM directly. The PCI_EXP_TYPE_* values are
> decoded port type numbers, not values encoded for the
> PCI_EXP_FLAGS_TYPE bitfield, so the corrected type is stored in the
> wrong bit position.
> 
> As a result, a device whose type has been corrected may subsequently
> be reported as PCI_EXP_TYPE_ENDPOINT instead of the intended
> upstream or downstream port type.
> 
> Use FIELD_MODIFY() to update PCI_EXP_FLAGS_TYPE so the corrected
> port type is encoded consistently with the format used in the PCI
> Express Capabilities Register.
> 
> Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
> Link: https://lkml.org/lkml/2024/12/13/198

Patch looks good, but this link doesn't work for me.  Probably a
temporary issue with lkml.org, but https://lore.kernel.org links are
always better.  Looks like it might be
https://lore.kernel.org/all/20241213070241.3334854-1-gthiagarajan@marvell.com/?

> Reported-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
> ---
> v2:
>  - Use FIELD_MODIFY() as suggested by Bjorn Helgaas
>  - Clarify impact by describing the resulting PCI_EXP_TYPE_ENDPOINT
>  - Add Fixes tag
>  - Add Link tag to previous discussion
>  - Add Reported-by
> 
>  drivers/pci/probe.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f..93e2e1f688ca 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1673,8 +1673,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		 */
>  		if (pcie_downstream_port(parent)) {
>  			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
> -			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
> +			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg, PCI_EXP_TYPE_UPSTREAM);
>  		}
>  	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
>  		/*
> @@ -1684,8 +1683,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		 */
>  		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
>  			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
> -			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
> +			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg, PCI_EXP_TYPE_DOWNSTREAM);
>  		}
>  	}
>  }
> -- 
> 2.54.0
> 

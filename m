Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336933EB1A
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489065; cv=none; b=Ei0froV4iCyA9oChTfB1D+LxB7qZ2q7Bynb8fmpja4Bq6eDWY6CFhqPS2lVDNQBcIa9s9+BXmsa4jiQEm0EelzIqMutrFgQxfGgIR6FD7HK+TWtL7cvk6sYEFikp/Uyti60fR/yxlhN3R+icKbL2OdEIOEdk0xna/UaSp8J9sRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489065; c=relaxed/simple;
	bh=Cc8fSeRm8N++er9Zu80pelq1NgOIeymeGa4WZTBTikY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pmdx7OUX8TNm+3KAANCKRtRnFrEqJLzYyeq/Mvwz9mLXRHVaiQDdTSCN2dGFHnt3SolvR+P6YR57rgPSkTOa93tyfXUX7kYGVI/eoIWyvBrDDein9WM89C/K8Jrnl5UWLnZkAxA4oGRNKeoddjjXfqLBmVrJMcArC+lH7sTsAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBnrqSfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBnrqSfU"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8525D1F000E9;
	Fri, 22 May 2026 22:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489063;
	bh=mJv1BYiwn8JNb/RymIQifAo8yX2QBBfmE5to3tkE5C8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MBnrqSfUyKvBuB4i00d+oDgnBWwRzD8AGa6yteUDYkkbUZEoLjXLdh64Q7eqF3rZg
	 nV15AjqsTXaFFcodukZ7zpSzFeTOnpae6RDkKxBAeLSXCTY4Pi5lu1PEVsO9JkmrsF
	 YCEdp/AIgLTYojxk1n3y05+0Y5dg8Y3pLzDD2qb1A82he6uR3AAroXqQ3IEK0M0Ifa
	 FoxB8ODO9qZp2A2b6Uf8I5S2aJUB+1WI7FRaDe56sMv42zNNH4Vw9vZjrfv7QZz7vb
	 Wmt2nuU0cx48Ri8e3J1zAqH+XKQdN5UrqyQ+feLCtd9YUsYRkCSksH7RuQ04Arsm18
	 gC9/TtOBNsJEA==
Date: Fri, 22 May 2026 17:31:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH] PCI: Drop unnecessary retries when restoring BARs
Message-ID: <20260522223102.GA254275@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785c98b50a7a00d0698848c75d51b8f5669ad18f.1777814679.git.lukas@wunner.de>

On Sun, May 03, 2026 at 03:34:46PM +0200, Lukas Wunner wrote:
> In 2012, commit 26f41062f28d ("PCI: check for pci bar restore completion
> and retry") amended pci_restore_state() to attempt BAR restoration up to
> 10 times.  This was necessary because back in the day, only a 100 msec
> delay was observed after pcie_flr() carried out a Function Level Reset.
> The retries ensured that BARs were restored even if devices needed more
> time to come out of reset.
> 
> In 2016, commit 5adecf817dd6 ("PCI: Wait for up to 1000ms after FLR
> reset") extended the delay to 1 sec.  Commit a2758b6b8fdb ("PCI: Rename
> pci_flr_wait() to pci_dev_wait() and make it generic") subsequently
> extended it further to 60 sec.
> 
> The lengthened delay makes it unnecessary to retry BAR restoration, so
> drop it.
> 
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Closes: https://lore.kernel.org/r/20260416225745.GA41850@bhelgaas/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/reset for v7.2, thanks!

> ---
> Jesse did ask "why we don't do this delay/check when we perform the FLR
> in the first place" when he applied the patch, but nobody followed up
> with a patch until Alex did four years later:
> 
> https://lore.kernel.org/r/003AAFE53969E14CB1F09B6FD68C3CD409A8B4F2@ORSMSX105.amr.corp.intel.com/
> 
>  drivers/pci/pci.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc..1e386df 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1764,7 +1764,7 @@ int pci_save_state(struct pci_dev *dev)
>  EXPORT_SYMBOL(pci_save_state);
>  
>  static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
> -				     u32 saved_val, int retry, bool force)
> +				     u32 saved_val, bool force)
>  {
>  	u32 val;
>  
> @@ -1772,52 +1772,42 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
>  	if (!force && val == saved_val)
>  		return;
>  
> -	for (;;) {
> -		pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n",
> -			offset, val, saved_val);
> -		pci_write_config_dword(pdev, offset, saved_val);
> -		if (retry-- <= 0)
> -			return;
> +	pci_dbg(pdev, "restore config %#04x: %#010x -> %#010x\n", offset, val,
> +		saved_val);
>  
> -		pci_read_config_dword(pdev, offset, &val);
> -		if (val == saved_val)
> -			return;
> -
> -		mdelay(1);
> -	}
> +	pci_write_config_dword(pdev, offset, saved_val);
>  }
>  
>  static void pci_restore_config_space_range(struct pci_dev *pdev,
> -					   int start, int end, int retry,
> -					   bool force)
> +					   int start, int end, bool force)
>  {
>  	int index;
>  
>  	for (index = end; index >= start; index--)
>  		pci_restore_config_dword(pdev, 4 * index,
>  					 pdev->saved_config_space[index],
> -					 retry, force);
> +					 force);
>  }
>  
>  static void pci_restore_config_space(struct pci_dev *pdev)
>  {
>  	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
> -		pci_restore_config_space_range(pdev, 10, 15, 0, false);
> +		pci_restore_config_space_range(pdev, 10, 15, false);
>  		/* Restore BARs before the command register. */
> -		pci_restore_config_space_range(pdev, 4, 9, 10, false);
> -		pci_restore_config_space_range(pdev, 0, 3, 0, false);
> +		pci_restore_config_space_range(pdev, 4, 9, false);
> +		pci_restore_config_space_range(pdev, 0, 3, false);
>  	} else if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> -		pci_restore_config_space_range(pdev, 12, 15, 0, false);
> +		pci_restore_config_space_range(pdev, 12, 15, false);
>  
>  		/*
>  		 * Force rewriting of prefetch registers to avoid S3 resume
>  		 * issues on Intel PCI bridges that occur when these
>  		 * registers are not explicitly written.
>  		 */
> -		pci_restore_config_space_range(pdev, 9, 11, 0, true);
> -		pci_restore_config_space_range(pdev, 0, 8, 0, false);
> +		pci_restore_config_space_range(pdev, 9, 11, true);
> +		pci_restore_config_space_range(pdev, 0, 8, false);
>  	} else {
> -		pci_restore_config_space_range(pdev, 0, 15, 0, false);
> +		pci_restore_config_space_range(pdev, 0, 15, false);
>  	}
>  }
>  
> -- 
> 2.51.0
> 

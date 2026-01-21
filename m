Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247926E719;
	Wed, 21 Jan 2026 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769038686; cv=none; b=CBqgvAUMmaH/5AV1aO86edpDo5ZiMHnKEF4DL0wG6jPjXMtH7FnDYUfwetZcBR9JB625iSzXcT8ULlIfwvBdCJFF8k33PBsL5nie9uet9su0MTOeqp8MUl6rii8e5vIUapNSD94juOKrROzX3XHU2HfDvspC+oMRXbtrSiqC9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769038686; c=relaxed/simple;
	bh=weaJN1Iequ/ZyzA1DPueH31401FC5DUZbpwwcPNyzmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PSu/uhoqpkaoWwWlUi+KefqclK3Qpq9AiFSrGJ89zmZK8jMf0J+vtXjACLp8NYjUs2T1oM1fjFdez+2CaK7GRoJrkGZtdILDaF4+FW/YAZKbpuEgJSUPpA45k5lSKpo8xojR5lUZPG6tyRsLa1APp1mBnJT716FL2vg2Hck+ciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeikHttw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeikHttw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A20C4CEF1;
	Wed, 21 Jan 2026 23:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769038685;
	bh=weaJN1Iequ/ZyzA1DPueH31401FC5DUZbpwwcPNyzmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BeikHttwrCy8vR2Z2txVC+OK5mggBSlKkHUlak+4qJNsLFrRy2lVin2znkr8uhTQV
	 hDrmRILtEmj7vUJozkGZqTtkC7jUFLFbW93vmaGTVqr/Sn5lqEpjj1cfK583XK2h1W
	 cWE3lMXXh6kONxTUrzilJiZU5A5Y89Zu2yn7RIUyGceGoUtYvSK8Y5rNZvlAy9u9iN
	 R2s2BfJMHAxgIvFEovn2WRV21tJsbeLz8tsu8o8CSDoBDHmaPSHQj2jCW8PFkiE8aJ
	 ocO0pWswC8u3eMGvxOnwCJab2Y+7vdjDnkfCiO1CZLrXf1aJX6D22EoP5AUFp1+EdI
	 qGoPNveHv3RcA==
Date: Wed, 21 Jan 2026 17:38:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"Creeley, Brett" <bcreeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Han Gao <gaohan@iscas.ac.cn>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v2 2/4] PCI/MSI: Check msi_addr_mask in
 msi_verify_entries()
Message-ID: <20260121233804.GA1221537@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-pci-msi-addr-mask-v2-2-f42593168989@iscas.ac.cn>

[+cc Thomas, thread at https://lore.kernel.org/r/20260121-pci-msi-addr-mask-v2-0-f42593168989@iscas.ac.cn]

On Wed, Jan 21, 2026 at 11:49:38AM +0800, Vivian Wang wrote:
> Instead of a 32-bit/64-bit dichotomy, check the MSI address against
> msi_addr_mask.
> 
> This allows platforms with MSI doorbell above 32-bit address space to
> work with devices without full 64-bit MSI address support, as long as
> the doorbell is within addressable range of MSI of the device.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> 
> ---
> v2: No changes
> ---
>  drivers/pci/msi/msi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 48f5f03d1479..2ecbcd6c436a 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -321,14 +321,17 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
>  static int msi_verify_entries(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
> +	u64 address;
>  
>  	if (dev->msi_addr_mask == DMA_BIT_MASK(64))
>  		return 0;
>  
>  	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
> -		if (entry->msg.address_hi) {
> -			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
> -				entry->msg.address_hi, entry->msg.address_lo);
> +		address = (u64)entry->msg.address_hi << 32 |
> +			  entry->msg.address_lo;
> +		if (address & ~dev->msi_addr_mask) {
> +			pci_err(dev, "arch assigned 64-bit MSI address %llx above device MSI address mask %llx\n",

Use %#llx so it's clear these addresses are hex.  The previous message
did that, not sure why you dropped it.

> +				address, dev->msi_addr_mask);
>  			break;
>  		}
>  	}
> 
> -- 
> 2.52.0
> 

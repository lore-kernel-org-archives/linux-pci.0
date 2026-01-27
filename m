Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B587A217723;
	Tue, 27 Jan 2026 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506081; cv=none; b=e97nOJk1LtCrnXRTMDxPs8D85tyHn5lP2efE/24x528TEqzgJQcvbMLiW211XuVCPS7N1+3gzLDGgBwUypfBZwZiZdO16HdlcazobeNUCCMtPKjZCS9d0/KQNQk2wGWHd1X48TjtqmB23BzF6Jn4C0LLxzC5uRwnsHpeDLkp+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506081; c=relaxed/simple;
	bh=NUtdM1nWlicDFUqsuPzcoMB/gzA3aziNceLt7F8iSE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MQqNf5pPa61vtDPMz5lcSd0b9E+f3EvZnuyjYs7bs4v9j79mheRTTMbJxMtI7JwsWwr7tneJaaA/qeYI4EYpQKb7YmvucOjGpLivbo08wiJ/OLVXKGBKtM5Xt7fMP0adTRTrTKaXuLT3NJQ184WZ7hvYqtT20a6m1mx/6QqlEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEO2FeMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEO2FeMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA751C116C6;
	Tue, 27 Jan 2026 09:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769506081;
	bh=NUtdM1nWlicDFUqsuPzcoMB/gzA3aziNceLt7F8iSE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oEO2FeMpvi1NaSCO2Gn8Cj6UbLkdPGgHSCr2a7tIho96JHKe2OPIWUlyKRZRs+g/p
	 bOydMQemiNt+degt62tyGOKCzCMxGQP/+fWYHd5fQoEeMMtMBrEhvbKzxQI+uASfo+
	 WnvxAODGQoHBidevnuikSB14Qm/l1uuA8SKt8swMro14a0ryd5Zo1SXOw/QtvrZtYe
	 o9wowBLm4NktfnH4gj6vq4gkvSOgZCJwp+WvtCKPASNeo0iUYm1k9Mj89Qs/nBEKdC
	 UoXofhNhiJNlSAVG+UzzUh/MKGzx0b0QaoSEXAsSwPPoP60aL3O7aNFQz0OEp+KLaq
	 Ksz08X55xve/w==
From: Thomas Gleixner <tglx@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, "Creeley, Brett" <bcreeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Vivian Wang <wangruikang@iscas.ac.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev
Subject: Re: [PATCH v3 2/4] PCI/MSI: Check msi_addr_mask in
 msi_verify_entries()
In-Reply-To: <20260123-pci-msi-addr-mask-v3-2-9f9baa048524@iscas.ac.cn>
References: <20260123-pci-msi-addr-mask-v3-0-9f9baa048524@iscas.ac.cn>
 <20260123-pci-msi-addr-mask-v3-2-9f9baa048524@iscas.ac.cn>
Date: Tue, 27 Jan 2026 10:27:58 +0100
Message-ID: <87jyx3be1t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 23 2026 at 14:07, Vivian Wang wrote:
> Instead of a 32-bit/64-bit dichotomy, check the MSI address against
> msi_addr_mask.
>
> This allows platforms with MSI doorbell above 32-bit address space to

with a MSI doorbell address above the 32-bit limit to

> work with devices without full 64-bit MSI address support, as long as
> the doorbell is within addressable range of MSI of the device.

within the addressable

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

No line break required. Let it stick out.

> +		if (address & ~dev->msi_addr_mask) {
> +			pci_err(dev, "arch assigned 64-bit MSI address %#llx above device MSI address mask %#llx\n",
> +				address, dev->msi_addr_mask);
>  			break;
>  		}
>  	}

Other than those nits:

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

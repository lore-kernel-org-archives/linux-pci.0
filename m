Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEEC2DBF47;
	Tue, 27 Jan 2026 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769505949; cv=none; b=sG7Bvdg3WfmOfoKg1qqXgjEeLLmxY85FFooOEIJUAxzBQ6FP4oE53c45LbNBluEuTVg7hLvMM8WPDzEM6xaZ+qeYnjhq/ZD5Yjdd8ueNigMzB33HFnpFPXauLptRLEJP2uV6R0IiFxcAUWzKrinOCzBrqID8J6hz6HPsA++Jy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769505949; c=relaxed/simple;
	bh=4jiQZv9wxoQeg5GZ0kgb1xulJUpKBRxTXH2y58bWr18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uuqzRzOuAbIHdwOuI2vurHkFOSMiiZjYXwG5xLTxawq53J6EyxgDYgKmBAM6y1A/OZhf2tiEyYMdr7z0ziPIdCqnI6wITolS2GJsiBWYH/Ftt0OaxlXnXpVOUYf9S9mng9faznL1EBt88HM9k8AC4qkKA5YsVnxDbXubZJjnZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwfWSVSN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwfWSVSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD12C2BC86;
	Tue, 27 Jan 2026 09:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769505949;
	bh=4jiQZv9wxoQeg5GZ0kgb1xulJUpKBRxTXH2y58bWr18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MwfWSVSNX2GZRCGGxBdlvB8xQYGAbi+lkcajYFbHijmcWUpTHXDVhI7ydYg1uDjw4
	 HPpv7cCWzutovVqQJEFV3KZL//Hjra5aOIzQJyjIGBzCYXBC3ssyUAgViMMRma4E8N
	 9SI9RpBNdQlO2gZ1RG3HWsxR056Wvm49DwJQ5mjLp02M/PoyIPmVEZs045/mNPrN8l
	 XEVpJ/uVSxciHV8bwp11WnyYsne7NENgI/2Vp0/n6QymhC8d5j3IAzg0x8lS3r/mDR
	 Luvuoy36/GTL+oCN+smnWQtd3kI0mNNEOL3E95afS5itU4dMOYSPhDbadVadZSN/bL
	 xSVk3WlsToqFA==
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
 sophgo@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3 1/4] PCI/MSI: Conservatively generalize no_64bit_msi
 into msi_addr_mask
In-Reply-To: <20260123-pci-msi-addr-mask-v3-1-9f9baa048524@iscas.ac.cn>
References: <20260123-pci-msi-addr-mask-v3-0-9f9baa048524@iscas.ac.cn>
 <20260123-pci-msi-addr-mask-v3-1-9f9baa048524@iscas.ac.cn>
Date: Tue, 27 Jan 2026 10:25:46 +0100
Message-ID: <87o6mfbe5h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 23 2026 at 14:07, Vivian Wang wrote:
> Some PCI devices have PCI_MSI_FLAGS_64BIT in the MSI capability, but
> implement less than 64 address bits. This breaks on platforms where such
> a device is assigned an MSI address higher than what's reachable.
>
> Currently, we deal with this with a single no_64bit_msi flag, and

we don't deal with anything. The code has a single bit
limitation. Please use passive voice as documented.

> (notably on powerpc) forces 32-bit MSI address for these devices.

this is not a valid sentence.

> However, on some platforms the MSI doorbell address is above 32-bit but
> within device ability.
>
> As a first step to enabling MSI on those combinations of devices and
> platforms, conservatively generalize the single-bit flag no_64bit_msi
> into msi_addr_mask. (The name msi_addr_mask is chosen to avoid confusion
> with msi_mask.)
>
> The translation is essentially:
>
> - no_64bit_msi = 1    ->    msi_addr_mask = DMA_BIT_MASK(32)
> - no_64bit_msi = 0    ->    msi_addr_mask = DMA_BIT_MASK(64)
> - if (no_64bit_msi)   ->    if (msi_addr_mask < DMA_BIT_MASK(64))
>
> Since no values other than DMA_BIT_MASK(32) and DMA_BIT_MASK(64) is

s/is/are/

> used, no functional change is intended. Future patches that make use of
> intermediate values of msi_addr_mask will follow, allowing devices that
> cannot use full 64-bit addresses for MSI to work on platforms with MSI
> doorbell above 32-bit address space.
>
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Other than those nits:

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

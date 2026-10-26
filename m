Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028091;
	b=UIzyqLzlhkmDnFVpUjGnpIhP0/yB76LBshkKALRR84vURtey5u7Dlqf7H4O3Whix5zNp
	 Mjhp76O8c3lg4AybacjXNVGOgUQOEGwchuUp8o6gSZnWdsqcVWc+BlV5iEPTYaE6y7EkG
	 +KVv6+ShHXrcHEBRX/hvtcMutO9dVvy8AwLGCx4FtenTu1Z4MyFuXTn5lisfvSroehCQF
	 Oj/ZJ0FETj9XiSM5DeXoYuRRswbnFFdxDS6NZM+PqHr4TEmQXlZRnDRS+lnGEQwqxfDdP
	 u2ASEm8tntvn7J2nZu2e0N1gMiwHKThE59rIAd8ANXfTnRzdldosA0d1J+Pa4fKktEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028091;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O4Wglfoso0hTNUGdp/PoRiQMvHPVtKvf5IHe9tQ03Po=;
	b=NvLhD1sHX1BlIxrQgFWGe9hcbtUPrz7XGBPWtpdfy7ukkHmnhuHhOYnDnHuQrrRLRsSC
	 jXlAZkyyyXavFuL8B2Cwv+cxaPFLr86lzXgnaXiCsg8w/Thl7l97BJiGtk/0qeSpMsc8H
	 6KGJAj34R9+8hPub/0CAFpVvKItNUnnSLKs39lr/C9/PB2aZi9FlYvgisN7VBf/6pYMkg
	 ou0sOzF+81/LV/q8b23mSrz6mH4zf76AcMM1U080W6Mphc5oHx6qRlZY4wwHsHfN4TqUy
	 NE25fWslrFtT48kJ7GNO1rVQ1uEntPwoWO2uK3F9E4In/O4DcMFIY9PoPba0tDCVgyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSq7Eh2S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE5606A31B;
	Mon, 26 Oct 2026 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSq7Eh2S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D431F031E2;
	Mon, 26 Oct 2026 15:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793028090;
	bh=O4Wglfoso0hTNUGdp/PoRiQMvHPVtKvf5IHe9tQ03Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NSq7Eh2Sfl8TN0YCuXAQPu4BLGbqDGU9S4n0Z/bxR414nHWSXtIUIhBrXYoQcglmd
	 6KPbK+0I9odOYWJ9b1FcyNjKA/E0j6C3NvecdpUiYWwkCGdoQ9Ga5V3iVZZvX3ufkR
	 MYoV4Fl3/cVjHF6R1jLg7lnUT3h8pDeWzlORzSsrEhtoaNkdT/eJke3EbTgA/8H9Ah
	 bpORAstqhC4byBSL6RrZohzNDnBos9WTmHsdO/BevrrBz+1MlHX++O8oHsFj5J4H8K
	 h06964LH1glX2cY7Pst9OS7tQj8lVlRPbuNGuUF6wgpihMwBcEEYNGwi4O2Eyy/79y
	 LFx/BctBU3+ug==
Date: Mon, 26 Oct 2026 09:21:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nikita Vetoshkin <nekto0n@meta.com>
Subject: Re: [PATCH 4/5] PCI/sysfs: Use user config accessors for link
 attributes
Message-ID: <at9v-M0sb9dSRDEt@kbusch-mbp>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
 <20261025000836.58294-5-thepacketgeek@gmail.com>
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
In-Reply-To: <20261025000836.58294-5-thepacketgeek@gmail.com>

On Sat, Oct 24, 2026 at 05:08:32PM -0700, Matthew Wood wrote:
> max_link_width, current_link_speed and current_link_width read the PCIe
> Link Capabilities and Link Status registers with the kernel config
> accessors. Those don't check block_cfg_access so a read that races
> with a reset goes to the device mid-reset and can fail or return a bogus
> value.
> 
> Use pcie_capability_user_read_{word,dword}() instead so the read waits for
> any pci_cfg_access_lock() holder (e.g. pci_reset_function()) to finish. For
> max_link_width, this means inlining the pcie_get_width_cap() logic
> instead of creating an additional helper with this single calling location.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

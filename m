Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BAA27AC41
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072481; cv=none; b=sDSfLSGRRoPl0kpKUHcjidZw7nhWE0g4qWv9++4le0l/2TUcb8E5F2nr0Jx5IuGpjXKF0sR020xaNTi9YSPkv6vWF/EPPPj+yIsi8GysSV2cIGPo0djnQDj3JKdzoF9O8tL7cymEtrfss0C8hRoiPu5urSkec2HSTh+sauYG0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072481; c=relaxed/simple;
	bh=OEsc/oFbafBXsySfpvbb/EcFFG7wIIq7aGAbVJcjTVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwnehQGFTlfCN4YwP4HTJxNwg5ee91OoZD9hp1yK09ygvR+ZovRoUnvukr4zBPlnu4/UlMWl+WOKMOrjC5p7wmLo/FEWAORX88a1FthGhNXtFGozKjiG8ZMCffJ8jcZwVQiCzH5JSz08IZTWlXLG/SojME4TkQg3+ux1DFrxbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 883D92007FF3;
	Thu, 22 Jan 2026 10:01:08 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7FEC22D3E7; Thu, 22 Jan 2026 10:01:08 +0100 (CET)
Date: Thu, 22 Jan 2026 10:01:08 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PME: Replace RMW of Root Status register with direct
 write
Message-ID: <aXHnVK2NRa-uQ2cM@wunner.de>
References: <39f87c99f6c44be3c0371c79e454e6fde7be0d4d.1761497583.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f87c99f6c44be3c0371c79e454e6fde7be0d4d.1761497583.git.lukas@wunner.de>

On Sun, Oct 26, 2025 at 05:57:57PM +0100, Lukas Wunner wrote:
> As of PCIe r7.0, the Root Status register contains a single writeable bit
> (PME Status, type RW1C) and otherwise just read-only bits and RsvdZ bits
> (which software must write as zero, PCIe r7.0 sec 7.4).
> 
> Thus, when clearing the PME Status bit, there's no need to perform a
> read-modify-write of the register.  Instead, the bit can be written
> directly.

Hm, I just noticed that this patch is marked "Not Applicable" in patchwork:

https://patchwork.kernel.org/project/linux-pci/patch/39f87c99f6c44be3c0371c79e454e6fde7be0d4d.1761497583.git.lukas@wunner.de/

It didn't get any on-list replies and didn't get applied AFAICS.
I'm not sure why it's marked this way in patchwork or what to do about it.

There's one other patch sharing the same fate:

https://patchwork.kernel.org/project/linux-pci/patch/75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de/

Thanks!

Lukas

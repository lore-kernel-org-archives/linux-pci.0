Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F536F434
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604259; cv=none; b=ImqroTZWnQSqwk272+iG3YWXGJkhpkrC96Vac/o0nyD8KKcjm82W075umyE7P8Qay2RetMgBIFfTQdASigYnMcoX74rXrmsIMzf3tW7Zz/lgQ2DLt22C4W/lou3HowtHfrRJxWv/6U4EViHGRHmPzGisvFzwPW39Hq7BLFhXwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604259; c=relaxed/simple;
	bh=MkgBdywlyEzEylbjN0LWYMsil9WuUPOTuRrE3qasGfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/GHU3UBYkfNeqTIzoeQQ8ULDEM3wpHFPYdrnLpm5aK4tjquQisez9vVG1CDyPMKy+G2hBKkNkvNWiDfPZq1YkeWSCEY4XcRCgTyETDgUheRZgk1BPyzF5VqG0Jg7gOls1qf6YhZqB5qPzH0I6flsxIhEUFZRrcoeTm28IaX/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=r/OOAUQE; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="r/OOAUQE"
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 9E3E5280177; Mon, 24 Aug 2026 22:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1787603840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OjnL2X4opqPoOkCRCg4VkdB++oNFuy3kh9vMjKv0KNg=;
	b=r/OOAUQEMJBfGRhKRZqUHYwFOk6HZP3ex492GnuUrK39ugRnUYl40u5YqnYHaFXlmuA5JS
	x+8WRKohNq5Fq/rfhn/Wn0LTPQfPTxr950oa6KWKYYyLVtLMqMPey8pCJI5bjEgA/Whaul
	wXLAdRsum/vywj+k62uyRhVXw4tQrCo=
Date: Mon, 24 Aug 2026 22:37:20 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: David Matlack <dmatlack@google.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pciutils PATCH v2] lspci: Determine bridge window address size
 from bridge_flags
Message-ID: <mj+md-20260824.203623.76319.nikam@ucw.cz>
References: <20260821221610.3570722-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821221610.3570722-1-dmatlack@google.com>

Hello!

> Use bridge_flags to determine address size bits (16- vs 32-bit for I/O,
> 32- vs 64-bit for prefetchable memory) when displaying bridge ranges
> populated via PCI_FILL_BRIDGE_BASES.
> 
> Commit ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if
> range behind bridge is disabled or unsupported") introduced code in
> show_htype1() that reads PCI_IO_RANGE_TYPE_MASK and
> PCI_MEMORY_RANGE_TYPE_MASK from bridge_base_addr[]. However,
> bridge_base_addr[] holds base addresses without flags, as documented in
> lib/pci.h and implemented across backends like sysfs.c and
> win32-cfgmgr32.c.
> 
> Because bridge_base_addr[] does not contain configuration register flag
> bits, masking the lower bits evaluates to zero. As a result, 32-bit I/O
> windows are mislabeled as "[16-bit]" and 64-bit prefetchable memory
> windows are mislabeled as "[32-bit]" when using PCI_FILL_BRIDGE_BASES.
> 
> Fixes: ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if range behind bridge is disabled or unsupported")
> Signed-off-by: David Matlack <dmatlack@google.com>

Thanks, applied.

Unfortunately, the current system of test cases cannot handle this
type of errors, because it is based solely on parsing dumps. Maybe
we should collect sysfs subtrees instead?

				Martin

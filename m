Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E7219A8A;
	Mon, 26 Jan 2026 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465845; cv=none; b=ReEfX9MHxF+MeU10TCLSmmqT0E7XJaXXSKq4qy4NBCT47kOj05NK6iA1TWxaJWoqHje1nl0gURQRS2mQ0pgd0pHt3ENoylJTFUYaurfi/mw6wWOT70JcIDZ0I0wIYLw0oI3VZP++cyV5Sx2ThxmxfIQeNtaOUXtbmHggl+8QCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465845; c=relaxed/simple;
	bh=sU+Hp3wk6QmRO3zATaAn8ZCf5MiqeRpoDYFeioJMV0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qbSL+JiEaUt7j+7TRDD1yjgQlsC6KigkZDfiyXutv60YDgVQ4olh9ZS5dVHYHo2DmDXvktvVHzwSI5upO1jhuCBDJ/So/VOuJCmXr4GcfUTPAHqLspWEbacgxibzA5Ru2fPz1v219E+TDt6/2UrSTOpAsWsxpmHjxW5UspR6TMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOrEHjNj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOrEHjNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47EDC116C6;
	Mon, 26 Jan 2026 22:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769465844;
	bh=sU+Hp3wk6QmRO3zATaAn8ZCf5MiqeRpoDYFeioJMV0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BOrEHjNjWFXVAS2K+Sdlfezf4BWBiV8HH6t2Jg8+c0H/XVjdtn/yejMwQl13z57Lu
	 ln4DLnc3g6bQYgn/xLDwED/5VCrVTNnIQODGYiZ/IyolmED1KK1fFkIdW8qjCk3cch
	 0bvETEVl1uXcxbU3c+/a8ivapko+kj4mHOVxclinrEqLMLGiDLlOj8Vc33owv7iS5d
	 ZYfkrAdEaTFujUgjXU7DnaI8X3dz0EePa6x61ARe3BatZNsbb8pviL+pc/xazeUbGw
	 bfhujpdMZ0Uq2BY+BDScYrDW3LxfkBh8rjidze3wJ1wnwlGbBVlYyN2xkOKIfgdQx6
	 qGOGGuFq2WEdA==
Date: Mon, 26 Jan 2026 16:17:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org,
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte+lkml@tnxip.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/23] PCI: Rewrite bridge window head alignment function
Message-ID: <20260126221723.GA318550@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219174036.16738-3-ilpo.jarvinen@linux.intel.com>

On Fri, Dec 19, 2025 at 07:40:15PM +0200, Ilpo Järvinen wrote:
> The calculation of bridge window head alignment is done by
> calculate_mem_align() [*]. With the default bridge window alignment, it
> is used for both head and tail alignment.
> 
> The selected head alignment does not always result in tight-fitting
> resources (gap at d4f00000-d4ffffff):
> 
>     d4800000-dbffffff : PCI Bus 0000:06
>       d4800000-d48fffff : PCI Bus 0000:07
>         d4800000-d4803fff : 0000:07:00.0
>           d4800000-d4803fff : nvme
>       d4900000-d49fffff : PCI Bus 0000:0a
>         d4900000-d490ffff : 0000:0a:00.0
>           d4900000-d490ffff : r8169
>         d4910000-d4913fff : 0000:0a:00.0
>       d4a00000-d4cfffff : PCI Bus 0000:0b
>         d4a00000-d4bfffff : 0000:0b:00.0
>           d4a00000-d4bfffff : 0000:0b:00.0
>         d4c00000-d4c07fff : 0000:0b:00.0
>       d4d00000-d4dfffff : PCI Bus 0000:15
>         d4d00000-d4d07fff : 0000:15:00.0
>           d4d00000-d4d07fff : xhci-hcd
>       d4e00000-d4efffff : PCI Bus 0000:16
>         d4e00000-d4e7ffff : 0000:16:00.0
>         d4e80000-d4e803ff : 0000:16:00.0
>           d4e80000-d4e803ff : ahci
>       d5000000-dbffffff : PCI Bus 0000:0c
> 
> This has not been caused problems (for years) with the default bridge
> window tail alignment that grossly over-estimates the required tail
> alignment leaving more tail room than necessary. With the introduction
> of relaxed tail alignment that leaves no extra tail room whatsoever,
> any gaps will immediately turn into assignment failures.
> 
> Introduce head alignment calculation that ensures no gaps are left and
> apply the new approach when using relaxed alignment. We may want to
> consider using it for the normal alignment eventually, but as the first
> step, solve only the problem with the relaxed tail alignment.
> 
> ([*] I don't understand the algorithm in calculate_mem_align().)
> 
> Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]")

check_commits complains that this SHA1 doesn't exist:

  In commit

    a21a27a0e893 ("PCI: Rewrite bridge window head alignment function")

  Fixes tag

    Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]")

  has these problem(s):

    - Target SHA1 does not exist

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d0a8965aea9
does find it, but says it's not reachable.

It's so old (2002) that I'm not sure it's worth including it as a
Fixes: tag.

Bjorn

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB092D63F6;
	Mon, 16 Feb 2026 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247660; cv=none; b=nf0mTaK6rdYJ9h03Fo3pErLDjG4aKsvhtdXo6sMAwHEJcnHc6QPBZ1jAZSC6Y6nkbgSv1tBDdM0mkC+E+cZRgF0zIppZqEvLFsMH1LemVkZVYPiMWaG6B04CgKS/W7xKKZ+Jau+0FSDxs7hS6UZUnhYoY8FeE96Nuc9YMAMuEiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247660; c=relaxed/simple;
	bh=rTVtJErvfo78G+WfSugqek+yR6ecMX/f2+JQF6wZ5lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la0xJZS18yuCGmMSHhteAYCcwfPrfPxhg8iLv9KkuYMPYO0G8Mp+6a/9Mhsk9xzPxt5pKwnUpdPREBBgr6r/giGK4ZFZ5qRsoiSuuGGdB+nnqwQ54jkOITG/+kBnrrmo7oCcSp2ZqUa9BfX3pXgq2/yiUB/gCuen84VyHeaRsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukOM0Q7h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukOM0Q7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE9FC116C6;
	Mon, 16 Feb 2026 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771247659;
	bh=rTVtJErvfo78G+WfSugqek+yR6ecMX/f2+JQF6wZ5lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ukOM0Q7hL59XowyB+fKB/eWR92VN41OVaWUZQ44tTH+MkD6NuL8fkxqeOoit5Nr2J
	 9RUJjk0gu9jwPvXaPIAW1gDoEXH8VsO8lcXTW7a5nZyBD6Z+/EFdB+nI94/zNO8DcV
	 s5545/ax4bcMxAZiLKWwXJWb25Hm1Y1upS5Jhz4hsjS6+UJOxEnJ04AB1t2h8yJGOy
	 GdZhZuLNfggMb+BfTJ7es+/dyLuybIUarppUtwQrKxAoNvi0dSEWIMHHQXT3/6pWbj
	 6mutAn3cKLUYnrkyP9efZAs72uA35HMnsOVWPXh04Dhlkt3aOiwxlgGWHCBdESF8ck
	 sZ849Qr+Onc/g==
Date: Mon, 16 Feb 2026 14:14:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 2/4] PCI: endpoint: pci-epf-test: Sanity-check doorbell
 offset within BAR
Message-ID: <aZMYJsjpqPR9uNqp@ryzen>
References: <20260215150914.3392479-1-den@valinux.co.jp>
 <20260215150914.3392479-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215150914.3392479-3-den@valinux.co.jp>

On Mon, Feb 16, 2026 at 12:09:12AM +0900, Koichiro Den wrote:
> pci-epf-test advertises the doorbell target to the RC as a BAR number
> and an offset. The RC rings the doorbell with a single DWORD MMIO write
> to BAR + offset.
> 
> For MSI/MSI-X-based doorbells, the message address is required to be
> DWORD-aligned, so the computed offset should not straddle a BAR boundary
> in normal operation.
> 
> However, with support for doorbells based on mechanisms other than
> MSI/MSI-X (via pci_epf_alloc_doorbell()), the returned message address
> may not necessarily be DWORD-aligned. In such a case, offset plus the
> 32-bit write width could cross the end of the BAR aperture. The offset
> returned by pci_epf_align_inbound_addr() is guaranteed to be within the
> BAR size, but this alone does not ensure that a 32-bit write starting at
> that offset stays within the BAR.
> 
> Add a bounds check to ensure that the 32-bit doorbell write always stays
> within the BAR aperture. While this should not trigger for
> spec-compliant MSI/MSI-X addresses, it provides a defensive guard
> against unexpected offsets from future doorbell implementations.

I think everything you write is true,
and I know that I suggested this...

But for the MMIO address, will it ever not be 32-bit aligned?

Even in the eDMA case, the eDMA registers are 32-bit aligned.

Did I perhaps have a brain fart and overthink this?


I guess theoretically, some future pci_epf_alloc_doorbell() implementation
could return something that is not 32-bit aligned...

But if we really want to add a safety check for that... perhaps a 32-bit
alignment check would be better suited to have in pci_epf_alloc_doorbell() ?


Perhaps this check is better added in pci_epf_alloc_doorbell() or
pci_epf_alloc_doorbell_embedded(), in the series that adds support for
embedded doorbells ?


Kind regards,
Niklas

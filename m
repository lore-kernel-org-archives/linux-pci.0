Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2F39B4AF;
	Wed,  7 Oct 2026 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370433; cv=none; b=s2XAwXJYZJVkC27c6tz/ayqGVKqLqTfhFfUei1E5mfwzt/WwcjElxi4sTVjJGHMdFJurXiKbK0yNo7NwzE7sTIhCY+9t/pafRUjxtFbFAEvMuU7ZnwL7ePVqpzmMuZxmWXmnfgPbpj3WxCw3lTxPCSYxvgUUMNRRQKoGRsKqmSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370433; c=relaxed/simple;
	bh=yzVDZVj2uEzezJs+nadaDVA2RRODDD5RX0zsyDk0bDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn5YepXxZH35PrZ5JF/hlMWb66ETHsUU3bekGjyBmzT/gCIiQ5ikdVzMa+qOZycL+u7pUlRWMg6GrRJn9xSXDXnT157Amvp5y1n9YJzapITvcWvHRUlXR25L4dOYfSnl8cWBNKF+Rb4W5NmN1DmYZrd6wZOU0gTq9xUiziZLHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcPzy05p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcPzy05p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC6F1F0089B;
	Wed,  7 Oct 2026 10:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791370402;
	bh=8UP2ng0XjxMFKsWAgf4LGIEwaqO8B0A7DdwcljBs1u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bcPzy05p3PgqYJ0z0E2sRMJS9zLPgpUVplMS+AVHdn//Iv3N1bQ/OOuwTgDxPvpkW
	 t+JIL5Cm2OnD5XTFQQelU81zhJUvRAaaoOTKI9fejLZjMl615xA2xb8LlmRbwEOCCh
	 F+rZHnz6yctxYYVktnxoL2uyrqxOE7XQjDtWJSlNplriPVTp1uo5Pdfl3G+1gKZZ2P
	 HXbNRmT9DmptlUzuZjlUZcZrLxtYbmMq4DPHorDlw+z8AMpj5PT0uwDeO1kUf7/kNK
	 DAzuvVaqhjbimqmJwTR2y2leGtSRF6fe18v8bqSez6wIKZQfMifS8J7zDl4aZbyWae
	 +ZgclaOqnHN1A==
Date: Wed, 7 Oct 2026 12:53:18 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, frank.li@kernel.org, den@valinux.co.jp,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH RESEND v2 0/2] Macro Ordering and Typo Correction
Message-ID: <asYknhxjo8mo8CeG@parshuram>
References: <20261007100336.4009004-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007100336.4009004-1-devverma@amd.com>

On 07-10-26, 15:33, Devendra K Verma wrote:
> These are minor and cosmetic changes.
> 
> o If the macros declaring the bit positions of a register
>   are in order then it provides a good view. Corrected
>   the ordering for once such register.
> o Corrected the typo under the IP related data struct to
>   have the correct name under respective IP structs.
> 
> Previous reviewed-by tags were part of the following
> review:

Please post a v3 after rebase on dma/next. As I told you code has
changed and this does not apply and you posted the same thing again!

> 
> https://lore.kernel.org/all/aoW7vxy2lpXEbmRq@SMW015318/
> https://lore.kernel.org/all/dx5jvko7ygrqugzkt3k74l3d7lk7iauikmxrzuhvn2b4bdv5ub@s2l6zl3alx3z/#t
> 
> Devendra K Verma (2):
>   dmaengine: dw-edma: Sort Register Field Macros by Bit Position
>   dmaengine: dw-edma: correct IP name in xilinx_cpm6_dma_data comment
> 
>  drivers/dma/dw-edma/dw-edma-pcie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0

-- 
~Vinod

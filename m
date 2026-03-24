Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082B23D281
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381069; cv=none; b=GjLBO1tbiTlxMwlfRJPztigarwtxsnnLgfM6EdzXKd4wuvn6gHQGA0+yYvagU2CSVnlSp36kleXf8ajVtbx+FXVDpXnGtPRsxu675jMdFBhMTMm30u3dd3wd3sFeKTTmf7ph2BNAWkPS4+O1r0Ndb0O28b+pKSz6b7paNsndGcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381069; c=relaxed/simple;
	bh=FSMbDfBQchxcTGQjhWPZ05ODXKaW0VAxUcIbKCRCGqs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ONbaoB4EgmX4SnfqZvCzobw4okJJy8Y12ILzZ3qPSPwBnpTLkINBfGpVzPp7armOGd5SRwB/Tuk/QPLeGx6KeXmaxpOUU86IztX7w5RfvwZ65vOsFM94apNonjE9pY/YWeVvOoiiiLkj8FE7Zf7tL9oD3H1+ZrwTVovQKeMaPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJEuEmU0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJEuEmU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74674C19424;
	Tue, 24 Mar 2026 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381069;
	bh=FSMbDfBQchxcTGQjhWPZ05ODXKaW0VAxUcIbKCRCGqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mJEuEmU0owy6a2jdKYB8/R9rQU8F4zXiwbP8QDPHGsOOTKVIgdHFju1XuLLaXdXGM
	 gU30O+8h/l9fksp4pppehaocDR9Gs6i4atxEukrk2iZyv0pbnc2CoAQwdty8J8gfKr
	 Qo9toOvHDQ3aEWsYoUer4AudPSFRRrpL1YVfqEvsgi1nHC/JvKja811h2dszHPexAO
	 w5Y97WcTxEnQrnqPCRW+1q2639lIGViRuxE3aAm5pwhbTQh/L50cmnd2ScIThkSNFO
	 TXfRixrw+17rDFz09P9ZnIrXwu9h9vuu4NM2hN9vcsZBXja3KYud5M8HAOBW2t0pjW
	 ioY6iHLowdpTw==
Date: Tue, 24 Mar 2026 14:37:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/5] vgaarb: pass vga_get_uninterruptible() errors to
 userspace
Message-ID: <20260324193748.GA1149226@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307173538.763188-2-Simon.Richter@hogyros.de>

On Sun, Mar 08, 2026 at 02:35:34AM +0900, Simon Richter wrote:
> If VGA routing cannot be established, vga_get_uninterruptible() returns an
> error and does not increment the lock count. Pass the error on, and don't
> call vga_put() when userspace closes the handle.

I applied this, but I'm a little confused about the "don't call
vga_put() when userspace closes the handle" part.  Does that happen in
this patch and I'm just missing it?  This patch changes the "lock"
case, and the only vga_put() call I see is in the "unlock" case.

> Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> ---
>  drivers/pci/vgaarb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index d9383bf541e7..22b2b6ebdefd 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -1134,6 +1134,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  	char kbuf[64], *curr_pos;
>  	size_t remaining = count;
>  
> +	int err;
>  	int ret_val;
>  	int i;
>  
> @@ -1165,7 +1166,11 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  			goto done;
>  		}
>  
> -		vga_get_uninterruptible(pdev, io_state);
> +		err = vga_get_uninterruptible(pdev, io_state);
> +		if (err) {
> +			ret_val = err;
> +			goto done;
> +		}
>  
>  		/* Update the client's locks lists */
>  		for (i = 0; i < MAX_USER_CARDS; i++) {
> -- 
> 2.47.3
> 

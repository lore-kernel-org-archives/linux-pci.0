Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE63BBFCA
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789534877; cv=none; b=WQ0cq/y0/9BxUh2SysmsKeu/mBpLoiVfahSxWNoTOqVi88OKPCR/w0wxdAo0DdYtE3w0oDL1OFgjnbB/2G0IuQc6EBB4FnuW8WHwQKWHugV2MwVoIi/MO+DlzluQ57ntQmc5e5VZ2nHTyqFqset6NEj99FuB+/tFkSy+o4coYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789534877; c=relaxed/simple;
	bh=pj8AhhdEnsh80eO9w9xsLy7jrkPp1IC8EO9Qmi/Ciow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwC3gLiKN/tAke/n3rXOAwL+p18vDRaDd9tAEj7Q1ig1P2zZuk0h4fE/QUQhcCNFmGk0ODxkMF3hv48rTsX3vJWwfiWG/fjvkXavXGY3zalpS9LpUWHTOEgFFXhRjlocTYPx2gQX+Q/l8k9ba6vYp7p9yOdkGOnmi4aHqzN30mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXdbGvmv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXdbGvmv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1887650a91.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 22:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789534876; x=1790139676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YX/Aaiy2ApxKLbdrXbii2Ini0fQbNuOc4vW+XIt2M8I=;
        b=DXdbGvmvUMzes4EvA1P1O8mlIFHFuUX2oyXv+gTdfBfoZZG/kqcfGC9/zCg/dmt0u/
         4CaHh/xoromes9nW5j4NA7n2741ubbBKYg9uQsIGWVkU3InbPsBkbEqSQR+2D80fMvu5
         VQfMrwkkrrZlCCga43y8XTwM/e1cWnOu0d3NuxpRBXtV6/k5U+AYhvTrODkD9Wp3BL+M
         YmKT6BNj545a9Vqa3e8zB9zqHkE+Zf/ZyqKsGb4O22ulIx9HsLSfB+VNn98Er0VFlqqj
         OvBoEg6IwvFbZRUDJrW3JHNIaXmShH0xBiPda9FoFBCBEcUxpYb7lkSZF/O96TqS69PQ
         JuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789534876; x=1790139676;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YX/Aaiy2ApxKLbdrXbii2Ini0fQbNuOc4vW+XIt2M8I=;
        b=h+0t9UdQfSuPi2X8AiO+0s7Tz6jbyjl3rg2UAOKumyHV/jxKf6zhMKy2eR08Hwzh/x
         TvALkjcrZ0HFq3G/1c6ZPUFxRsXl7YRCcMxZSTWeEezWuxN8ZLGmgZAq1C0ttLWB5WCZ
         vl/mKhXGZkEt7R3Gn0hgD5B9L2vEYqcgxduiMTqQRDFsYKYhilqPDOr9Ls7KqomeGGCm
         GnCTZuGQKJKx6exN9pFz4kbNCGOx5QO3/WYabB+yp0j5P3us6W0ZmrkKt+pPQ+tQd4X3
         Nhmy4YqI24jzjvn2y3ummznroZFA53Dvdn3YH7cRFWnexCY1jHeO4fsCUnjrSwzG4SBh
         r4ag==
X-Forwarded-Encrypted: i=1; AKwUvBzdBnHBtETLh8QvAqsf9sct5Dqc8YIZove16JbWtWgrIDBQon52CX4u7triBVgsOsAIF3EtowN65r8=@vger.kernel.org
X-Gm-Message-State: AFuF++kS70ayo1N3mpZZmi5d0s5Wt9BZVLSWLJ4LJSzz1vIwsoHGxWSq
	h70pODGpp2Z9Bq+E1q161wFj4eu0oi9SFwehZHK2y1ra48DHFUkmJWEo
X-Gm-Gg: AYBFou3ADUzHQG+YKrwv5dKfgKUkuNWa0MhQ4DpTVtE3T8dgs6Rl2FJAc97X5ICTq8V
	yXb8qWrBEDh+yXPb6hNTzgr+xJN0eS8E+8zi5A7J2ZlQhSUIzJ3stYLFGvvhPknyJJPM20Zqfdc
	3Gt9kCUOf6PvCpeac68Hs+NoTQXAINeH4zlVIiQxLusRxyX8pZmHJsXuIlLZH9UUWuYLAGATW6I
	7HT8eRWVwm+jjwFCFZsUcUZzSQ8NynCBKeppKRUZRvpUtiBNRaqIdTNIggxc4hsZCh5ffZZLSc+
	C2ZmPw4jBDBtsjkfzDr64V9QwKw7roX+GrA7Q1vj/rib5WJQHL322fWxfbwkJWSKy1y4IvCEA3d
	TWTrPQ+1b6otmQBjEGSmlP+mZ/moVBrqM0xRYdsKmoJsHL/e/IBzLiEehzTR9pzxsdsnIWbAJA+
	+0ScFV44wzgil2uAIehzOMV3spSta4O/VVEuvhN3x0bxBo1dnd1H+xC5rryMLAnpEgH4AbNi5+5
	a54DW+Hrv5a36Zkmw==
X-Received: by 2002:a17:90b:2f08:b0:37f:e5b1:ec4b with SMTP id 98e67ed59e1d1-39dfdfd409amr7316774a91.5.1789534875559;
        Tue, 15 Sep 2026 22:01:15 -0700 (PDT)
Received: from kernel ([45.251.35.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a1a5sm4300257eec.5.2026.09.15.22.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:01:14 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:31:09 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: alex@shazbot.org, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: quirks: Fix out-of-bounds MMIO read in
 mellanox_check_broken_intx_masking()
Message-ID: <aqoilQgDWM_O5eXq@kernel>
References: <20260905161743.5766-1-raizudeen.kerneldev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905161743.5766-1-raizudeen.kerneldev@gmail.com>

On Sat, Sep 05, 2026 at 09:47:43PM +0530, Mohamad Raizudeen wrote:
> The mellanox_check_broken_intx_masking() function maps 4 bytes of MMIO
> memory using ioremap() with a size of 4 bytes, but then reads two 32 bit
> values using ioread32be(fw_ver) and ioread32be(fw_ver + 1).
> 
> Because fw_ver is a pointer to a 32 bit type, fw_ver + 1 advances the
> address by 4 bytes. Reading 4 bytes at offset 4 goes past the mapped 4
> byte boundary. This violates the API contract.
> 
> Fix this by increasing the mapping size to 8 bytes to safely cover both
> 32 bits.
> 
> Fixes: 1600f62534b7b ("PCI: support INTx masking on ConnectX-4 with firmware x.14.1100+")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
> Changes in v2:
> - Fixed a typo in the commit message("ad" -> "and").
> - Updated commit message to use "violates the API contract" instead of
>   "page fault or kernel panic" to avoid overstating the risk, matching
>   the feedback from Alex Williamson on a similar patch.
> 
> Link for v1: https://lore.kernel.org/linux-pci/20260827071940.B7CC01F000E9@smtp.kernel.org/T/
> 
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21f..b30ca4244f14 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3714,7 +3714,7 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
>  		return;
>  	}
>  
> -	fw_ver = ioremap(pci_resource_start(pdev, 0), 4);
> +	fw_ver = ioremap(pci_resource_start(pdev, 0), 8);
>  	if (!fw_ver) {
>  		pci_warn(pdev, "Can't map ConnectX-4 initialization segment\n");
>  		goto out;
> -- 
> 2.53.0
>
Hi Bjorn, 

Just following up on this patch. Please let me know if you have any
feedback or if further changes are needed.

Thanks,
Mohamad Raizudeen

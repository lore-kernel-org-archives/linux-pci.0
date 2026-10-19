Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792449617;
	b=dKiw7FUcTRuw6UUz+xVsqf5IlQoBkVBM2EST5mWiq4lcz+ni4ZFf5TWIlo0YPGicmD4c
	 JYjSEUr2gHPGvKFJyC6MsNjM02fVJAMyg56QzVzPAeLf664HJY8SiEz6bZmhx29SgjXY8
	 VWxT1XBQlvBIbpe56uDSMHRgBDKXKQajV6JzcjMAmJ/dQaueUKDDY6L6rYjqnLwdqYriV
	 JYDcGhJipu8ITPROsxIfewxVVoGswgG8kzAGqOjxBHryphrc0bGewBF+1AxJ741R04/w+
	 pqIcSQYDREkppLrmsp3IHHO4k2lIXEZQkjOIk6RvhziG8pDlKMQ2Xrk8vOwv5bBkn+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792449617;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YmuZwfeBT5PsQnS4UwCJoYlbiqEwj60N4JH54SSWZiA=;
	b=NoOwAldkRjRFNE3RexYhly5mcX5V4OxdRZ6Str1lB/ldt5oVJ3zT9IuXDSF/2gaZvGS9
	 8QZGNfY7hYa/uXpxnwM0RsTcxwNritvKejg2fYsjrvfAdI47+SJT45xwL4SUMB5t9hhu6
	 TaPVVb9SREwt5htFMuuE0qBKxcNC/NpwM1YXXali37MrE50/a4BKuHqvDc9THd59WRure
	 LKE2ic7nQhrEoj7Mc9RHWKe16Cw0C0bsqLTEE49Xr9roof5lzjGhdNnm5c9u4/TFTBN8Z
	 Fqlt++zBL+IHDdsmV35Xufz204CrDI3wuYU6ALGdj62FhPzBbzcu7K5j1igyFkmCYSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5Izwnj2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FE606A31A;
	Mon, 19 Oct 2026 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5Izwnj2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041071F000C4;
	Mon, 19 Oct 2026 22:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792449617;
	bh=YmuZwfeBT5PsQnS4UwCJoYlbiqEwj60N4JH54SSWZiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=C5Izwnj2RRmKah5xBRTSrdyIMMjxtS7nlh9XRcuOwmd8X/YBi2B0KUdKJ7gv77a4E
	 ZXLt/1Hl3Wh4DeMi1LbBrkBqufAFpu3AKu8rRvhYUNRjKNIatsZOer0vQqVY4jxV4V
	 lHKwoTwv+tB966v0bt0E6v6HORGoP+GspTNZ+rkXoQ5qpD18fwYDXpiQjCf+31jYbn
	 uJJtWhDqQvrtGALkGId5bmBtGkM9+qnd0vwH+TcH9nnCZcqETfOqaRcrY973tcunYf
	 gGbb2PN0V/p02Fx+MUeJ6vYrwOjorjR9davRvzFGNBwjLfHviT2FkUXadIdNhua/3I
	 x0Oy4bSgtRG+g==
Date: Mon, 19 Oct 2026 17:40:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: Re: [PATCH] PCI: sysfs: Reject unaligned resource I/O port accesses
Message-ID: <20261019224015.GA2281064@bhelgaas>
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
In-Reply-To: <20260809045946.15638-1-kartikey406@gmail.com>

On Sun, Aug 09, 2026 at 10:29:46AM +0530, Deepanshu Kartikey wrote:
> pci_resource_io() validates that off+count stays within the BAR's
> range but never checks that the resulting port is aligned to the
> access size. A pwrite64()/pread64() on a resourceN file with an odd
> offset and count=2 or count=4 reaches outw()/outl() with a misaligned
> address. On arm64 this becomes a store/load to a Device-memory
> mapping (PCI_IOBASE + port), which architecturally requires natural
> alignment, causing an alignment fault and kernel oops.
> 
> Reject misaligned accesses before they reach the low-level accessor.
> 
> Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7134530b25073b4ef373
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Applied to pci/sysfs for v7.4, thanks!

Hopefully the last patch for v7.4.

> ---
>  drivers/pci/pci-sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5ec0b245a69b..72f0404a34e9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1175,6 +1175,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  	if (port + count - 1 > pci_resource_end(pdev, bar))
>  		return -EINVAL;
>  
> +	if (!IS_ALIGNED(port, count))
> +		return -EINVAL;
> +
>  	switch (count) {
>  	case 1:
>  		if (write)
> -- 
> 2.43.0
> 

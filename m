Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D5356A12;
	Thu, 10 Sep 2026 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039884; cv=none; b=B3fG9OGYHEA7us5lyNTkwDesaHUsu7zWEWBq9tAkALKuA9pPK8wNcS3MTbTU3guB01HVklyk6AFCxdDRNCenu3VJgnBCgGeEopHB2+w1nOWH+A3irwlodoO/qPQajeKbNJrUR7vZULf0TtImO3yVmLiZQZO1C4Vbqbcpt9Jkr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039884; c=relaxed/simple;
	bh=zU3vzRxNIUcnktzrPzbJWxvzmBDjHsD2XrBZqp7kI6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm5lFmzmso4hUr9zBPJVwascBtVv3etOJOlePlGpPef83CST51aYSthKPcHmm5YYDPKwJiS5rXRfDX9jBRJk4ROIiayt4Zo5XSfodaoHQdbfp23H/FBjZGqB0fiQ7rpHkQ3y3lNNfWIphpVHoBUDvx7ooJ4td+HOAVyXEf/f7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWJWaPd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWJWaPd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7711F000FF;
	Thu, 10 Sep 2026 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039882;
	bh=sp+g2kf4DjcHYNr0fZESaZatEX+25HJxulaJdt99lS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BWJWaPd1d+Zc7JDdTCN9K2rRGLgVrvGxMtotAH/+SmbALwSZp/ZRim4cTj7UolVIP
	 cI5hNqZIXZYV8DrjrK7uSMpS31fcFp/74rpUDEQXh+GsJqkRiys9CwcFff7WdUBghU
	 kn7Xq1rXNzg4AH0thQm3BoFKKY3/V1A5lzGu/b4wTseWQPgZpKMvxA9hUYWH9QS5Oz
	 j2GWXBUsxbcbxM9yteMHkAIFoqnUob0PMfhr0ckrJPyNehFKc5sKCpWZQVzEM1e8eC
	 pADtLQrCDtEWtqM5fgs5d71LN/6qZuVrsMC9AIQ4po+6kY0yweYIffVQbyytB/Ul1w
	 MG5UAOdnUwMrg==
Date: Thu, 10 Sep 2026 13:31:13 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: Re: [PATCH] PCI: sysfs: Reject unaligned resource I/O port accesses
Message-ID: <wmlvf7r5xd6ibcc6kimlqylfkvzgim44n364wmqugrj4tntlrm@mld5ilctx6wa>
References: <20260809045946.15638-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

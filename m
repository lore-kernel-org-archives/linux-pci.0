Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8375C173
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778216092; cv=none; b=IKrJcP/ePfBrDT3tDp0YgfjAjlO1FG/hCvZbCIXjLpsjZDbgNOKQ9+cfCUZMegZnxUOiZ/emA9drxvsO+8JWrwHL4A/om2Obe4Ge5MsInAFuCuK1dahSSppD6zEhqyySzfqPm1zmSJnHYXAsa3StnIKjv+3M+YPoiA1HiH2CODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778216092; c=relaxed/simple;
	bh=fJx0DENx4A5ZQ/uNrVMar/h05GwEuQ8ok/CgO29jCyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ONKbQOje258aHZ+7jpMCJa/z/bqDsOM3OSL3TaGIidtyCL1nunXtztmtgMYJyjRphGhty9lowAskOHfOHdakv4usyv96edaTWrUuSmhu5rRPf8tLMFSdcJxyHZfGQsFjf/9JVGN7aVbZX/QGeps1eJujv1hQURmpcvkEy9Iwf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZltCzfEG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZltCzfEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B72C2BCB0;
	Fri,  8 May 2026 04:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778216092;
	bh=fJx0DENx4A5ZQ/uNrVMar/h05GwEuQ8ok/CgO29jCyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZltCzfEGhA98wnboNguX6yU43Dm3HdfIRbYBPA6K9bI8ojG0NB9BQfVdvv4v8Wb3K
	 WBTgCRP9aa21A1O/5fGbRzNVVyQoOaqVhb78+2sS6LePwRv4WAoxHWeIVNku6+1AsC
	 Xv3F7coAHXEstiKe4C4qIRj/7ZupG2z7uN/qY2FlemW7bSmvobUh7RdSEziyN157uH
	 S3L8RGshtwlaxvRfQNEmTxJu/YZbt6U8OrWQPgvfV9y6xxZplm4RmwIfYSkHF5Mc6r
	 Lzs6Rgj65Na6hOPu1kF6RH7nv2BE7tZeA8BjLcpm8aSJqzG533+FOZrhqkn05RIggF
	 cXpty2/bt6TMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/24] alpha/PCI: Remove WARN from __pci_mmap_fits()
 and __legacy_mmap_fits()
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508043543.217179-16-kwilczynski@kernel.org>
References: <20260508043543.217179-16-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 04:54:51 +0000
Message-Id: <20260508045452.15B72C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `hose` parameter in `__legacy_mmap_fits()` is now unused.
--

commit 7cae102d6c390202438077326b2b816098a36a13
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

alpha/PCI: Remove WARN from __pci_mmap_fits() and __legacy_mmap_fits()

This commit removes the WARN() that triggers when userspace attempts to mmap
beyond the BAR bounds. The mapping is still rejected, but the warning is
suppressed to prevent excessive logging.

> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
> index 8802f955256ea..a8dade7d084bc 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
[ ... ]
> @@ -259,7 +253,7 @@ int pci_create_resource_files(struct pci_dev *pdev)
> =20
>  static int __legacy_mmap_fits(struct pci_controller *hose,
>  			      struct vm_area_struct *vma,
> -			      unsigned long res_size, int sparse)
> +			      unsigned long res_size)

This isn't a bug, but since the WARN() statement that used hose->index was
removed below, is the hose parameter still needed? It appears to be complet=
ely
unused in the function body now.

>  {
>  	unsigned long nr, start, size;
> =20
> @@ -267,13 +261,7 @@ static int __legacy_mmap_fits(struct pci_controller =
*hose,
>  	start =3D vma->vm_pgoff;
>  	size =3D ((res_size - 1) >> PAGE_SHIFT) + 1;
> =20
> -	if (start < size && size - start >=3D nr)
> -		return 1;
> -	WARN(1, "process \"%s\" tried to map%s 0x%08lx-0x%08lx on hose %d "
> -		"(size 0x%08lx)\n",
> -		current->comm, sparse ? " sparse" : "", start, start + nr,
> -		hose->index, size);
> -	return 0;
> +	return start < size && size - start >=3D nr;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508043543.2171=
79-1-kwilczynski@kernel.org?part=3D15

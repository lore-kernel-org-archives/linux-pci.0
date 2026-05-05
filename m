Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67014335BDB
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012789; cv=none; b=pxxWv3zOZofNvaAcV+AYS4eZajIjCN08WEXRDFGMXAVGv7zqPfYC/2DLIxczE9OdpjfkqKl7h/aQMuXYgntZTVu7veRKsvL2LuVxWHt50ACIDuSMIjbY3W24TkE6vBeZaamEuK+HyCEIbfNCp43nEHW9uEK7HaxqlmI8uXmhn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012789; c=relaxed/simple;
	bh=CQZeqQJm0IT4vT4vf9BZ4VhHtWv6+YgC76t9f/5ATjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rK85VJaR0ySx23jHRGqTFBDE7nWuVqwHPsWib/ezdfMPMMRF0lNuP4zoBs8GsMdyLGkE3LjHRgkGLTnMT9Pmx1DelaVxTyPrhkNrMv0zH3xZEESyVzW1liSOIfBGJJ03QpxWCop/sKWzmlCK0kurllYogFWqckKcBzBv/JFDHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoWunV7e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoWunV7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352A9C2BCB4;
	Tue,  5 May 2026 20:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778012789;
	bh=CQZeqQJm0IT4vT4vf9BZ4VhHtWv6+YgC76t9f/5ATjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KoWunV7epQvN2uJaEMF6cw/jhowQ1rs450X7/ITsVzd5pF7HbH+5nfKkKq6pxthq+
	 Q0N0JY7pk1wRbvCa+qBScp9KEn20Puj3slyTYWnI5wzndOtNikjLdOIPopixGSpifN
	 MqP3L5pMTWJN/Is5EbDbNl6uAuKhEs6FSZU487wOc/J+71boMg+rRxadBujj0UWen5
	 zG8HOUbzldRPEI/4zKODmXOlO+d5ctIHY5flBRdtSP6gOTMY2aEKqh3AyuQeGFW+yb
	 zG5sNtEJ86J4xEneDLwBD4ZH9z2jlVdf55EBFl0rrN+YFaoYCaO9x6SN+52fzwJuo7
	 jdzh3y2PnuMsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 01/11] PCI/AER: Introduce AER-CXL Kfifo
Reply-To: sashiko@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505173029.2718246-2-terry.bowman@amd.com>
References: <20260505173029.2718246-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 20:26:28 +0000
Message-Id: <20260505202629.352A9C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Early exit in `for_each_cxl_proto_err()` strands remaining kfifo i=
tems and leaks `pci_dev` references.
--

commit fc9ac9cc58a6a77c19c9c8d750f3b41f9490529e
Author: Terry Bowman <terry.bowman@amd.com>

PCI/AER: Introduce AER-CXL Kfifo

This commit introduces a kfifo work queue to be used by the AER and CXL
drivers for CXL protocol error handling. It adds registration functions and
a cxl_forward_error() function to queue the errors with their associated
PCI device.

> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 0000000000000..c0fea2c2b9bc6
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c

[ ... ]

> +int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			   cxl_proto_err_fn_t fn)
> +{
> +	int rc;
> +
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
> +		rc =3D fn(wd);
> +		pci_dev_put(wd->pdev);
> +		if (rc)
> +			return rc;

If the consumer callback fn() returns an error, does this early return
strand the remaining items in the kfifo?

Because cxl_forward_error() takes a pci_dev reference for each enqueued
item, it looks like these stranded items might leak their pci_dev references
and prevent clean unbinding or hot-unplug until a new error triggers the
queue again.

> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505173029.2718=
246-1-terry.bowman@amd.com?part=3D1

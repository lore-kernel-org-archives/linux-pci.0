Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204F32B118
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619923; cv=none; b=fJdO1E3UBCrl8VPTx1NJdBNrwDf4+9APtf+LNZS0OrwbLyFzn6abd1UKMC5zCe98tOZPN7x0dsqAWCZpRo9v/SXgnM3txxOfNsyju0a6Sis3kVRNRlmN146tVL+ZMVX9a8qsebvahBk+KqlykNTPiY26+i7JVV4iK/p74yiFA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619923; c=relaxed/simple;
	bh=NzkzCTZIST7RkkvwMmT1qn404iB4B7vBzccn7DTSrDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GhhhtSwqt5W8Cz8gyymrdriSA8m3EOWHI4XwQx3FN3oAoHmbK4baHS11lZKmz+Gvb4ZKFetlBhT5v/lWPspt11WaQSUsXvARNvarkoS6hSLT4ESqKZHy5sBfpS2OQ40JWBb1ym5bAVVroCx9zXELB4szMhHUSvciAPHICYNwx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMQnJ6rW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMQnJ6rW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FAA1F000E9;
	Tue, 16 Jun 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781619922;
	bh=NqPeOtsXZ9QGLrfcwL7F2y66WijnlPIQv0xc0ZHIgeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bMQnJ6rWz39qW+SAdqAkBQzg8D17ZFZ/Xix9DWTVYgOfVWblf1QYRzK90ttv4Y5oU
	 nINMpjHY+WufuDr1RNQ3Eyp5/eC9I/RG/C5C51mKxKGPQcYIVVeLE+WFyCADQ87kHO
	 iKJ76KwjwwFs7RfgqkKRFAKplKAPNH6XC7nGVkXbugucYi93CLWFl1Kwf93uu7LC3u
	 vWLbwcvuHbke5Wib+EwttLp3qcq8DdzVSGzVxJHoIz33dvQ14/YIXYFOMilz4hQH7P
	 iR6LRnO35+Blyn80+Pdu1dcjfRaB4/RbfoOFuBYLF9crIe3CciG0gFq3fY1zLmucSu
	 DQ90kd0m4L3CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/PTM: fix refcount leak in pci_enable_ptm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260616141733.1688264-1-vulab@iscas.ac.cn>
References: <20260616141733.1688264-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 14:25:21 +0000
Message-Id: <20260616142521.B3FAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces a strict compilation failure because the varia=
ble `parent` is referenced outside of its declared scope in the error path.

Pre-existing issues:
- [High] Concurrent calls to `pci_enable_ptm()` can lead to a lockless TOCT=
OU race condition where a caller incorrectly assumes PTM is enabled before =
the hardware initialization completes.
--

commit 98f3a56b29bf607b6f9174e20f676b1549c2aaaa
Author: Wentao Liang <vulab@iscas.ac.cn>

PCI/PTM: fix refcount leak in pci_enable_ptm()

This commit addresses a refcount leak in pci_enable_ptm() when the function
fails to enable PTM on a child device. It does this by adding a call to
pci_disable_ptm() for the parent device in the error path.

Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index a41ffd1914de4..01f6c7da7ca91 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -201,6 +201,8 @@ int pci_enable_ptm(struct pci_dev *dev)
> =20
>  	rc =3D __pci_enable_ptm(dev);

[Severity: High]
This is a pre-existing issue, but can the lockless check just above this
call lead to a race condition?

Looking at pci_enable_ptm(), the counter check bypasses hardware
configuration locklessly:

        if (atomic_inc_return(&dev->ptm_enable_cnt) > 1)
                return 0;
       =20
        rc =3D __pci_enable_ptm(dev);

If multiple downstream devices probe concurrently, two threads might call
pci_enable_ptm() on their shared parent simultaneously. If the second thread
increments the counter to 2 and returns immediately, it will assume the
parent is fully initialized. It could then proceed to configure the child
before the first thread finishes hardware configuration in __pci_enable_ptm=
(),
potentially causing Unsupported Request errors or bus resets.

>  	if (rc) {
> +		if (!dev->ptm_root)
> +			pci_disable_ptm(parent);

[Severity: Low]
Does this cause a build failure? The variable parent is referenced here,
but looking at pci_enable_ptm(), parent is declared locally inside an earli=
er
if block:

        if (!dev->ptm_root) {
                struct pci_dev *parent;

                parent =3D pci_upstream_ptm(dev);
                ...
        }

This makes parent out of scope in this error path, which will break the bui=
ld.

>  		atomic_dec(&dev->ptm_enable_cnt);
>  		return rc;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616141733.1688=
264-1-vulab@iscas.ac.cn?part=3D1

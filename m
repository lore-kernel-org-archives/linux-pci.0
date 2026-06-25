Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE97364028
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368340; cv=none; b=h1oxFJMzI5Bnr8Pvy/6xophK9uEAC7tvg2SufBojuchwrytSRItqAzYK9gMSRoYi82C9OhyGqM3q/uDdmdZMaqg3BbYdTiAylZhQF1zrN2CEllh/YDsTPvgO81382PZ8X3aEULh7jcf+7kwGdDCLyk7UEbK1UUwYVLPnQ7GnQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368340; c=relaxed/simple;
	bh=OrMgCUR4KY4W2mFI7KWiOL10jvbRZaUgiGmI2sVIEhQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZXXRmmFsoWi1XzYpLbcLereA3bIvdTRMFNTCsXJBWISn/aMuD30K58COkQ4EoCkPp+oVxHm3PVFxyc3WbN7O5USq9N9ux7HzsnZd4F4h+KTLfy7yoshWxl+liKpbE2bku2jvC8HNOLjD16LeXsOJgU/DrIRnDJWv8X42ardEQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAL7UOvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAL7UOvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BA41F000E9;
	Thu, 25 Jun 2026 06:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782368339;
	bh=Cneff/fAqbtA3Ngn0HuxuRDm4XzjC2kuffZPoJ9T58w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAL7UOvF/fEyx+gyo/ryL1AiF4fgpccHhktpZSKlvnjLtsZP+ZhTkEJjKQBcorReF
	 mrZGBSFDSwGT1adJr/bHmgxTjZPNov6+F/tqIu4ijP+PY34RXIObT7ru3D31Mj/P34
	 zV907MBHBgPA0W+cyr7MDvu+FUd+mm3ibXJKm2wHHpznzC1WLIKb+HkI8ZQnpNUfKd
	 MnEp/d6oxIQ9wBwGpzFMGsn2vrA0O18/+hDfi9vypNu/OPYHvolY2oiNbTVSZU4QrZ
	 9j+llcVIfDt5e+/Fayn7X6zRwHp4AUw+uo63aEBkw0G8ZGH/MInqEc9D+xklo/BEiY
	 /nln5arB74ajQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] PCI: vmd: Convert bus and busn_start to an array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260625082940.1290740-7-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
 <20260625082940.1290740-7-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 06:18:58 +0000
Message-Id: <20260625061859.12BA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failing to call pci_free_irq_vectors() in error paths and driver r=
emoval leaks IRQ resources.
- [High] SRCU structures are destroyed before IRQ vectors are explicitly di=
sabled, risking a Use-After-Free on spurious interrupts.
--

commit 5baf3e06c174f82b0781954bbca2834e43441922
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Convert bus and busn_start to an array

Convert bus and busn_start from scalar to an array to support multiple VMD
buses in the future. No functional changes.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9ff82a24e859c..2bfc16875d912 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -1114,9 +1122,9 @@ static void vmd_remove(struct pci_dev *dev)
>  {
>  	struct vmd_dev *vmd =3D pci_get_drvdata(dev);
> =20
> -	pci_stop_root_bus(vmd->bus);
> +	pci_stop_root_bus(vmd->bus[VMD_BUS_0]);
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
> -	pci_remove_root_bus(vmd->bus);
> +	pci_remove_root_bus(vmd->bus[VMD_BUS_0]);

[Severity: High]
This is a pre-existing issue, but does device removal or probe failure leak
IRQ resources?

In vmd_alloc_irqs(), vectors are successfully allocated:

vmd->msix_count =3D pci_alloc_irq_vectors(dev, vmd->first_vec + 1,
                                        vmd->msix_count, PCI_IRQ_MSIX);

However, they do not appear to be explicitly freed in error paths or upon
driver removal in vmd_remove(). The PCI subsystem guidelines state that eve=
ry
error path or removal after successful allocation must call
pci_free_irq_vectors() to prevent resource leaks and potential exhaustion of
system IRQ capacity.

[Severity: High]
This is also a pre-existing issue, but is there a use-after-free risk during
teardown if a spurious interrupt fires?

In vmd_remove(), the SRCU structures are destroyed via vmd_cleanup_srcu().
However, the IRQ handlers are managed by devres (via devm_request_irq) and
will only be disabled after vmd_remove() returns.

If a spurious or shared interrupt fires after the SRCU structures are
destroyed but before devres cleanup completes, the handler will execute
and access the destroyed struct:

vmd_irq() {
    ...
    idx =3D srcu_read_lock(&irqs->srcu);
}

Could this race condition lead to memory corruption or a crash? Should the
interrupts be explicitly disabled before destroying the SRCU structures?

>  	/* CFGBAR is static, does not require releasing memory */
>  	kfree(vmd->resources[VMD_RES_MBAR_1].name);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625082940.1290=
740-1-szymon.durawa@linux.intel.com?part=3D6

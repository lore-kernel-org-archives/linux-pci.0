Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18E54654
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015842; cv=none; b=PBnoxa02Ti0pl9621eBpPQa6mBRTIaKrQfV9oCqND2QmoPociHMagPXIeBvvKODe1ub6yFHokZS6a46fvh9xx9iOlJhwPUl4IXwu1QSJC6HOSx87fokEToGBP6KNi6AWn2/ZgGWFYp1Axed3xYx+pQiOpUgvyrFEJHJkEfUPbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015842; c=relaxed/simple;
	bh=09TV64aT53CBvqXv7ZN33RPVZjLa8iVFbVwTfw7dzy0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i8RxVelc7nllA0/zJnQGNLoZyD5pX5CS2CkXjiW9s+/EvFEGhauD2rGEuWgbNctMiAwf+bpcs3vMXIdUeCEq0i2xkT9QCtLhry8x/Piya05j6oukbAo9DQ9BCN8aC9Jj+e/AKFvMYW8cq1HhkGtDlpADRU23eyQlWYShRqTSA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgD0COQT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgD0COQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ACFC2BCB4;
	Tue,  5 May 2026 21:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778015842;
	bh=09TV64aT53CBvqXv7ZN33RPVZjLa8iVFbVwTfw7dzy0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XgD0COQTx8d5NgSfBy7fLNfRfnyoLL0f0fxUpNUEDNdhsgsegCnKHTixeNcqY6z9V
	 I4zRNeFD9epTqfsTerBif2hOLyh8QJxyXaW1cWkkoi4PYQwZoHbG08bPq+5gDwKUk3
	 mz0oM+TLHbWc6xPvGZBzybl7pFixrok1x+vcMpMYXGqcD6iYdk/NQ3MfDgwFbTIbvL
	 5wUpx9ntA0s42bpb1vTDJkBeTN37GOWs3W2rkldC5kblG0jXRVCLOGr9r0rYjBkThm
	 B9tdAvMZzwsdJ+vdBA1lbFHff2IsXFWFNY1Gpz0Z6ZJQLnUToWhQNEOasCpngWb+Kz
	 XT44v1v5TGbgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI/IOV: Restore initial VF ReBAR sizes on PF
 release
Reply-To: sashiko@lists.linux.dev
To: "Marcin Bernatowicz" <marcin.bernatowicz@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505170010.3414074-4-marcin.bernatowicz@linux.intel.com>
References: <20260505170010.3414074-4-marcin.bernatowicz@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 21:17:21 +0000
Message-Id: <20260505211722.09ACFC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unsafe hardware configuration writes during kobject .release callb=
ack and incorrect lifecycle hook.
--

commit b1af88a89dd13b3ede54e65628a75befe1b43cf4
Author: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>

PCI/IOV: Restore initial VF ReBAR sizes on PF release

This commit attempts to restore the per-VF BAR sizes to their initial
values when sriov_release() is called. It aims to handle the case where
VF BARs were resized but SR-IOV was not enabled when the PF driver is
unbound.

>     sriov_disable() and sriov_enable() error paths restore the per-VF BAR
>     sizes saved at probe time. They do not cover the case where the PF
>     driver is unbound while VF BARs were resized but SR-IOV was never
>     enabled (or was already disabled).
>    =20
>     On the next bind, sriov_init() re-reads the SR-IOV capability and
>     captures the current (inflated) BAR registers as the new initial sizes
>     in iov->barsz_orig[]. The restore logic becomes a no-op for that boot
>     and the kernel may reserve MMIO for the inflated VF aperture multipli=
ed
>     by TotalVFs.

Is sriov_release() the correct place for this restoration?

The commit message states it covers when the PF driver is unbound and menti=
ons
the next bind, but sriov_release() is called by pci_release_dev() which is
the kobject .release callback.

This executes when the pci_dev reference count drops to 0 (such as during
device destruction), not during a driver unbind via sysfs. Furthermore,
sriov_init() is called during device enumeration, not driver bind.

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index a05c1be388d2f..794f956910886 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -969,6 +969,8 @@ static void sriov_release(struct pci_dev *dev)
>  {
>  	BUG_ON(dev->sriov->num_VFs);
> =20
> +	sriov_restore_vf_rebar_initial_sizes(dev);

Is it safe to access the hardware configuration space here?

Since sriov_release() executes as a .release callback, it can run at an
arbitrary time, such as being delayed indefinitely by an open sysfs file
descriptor.

If the device has been surprise-removed or placed in D3cold (suspended), wo=
n't
PCIe config space reads return ~0 (0xFFFF)?

In that case, pci_iov_is_memory_decoding_enabled() would evaluate
0xFFFF & PCI_SRIOV_CTRL_MSE as true, causing pci_iov_vf_bar_set_size() to
return -EBUSY.

This could trigger a pci_warn() in sriov_restore_vf_rebar_initial_sizes() f=
or
every resized VF BAR, spamming the kernel log with false-positive warnings,=
 and
potentially causing PCIe Unsupported Requests or bus errors.

> +
>  	if (dev !=3D dev->sriov->dev)
>  		pci_dev_put(dev->sriov->dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505170010.3414=
074-1-marcin.bernatowicz@linux.intel.com?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7245BE3;
	Thu, 18 Jun 2026 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803248; cv=none; b=EpKQ+HpqhTMDntI3etK7Oz1DetNpBC0dyjenu7VdR1gyw+vuSx8w+ylJRXR1Dv7VXhWNThB8AmOzJUXCOWx2ZrRiopyVx73xgkeIT4vVunhVgAY/xoYC2vcwuHufrV3xtix20s1rRWdFibXhCXO8nFfgyjD0i7MCLRsK6s0U8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803248; c=relaxed/simple;
	bh=TsUXD5p6U8oIvncABKXGmgWde+y60xdQXHMoTHTMARo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YF49/zcEE3U3ijyor2CCc5yRZ5N8WryXz3w5CXVjXEMDkqFO9zkzDT3jX0IDmih8ZKn6aSExTa9YdFVQWFhiP+TosuSfZ4nK/w5h9HgTRYCYfMRpC26IWocFGYsklpelL3GtDK3uHjfqWnr7FytE2ThpA6keVCCnp2aC8m1iEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N18nluRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N18nluRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535241F000E9;
	Thu, 18 Jun 2026 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781803247;
	bh=PFdKfR3A0il21s3EGvhymrAAeETR4xjznPYNJB5Nj3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N18nluRdD0DM6mi9Z9AZWy+9wo2G0LZ/EL5uYoiik9LRIVQRyldrm9gawBr0GDB1O
	 mC4AZuIKA29TBHUNkIk+AXucyMWe1HcahPj5qacJmW6SmUe1wwOrDOSvcqjqLjPbH9
	 U5z0NoSxMJ6dDydZNvzVS7sRyVfQpQix/fPPJbOqcxNB+WB60vvPFG0i8EUsSsfSJL
	 OpCleAKiYMP1coHIH+DFyS6+8ZK/ivDm3d9RMy8SITcRevi+ZXuNbG/EMLn1E5+uHk
	 BDacktyPUCWrG+mFh3SPasaLcOAThfKr9i/ip7s+Lbtf+P63SDmzamn7EtXHZIdZbM
	 eynpl+JS7pamQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/2] PCI/CXL: Enable usage of RDPAS to shortcut
 error device discovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260618170723.2010490-3-dave.jiang@intel.com>
References: <20260618170723.2010490-1-dave.jiang@intel.com>
 <20260618170723.2010490-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 17:20:46 +0000
Message-Id: <20260618172047.535241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect fall-through logic in `cxl_rch_get_err_src_id()` extract=
s and returns the wrong error source ID for correctable errors.
- [High] The RDPAS list is built concurrently without locking and traversed=
 locklessly in the AER error handler, exposing readers to partially built l=
ists or list corruption.
- [Low] The function `cxl_forward_error` is invoked but is neither declared=
 nor defined anywhere in the kernel.
--

commit e9dabb60b82f98b2295a3d242546827da2279bbf
Author: Dave Jiang <dave.jiang@intel.com>

PCI/CXL: Enable usage of RDPAS to shortcut error device discovery

This commit changes the CXL RCH error handler to probe the RCRB first to
see if the error device can be discovered quickly, falling back to iterating
through RCiEPs if needed. It introduces RDPAS parsing to directly locate the
RCRB and determine the BDF of the error device.

diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c

[ ... ]

> +static u16 cxl_rch_get_err_src_id(u64 rcrb_base, struct aer_err_info *in=
fo)
> +{
> +	u32 root_status, err_src;

[ ... ]

> +	if (info->severity =3D=3D AER_CORRECTABLE &&
> +	    root_status & PCI_ERR_ROOT_COR_RCV)
> +		return FIELD_GET(GENMASK(15, 0), err_src);
> +
> +	/* Assume at this point the info->severity points to UNCOR */
> +	if (root_status & PCI_ERR_ROOT_UNCOR_RCV)
> +		return FIELD_GET(GENMASK(31, 16), err_src);
> +
> +	return 0;
> +}

[Severity: High]
If this is handling a correctable error but PCI_ERR_ROOT_COR_RCV is not set,
is it intentional to fall through to the uncorrectable error check?

If an uncorrectable error is concurrently logged in the RCRB status, this
would return the source ID of the uncorrectable error instead of 0, which
might misroute the correctable error notification.

Should these severity checks be mutually exclusive using an else block?

> +static bool cxl_rch_forward_error_by_dsp(struct pci_dev *rcec, u64 rcrb_=
base,
> +					 struct aer_err_info *info)
> +{

[ ... ]

> +	if (!is_cxl_mem_dev(pdev) || !cxl_error_is_native(pdev))
> +		return false;
> +
> +	cxl_forward_error(pdev, info);

[Severity: Low]
Does cxl_forward_error() exist in the kernel tree?

I'm having trouble finding its declaration or definition in the codebase,
which seems like it might cause an implicit function declaration build fail=
ure.

> +	return true;
> +}
> +
> +static bool cxl_rch_handled_error_by_rdpas(struct pci_dev *rcec,
> +					   struct aer_err_info *info)
> +{
> +	struct cxl_rdpas_rcec *rdpas_rcec;
> +	struct cxl_rdpas_entry *entry;
> +	bool handled =3D false;
> +
> +	rdpas_rcec =3D cxl_get_rdpas_by_rcec(rcec);
> +	if (!rdpas_rcec)
> +		return false;
> +
> +	/*
> +	 * The RCEC aggregates multiple downstream ports. Each CXL.io
> +	 * downstream port associated with this RCEC exposes the RCRB at its
> +	 * base address; walk them all and forward the error from every port
> +	 * that reports a valid error source.
> +	 */
> +	list_for_each_entry(entry, &rdpas_rcec->ports, list) {

[Severity: High]
Could this lockless list traversal race with the initialization in
__cxl_parse_rdpas()?

If an asynchronous AER hardware event triggers cxl_rch_handle_error() while
__cxl_parse_rdpas() is still running, it seems we might walk rdpas_rcec->po=
rts
using list_for_each_entry() while it is concurrently being mutated by
list_add_tail().

Since the rdpas_rcec container is published to the cxl_rdpas xarray before
the list is fully populated, would this expose readers to partially built
lists or use-after-free conditions? Additionally, would the lockless check
of rdpas_parsed in cxl_rdpas_init() allow concurrent probes to race and
corrupt the list?

> +		if (entry->protocol !=3D ACPI_CEDT_RDPAS_PROTOCOL_IO)
> +			continue;
> +
> +		if (cxl_rch_forward_error_by_dsp(rcec, entry->address, info))
> +			handled =3D true;
> +	}
> +
> +	return handled;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618170723.2010=
490-1-dave.jiang@intel.com?part=3D2

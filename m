Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4B2F745E
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778024080; cv=none; b=bXpf8p86GrSsPa1ouLcTBvSKBxkzsHF5MiBF4fur9yEFQ0iy4YB8opLsvnH9SQfJzL8eweCvkaKs4pkhxj2me3dKMJVoUH6bZSym9rtRwNUyzVIzikdiCICQMQOIEHVICyiQoWuAoC9Goh3ah+JVFqt1/VZkQHecGvjC3okFNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778024080; c=relaxed/simple;
	bh=RtlSpmKfd1Hwh1b0C6s4LGQ86riFzHAxJtEJp5s18rk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rXzVYj5qSCDi0GZG9A+zP20n9EJt5wYIRoNZRcGAxUf6BGAvVbuoMAXdEbkOE3eyFko5AKVc9Saa5oIwqBOD5tmnQVHlLes7Xns/1esfC77d8M+tLEEnTizbEOmLk7G19GJ4wpYXQ2shYYwzO0pVS8C/jXwejuyzH2iVTdWRajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hdi1yPVU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hdi1yPVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22ABC2BCB4;
	Tue,  5 May 2026 23:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778024079;
	bh=RtlSpmKfd1Hwh1b0C6s4LGQ86riFzHAxJtEJp5s18rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Hdi1yPVUIb8F4FKc2as7fwB+qzPwQ5x7igdTGCHWMbMQS4BxxzooTfohtE90AraZA
	 Bh8uajEZXAaySvzar9ykR6h8iQJxG12kuZUaWns7MH3Hwn4MwME1zICy6AvKjTI7Vv
	 hMw2gZg3Ds5xEoRE8HB5jrIZqj1wezA0r0VxW7QAPuIk2z+REy2kQKfQDHoIvjcUNk
	 4vpMOAA7dxnD/uxEjwiN3uU4VwPWh1tmXkvn6fRukSLvaV0XTDD5yFkyxHJNYUy/5g
	 6lnLKBY9Es5D1AfVcdZdlQ2NQmDEYokTa9gZZ7raOEh0/8dnmUL3Ynz/sYdaUvvPUl
	 bZyRW33JAfSnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 07/11] PCI/CXL: Add RCH support to CXL handlers
Reply-To: sashiko@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505173029.2718246-8-terry.bowman@amd.com>
References: <20260505173029.2718246-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 23:34:39 +0000
Message-Id: <20260505233439.B22ABC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Uncorrectable protocol errors on RCH Downstream Ports are swallowe=
d without triggering the intended panic, resulting in silent data corruptio=
n.
- [High] cxl_forward_error() corrupts the RCD Endpoint's AER state and pote=
ntially BAR0 by misapplying the RCEC's AER Correctable Status mask.
- [High] Forwarding RCH protocol errors to the asynchronous CXL kfifo intro=
duces a race condition with PCIe AER recovery, leading to concurrent MMIO a=
ccesses during device reset.
- [High] Direct uncorrectable CXL protocol errors from RCDs (RC_END) bypass=
 the unified AER-CXL kfifo error flow and fail to panic as intended.
--

commit 71e85613fcf97cc6374754fbf172de84d9fe7371
Author: Terry Bowman <terry.bowman@amd.com>

PCI/CXL: Add RCH support to CXL handlers

This commit folds Restricted CXL Host (RCH) error handling into the new CXL
Port error handling flow. RCH protocol errors are now forwarded through the
AER-CXL kfifo, and uncorrectable errors are intended to panic via
cxl_do_recovery().

> Behavior change: an RCD uncorrectable CXL RAS error now panics via
> cxl_do_recovery(). Before this patch the RCH path returned
> PCI_ERS_RESULT_NEED_RESET via cxl_pci's err_handler. After this patch
> the same condition panics.

Do direct uncorrectable CXL protocol errors from RCDs (RC_END) bypass the
unified AER-CXL kfifo error flow and fail to panic as intended?

When an RCD (PCI_EXP_TYPE_RC_END) signals an error directly,
handle_error_source() invokes is_cxl_error(dev, info). However,
is_cxl_error() checks the PCIe type but only matches PCI_EXP_TYPE_ENDPOINT,
completely omitting PCI_EXP_TYPE_RC_END.

Consequently, is_cxl_error() returns false, bypassing cxl_forward_error()
and the kfifo. The error falls back to pci_aer_handle_error(), which
triggers the legacy cxl_error_detected() handler.

The legacy handler returns PCI_ERS_RESULT_NEED_RESET rather than triggering
cxl_do_recovery() to panic, violating the stated safety policy for fatal
cachemem errors.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 0a552d5a236e7..1f1dd20623f6d 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
[ ... ]
> @@ -329,6 +324,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>  static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port=
 *port,
>  				   struct cxl_dport *dport, int severity)
>  {
> +	/*
> +	 * An RC_END device is an RCD (Restricted CXL Device). Its AER
> +	 * interrupt is shared with the RCH Downstream Port, so handle RCH
> +	 * Downstream Port protocol errors first before processing the RCD's
> +	 * own errors. See CXL spec r3.1 s12.2.
> +	 */
> +	if (pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_RC_END)
> +		cxl_handle_rdport_errors(pdev);
> +

Are uncorrectable protocol errors on RCH Downstream Ports swallowed here
without triggering the intended panic?

cxl_handle_rdport_errors() correctly logs the error via cxl_handle_ras(),
which returns true for uncorrectable errors, but the return value is ignore=
d.
Execution then proceeds unconditionally to cxl_do_recovery():

cxl_handle_proto_error() {
    ...
    if (pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_RC_END)
        cxl_handle_rdport_errors(pdev);
   =20
    if (severity =3D=3D AER_CORRECTABLE) {
        ...
    } else {
        cxl_do_recovery(pdev, port, dport);
    }
}

Because dport evaluates to NULL for RCDs in this context, cxl_do_recovery()
checks only the RCD Endpoint's RAS capability. If the uncorrectable error
occurred exclusively in the RCH Downstream Port, cxl_do_recovery() observes
the uncorrectable error flag as false and silently returns without panickin=
g.

Could this allow the system to continue using corrupted CXL.cachemem traffi=
c?

> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rc=
h.c
> index e471eefec9c40..83142eac0cabf 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
[ ... ]
> @@ -37,26 +37,11 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  {
>  	struct aer_err_info *info =3D (struct aer_err_info *)data;
> =20
>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>  		return 0;
> =20
> -	guard(device)(&dev->dev);
> -
> -	err_handler =3D dev->driver ? dev->driver->err_handler : NULL;
> -	if (!err_handler)
> -		return 0;
> -
> -	if (info->severity =3D=3D AER_CORRECTABLE) {
> -		if (err_handler->cor_error_detected)
> -			err_handler->cor_error_detected(dev);
> -	} else if (err_handler->error_detected) {
> -		if (info->severity =3D=3D AER_NONFATAL)
> -			err_handler->error_detected(dev, pci_channel_io_normal);
> -		else if (info->severity =3D=3D AER_FATAL)
> -			err_handler->error_detected(dev, pci_channel_io_frozen);
> -	}
> +	cxl_forward_error(dev, info);
>  	return 0;
>  }

Does cxl_forward_error() corrupt the RCD Endpoint's AER state and potential=
ly
BAR0 by misapplying the RCEC's AER Correctable Status mask?

When an RCH Downstream Port signals an error, it is logged as an internal
error by the RCEC. This code iterates over the associated RCD Endpoints and
passes the RCD device (dev) along with the RCEC's error record (info) to
cxl_forward_error().

For correctable errors, cxl_forward_error() executes:

    pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_STATUS, info->=
status);

This writes the RCEC's error bitmask into the RCD's Write-1-to-Clear (W1C)
AER capability register, which will silently clear unrelated pending
correctable errors on the RCD.

Additionally, if the RCD lacks a native PCIe AER capability (pdev->aer_cap
is 0), the write targets offset 0x10 (BAR0), which might silently corrupt t=
he
device's MMIO configuration.


Does forwarding RCH protocol errors to the asynchronous CXL kfifo introduce=
 a
race condition with PCIe AER recovery?

Before this patch, cxl_rch_handle_error_iter() synchronously called the RCD
driver's error handler before the AER driver proceeded with recovery. This
patch delegates the handling to cxl_forward_error(), which queues a work it=
em
and returns immediately.

Because is_cxl_error() evaluates to false for the RCEC (PCI_EXP_TYPE_RC_EC),
the AER driver proceeds directly to pci_aer_handle_error(), invoking
pcie_do_recovery() and issuing resets.

Concurrently, the asynchronous work queues wake up and access the RCH
Downstream Port's AER and RAS MMIO capabilities. Accessing MMIO regions whi=
le
the device or its parent is actively undergoing reset can trigger Master
Aborts, return ~0 data, or freeze the system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505173029.2718=
246-1-terry.bowman@amd.com?part=3D7

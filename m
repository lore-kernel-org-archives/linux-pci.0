Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F935291864
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015274; cv=none; b=h9S1qWVzbQ5u0mI95g4erYRJ3c0dL9GEnzFLRXihVmJi9bAGNQ1o2/AjXNOuHCEIItBkB0k9HdlbbzALy0TQCRfc0V3UAtRZXenpxGL1fc9RIW80D7R9AUVK2WcOWJfHUUW1hBDzWmIltJnhqpSPMXWyKLCvpu5kEXbao4zKDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015274; c=relaxed/simple;
	bh=Mu5QqxyqVGswjgV1q0Kxf4rbENVMtQfqfy3dr4PFfUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fgh4ehp5lMX17VgUbl1gnmcNyjJAzHurkr05SckEpSmIq5gob6a3BoCVhCrnUxAVRzp/vzMdz6EAIzLrQ1uK4TBkjvbuj4s8XxfkNyYy6Wc4GPDh37xxkSzu8ZwZk94o2BpVsEXHfhzYU9R4XQy2UPp68/ksxr7sG3P76rXZGgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1k08Uy6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1k08Uy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B8FC2BCB4;
	Tue,  5 May 2026 21:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778015273;
	bh=Mu5QqxyqVGswjgV1q0Kxf4rbENVMtQfqfy3dr4PFfUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q1k08Uy6PnaulxxSgI5Jjsrq8tiK52wYGSuO51FV7x8VJ6q7+ZRet4n6n8pDDf8lI
	 nMUiqalG5eKsB68qj9ZI8Fgg4GZjJ595WihDA9PCUobobPDL6bv/h4PEdE6bxm+PoE
	 wczCUvClfvWJ7mvGBJhRSvUhLZ3srpFgpYlhvUN99kwoDIvImKXVjHgt8cojaBx5q+
	 lw31pjS3/Tao34So19feGKblT7F+PhKrzCosicSVYzilwrHzs6Deu2SpMZtZg+wjyc
	 YDkjjw8h5RCzSuCiokS5M3LpW2jl7FC6444rWp0k7TuQYn3wmd+QvnKWyIk2jOqbFI
	 heEnMxjj+Cffw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 02/11] cxl/ras: Unify Endpoint and Port AER trace
 events
Reply-To: sashiko@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505173029.2718246-3-terry.bowman@amd.com>
References: <20260505173029.2718246-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 21:07:53 +0000
Message-Id: <20260505210753.B9B8FC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] ABI breakage for user-space RAS monitoring tools.
- [Critical] Massive kernel stack out-of-bounds read (Information Leak) in =
trace_cxl_aer_uncorrectable_error.
- [High] Unconditional PCI configuration space reads via pci_get_dsn() on p=
otentially frozen links.
- [High] Out-of-bounds MMIO read in header_log_copy() causing potential sys=
tem crash.
--

commit 7ac043ff49acf52a4133043e3ef651a4e11ba73f
Author: Dan Williams <djbw@kernel.org>

cxl/ras: Unify Endpoint and Port AER trace events

This commit unifies the trace events for CXL Endpoint and Port devices on
both the CPER and native AER paths. It generalizes the correctable and
uncorrectable error events to use a common device and serial number format.
It also renames the memdev field to device to support all CXL device types.

Link: https://lore.kernel.org/linux-cxl/69cb2d5ba3111_178904100b7@dwillia2-=
mobl4.notmuch/

>     **WARNING: ABI BREAK**
>     Rename the trace event field "memdev" to "device" so all CXL device t=
ypes
>     (Ports and Endpoints) can be reported under a common field name. Note=
 this
>     is an ABI break for userspace tools that key off the old "memdev" fie=
ld.
>     Specifically, rasdaemon's ras-cxl-handler.c looks up "memdev" and bai=
ls on
>     NULL, so an unmodified rasdaemon will drop every CXL CE/UCE event onc=
e this
>     kernel ships. A rasdaemon update is needed in a separate series.

Does renaming this trace event field violate the stable ABI policy for
trace events?

Since unmodified system monitoring utilities like rasdaemon will drop
these memory errors after this change, should a backward-compatible approach
be used, such as retaining the memdev field or adding a new event without
deleting the old one?

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 006c6ffc2f567..d7081caaf5d3f 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -28,20 +28,24 @@ static void cxl_cper_trace_uncorr_port_prot_err(struc=
t pci_dev *pdev,
>  	else
>  		fe =3D status;
> =20
> -	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
> -					       ras_cap.header_log);
> +	trace_cxl_aer_uncorrectable_error(&pdev->dev, status, fe,
> +					  ras_cap.header_log,
> +					  pci_get_dsn(pdev));
>  }

Can passing ras_cap.header_log here cause an out-of-bounds stack read?

The ras_cap.header_log field is an array of 16 u32 elements (64 bytes).
However, inside the trace_cxl_aer_uncorrectable_error() fast assign block,
it copies CXL_HEADERLOG_SIZE (512 bytes):

	TP_fast_assign(
		...
		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
	)

Will this read 448 bytes past the end of the header_log array and leak
adjacent uninitialized kernel stack data into the trace ring buffer, making
it accessible to user-space?

Also, can calling pci_get_dsn() here cause issues if the PCIe link is in a
frozen state?

Since pci_get_dsn() performs live PCI config space reads, executing it on a
disconnected or frozen device could result in system hangs, extended timeou=
ts,
or Unsupported Request completions.

Furthermore, since pci_get_dsn() is passed as an argument to the trace
wrapper, won't the config space read execute unconditionally on every
error even if tracing is disabled?

[ ... ]

> @@ -247,7 +252,7 @@ bool cxl_handle_ras(struct device *dev, void __iomem =
*ras_base)
>  	}
> =20
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);

Can the call to header_log_copy() just above this trace event cause an
out-of-bounds MMIO read?

The header_log_copy() function iterates 128 times to read 512 bytes from
the MMIO address:

static void header_log_copy(void __iomem *ras_base, u32 *log)
{
	...
	int i, log_u32_size =3D CXL_HEADERLOG_SIZE / sizeof(u32);

	addr =3D ras_base + CXL_RAS_HEADER_LOG_OFFSET;
	log_addr =3D log;

	for (i =3D 0; i < log_u32_size; i++) {
		*log_addr =3D readl(addr);
		...
}

However, during component probe, the CXL RAS capability block is mapped
with a length of CXL_RAS_CAPABILITY_LENGTH, which is only 88 bytes.

Could attempting to read 512 bytes from an 88-byte MMIO mapping send PCIe
memory reads to unintended device offsets, potentially triggering
Master Aborts, Unsupported Requests, or unhandled page faults?

[ ... ]

> @@ -299,7 +305,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *p=
dev,
>  		 * chance the situation is recoverable dump the status of the RAS
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
> -		ue =3D cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
> +		ue =3D cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
> +				    cxlmd->endpoint->regs.ras);
>  	}

In cxl_error_detected(), if the PCIe link is in a frozen state, will the
call to pci_get_dsn() fail?

Because pci_get_dsn() performs live PCI config space reads, calling it
when the channel state is pci_channel_io_frozen could cause system hangs
or Unsupported Request completions.

Will this vulnerability persist even if subsequent patches in the series
(like "cxl: Update Endpoint AER uncorrectable handler") refactor the error
flow into a workqueue, since the pci_get_dsn() call remains on the
fatal error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505173029.2718=
246-1-terry.bowman@amd.com?part=3D2

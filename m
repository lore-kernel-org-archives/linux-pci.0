Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0644137AE;
	Wed,  2 Sep 2026 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357431; cv=none; b=TFq30v0SLT39yh/I6UEH4J+odag08TJ2BRilyU4cSKvQwPGlABwaLKIFSUY6iSu7YEgfUaFFgF+cz/EDwlyA2d9oPFo5hd5hhtVGEw+9YvDlWI/07R9ZZ4+yqRs2RZNsxUhLUsG+K4QSmn4BGCGlUD7BM4Awj4kkU52VT53VrFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357431; c=relaxed/simple;
	bh=WTfg+8U9cXm4IywOaUFavfDP49lvXMVkn4yPRsr0XD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sQ71UMS+jvNnA9bCIxAp81PnOFdJ3c1z2jauSVEnw9epLc2CJnbZaJ16ZdOFVM9yENMdGLWJeJNzIGIQXCMlmoXxG0etRTMIyMrdBKxdXok5ir6+fs7qHBbbgMH6O9JWtnDEV+94iqqMj2i7INRAk226dTfmwuDtNQW4CoSv8bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc3k2Zdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc3k2Zdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E759F1F000E9;
	Wed,  2 Sep 2026 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357430;
	bh=T14xAqcgBYN9kcnFKk4BEB3x1bvM/xCLLzLA7qvDYyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jc3k2Zdu00kZ3MsG+WA9IciZwKhwA65DHeKbZyVWKUJYpT7xj/G4B2QgNYJ0K6lr4
	 dklEQUkecoRCH/LqYbemmUxGApfue/jjxkP77RDcAP+2AL9ipZikLqwKJnkkb1lhya
	 mFE+McH71SQyXbtOloxp46fgKS2QUnew12ELx8UrDZZkEZBR1JaPJw/DA9CANwO6QJ
	 o+nct5Uv4nocssZBCiza8vyb8lagSSNq3Yz+j3JF7mAS74rBmKmubduGMNkZt5TXz5
	 l84Fb+OH8rdpPDNbAvaByEpFM+vwaoQK0Ch7ZmmCgwnZyjD9UZmqPd+/lFfRkl2/OS
	 mBrYwBZ9nBapg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 2/9] PCI: Establish common CXL Port protocol error
 flow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902133933.2992457-3-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:57:09 +0000
Message-Id: <20260902135709.E759F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] CXL protocol errors on RCD Endpoints bypass the AER-CXL kfifo, lea=
ding to dropped correctable errors and UCE race conditions.
--

commit 6e514f9fb46669ba2eab05ced2511b382df00bce
Author: Terry Bowman <terry.bowman@amd.com>

PCI: Establish common CXL Port protocol error flow

This commit establishes a single CXL protocol error path shared by Virtual
Hierarchy and Restricted CXL Host topologies. It routes CXL protocol errors,
gated by is_cxl_error(), through an AER-CXL kfifo to a core consumer for
logging and recovery to ensure synchronization.

> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rc=
h.c
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
[ ... ]
> -void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> +bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
> +	struct cxl_rch_error_ctx ctx =3D { .info =3D info };
> +
>  	/*
> -	 * Internal errors of an RCEC indicate an AER error in an
> -	 * RCH's downstream port. Check and handle them in the CXL.mem
> -	 * device driver.
> +	 * An RCEC AER internal error indicates an error in an
> +	 * associated RCH Downstream Port or RCD device or both.
> +	 * Forward to the cxl_core module for handling.
>  	 */
>  	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC &&
>  	    is_aer_internal_error(info))
> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, &ctx);
> +
> +	return ctx.enqueued;
>  }

[Severity: High]
Does this check accidentally skip errors logged directly by the RCD itself?

When an RCD detects an error, it logs it in its own AER capability and the
RCEC raises the interrupt. The AER driver's find_source_device() then walks
the RCEC's children, finds the RCD with the set AER status, and calls
handle_error_source() with the RCD device.

Because this condition strictly checks for PCI_EXP_TYPE_RC_EC, it intercepts
errors from the RCEC itself (like RCH Downstream Port errors), but bypasses
handling when the RCD device itself is passed in.

> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
[ ... ]
> @@ -54,8 +54,22 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err=
_info *info)
>  	if (!info || !info->is_cxl)
>  		return false;
> =20
> -	if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_ENDPOINT)
> +	/*
> +	 * RCD (PCI_EXP_TYPE_RC_END) is not included here because RCDs
> +	 * report errors on behalf of upstream RCH Downstream Port and thus
> +	 * require a unique discovery detailed in CXL4.0 spec (12.2.1.1).
> +	 * The RCH device error discovery and RCD forwarding flow begins
> +	 * in cxl_rch_handle_error().
> +	 */
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		break;
> +	default:
>  		return false;
> +	}
> =20
>  	return is_aer_internal_error(info);
>  }

[Severity: High]
Since RCDs are excluded here, does this bypass the AER-CXL kfifo entirely f=
or
RCD protocol errors?

As noted above, cxl_rch_handle_error() skips the RCD device. With the RCD
also falling through to the default case here and returning false, these
errors are never enqueued.

This results in correctable errors being silently dropped without being
traced or cleared (as the legacy cor_error_detected fallback was removed).
For uncorrectable errors, it bypasses the kfifo's synchronization, defeating
the race-condition fix and leaving the system vulnerable to teardown races.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902133933.2992=
457-1-terry.bowman@amd.com?part=3D2

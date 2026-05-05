Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5B37B014
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020133; cv=none; b=b9dgej61ph520zcr20gwiWberg1/EClYGKaT5F7sushskb30CB6Eh2FGu65kZnQ0rw8a2V9k+87gO4skNc+xggOUtwvI0uHEnZ6ojVGvmyqasWulwl2wiAvHIl9jHh3mIMgcl977xuhOI8dSBkGmmRYVOzZRmaCbGR1sZkHrsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020133; c=relaxed/simple;
	bh=NcJrR+AoDc1OAKzaL766DaGMVHu0D+hJUS0ew21RXaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qRIDVhDEd0IhYB6KXZlJb65XCQWggclWXmKGhICD79QyFp989k/IoOM9Wt0eXtBTPb252eYHsQdhi70707LwmjTz3LqayFagYJqQdxv2oqJC+lBD1dsRhEPo7+d5jdAxRH1TUVJo38kScce2xQFvz7zlKgSKxrhRDcdcY0jve/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUsz642U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUsz642U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00913C2BCB4;
	Tue,  5 May 2026 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778020133;
	bh=NcJrR+AoDc1OAKzaL766DaGMVHu0D+hJUS0ew21RXaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eUsz642UQWOAq3jJsXYvu6qi1QBEwd287p38VeCVt9YG/lz9UgjslD6H40wBjYlmx
	 Df337SfIzUbYFu38v+Ff1S7v1rTzrDl5gJ6TVeXr64/TQpHPjcu60oPJL3NDYUQZZa
	 ohQQUj501BgLVt8iq/4kiuIfOD0AgYu8WHSrHektWnmTGNeV0lxknsFXHgjkHsOesp
	 RjMsX+qLMdjjLtNIOB4fft2DgXqkLlf+Somql1673eL3b/cszvfsNm3jeH4Zw/uDoh
	 fJtHr/etf+JwAHEKLjMkBQoHMeFCdcHVZvO+JwutG2F6UTACM28kyYzaBlRLf9H3eD
	 9hv0tQg2z6S4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/11] PCI: Establish common CXL Port protocol error
 flow
Reply-To: sashiko@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505173029.2718246-7-terry.bowman@amd.com>
References: <20260505173029.2718246-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 22:28:52 +0000
Message-Id: <20260505222853.00913C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Mixed AER uncorrectable errors and Fatal errors bypass standard PC=
Ie error recovery.
- [High] `cxl_forward_error()` unconditionally writes to `pdev->aer_cap + P=
CI_ERR_COR_STATUS`, which can corrupt BAR0 if `aer_cap` is 0.
- [Medium] AER Uncorrectable Error status is left uncleared if the CXL port=
 driver is unbound.
--

commit 40776581efad3966047d440ec936219af21ff33c
Author: Terry Bowman <terry.bowman@amd.com>

PCI: Establish common CXL Port protocol error flow

This commit adds CXL Port protocol error handling callbacks to unify
detection, logging, and recovery across CXL Ports and Endpoints. It also
routes CXL protocol errors through the CXL RAS helpers and wires the AER
core to a kfifo for error processing.

> The correctable AER status is cleared by the producer in
> cxl_forward_error().

The patch 'PCI/CXL: Add RCH support to CXL handlers' updates
cxl_rch_handle_error_iter() to call cxl_forward_error() directly for
RCD Endpoints (RCiEPs).

If cxl_forward_error() unconditionally writes to
pdev->aer_cap + PCI_ERR_COR_STATUS to clear the correctable AER status,
what happens if an RCD Endpoint does not expose an AER capability to the
OS and dev->aer_cap is 0?

Would writing to 0 + PCI_ERR_COR_STATUS (offset 0x10) inadvertently
overwrite the PCI Base Address Register 0 (BAR0) and corrupt the device's
memory mapping?=20

The original pci_aer_handle_error() explicitly guarded this write by
checking if the aer offset is non-zero.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c

[ ... ]

> @@ -1186,7 +1187,10 @@ static void pci_aer_handle_error(struct pci_dev *d=
ev, struct aer_err_info *info)
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info=
 *info)
>  {
>  	cxl_rch_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);
> +	if (is_cxl_error(dev, info))
> +		cxl_forward_error(dev, info);
> +	else
> +		pci_aer_handle_error(dev, info);
>  	pci_dev_put(dev);
>  }

Since is_cxl_error() returns true when the CXL Internal Error bit is set,
does this bypass standard PCIe error recovery if a device experiences a
concurrent CXL Internal Error and a standard PCIe Uncorrectable Error
(such as a Data Link Protocol Error)?

Additionally, if the error is fatal, the PCIe link is frozen. Standard
handling in pci_aer_handle_error() would normally call pcie_do_recovery()
to perform a link reset.

Because cxl_do_recovery() only clears the AER status and returns without
resetting the link, could the device be left permanently frozen?

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

[ ... ]

> +static int __cxl_proto_err_work_fn(struct cxl_proto_err_work_data *wd)
> +{
> +	struct cxl_dport *dport;
> +	struct cxl_port *port __free(put_cxl_port) =3D
> +		find_cxl_port_by_dev(&wd->pdev->dev, &dport);
> +
> +	if (!port) {
> +		dev_err_ratelimited(&wd->pdev->dev,
> +				    "Failed to find parent port device in CXL topology\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Hold the port device lock and verify a driver is bound before
> +	 * handling errors. Protects against NULL deref if an error is
> +	 * dispatched before probe completion or after driver removal.
> +	 */
> +	guard(device)(&port->dev);
> +	if (!port->dev.driver) {
> +		dev_err_ratelimited(&port->dev,
> +				    "Port device is unbound, abort error handling\n");
> +		return 0;
> +	}
> +
> +	cxl_handle_proto_error(wd->pdev, port, dport, wd->severity);
> +
> +	return 0;
> +}

If the port is not found or the driver is unbound, this function aborts
and returns early before calling cxl_handle_proto_error().

Since handle_error_source() already bypassed the standard PCIe error
recovery, does returning early here leave the AER Uncorrectable Error
status uncleared on the device?

Standard PCIe handling normally ensures these registers are cleared even
if no driver is bound. Could leaving them uncleared block future error
reporting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505173029.2718=
246-1-terry.bowman@amd.com?part=3D6

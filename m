Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB96344D91;
	Mon,  3 Aug 2026 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785797782; cv=none; b=EoTs2iJX8X6mIdEcJsK2njZ45MiZckkjtNeZpMkHxty0xBOprOXmPuCn27Qrd/m05+z8gq5d7z3K+D7obRW8bY5jHD/uPk+wQXSMzi6aM3ssUmeNa2YvXCWqo3UTJZVEYb11gUesU9+2oXRHfhlPAtMvXqIF4MxVkdgzVHkCjxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785797782; c=relaxed/simple;
	bh=ZcKa/DXNbkIcEDaJ72DR7BAwMWyqy475yUwZWZw7Pb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b2xM7aBsm1BycYPVAMVN1V8AgQGMf3RSRufs7MoOJ0TZMndzxmaVGYkTJij06YweFZDprnv77pHi6zRh54ZXljIQTO2bpgt+eD4+rBE0JJkcXfO65dfj3PIY9ozmjsXkiJI4p/F8UWHZUT1pTbu+fIifh5yU4taQC0Pkt1IIvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbDgjC4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbDgjC4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DEC1F000E9;
	Mon,  3 Aug 2026 22:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785797780;
	bh=kNyvTT3XC+nH9xcHCg/oqYibSoaOxSgwRdvFqBaA0BE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PbDgjC4po4Xg9G/gOyHcW7W9IpEhra1Q/jnt0xNfHJF6IDHuc2MMBX99ifUJkVmyr
	 9CrLEdxHHFqdXUPnEYghaeVlmkg7P2ehPMNbILvpdfMRnnmKrQAF47Ufw40nKmavcb
	 8oJ25HrRp2pfOt+FIUvXyfop8URpc/lbuXXUzwFYwIbKElsBQUFVkYkRkMp5X6GjW9
	 I4XoJ9RCaKp9csHdnD4G1GwTUnVV8UNUMQTT/wiZpKTfIG78BIlbSEtMOCknh0hm2/
	 tujO1wxERHTdDy2ijm+v5s96hrnwAxIf3s+ts4Nt9kqiz6NPztXAo3LO8QZJZjJchh
	 eaMSsSOdMMmNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 07/14] PCI: Establish common CXL Port protocol error
 flow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260803221810.3685703-8-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:56:19 +0000
Message-Id: <20260803225620.42DEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent devm cleanup and port driver unbinds cause a Use-Af=
ter-Free of `cxl_dport` and its MMIO registers in the AER handling workqueu=
e.
--

--- Patch [7]: [PATCH v19 07/14] PCI: Establish common CXL Port protocol er=
ror flow ---
commit cee1514715e6511f03b640de984db92a0e13bd58
Author: Terry Bowman <terry.bowman@amd.com>

PCI: Establish common CXL Port protocol error flow
   =20
Establish a single CXL protocol error path shared by both CXL Virtual
Hierarchy (VH) and Restricted CXL Host (RCH) topologies. AER dispatch in
handle_error_source() uses is_cxl_error() and cxl_forward_error() to route
CXL protocol errors through the AER-CXL kfifo to a cxl_core consumer for
logging and recovery.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index e307361bb39e4..83df544e5a656 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

[ ... ]

> @@ -335,3 +371,79 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *=
pdev,
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +
> +static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port=
 *port,
> +				   struct cxl_dport *dport, int severity)
> +{

[ ... ]

> +}
> +
> +static void __cxl_proto_err_work_fn(struct cxl_proto_err_work_data *wd)
> +{
> +	struct cxl_dport *dport;
> +
> +	/*
> +	 * For RCD devices, handle RCH Downstream Port errors first.
> +	 * cxl_handle_rdport_errors() does its own port lookup and locking,
> +	 * keeping the Downstream Port lock separate from the Endpoint Port
> +	 * lock taken below.
> +	 */
> +	if (is_cxl_restricted(wd->pdev))
> +		cxl_handle_rdport_errors(wd->pdev);
> +
> +	struct cxl_port *port __free(put_cxl_port) =3D find_cxl_port_by_dev(&wd=
->pdev->dev, NULL);
> +	if (!port) {
> +		dev_err_ratelimited(&wd->pdev->dev,
> +				    "Failed to find parent port device in CXL topology\n");
> +		return;
> +	}
> +
> +	guard(device)(&port->dev);
> +	if (!port->dev.driver) {
> +		dev_err_ratelimited(&port->dev,
> +				    "Port device is unbound, abort error handling\n");
> +		return;
> +	}
> +
> +	dport =3D cxl_find_dport_by_dev(port, &wd->pdev->dev);

[Severity: Critical]
This is a pre-existing issue, but does checking !port->dev.driver safely gu=
ard
against an ACPI unbind racing with the AER handling workqueue?

The commit message states the kfifo consumer "holds the Port device lock and
skips handling when the Port driver is unbound, so RAS register iomaps are
not torn down while the handler reads them."

However, for Root Ports, the cxl_dport and its devres are attached to the
ACPI device (port->uport_dev), not &port->dev.

If devres_release_all(acpi_dev) runs concurrently with the AER workqueue,
it frees dport and unmaps the registers independently of device_lock(&port-=
>dev).

Because the cxl_port driver remains bound until devres_release_all(acpi_dev)
finishes and unregisters the port, checking !port->dev.driver wouldn't prot=
ect
against this. Could this lead to a use-after-free of the cxl_dport structure
and reading from unmapped MMIO (RAS/AER registers) in __cxl_proto_err_work_=
fn()?

> +	if (!dport && (pci_pcie_type(wd->pdev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +		       pci_pcie_type(wd->pdev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM)) {
> +		dev_err_ratelimited(&wd->pdev->dev,
> +				    "Failed to find dport device in CXL topology\n");
> +		return;
> +	}
> +
> +	cxl_handle_proto_error(wd->pdev, port, dport, wd->severity);
> +}

[ ... ]

> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index e0e01aa5eba6c..41959c0333711 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c

[ ... ]

> @@ -110,18 +109,21 @@ static bool cxl_rch_get_aer_severity(struct aer_cap=
ability_regs *aer_regs,
>  	return false;
>  }
> =20
> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> +void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  {
> -	struct pci_dev *pdev =3D to_pci_dev(cxlds->dev);
>  	struct aer_capability_regs aer_regs;
>  	struct cxl_dport *dport;
>  	int severity;
> =20
> -	struct cxl_port *port __free(put_cxl_port) =3D
> -		cxl_pci_find_port(pdev, &dport);
> +	struct cxl_port *port __free(put_cxl_port) =3D cxl_pci_find_port(pdev, =
NULL);
>  	if (!port)
>  		return;
> =20
> +	guard(device)(&port->dev);
> +	dport =3D cxl_find_dport_by_dev(port, pdev->dev.parent);
> +	if (!dport)
> +		return;
> +
> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))

[Severity: Critical]
This is a pre-existing issue, but does this still suffer from the same race?

The dport is looked up under the &port->dev lock, but for Root Ports its
devm lifecycle is tied to the parent ACPI device. If a concurrent ACPI unbi=
nd
occurs, couldn't dport be freed and unmapped before being dereferenced here?

>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D7

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38F3B71B6;
	Fri, 17 Jul 2026 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328807; cv=none; b=eFJ+E0C8RPNHnDS6WyohJZ/tM/Kw8YRHPAfEOT6Q9pj7IsjU/yfffsWad92yZrRO7GSEZbMXyoMAvJdI9UcuDDdMU69pLEvbOVVoDCYi7ZZFDrH6tEyKtSh6JtThC3pw1tu2ABbFsY6H08kItONgTuRBx3u2kY3xhtVaulN1L9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328807; c=relaxed/simple;
	bh=eTRzHl/o4sudDm73m21OEXMaQyrTCLUIiIkznFIrm9I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lJblYj5ItHM9Il0O9fqVFSUBvLOvvYX2zPtvYFFOMaM9mrDMR0TgS0Kg6h9Te/272OmWMVJpGZXYpkTJ/uxEzeOkheRh+Xiknu5DTUPCFM+lp+fJiLDtNQiEDz/7z7VyFKopYC5jPCDbGMMjDODfXGTsZKY2eLmBhbZnzH8U+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYy50muc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYy50muc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D321F000E9;
	Fri, 17 Jul 2026 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784328796;
	bh=CxnAtG+rK/UTCLdP5k4ky7hfls8i+dMqWsJq5SEb/JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AYy50mucLrF3DXrctyemkajic+h//f/Qfg9QGhLif2P87ax596zAyDZT7yAK1ZAEu
	 5E8o6lYMuinirAfsELRXADoz8OCt13Y6k4GhgltOa7IGGPCtsZ8ZM907NQRi50vEt1
	 1BpmBBGJSZ20nYXsc95x3UXqYE4sPzz0i8YlMcFtl0V38CXp3QA2kSqbLzLOeY0yvv
	 jLcJYqYuF8QBdi5elz5wjFNV/Z58zDWv3LO1UJZq7gVlPqTcoAzzwVXhZAvDlLaD2q
	 xwyvCCqECPaz9g9/1K7DKbW5vNsyOJyddpzFPEpMOix+ZlYBS3ofxkzle147/QYrFV
	 fWvx3RJVIDfYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 10/13] cxl: Add port and dport identifiers to CXL
 AER trace events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717222706.3540281-11-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-11-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:53:15 +0000
Message-Id: <20260717225316.02D321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Asynchronous CPER error handling races with ACPI driver unbind, ca=
using Use-After-Free of cxl_dport.
- [High] Live PCI configuration space reads on a potentially frozen or dead=
 link during AER recovery.
--

--- Patch [10]: [PATCH v18 10/13] cxl: Add port and dport identifiers to CX=
L AER trace events ---
commit 069c60a58d08507582ec548c08666c5374faa22d
Author: Dan Williams <djbw@kernel.org>
Subject: cxl: Add port and dport identifiers to CXL AER trace events

This commit updates the CXL AER trace events to include port and dport
identifiers instead of deriving a plain device pointer at the caller. It
replaces the separate uncorrectable and correctable trace events with
unified cxl_aer_* events. CPER handling is also reworked to use
find_cxl_port_by_dev() and the unified trace helpers.

> The serial number is retrieved via pci_get_dsn() which performs live
> PCI configuration space reads. A following patch ("PCI: Cache PCI
> DSN into pci_dev->dsn during probe") replaces these with a cached
> serial number to avoid config space access in error handlers and panic
> paths.

[Severity: High]
Does calling pci_get_dsn() before the follow-up patch is applied risk
causing a lockup?

cxl_pci_error_detected() is called during AER recovery, where the link may
be in the pci_channel_io_frozen state. pci_get_dsn() executes live
configuration reads (pci_read_config_dword()) to traverse PCIe extended
capabilities.

Accessing a frozen link can cause the host bridge to lock up or trigger a
secondary master abort. Will this cause completion timeouts and prevent
recovery during the window between this patch and the subsequent caching
patch?

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index d5dc2c22565da..acf40b2396c3b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
[ ... ]
> @@ -109,47 +77,34 @@ static struct cxl_port *find_cxl_port_by_dev(struct =
device *dev, struct cxl_dpor
> =20
>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {
[ ... ]
> +	guard(device)(&port->dev);
> +
> +	/* dport is NULL for Endpoint and Upstream Port devices */
> +	dport =3D cxl_find_dport_by_dev(port, &pdev->dev);

[Severity: High]
Is it possible for the dport to be freed concurrently here, leading to a
use-after-free regression?

While cxl_cper_handle_prot_err() holds the port's device lock, cxl_dport
structures for root ports are tied to the parent ACPI device's devres
lifecycle.

If the parent driver unbinds (e.g., during ACPI hot-remove), it executes
devres_release_all() under the parent's lock, which frees the dport
directly via cxl_dport_remove() and free_dport().

Could cxl_find_dport_by_dev() load this freed pointer, which is then
dereferenced in the trace event?

drivers/cxl/core/trace.c:cxl_trace_dport_name() {
    if (dport)
        return dev_name(dport->dport_dev);
    ...
}

> -	cxlmd =3D to_cxl_memdev(mem_dev);
>  	if (data->severity =3D=3D AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(port, dport, pci_get_dsn(pdev),
> +					     &data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(port, dport, pci_get_dsn(pdev),
> +					       &data->ras_cap);
>  }
[ ... ]
> @@ -360,7 +306,8 @@ pci_ers_result_t cxl_pci_error_detected(struct pci_de=
v *pdev,
>  		 * cases below handle AER recovery for devices without active
>  		 * CXL.mem traffic.
>  		 */
> -		ue =3D cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
> +		ue =3D cxl_handle_ras(port, NULL, to_ras_base(port, NULL),
> +				    pci_get_dsn(pdev));
>  	}

[Severity: High]
Does this live config read trigger the lockups mentioned in the commit
message? Since cxl_pci_error_detected() executes when the link state is
potentially pci_channel_io_frozen, the pci_get_dsn() call will traverse
PCIe extended capabilities on a dead link.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D10

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23823644C1
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016610; cv=none; b=VwC8hNL+YLDf1ZllwRAKAgcyP1X8DeGIO3O6l8UDS7YPzMBxiwQith+31zjK+iSY/oWxPEEF9u2dEs41aG6bWXouqGS84d0V/bKDOwEGSfu1MdKn6Gkc/uzZJt2MlkKWrxZcVjEXyI7c6v35CRL8Z7eGTBjV4HcsCaDXJP3T+aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016610; c=relaxed/simple;
	bh=Fjr0+pe6IKzwNvLCaCHDr61vsV9a45l5edQ0TvHz6PQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NjW+QmC6eF9lMvtSxHgAbT8M7go+Q4bFs9AkxYhbQ6mDVeX3N/YKjcGLLSTba/kS+g4jxk7qXcyPgnYaQxRjLBjBWP3NaBEFBeP7sMxY2jH1yAFpIW5dd4xcU1+hzC8l6fzH3ZlnK3P7hr6wlENFUQN33KyyGPzUs9rZa4yaSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWtPqsgL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWtPqsgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234D2C2BCB4;
	Tue,  5 May 2026 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778016610;
	bh=Fjr0+pe6IKzwNvLCaCHDr61vsV9a45l5edQ0TvHz6PQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jWtPqsgL9XqaCwbbFd/wE/mhA7HU4335CpqVJ4Lp9mWF2SSPD9R9ECp22iWMfrvbC
	 nWc1GBQL+Z+mgUYkkd1ukf32/tgqARF2TwIRUegfEaBsV+NrvbGuEERBk/n6vhQjsD
	 4+rrdTvRB29qNKG3i5qAiJ+PlJU8XYmKjNe3dNguTtYUQ7XHAFLa5HvV8rKcTkRwQJ
	 ija2vW0I/P7zonwBFV+106DHBhbRQIjeejWv+t2cXWkU6SSj9KKGuFhM3PT4jKTy06
	 gjjXufFnHEz7Z4eKcgMmzIFC/FVcN1r4n7isQG6RHPPN4KERwGXM8KPYFhq+vOWKwW
	 xtv+AdEMSGtaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 03/11] cxl: Use common CPER handling for all CXL
 devices
Reply-To: sashiko@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505173029.2718246-4-terry.bowman@amd.com>
References: <20260505173029.2718246-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 21:30:09 +0000
Message-Id: <20260505213010.234D2C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Stack out-of-bounds read of 448 bytes when copying the CXL hea=
der log to the trace event ring buffer, leaking kernel stack memory to user=
space.
- [High] Silent dropping of valid CPER hardware errors for unbound devices.
- [Medium] Unnecessary device locking based on a flawed premise of object l=
ifetime.
--

commit fb7e6f8e6c582af55947d02985f007b61cfc1671
Author: Terry Bowman <terry.bowman@amd.com>

cxl: Use common CPER handling for all CXL devices

This commit unifies the CPER error handling paths for CXL Port and Endpoint
devices by removing the PCI-type specific dispatch. It extends the driver
check and device lock to Port devices, and replaces the memdev lookup with
direct use of the PCI device for trace events.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index d7081caaf5d3f..56611da8357a2 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

[ ... ]

> @@ -77,38 +40,20 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_er=
r_work_data *data)
>  		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>  					    data->prot_err.agent_addr.bus,
>  					    devfn);
> -	struct cxl_memdev *cxlmd;
> -	int port_type;
> =20
>  	if (!pdev)
>  		return;
> =20
> -	port_type =3D pci_pcie_type(pdev);
> -	if (port_type =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> -	    port_type =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
> -	    port_type =3D=3D PCI_EXP_TYPE_UPSTREAM) {
> -		if (data->severity =3D=3D AER_CORRECTABLE)
> -			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
> -		else
> -			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
> -
> -		return;
> -	}
> -
>  	guard(device)(&pdev->dev);
>  	if (!pdev->dev.driver)
>  		return;

Will this silently drop valid CPER hardware errors for unbound Port devices?

Previously, the port device dispatch block correctly bypassed the driver ch=
eck
for CXL ports. Since the code only logs the CPER data via tracepoints and
reads the PCI config space for the DSN, is a bound driver actually required?

Also, is the device lock necessary here?

The commit message notes "the existing device lock will ensure the CXL devi=
ce
remains accessible while in scope". However, object lifetime and accessibil=
ity
of pdev are already guaranteed by the reference count acquired via
pci_get_domain_bus_and_slot(), which is released safely by the
__free(pci_dev_put) cleanup.

> -	struct device *mem_dev __free(put_device) =3D bus_find_device(
> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> -	if (!mem_dev)
> -		return;
> -
> -	cxlmd =3D to_cxl_memdev(mem_dev);
>  	if (data->severity =3D=3D AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(pdev, cxlmd, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(pdev, pci_get_dsn(pdev),
> +					     &data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(pdev, cxlmd, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(pdev, pci_get_dsn(pdev),
> +					       &data->ras_cap);

Can this cause an out-of-bounds read of kernel stack memory?

The trace event cxl_aer_uncorrectable_error performs a memory copy of the
header log:

memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);

CXL_HEADERLOG_SIZE is 512 bytes, but the hl pointer passed in via
ras_cap->header_log is only a 16-element u32 array (64 bytes) inside
struct cxl_ras_capability_regs.

Could this copy 448 bytes of uninitialized stack memory past the array into
the userspace trace buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505173029.2718=
246-1-terry.bowman@amd.com?part=3D3

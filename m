Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77232E889C;
	Mon,  3 Aug 2026 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796945; cv=none; b=ehM7pV55jHoQvnEhuPPyYCvet4eXsS8ZWMLj7q0RgWriepq53nkf8FocY+dP79zTtrDYWX0vO7BwtIahOdH++NKHNydVNv3jbbltCMcpAMfz0onYcIu3ZIL+wKqI9HJOGqPoQ8AwHh7cnxEg0sV6w5bCHcCl7ByjMiUELUTt03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796945; c=relaxed/simple;
	bh=5tCLbkygSr8sLE6iDVXADUbcDGmGhNyx1Df2TKB3j90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MtAtx0qXsV36gzIhtEgWfNQVGTMSfXZWhWzLY27gPASuVVSOfsU96ehYonyNdb19LZwKf/Tq+jAT1yB9PEkJUYMA1g578Z92g2e0gM6qBd+py11ObGccI57CZqV7Nb7AG/fANjT7DZH3KTPVVAdsX3GaJ+n4l8V0R2UjneyhlM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcqHAOc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcqHAOc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF041F000E9;
	Mon,  3 Aug 2026 22:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796944;
	bh=gkMwzs4tFKv1EGcoXDCgkJml+ndtTmAp+ayuftaJFyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jcqHAOc1MWZapFpyFmwdYisyqVZxalz0fHeDE5bn2DZbHdeORZ2S0ZHN/ekj7jkxa
	 PuX4ouYMzOb5NuA/lazbgyXB0Jly/+GzSnorMHCsGp9mUquRZA6GPmkXsVpGsv+mGM
	 6jU8i+tnJxCx2osvae8lWQymRhd7kwiNbkFvCZIHfkBh/LyaY72Q3XYcjiIrquFuP1
	 3eEq5Mp0i8pp5EzmWPA7cMVR2T46UQl1jq/LhvIg8FuKcb3lHWxKVes5wv9pslHMQK
	 JbpAny1oHIzAeJXbcKTYMFl96pMxY6fOc+0ACDBNJCB2YV1PegqtXS4Gqv/Ou7ZiRP
	 S/Erl2YKHM6tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 12/14] cxl: Add port and dport identifiers to CXL
 AER trace events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260803221810.3685703-13-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-13-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:42:23 +0000
Message-Id: <20260803224224.5FF041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing device lock in cxl_cper_handle_prot_err() leads to Use-Aft=
er-Free of devres-managed objects like 'dport' during concurrent driver unb=
ind.
--

--- Patch [12]: [PATCH v19 12/14] cxl: Add port and dport identifiers to CX=
L AER trace events ---
commit 3fa84eaf0343ed1c7fb39fd22762efda3659de2c
Author: Dan Williams <djbw@kernel.org>

cxl: Add port and dport identifiers to CXL AER trace events

This commit modifies CXL AER trace events to use struct cxl_port and struct
cxl_dport pointers instead of deriving device strings at the caller. It
unifies the correctable and uncorrectable error trace events and updates
cxl_cper_handle_prot_err() to use these new helpers while dropping a device
lock it considered redundant.

> Changes in v18->v19:
> - Drop redundant device lock in cxl_cper_handle_prot_err(); the port
>   reference already keeps the object alive and no RAS iomap is accessed.

[Severity: High]
Does dropping the device lock here leave devres-managed objects unprotected?

The commit message notes that the port reference keeps the object alive, bu=
t a
device reference only protects the struct device allocation itself, not the
driver binding state or devm actions.

[ ... ]

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 5183b3c532952..0254b7ec64c30 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

[ ... ]

> @@ -108,44 +76,32 @@ static struct cxl_port *find_cxl_port_by_dev(struct =
device *dev, struct cxl_dpor
> =20
>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {

[ ... ]

> -	guard(device)(&pdev->dev);
> -	if (!pdev->dev.driver)
> +	struct cxl_port *port __free(put_cxl_port) =3D find_cxl_port_by_dev(&pd=
ev->dev, NULL);
> +	if (!port) {
> +		dev_err_ratelimited(&pdev->dev,
> +				    "Failed to find parent port device in CXL topology\n");
>  		return;
> +	}
> =20
> -	struct device *mem_dev __free(put_device) =3D bus_find_device(
> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> -	if (!mem_dev)
> -		return;
> +	/* dport is NULL for Endpoint and Upstream Port devices */
> +	dport =3D cxl_find_dport_by_dev(port, &pdev->dev);
> =20
> -	cxlmd =3D to_cxl_memdev(mem_dev);
>  	if (data->severity =3D=3D AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(port, dport, pdev->dsn,
> +					     &data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(port, dport, pdev->dsn,
> +					       &data->ras_cap);
>  }

[Severity: High]
Can accessing dport here race with a driver unbind?

If a concurrent CXL port driver unbind occurs (via sysfs or device hot-remo=
ve),
the devres release actions will execute while cxl_cper_handle_prot_err() is
still running.

This could result in the devm-managed dport being freed, leaving the dport
pointer referencing freed memory. This pointer is then passed into the trace
events where cxl_trace_dport_name() attempts to read dport->dport_dev:

drivers/cxl/core/trace.c:cxl_trace_dport_name() {
    ...
    if (dport)
        return dev_name(dport->dport_dev);
    ...
}

Could this result in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D12

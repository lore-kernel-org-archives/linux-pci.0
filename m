Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E0352003;
	Wed,  2 Sep 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357912; cv=none; b=CdK1jCN92s48180ooyjOflVQVK4w6JYpeeArmocfQVGvzmnB0GGCSD9HuGKxPgbrijglkLiPdNiWEGNsYseKb+YP3pBZUbB6yBvwB5MeUKIKPn4BEiz3AyRrbZgBR0JWF7MdxzZF0/KuBUEA1JyNMf38VYPBj1jVd0fjXdhK++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357912; c=relaxed/simple;
	bh=7/4D1n+seE6sWIPiytC/aRNXUub5yv0aeirMIIPwyEI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QS4+7wi/q28D4b/errG3wxqcSeWGGxduFADAAkUvcYObG6bqG8YKzWOmNlCRrcTgzlVQDwE7b+PeSaQMwfdskCX5x5abIVRhrNLSqO5qn12m+00fHtI2mGk8LeB++jhYrLhOTo14urBmlIk9kZoC2uN6eI7F3I9//QUwYLssl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWS+/0lZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWS+/0lZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F1C1F000E9;
	Wed,  2 Sep 2026 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357911;
	bh=5HJ1PudFkTlTywzZCLS4F6ZjEJ9EGlKcsdAKxrt50fs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWS+/0lZnyeqgtks0SkaoCMKjtQFmiDw+Gn7cSYdmQc4kM8HtqZzk0PAVfEOToc6D
	 pxR86SaakexRLOgxsZ9g5BdTgDrjTApQmkYYSTRakGQXymedMG1adXlQXXRbY0Sx2Z
	 b+GgdKTUCBKTtg03/xh8xJdJk2gE8m11mw26IjDRZVboel38rEQIFvziwUbkpapAD0
	 7GFGrlxi+RnGppEJ1T5FRJ4wpP7aZfV1Tk41YUS6m5x3T07GPrQF/R7beAHvMPNvHR
	 qgDlUaRZyi6tR+aqAVWRlEq+eHZQmaCtaG2XQ+byUqhFnlBa2UfX15dh9KQ3e/ws9b
	 19/pfRB4eyXMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 5/9] cxl: Update CXL Endpoint AER handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902133933.2992457-6-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:05:10 +0000
Message-Id: <20260902140511.46F1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Self-deadlock with PCI AER core via device_release_driver()
- [High] AB-BA lock inversion between PCI AER core and CXL port uport_dev

Pre-existing issues:
- [High] Undefined behavior and truncation on BIT(63) during dead link RAS =
handling
--

commit 2f0ed965e221155153683db0b8960c5aeb8afd4e
Author: Terry Bowman <terry.bowman@amd.com>

cxl: Update CXL Endpoint AER handler
   =20
This patch renames cxl_error_detected() to cxl_pci_error_detected() and ali=
gns
error handler names. It also modifies the RAS read policy to be uncondition=
al
and documents the behavior on dead links.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index e307361bb39e4..bf479fac08565 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

[ ... ]

> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> -{
> -	struct cxl_dev_state *cxlds =3D pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd =3D cxlds->cxlmd;
> -	struct device *dev =3D &cxlmd->dev;
> -	bool ue;
> -
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> +				 "%s: port disabled, abort error handling\n",
> +				 dev_name(&port->dev));
>  			return PCI_ERS_RESULT_DISCONNECT;
>  		}
> =20
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
>  		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> +		 * The CXL RAS uncorrectable status is the only signal here
> +		 * that the error is a CXL internal (protocol) error. A set
> +		 * UCE bit confirms it and triggers the panic below. On a dead
> +		 * link readl() returns 0xFFFFFFFF, which sets all UCE bits and
> +		 * triggers the panic intentionally.
> +		 *
> +		 * If RAS is not mapped the read is skipped. Unlike
> +		 * cxl_do_recovery(), which is reached only after
> +		 * is_aer_internal_error() has already confirmed a CXL internal
> +		 * UCE, this path has no such confirmation, so an unmapped RAS
> +		 * block cannot attribute the error to CXL and must not panic.
> +		 * The switch cases below then handle AER recovery.
>  		 */

[Severity: High]
This is a pre-existing issue, but this patch explicitly documents that
reading the RAS registers on a dead link returning 0xFFFFFFFF is
intentional.

If readl() returns 0xFFFFFFFF, inside cxl_handle_ras(), hweight32(status) >=
 1
is true, so it evaluates:

    fe =3D BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
                       readl(rcc_addr)));

Since the dead link causes readl() to return 0xFFFFFFFF, FIELD_GET will
extract bits 0-5 and yield 63. Will evaluating BIT(63) trigger undefined
behavior on 32-bit platforms and silent truncation on 64-bit platforms?

> -		ue =3D cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
> +		ue =3D cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>  	}
> =20
> +	/*
> +	 * CXL.mem UCE means cache coherency is lost. Continuing risks
> +	 * silent data corruption.
> +	 */
> +	if (ue)
> +		panic("CXL cachemem error");
> +
>  	switch (state) {
>  	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
>  		return PCI_ERS_RESULT_CAN_RECOVER;
>  	case pci_channel_io_frozen:
>  		dev_warn(&pdev->dev,
>  			 "%s: frozen state error detected, disable CXL.mem\n",
> -			 dev_name(dev));
> -		device_release_driver(dev);
> +			 dev_name(port->uport_dev));
> +		device_release_driver(port->uport_dev);

[Severity: High]
The AER core calls report_error_detected() which acquires
device_lock(&pdev->dev) before invoking this driver callback.

Because port is resolved via find_cxl_port_by_uport(&pdev->dev),
port->uport_dev is identical to &pdev->dev. Will calling
device_release_driver(port->uport_dev) here unconditionally attempt to
acquire the exact lock that the AER thread is already holding, resulting in
a self-deadlock?

>  		return PCI_ERS_RESULT_NEED_RESET;

[ ... ]

> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index e0e01aa5eba6c..bc6cf50fcc926 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c

[ ... ]

> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> -{
> -	struct pci_dev *pdev =3D to_pci_dev(cxlds->dev);
>  	struct aer_capability_regs aer_regs;
>  	struct cxl_dport *dport;
> -	int severity;
> =20
> -	struct cxl_port *port __free(put_cxl_port) =3D
> -		cxl_pci_find_port(pdev, &dport);
> +	struct cxl_port *port __free(put_cxl_port) =3D cxl_pci_find_port(pdev, =
NULL);
>  	if (!port)
>  		return;
> =20
> +	guard(device)(port->uport_dev);

[Severity: High]
The AER core executes cxl_pci_error_detected() with device_lock(&pdev->dev)
already held, which synchronously calls this function for an RCD.

For an RCD, port->uport_dev resolves to the ACPI root or host bridge, which
is an ancestor of pdev. Will locking this ancestor device while holding a
descendant's lock create an AB-BA deadlock with concurrent device removal
operations that lock from parent to child?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902133933.2992=
457-1-terry.bowman@amd.com?part=3D5

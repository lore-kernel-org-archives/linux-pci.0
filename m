Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFD3C81B9;
	Fri, 17 Jul 2026 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328841; cv=none; b=csJzyXQ7rVtrlDkSOGWteVzg0aeC1F4NOaa+jPA+rXs76XCLRil1VKkNMcH5OGLV/u91PlvgK9ATGmdpiJ9oU9/wK/feJro+PK7GYYYnmdUR0qMWDEjBF0jwxpvdI4HZxu3knOVSgZyQMQbs5lxLf30+hpgUai02BXs17x/nkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328841; c=relaxed/simple;
	bh=LcYZ9lahysSIW3DmaBdp/5XNV4bDdusyhH/H3eGjx+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1yZeYILIprFLKV9CMAhjXBQ0GPVGNiU5r2cY4jbBn+8oTblmEL+uHXXJAmzI0s2tBe+tLbf9AaM02fyA3m7AETXVuuNz7I6ce+bMjVIz9XSE7QrkDMlBPU0AXWJmd61VF5kDWAGAszItb2AM+4FnjunQkXytc9v9YPiQOf5Ta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOTiqvK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOTiqvK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720041F000E9;
	Fri, 17 Jul 2026 22:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784328828;
	bh=1iHoyKt44WWs0iYtMsD5wPJ3TMQtGOYKSI/el0WxVsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BOTiqvK6B437IPCZkm/NTN7Ek1jHw3TfS2LZFiiwsNJ5T8DyI2+eW7/svKxp1qCFl
	 GXloGxB4yKMaQxHKhUGlBKAJVx783gwqkvTSuHbz2Rv29HJHm2rCM6lOIVSxwtHbng
	 RJlOX7Mc/pUYOHdQ4fgqsAKttfdlAsKoZeCvjbd2VJvZA1CDBOl5jwXPCIlzsdLRNO
	 GfnSDx6z9B1lPBCiWEax1PaF4ie4Nsc59CdUlqsqK4NMm1sBWFB5LCbqXBhSoof4L9
	 zEnwvxaldHOZA7TciC7ikRKFq57xezEmXadnXk464NUykDwxyOtT6qt2pO3v27mouu
	 l9d/ai2GmuSQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 09/13] cxl: Update CXL Endpoint AER handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260717222706.3540281-10-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:53:47 +0000
Message-Id: <20260717225348.720041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional kernel panic on PCIe link failure for idle/unused CX=
L endpoint devices.
--

--- Patch [9]: [PATCH v18 09/13] cxl: Update CXL Endpoint AER handler ---
commit 01bcb4332c20e7d1dcce013851a595e79f03a892
Author: Terry Bowman <terry.bowman@amd.com>

cxl: Update CXL Endpoint AER handler

This commit updates the CXL endpoint AER error handler. It documents the
unconditional CXL RAS read policy and relies on this policy for CXL endpoint
error handling.

> Document the unconditional CXL RAS read policy: on a dead link,
> readl() returns 0xFFFFFFFF which is interpreted as UCE bits set and
> triggers a panic. If RAS registers are not mapped the read is
> skipped and the frozen/perm_failure switch cases defer to AER
> recovery for devices without active CXL.mem traffic.

Is this assumption about RAS registers not being mapped accurate?=20

Looking at cxl_endpoint_port_probe(), it appears to unconditionally map the
RAS registers via devm_cxl_port_ras_setup() for any present endpoint.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

[ ... ]

> @@ -349,10 +347,18 @@ pci_ers_result_t cxl_error_detected(struct pci_dev =
*pdev,
>  		}
> =20
>  		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> +		 * The CXL RAS read is unconditional regardless of channel
> +		 * state.  Any uncorrectable error bit set in the CXL RAS
> +		 * status register triggers a panic because CXL.mem cache
> +		 * coherency is already lost; continuing risks silent data
> +		 * corruption across interleaved HDM regions.
> +		 *
> +		 * On a dead link readl() returns 0xFFFFFFFF which sets all
> +		 * UCE bits and also triggers the panic - this is intentional.
> +		 * If RAS registers are not mapped the read is skipped, the
> +		 * panic is not reached, and the frozen/perm_failure switch
> +		 * cases below handle AER recovery for devices without active
> +		 * CXL.mem traffic.
>  		 */
>  		ue =3D cxl_handle_ras(port, NULL, to_ras_base(port, NULL));

[Severity: High]
Does this regression cause a system-wide panic for idle or unused CXL endpo=
int
devices?

If devm_cxl_port_ras_setup() unconditionally maps the RAS registers during
probe, cxl_handle_ras() will always execute the readl() here. During a
transient PCIe link failure (like an AER frozen state) or a surprise hot
unplug, the link is dead, so readl() returns 0xFFFFFFFF.

Because this sets the uncorrectable error (UCE) bits, cxl_handle_ras() will
return true. Doesn't this mean any transient PCIe link failure will now
unconditionally crash the system due to the subsequent if (ue) panic check,
breaking standard PCIe error containment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D9

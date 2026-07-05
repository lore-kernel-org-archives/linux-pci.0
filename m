Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C9253958
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289815; cv=none; b=ZjiLXFR8LstX4unLhlmiTVE4FX2zmSj74DP3pJ9zh1IcPRdEA0qsQqsoGs8HYBNCg9SUtu97CX34fgNj8hGNLX4doKOH+hhr280Qz6glNk6C/s0F3Wo3ovXML5r5Boi20lrpbwscHPx31MWI21C5qnQhk/2BnauVk0GFP8hAgy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289815; c=relaxed/simple;
	bh=WGk9PvjtVJwFdUGnkm/OjHGSBJk2dIIES8Z7GuPlSls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SAsoGCryOnJ+Tt02Ip8Z0TgrmwJ0nFvrTkFSdpX/ksv4+9pX6y86yNwinBCr4sXPcvDvX36zA/mS8raN10buD7VzOwEtKfrMQKHTXh6CeTSeUMTn7+BnQeIIhAkLhD0yxnVeN2dAuTkWYYrWdDo3foJSRS9YKVj0pCiL0DnnFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGIM3lr+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGIM3lr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032A41F000E9;
	Sun,  5 Jul 2026 22:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289814;
	bh=H40DUk58YNckAxDIhNtUtmXFIQP9KCrNHop2DAVMQEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OGIM3lr+MSheq3tTsX5bYQUrFNOhRhx9XFCzPVoTA2urLtqldMBvqGkt71JX2mOOh
	 v9V/FygwbRiGtvJqb0nt5G2QVRuuVT7wRMiUb6KpLnWs4C8ueBagkseCtpj4nBdKYP
	 qzh//AqWu9MKRNlXEQWbzPoQU/zHUpjJlGPUr8MCrHTiSiF5upU2DynShefxpi2o5g
	 Vdg+62Dv6QsgqgZlBdQTVl/zIuNHFM643ZTtkguSYe+nlXbK/xYKowwaB1bdEqE326
	 1M5e7yDsEjsgk0VIhCO3MOey40fTAWjBUbJi3UlX5A7eGPlvqvHZntiPSLSpZrbqaL
	 LOHb74jLK0TGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] PCI/TSM: Add device evidence support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-7-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-7-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:16:53 +0000
Message-Id: <20260705221654.032A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing NULL check for `pdev->tsm->evidence` in `pci_tsm_refresh_e=
vidence()` leads to a NULL pointer dereference.
- [Medium] `pci_tsm_evidence_read_begin()` incorrectly masks wait interrupt=
 errors, returning `-ENXIO` instead of the original error code.
--

commit 59da43773186eeb0cfa223261094a555b176c018
Author: Dan Williams <djbw@kernel.org>

PCI/TSM: Add device evidence support

This commit registers the PCI TSM framework with the device-evidence
netlink ABI. It introduces a struct device_evidence context for TSMs to own
SPDM sessions and handle evidence refresh requests.

> diff --git a/drivers/pci/tsm/evidence.c b/drivers/pci/tsm/evidence.c
> new file mode 100644
> index 0000000000000..ffb08208f0c0d
> --- /dev/null
> +++ b/drivers/pci/tsm/evidence.c
[ ... ]
> +static struct device_evidence *pci_tsm_evidence_read_begin(struct device=
 *dev)
> +{
[ ... ]
> +	/* Hold the evidence stable against conflicting refresh updates */
> +	evidence =3D pdev->tsm->evidence;
> +	rc =3D down_read_interruptible(&evidence->lock);
> +	if (rc)
> +		goto err;
> +
> +	return evidence;
> +err:
> +	up_read(&pci_tsm_rwsem);
> +	return ERR_PTR(-ENXIO);

[Severity: Medium]
Does this error path intentionally mask the error code from
down_read_interruptible()?

If the wait is interrupted, rc is populated with -EINTR, but the err label
unconditionally returns -ENXIO. Could this lead to userspace receiving a
misleading 'No such device or address' error instead of a retryable
interrupt signal?

[ ... ]
> +static int pci_tsm_refresh_evidence(struct device *dev, const void *nonc=
e,
> +				    size_t nonce_len)
> +{
[ ... ]
> +	/* Sync against pci_tsm_evidence_read_begin */
> +	evidence =3D pdev->tsm->evidence;
> +	ACQUIRE(rwsem_write_kill, elock)(&evidence->lock);

[Severity: High]
Is it possible for pdev->tsm->evidence to be NULL here?

Looking at the evidence_available() helper earlier in this file, it appears
structurally valid for a TSM to exist without an associated evidence contex=
t.

If evidence is NULL, would passing &evidence->lock into ACQUIRE() cause a
NULL pointer dereference?

> +	if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &elock)))
> +		return rc;
> +
> +	return ops->refresh_evidence(pdev->tsm, nonce, nonce_len);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D6

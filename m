Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D806547068
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791254613; cv=none; b=qbpzAd82dbRZKFN6CiLCqMULyXpMNAqnai9EzeObwhtmKNzvew/MoQ2xtvbAYfbp3uzS5KI1CfMOOLijHD66rCArTUVJo5uA9CIXtHUjx34eWZ5Mi6fifcWyWXiFtq/PyMpe5uJylfzi3ZKjE7ao2TO7T+JaDowMxe5M9p6fYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791254613; c=relaxed/simple;
	bh=qTwAYCR2YInHktm7l1EVTu69LWPeI/9vMoAWJskrMMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ItgTuD/KmWXccjbjnjNuEWWZiyZsoYOXSM/zhWg4EpQ855RRuaAFZOXtjgdwwW09SciTIGleSMew0m/yxPxrCYgpBx9gl5ThZq6OHT7G3Z61fRgra4zI402bFmemv4txJJoGY4yaoSTgzKYFwR2scD4+aNysJLepc9Qh8eP2BPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvrgeZ85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvrgeZ85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2C01F000FF;
	Tue,  6 Oct 2026 02:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791254611;
	bh=I53kJlIAFVYbp401jbTJAhsEAlNQj5s478iCaQ+52co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bvrgeZ857N/Bd9MGhw6bn7U/xkhWkqVkzqr+9TYXmIQ4xJP7CZLHGhBM14A+4z9v4
	 RzNrDDpKIFkjRmL4W7GF6Vhmy5lm59HIQgelI611MkD3Mdgub3yw9FnbZS+JVn6p6s
	 vYm8QSmt2NcPUWdtSeom3o8eHb/YnZV0ZYyZwWxVoGc+jkJSDSdy4j1u/DHOc5chF2
	 IKsIwx9V1AHO9JIsXNhH85TfSTfM9+VWf7TrGHa9q7XAnAfDYeAzzU8BAUYhtl5G0X
	 QULiVAf5VQFJvkfJI6gU08oZKvuKLgxyxsW//8C5KI6m1nGZl/GgxHF3dS4OlsNYCR
	 wQZGkdR7v3zvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] xen/pcifront: check that an AER callback exists
 before calling it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261006023443.338194-1-yhlee@isslab.korea.ac.kr>
References: <20261006023443.338194-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 02:43:31 +0000
Message-Id: <20261006024331.BF2C01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pcifront_common_process() handles an AER request from the backend by
> dispatching on aer_op.cmd to the bound driver's PCI error handler.  It
> only checks that err_handler and err_handler->error_detected are present,
> then for the mmio_enabled, slot_reset and resume commands it calls the
> corresponding callback unconditionally.  Those three callbacks are
> optional -- the PCI core NULL-checks each of them individually before
> use -- and many drivers (for example igb, igc, ice and ixgbevf) install
> error_detected without all of them.
>=20
> aer_op.cmd comes from the shared ring, so a malicious or buggy backend
> can send XEN_PCI_OP_aer_mmio (or _slotreset/_resume) for a device whose
> driver leaves that callback NULL and make the frontend call through a
> NULL pointer, crashing the guest.
>=20
> Check each callback before calling it.  When mmio_enabled or slot_reset is
> absent, return PCI_ERS_RESULT_RECOVERED so recovery proceeds, as the PCI
> core does for a missing callback; returning PCI_ERS_RESULT_NONE would
> instead make xen-pciback tear the guest domain down.
>=20
> Fixes: 956a9202cd12 ("xen-pcifront: Xen PCI frontend driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006023443.3381=
94-1-yhlee@isslab.korea.ac.kr?part=3D1


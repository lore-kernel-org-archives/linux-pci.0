Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258FE31A556
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052833; cv=none; b=iCOVThL2hmvGZhuf3NgwDbSKxXtxzfmsHqWuWPGxQcFgXAVMThYdZ2K8hClEpNZq/FXPyIvI1onY0V2pZwMD9JpvXxa2U5V9r2OpiDSow3KAXYzNJdWBWQh6lhMDY5S5TZ6nkJJPd60fmgPYSC3FYL5cMAWQzsvHg5XLd0wFcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052833; c=relaxed/simple;
	bh=s7vNd/kAeQgPbCj/6uvF6HGA9wZNKvsoXZB4/J2xFOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MPHznK/FIgripzUP9nHO1c4JlGYiSAaHN8mGC0GOufMLneFjmc/FZdvZuzi9wPUMGxivVJMKko3kzl8lDg3ELxKJZ9EWK87AYU1j0ckuViyCOYn9/S6uVTgWVR09XjtDY0UMJxv7PTv0ofankY5oc84AKzG5r0QlILx6QUOJuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPH1evCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPH1evCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50BD1F000E9;
	Fri,  3 Jul 2026 04:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052823;
	bh=s7vNd/kAeQgPbCj/6uvF6HGA9wZNKvsoXZB4/J2xFOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPH1evCG8iHO9hS+K40mry5kz4ynWDh6sFsCYop470gUKcL7oDFyyC75BL4forrIl
	 i9JiOpPI0ssfrKNstYaP27DCSr2gPlCakmyC365rrQLZlLFtj+9p+u7msx/fuMaJ20
	 0pTdxEH7/GrhY+xDu1jP02bhR0d+GT2Iw0jH9lLchhT7ytu+cDzu+iYIXssOM8Ym/d
	 1RiNHjnkdT2WdYB8gO6kWO/cbgccWC/EeSeE7pRTLUbUgSFu9zHc8/kryDLmE8p8AH
	 z9i1hTQTF8HvKYhHOLDDRIPHnnMZ3UL2o6Atq3cfOjehwOj25kLOFU6YcEXq9yLkIs
	 0/3QJgDiKeY9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/18] PCI: Don't suspend IOMMU when probing reset
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <6dbbbbe30cdc08a467de893fb9ecdc07d9cc1fec.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <6dbbbbe30cdc08a467de893fb9ecdc07d9cc1fec.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:27:03 +0000
Message-Id: <20260703042703.A50BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> reset_method_store() in drivers/pci/pci-sysfs.c discovers supported reset
> methods by calling reset_fn(pdev, PCI_RESET_PROBE, ...) without holding a
> device_lock, since the probe path is expected to query the device's reset
> capability without changing device state.
>=20
> However, pci_reset_bus_function() and __pci_dev_specific_reset() violate
> that contract after pci_dev_reset_iommu_prepare/done() were added, which
> moves the device into a blocking domain and abruptly aborts any in-flight
> DMA. Doing this for a probe -- a state-query call that does not even hold
> device_lock -- can cause driver timeouts and data loss on a DMAing device.
>=20
> The peer reset helpers all handle this correctly: they short-circuit on a
> probe input before touching the IOMMU.
>=20
> Skip pci_dev_reset_iommu_prepare()/_done() entirely when probe is set. The
> inner reset routines already implement their own probe semantics, and they
> perform the capability checks and return without changing device state.
>=20
> Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a de=
vice")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D1


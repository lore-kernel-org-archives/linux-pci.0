Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496BE18B0F;
	Thu,  9 Jul 2026 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560423; cv=none; b=uFBQm/L5cDCyPSr66Gpl4poFO9TwAmnUMUyN7w/RLQMwwf+rntEcXzkWRsSr4RsY9vRTJxaH4+TgsmY8CFrJUHYRQlalMIjYkCxraMYzaxvzZuO9AzS7sR2bj9A98aPm7ctpr6hfHj+J/QQCk2f3ajgXIjNOm+IozjlTCwcFtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560423; c=relaxed/simple;
	bh=UTjigRJFpERL2rUoyh3WDgQKRFR6CoXTLLuIIRI0CMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HP8qLdNwmd5Wsh1x08gyFKOfPoAnCVvQn7NqZGp7y5n0vBRIIAjYLreRxhc5CXqLjr/aZdEWegfJZUswx227vWnO9VQIwqJm27HLV3KyVpoj/wSi2Yuivv+f4tgcCBFRcerPNvry33ksUVqk2tLjcQcgoWXnranHxCpxnm30cWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKP31xzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKP31xzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9A11F000E9;
	Thu,  9 Jul 2026 01:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783560421;
	bh=mnT9OXj+y4SXzlyOJZ2MDkMEKp41Wd+y0zBQrmSoxEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QKP31xzKPkpz4oFs8oMKpqhHs2gJR/8iTlxpiPjCJuWWxkpEBFWhwMrZ+6KNrNkMk
	 oQLRC26PQ3uYxOT7vrG30NaNFYpdGgGrrrPgWpXMeRWlSGsn7hzg5hCJVFRwa1URso
	 Qy6jotkD/qb1e/JV9+W8uBQASL27www7GK5TVUCHAHrEfGtOad8IO3E/tVsvLztWyq
	 nk9h4VOuJFvHF47/QBcH6HFsyadCGHXBe2v0tATJeltLt76zoDqLG8J1gBvla14iTs
	 qYl8GdH3I7kQwfWv5wJTw1AY09YWAVfqQNB90juvHMVfVzhJb74PzmUe3J72I8oy61
	 du5+LsO06Z8mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/11] PCI/CXL: Expose CXL Reset as a PCI reset
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260709010304.680422-10-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:27:01 +0000
Message-Id: <20260709012701.AB9A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The CXL reset method skips function-scoped validation during execu=
tion, relying entirely on a flawed probe-time check that occurs before sibl=
ing functions are added to the PCI bus.
--

--- Patch [9]: [PATCH v9 09/11] PCI/CXL: Expose CXL Reset as a PCI reset me=
thod ---
commit f2ff500e92a2699aaf86703b4ef5bcf21ad27f7b
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Expose CXL Reset as a PCI reset method

Add the CXL Reset helper to the PCI reset-method table so userspace can
select it through the existing reset_method ABI. Advertise the method for
Type 2 CXL devices that report CXL Reset support in the CXL Device DVSEC.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..ef25ba5f7fe95 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -5092,6 +5093,7 @@ const struct pci_reset_fn_method pci_reset_fn_metho=
ds[] =3D {
>  	{ },
>  	{ pci_dev_specific_reset, .name =3D "device_specific" },
>  	{ pci_dev_acpi_reset, .name =3D "acpi" },
> +	{ cxl_reset_function, .name =3D "cxl_reset" },

[Severity: High]
Does adding this reset method here introduce a regression where multi-funct=
ion
CXL devices are exposed to state corruption when a reset is triggered?

During early system boot, PCI enumeration calls pci_init_reset_methods()
which evaluates this method with probe =3D true. The method then calls
cxl_reset_validate_function_scoped() to walk the bus looking for siblings:

drivers/cxl/core/reset.c:cxl_reset_validate_function_scoped() {
    ...
    pci_walk_bus(pdev->bus, cxl_reset_validate_function_scope, &wctx);
    ...
}

Because function 0 has not yet been added to the bus list at this early sta=
ge
and sibling functions have not been scanned, the bus walk is empty. The res=
et
method is then incorrectly recorded as valid for function 0.

When the reset is actually executed later via VFIO or sysfs,
cxl_reset_function() is called with probe =3D false. This skips the validat=
ion:

drivers/cxl/core/reset.c:cxl_reset_function() {
    ...
    if (probe)
        return cxl_reset_validate_function_scoped(&ctx);
    ...
}

This means the bus is not re-evaluated when the siblings are actually prese=
nt.
Will this proceed to reset the entire device without isolating sibling
functions, resulting in corrupted or lost state for those siblings?

>  	{ pcie_reset_flr, .name =3D "flr" },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D9

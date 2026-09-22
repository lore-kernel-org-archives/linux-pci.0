Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714BF519E06;
	Tue, 22 Sep 2026 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067704; cv=none; b=fPp7PwvTXZdaUhiPySByXEzPt8evV+kR/rHBzg5sySiIVVKqKcuU4wxdlsAiYKPUI4kD18Slfp+0T9Vv0tUwdL+2PiG8+NAwDeT6Z6vyaBGQdqZ7VkWhnoRZz6FoGwzAbLjoS/s/akVA00cqU5e9nmtJxo3Qac/Ng6vcdFp9byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067704; c=relaxed/simple;
	bh=HDk2uqjECrdmm0KEv+wmOTooapEj2nXIR+8q1VWZY0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gaDwH4h/BTHI3QEM7WYrJo2lerJUH4WuRi0yEmOsU0qes2QV4gfA1FtO+RbBTZ6AtvsaOB1Op8Kc5j5iWGXw0cg0SP4rjshMqlC91jeLTac0RPbXjosfnio2cgNJIrpYerEVGneN9+KvTggupQK+q6ZSRoM6v2LbVpY+JGKmdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bchjg9L5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bchjg9L5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EAC1F000FF;
	Tue, 22 Sep 2026 09:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067702;
	bh=Irw2oSggUlTPWIkKnQ6DUA2P6qsac0G2q5DlHYd+Cy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bchjg9L5QxJikWz63JsqPq/twwhKt1p8uN9cZwp5ib6012jxV39oUjW3CX6rSGBpX
	 KXPYiqSEbUuZ2q8LqcuC14SWWugxPEGIaeLRUIdOEmp85Ehw/XSZjAZeIDWoGpNa8r
	 1s4HKSEpqF38Ap5sZq3ZScQGgVB8UXbWDZ4LmP/FS+xSTsyVWLOea5woSF26x+NzO8
	 TTuLFUN/73nUs5aFFFjpIibeTwH2m25F0fArAV93dew83+F9RN81+mcOXMvGxcjKzh
	 MkG4/th3CTC2ik7Wryab35u7mcH4toJZR6FoTh2oJolMNTudrrsaszJrqyek/Fb3Vu
	 KO6COBQaIis+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 15/15] PCI/CXL: Restore CXL state after CXL bus
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922083924.2451158-16-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-16-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:01:41 +0000
Message-Id: <20260922090141.D6EAC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl: HDM state restoration bypassed if SBR is natively unmasked
--

commit 44f7ddf109a23fa1e25d7dc89752e3e7548f5c17
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Restore CXL state after CXL bus reset

CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
control state. Restore the cached state after a successful cxl_bus reset
while IOMMU exclusion remains active.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index dc57a202c91f7..6928c99aa7856 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -5015,6 +5015,7 @@ static int pci_reset_bus_function(struct pci_dev *d=
ev, bool probe)
> =20
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
> +	struct cxl_hdm_info *snapshot __free(kfree) =3D NULL;

[Severity: High]
Will this new HDM state restoration logic be bypassed entirely if SBR is
natively unmasked?

Looking at pci_reset_fn_methods in drivers/pci/pci.c, "bus" is ordered
before "cxl_bus":

        { pci_reset_bus_function, .name =3D "bus" },
        { cxl_reset_bus_function, .name =3D "cxl_bus" },

When SBR is natively unmasked, pci_reset_bus_function() will succeed
during probe and will be placed before cxl_reset_bus_function() in the
device's reset_methods array. During a reset, __pci_reset_function_locked()
executes "bus" first. If "bus" succeeds and returns 0, it completely
bypasses "cxl_bus" and this newly added snapshot/restore logic.

Could this cause CXL HDM decoder state to be lost after a reset on these
devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D15

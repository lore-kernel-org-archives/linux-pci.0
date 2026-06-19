Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7CE311940
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860835; cv=none; b=nXv6yo3GWmub5ccTlLxk3IJknvXBFQ7uFM3s4dBwhIgI4f+oZFwtOw/7W4vNX98QYqWbwfZajUDj4HUUt+VRv7aHDQsrjYUDuukSc6BdGOcAyrhdtLaJ9KZNgsjgYo2bKV2IrEPyGKsN0yY3lnntPwiUQmXtZkbfGEtZUx3QN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860835; c=relaxed/simple;
	bh=fyu0N+gqA4KtaxbCDp/+IOrJ+QlqiOUQn1gY2Eq/ZHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V1VmzixevssXn388VJU3oLucJ6ExbiulMvBZvGieLcapZfEIQ0cMST7c4WGlG23pEbgPE7lsMsrTGLDM6+54XlrUepCllGC/Cse27Ah7xNpsxWWgJ0fCRgxORIy+c+3KYVyjxOTnVoiyWcs4URvh4MHvu3ymp66ieeM6iDxK2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZaadRz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZaadRz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543711F000E9;
	Fri, 19 Jun 2026 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860834;
	bh=YGii88SeH3mE7fJHmWoSNRkQqRgNP1M1PXhxV2izVgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZaadRz5LNJU7M+1wQ6npJpssqvVX4mTsct+jO/qWRK+vHIpzQhHJ0Q+YYABMBI+5
	 wDt8Ch6KaGqgVdvadSLbEmZreLiRaV+N1/I4C3sSvN+CvpODcpWozSgFmMf6M+wdNc
	 lAeiEaMWmISpQtGMFe6ECVfDI+YSa6rlgQP566igJMWtiK9zyH9QhchJ7zMdr/U13d
	 pc7zRWpYhVWP+uzm3wEKcWLYmEtDDBxUd1ypV4mcIcwHEduxwn4rd338+br++ek1Ku
	 SXXSLvG8B2Z0hyKsVcsIxxph047vJ0yegmBQqqXbDq3Fdtr8bGeQk36FrZksxecjHv
	 OGTlvr9c9mC5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 18/25] PCI/sysfs: Remove
 pci_{create,remove}_sysfs_dev_files()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-19-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-19-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:20:33 +0000
Message-Id: <20260619092034.543711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI resource sysfs files are exposed to userspace before their res=
ources are assigned.
--

commit 650a832c0afdbb810823f509ec90847d6a613433
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI/sysfs: Remove pci_{create,remove}_sysfs_dev_files()

Currently, pci_create_sysfs_dev_files() and pci_remove_sysfs_dev_files()
are no-op stubs. With both the generic and Alpha resource files now
handled by static attribute groups, no platform needs dynamic per-device
sysfs file creation.

> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 6c1ad1f542d9b..655ed53436d3e 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -354,7 +354,6 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	pci_fixup_device(pci_fixup_final, dev);
>  	if (pci_is_bridge(dev))
>  		of_pci_make_dev_node(dev);
> -	pci_create_sysfs_dev_files(dev);

[Severity: High]
With the transition to static attribute groups handling the resource files,
are the resources being exposed to userspace before they are actually assig=
ned?

Static attribute groups are created early during device_add() in
pci_device_add(). If firmware has not programmed the BARs at this stage, the
resources remain unassigned with start =3D 0 and the IORESOURCE_UNSET flag.

Looking at the visibility callback in drivers/pci/pci-sysfs.c:

__pci_resource_attr_is_visible()
{
	...
	if (!pci_resource_len(pdev, bar))
		return 0;

	if ((pci_resource_flags(pdev, bar) & flags) !=3D flags)
		return 0;
	...
}

There is no check for IORESOURCE_UNSET.

Since device_add() triggers a KOBJ_ADD uevent, could userspace immediately =
open
these files before pci_assign_unassigned_bus_resources() assigns the actual
addresses?

If userspace reads or writes an I/O resource file during this window,
pci_resource_io() would use start =3D 0, which could allow arbitrary root w=
rites
to I/O port 0 and potentially crash the system.

>  	pci_proc_attach_device(dev);
>  	pci_bridge_d3_update(dev);
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D18

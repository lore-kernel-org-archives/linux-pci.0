Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809673264CA;
	Thu,  4 Jun 2026 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586594; cv=none; b=U+lkfwiZCQoWbdXFVmTm0rebY7dyAUbRhveQAH57ZQfq8PiHOok8Hx1e1AKeLBUErHGvewgwHPvvf++RMXstVJsZMLzVXnFqhoGllq7cunYauHaXcaUddmRrgcXtBaJOCGobHY0RkdsnE0UMkwclJt7HkTxMNGxg7kXQ7Hwl8/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586594; c=relaxed/simple;
	bh=CHdS0pia+E0ZAfgBqlh9PTgMH5zKaiGg+CQP/Tcl9Lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y7+bKen7gbEydnd85PL3oLpKoln/eF5AHpBsgPFlnQmvREjci8ngn5uuDyxamN+4VDFv7BT++stT/Cxg80zNXk+FnlMNjubYOQtB12yHkCUoYUcYGGZwCUqkey7mAoRQUydJt6/aX/ekZdTAkTrbFaCJrEmUeYEYHfzYQe8PJe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExtTuBAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExtTuBAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B9E1F00893;
	Thu,  4 Jun 2026 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780586593;
	bh=6NEQXKJeh2o/nLBDRUlJG6IvhJPPveCDROrBzP4KRG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ExtTuBAshlM4GzIAzK5MqKgdsrD39XVrx/OCYNQk9VfUtEZCOEq04mw43iFjNashy
	 Us0f670sTYX7cvVCXm23cmz98nvrKmoyDt1JC2ITbIusb+yKu9fmYydc2p+4JECBnK
	 VzLj5Y1oM8Ee0tHbqbDpYlhlQZB8xneuTOlhzG6EX0YA7iiCU29dhF+xaRUmmMVN87
	 4M/807bJbrakuE/yR+aJsSX/2GyW368JtTMFhc2Ku5vpAWk7zU4sy0jZ3NgAc73ZPm
	 zPKQhTvwwjmR265TMSKag7WHh4GDXhCnxOjs0RfPOyM5y8VaPlMaUZ8zLz4I8r4e2l
	 SJP9Ni75I8XzQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 11/12] PCI: Initialize and release SIOV capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dimitri Daskalakis" <dimitri.daskalakis1@gmail.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260604150153.3619662-12-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-12-dimitri.daskalakis1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:23:12 +0000
Message-Id: <20260604152312.F3B9E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calculation of maximum SIOV bus consumption silently wraps around =
due to 16-bit truncation, underreporting the maximum bus number and breakin=
g IOMMU isolation.
--

commit 72b51539a88b3ec026656cdb5f408780a8f58cd2
Author: Dimitri Daskalakis <daskald@meta.com>

PCI: Initialize and release SIOV capability

This commit modifies pci_init_capabilities() to discover the SIOV extended
capability and allocate a struct pci_siov. It computes the worst-case bus
consumption from total_SDIs and mirrors SR-IOV initialization patterns.

> diff --git a/drivers/pci/siov.c b/drivers/pci/siov.c
> new file mode 100644
> index 0000000000000..7372ce95714b2
> --- /dev/null
> +++ b/drivers/pci/siov.c

[ ... ]

> +static int pci_siov_sdi_bus(struct pci_dev *dev, int sdi_id)
> +{
> +	if (!dev->siov)
> +		return -EINVAL;
> +	return pci_virtfn_routing_id(dev, dev->siov->offset,
> +				  dev->siov->stride, sdi_id) >> 8;
> +}
> +
> +static int compute_max_sdi_buses(struct pci_dev *dev)
> +{
> +	struct pci_siov *siov =3D dev->siov;
> +
> +	if (!siov->offset || (siov->total_SDIs > 1 && !siov->stride))
> +		return -EIO;
> +
> +	siov->max_SDI_buses =3D pci_siov_sdi_bus(dev, siov->total_SDIs - 1);

[Severity: High]
Does this calculation properly handle 16-bit truncation wrap-around?

If a PCIe endpoint advertises a total_SDIs and stride combination that exce=
eds
the 16-bit routing ID space (i.e. requesting a bus > 255), the result from
pci_virtfn_routing_id() will mathematically wrap around modulo 65536 since =
it
returns a u16:

drivers/pci/pci.h:pci_virtfn_routing_id() {
	return (pf->bus->number << 8) + pf->devfn + offset + stride * id;
}

Because this only evaluates the final SDI index (siov->total_SDIs - 1),
siov->max_SDI_buses could be set to a lower, wrapped value.

Later when reserving buses, this could cause an insufficient number of buse=
s to
be reserved, potentially assigning legitimate SDI bus numbers to other
downstream devices and breaking IOMMU isolation.

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150153.3619=
662-1-dimitri.daskalakis1@gmail.com?part=3D11

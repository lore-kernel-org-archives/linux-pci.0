Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555D334C1F;
	Thu,  4 Jun 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586600; cv=none; b=QT/CGnIdYbYMrsPCNFJeBnn1Fwn2uQboIf1YksFp/5o7nE5UWc09xb2ZxohZtwkjNwgE3Do63GgmZZr+BnthUSQJmnuHopfC9yvMoH0dFUrIeTbZmTwxcMEEeaXgYhOgsvRCfzT9cRuEktAiJJKld/h9Zcg7vf4eUJeZ+beBbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586600; c=relaxed/simple;
	bh=4ZBa/mylKJUvf3fkA/emIvhHwwS4lWypGKfQwFGFH54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NnFZnoath/JcR5dsIJgxhN9V17XCZ4HfMNA6QVg5h9HdynGEsaL8La2HCnQmrerAw8+R6YyFNzo4fA73DWJYsZyGnDJD4zD1XthbkrG6CISJgbt7cxAfNq8lbbuctYQ30TZJ3ww7KmZNDmp31tMWBMuYEdp8d7yGHEZjcT2SwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzGYJGMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzGYJGMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BDA1F00893;
	Thu,  4 Jun 2026 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780586598;
	bh=v4MSCF+ZT/9tx1uh0/OLmbJ7i6I3FhVhCeg7u+k8GAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nzGYJGMan48Vp5nfo4VSJoQUd1qTFKZF9stlXKOoKqMO6JkKlB3SHCZ4x1rhgsQT8
	 MN/5uBXwjXB0nDaZ40NnID22r52dHSG0g7leuAhkf5jdkvOHjUdD4aYRLAfM6vI0M/
	 GzVWhwX3xDeMLoaU1AAnptQFTYIbbO5YYxTVfP5Kzvgm/fdpSL6hSYwDGVQunAz81T
	 jIonrhUhFu9r4GlQOQRzkZc1CBBwucbzW3NUcFN0Z1dePvgm/ddG3Dux4rh0SY4GYX
	 b0uORSsN+fg1KxkjFzkWMcuGkaLJ0vtFcHRVc7H37Ypa8nrjVlQi0z6OpVGktTtKj6
	 +Aem0szWDlcMQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 10/12] PCI: Add Scalable I/O Virtualization data structure
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dimitri Daskalakis" <dimitri.daskalakis1@gmail.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260604150153.3619662-11-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-11-dimitri.daskalakis1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:23:18 +0000
Message-Id: <20260604152318.B2BDA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Refactoring of VF routing ID calculation introduces a silent 16-bi=
t truncation that bypasses the maximum bus number bounds check.
--

commit ca9b97e7dff7c499701ce4b55ae9cf14d51bbed7
Author: Dimitri Daskalakis <daskald@meta.com>

PCI: Add Scalable I/O Virtualization data structure definitions

Define the PCIe SIOV extended capability registers per the PCIe 7.0
spec, and introduce the kernel-internal data structures needed to track
SIOV state on a Physical Function. Add an is_siov bit to struct pci_dev
along with helpers to identify SIOV PFs/VFs.

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 45411960fd2ef..fd7c04e26c164 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -683,6 +683,19 @@ struct pci_sriov {
>  	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
>  };
> =20
> +/* Scalable I/O Virtualization */
> +struct pci_siov {
> +	struct pci_dev	*self;		/* This PF */
> +	u32		cap;		/* SIOV Capabilities */
> +	u16		pos;		/* Capability position */
> +	u16		total_SDIs;	/* Total SDIs associated with the PF */
> +	u16		num_SDIs;	/* Number of SDIs currently enabled */
> +	u16		offset;		/* First SDI Routing ID offset */
> +	u16		stride;		/* Following SDI stride */
> +	u16		driver_max_SDIs;/* Max num SDIs driver supports */
> +	u8		max_SDI_buses;	/* Max buses consumed by SDIs */
> +};
> +

[Severity: High]
This patch series relies on the pci_virtfn_routing_id() helper introduced in
an earlier commit ("PCI: Add helper to compute VF Routing ID to pci.h"), but
doesn't this helper introduce a silent truncation issue?

In drivers/pci/pci.h:

static inline u16 pci_virtfn_routing_id(struct pci_dev *pf, u16 offset,
				     u16 stride, int id)
{
	return (pf->bus->number << 8) + pf->devfn + offset + stride * id;
}

If the calculated bus number exceeds 255, the internal calculation exceeds
0xFFFF and is truncated by the u16 return type.

When this is used to determine the bus number in drivers/pci/iov.c:

int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
{
    ...
	return pci_virtfn_routing_id(dev, dev->sriov->offset,
				  dev->sriov->stride, vf_id) >> 8;
}

The right shift is performed on the truncated 16-bit value, resulting in a
wrapped-around bus number.

Consequently, does this allow the bounds check in sriov_enable() to be
bypassed?

drivers/pci/iov.c:sriov_enable() {
    ...
	bus =3D pci_iov_virtfn_bus(dev, nr_virtfn - 1);
	if (bus > dev->bus->busn_res.end) {
    ...
}

Because the wrapped-around bus value appears to be within bounds, this could
allow VFs to be enabled on invalid, overlapping bus numbers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150153.3619=
662-1-dimitri.daskalakis1@gmail.com?part=3D10

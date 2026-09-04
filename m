Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456821A6807
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490862; cv=none; b=UonWC2OKBX/5MzDfvLdcJvn1aeMdtDGSvrI3JRMpEK25baYRMKzWK3KmvDAGa12svqC+aZAzFkaV7X0rTLaGL4I4D7TAef3H+7qnvBFC7y/USxmDTUzdHoWzoEh8BBNOn0FUdqcXf2EW9uDMZk0Y/aNgGAwNE2duDiXySokYjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490862; c=relaxed/simple;
	bh=43BE9scOf1qtx10oMCtenlAJec5UwB6Jw6HV1WXuIWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=caY/ZOnm9cIy4P6MCltXzGT0c6/9iWTF2gY5jWOPXfQa6Z38PmV47F95Dzw4klYwiqqbQsbcPJCMArU77pLg9Jj3LzdMflxcNa2l+s8231Gfs3WoSBXqSKMwEkiBZ5O9qrv+OWCEYvT9/Mzpi4X84KZnwC0mvX0Fj4U/PverI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HidwQhyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HidwQhyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66361F00A3D;
	Fri,  4 Sep 2026 03:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490860;
	bh=DhcmFLrKrw+UqsXotv5f7y3kcaO5vwJuOiu9lDE7Mco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HidwQhyiJ+xWpXiR/PoQjZLa3nTU8sx9iTch2oYTvB2Uc8p+kv8u7RYdMNjStN3kn
	 BecD9+v2IZEBHAlJkwG83sg+25uZQSFsmIxMjYsKQMvfx9Pgf5GuHqLQEwCyQfbnyC
	 P6BYE8/VJepcCbKdyamDh3jv7XqCQiwQzZuIZc0DXQM2UKylLgYzadMGoarhKBqF7V
	 wRXL1l/xKkH8L9F+zHJQX9KWv4sYhoH00S03rBKX3ifOK2gBwIEkmjvzziqOLFCy3X
	 3scBjzM25yCB1NZS+08Nef8RBGUMRcW8fR7rWVD0U5f+JYJZur664g8rb35U/nKG98
	 aNFWTCknPjJ4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] PCI/pcie: Add PCIe Lane Margining at Receiver
 (LMR) support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260904-pcie-link-endpoints-v2-3-16fcb301a3e4@google.com>
References: <20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com>
 <20260904-pcie-link-endpoints-v2-3-16fcb301a3e4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 03:01:00 +0000
Message-Id: <20260904030100.B66361F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Manual port type checking for downstream/upstream components misse=
s PCI_EXP_TYPE_PCIE_BRIDGE, causing lock inversion deadlocks and violating =
PCIe spec initialization order.
--

commit 1a49529648026f2ee499ea16e34fdf520b1c02fb
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

This patch adds support for PCIe Lane Margining at Receiver (LMR) capability
(mandatory for Gen 6+ links, optional for Gen 4 and 5). It provides a debug=
fs
interface to view capabilities and execute margin timing/voltage commands.

> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> new file mode 100644
> index 0000000000000..1dde5aa928c74
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c
[ ... ]
> +static void pci_lmr_get_ports(struct pci_margin_dev *mdev,
> +			      struct pci_dev **downstream_port,
> +			      struct pci_dev **upstream_port)
> +{
> +	struct pci_dev *dev =3D mdev->dev;
> +	struct pci_dev *partner =3D mdev->partner;
> +
> +	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {

[Severity: High]
Does this manual port type check miss PCI_EXP_TYPE_PCIE_BRIDGE?

If the device is a PCI-to-PCIe bridge, it acts as a downstream-facing port
but would fall into the else branch here. This incorrectly classifies the
bridge as an upstream-facing port, reversing the downstream_port and
upstream_port assignments.

> +		*downstream_port =3D dev;
> +		*upstream_port =3D partner;
> +	} else {
> +		*downstream_port =3D partner;
> +		*upstream_port =3D dev;
> +	}
> +}
[ ... ]
> +static ssize_t margin_enable_write(struct file *file,
> +				   const char __user *user_buf, size_t count,
> +				   loff_t *ppos)
> +{
[ ... ]
> +	} else {
> +		struct pci_dev *partner;
[ ... ]
> +		if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +		    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {

[Severity: High]
Can this missing PCI_EXP_TYPE_PCIE_BRIDGE check cause an AB-BA lock
inversion?

When LMR is enabled via debugfs on a PCI-to-PCIe bridge,
pcie_get_link_endpoints() correctly identifies it as a downstream-facing po=
rt
and locks it first. During disable, the missing check reverses the
assignment, locking the link partner first and risking a deadlock if called
concurrently.

> +			downstream_port =3D pci_dev_get(dev);
> +			upstream_port =3D partner;
> +		} else {
> +			downstream_port =3D partner;
> +			upstream_port =3D pci_dev_get(dev);
> +		}
> +	}
[ ... ]
> +void pci_lmr_exit(struct pci_dev *dev)
> +{
> +	struct pci_margin_dev *mdev;
> +	struct pci_dev *partner;
> +	struct pci_dev *downstream_port, *upstream_port;
[ ... ]
> +	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {

[Severity: High]
Can this similarly cause a lock inversion deadlock during device removal?

If LMR is being concurrently manipulated, the missing
PCI_EXP_TYPE_PCIE_BRIDGE check reverses the locking order for the downstream
and upstream ports, potentially freezing the kernel.

> +		downstream_port =3D dev;
> +		upstream_port =3D partner;
> +	} else {
> +		downstream_port =3D partner;
> +		upstream_port =3D dev;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pcie-link-=
endpoints-v2-0-16fcb301a3e4@google.com?part=3D3

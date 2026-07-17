Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84093B995D;
	Fri, 17 Jul 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301042; cv=none; b=mAqezEXsYCU5f6Q9iq6YmgfH1yTEFKUe1A5AgYoDtKrfb1V+kLmgSgQc6bKO/0WmlMtr8T07yLFqYHOreWxHRUtTzGk1UeAqC1Hrtqqiehnq0iUEw/IRxGBTzDKyngxD7L6/6As5YCoODD2L4ZCFkdIUweCg+5l0XMcCT6xHByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301042; c=relaxed/simple;
	bh=rg0Bf2X55+aJsts5MpLagB+B5GZgaVlf/IrAo90cCXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WvNlDUh1uXMLoa/xGpFC7Q0w2sLyRQZaoLVCvTA7iYEovJAKWAVH4WFp6QagxOTygjyTwyBdL8XLzV0Irji2WsHCU+SHbkapye3Axx9wMdhTv1LVAo58cA35YSNdCRoAn3M3KTbAVztVFvLagQz86khxBS3OO0y6ah4KZgROROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWkXjbrj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWkXjbrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530CB1F000E9;
	Fri, 17 Jul 2026 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784301040;
	bh=pQlFtsliuNfMVQ1pO5lalDno7B2qXCnuniyBGWwHM2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWkXjbrjEJuoxahGHjSJXctJBiipY4gBCOsakKW0uno60neUsVlOJVcrzXwkMmPPN
	 W8JF0D/kDXVnxFLErkOV/6Mkerj6V4XNhCa9F5cpNUf8u+GfAfyim6umDL5afScLHP
	 aN9422nr0z2tGqZFAhMWJeDBF66+vjjTErvdEfH75gwdTeIQl8qmxl6zVdVsKawxHd
	 XBX7lvtSwDi0+WAWfcQNG8AeJcWlkw/7+41t79rDUhRq1CmD9TbamlUMXJonqVLx2/
	 yfsjWWlbgqJmSdtEYemIs6TXmdKC6oX564RHTMTBuNH/aUi+IUj8RsoEM69R8+9ALI
	 eP/j6xkYfjqPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/10] PCI: of: Set fwnode device of newly created
 PCI device nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717145147.823749-9-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:10:39 +0000
Message-Id: <20260717151040.530CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `of_pci_remove_node`, a NULL pointer dereference or memory corr=
uption occurs if the PCI device's device tree node was provided by a device=
 tree overlay rather than `of_pci_make_dev_node`.
--

--- Patch [8]: [PATCH v10 08/10] PCI: of: Set fwnode device of newly create=
d PCI device nodes ---
commit f4dcbb5e22115fd2e6073441c7d4ac5e66dae5c4
Author: Herve Codina <herve.codina@bootlin.com>

PCI: of: Set fwnode device of newly created PCI device nodes

This commit sets the fwnode device for PCI device nodes dynamically created=
=20
by the PCI core. This ensures that fw_devlink creates correct links pointing
to the PCI device rather than walking up to the PCI host bridge when overla=
ys
are applied.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 6a533f9bbf3c5..a98f360c289ae 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -657,6 +657,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>  		return;
> =20
> +	fw_devlink_set_device(&np->fwnode, NULL);
>  	device_remove_of_node(&pdev->dev);

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer=20
dereference or memory corruption if the device tree node was provided by=20
a standard device tree overlay?

If a user applies a standard device tree overlay describing a PCI device,=20
the newly created device node will have the OF_DYNAMIC flag set. When the=20
PCI device is later removed (e.g., via PCIe hotplug or device unbind),=20
of_pci_remove_node() will see the OF_DYNAMIC flag and execute these lines.=
=20

However, since the node was created by a standard overlay and not=20
by of_pci_make_dev_node(), np->data may be NULL or contain unrelated=20
data. Is it safe to unconditionally pass np->data to of_changeset_revert()=
=20
and of_changeset_destroy() here?

>  	of_changeset_revert(np->data);
>  	of_changeset_destroy(np->data);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717145147.8237=
49-1-herve.codina@bootlin.com?part=3D8

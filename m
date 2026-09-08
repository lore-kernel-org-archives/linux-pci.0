Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979D492E28
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909231; cv=none; b=arcanmYbO8B7CS0+IWBbPOPLK2ZiUn+83WSTninLm0dZlvl5aujg9wEwv1eU748ysSxQC0q6mFvTuQJ17IZnCqt3cgXPs1KugjwwbDxDTZiNMoyGyRX2OXiy0lKUBOOG92dCCG+CI+cPsk9pqT5+VmTCiDHdfU6JGb0M5CsPcKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909231; c=relaxed/simple;
	bh=78e91oN67zU1jyFMwrNMUpv3/C8d1ZVGcTJGYFuTPA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UnxJNzibHBE4vTrxJ26dHrMFfyxgwkMUAJhufanOn5TQ1wABuhR+ZJJa/fTMNklcUFGkamSDevjsSJDclphR5HO6S/0hl+mPc4Yxl9fyjVy59jvKkBcZBAybNvwQ6EL0jJKnjFTn+3gC0KBpv/TwCkE43fM4owmvczwBydiY/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7RCshke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7RCshke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682101F00A3A;
	Tue,  8 Sep 2026 23:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788909229;
	bh=DxLRI577wFA2Ug7GM4yuDNC/CH33CulzAsn7HA29nzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7RCshkeT93cXo6NcsPsKcO6C7Fzb5m7i1J6hsTQpfrV0KtCz9VLp8UV4xggRZXYR
	 SfWA1Y/KK/AJnixCMLusejaJ3Y4s3mTmSKetOj9++gagmmLWCn4AxL8YJ4a/gPhWSa
	 P/0Z1HKzLzlCtGwGetw77UWyDNBX5JbJnENPY0IYEJDc1Drj377hJyi/Ykg8U9dg5q
	 5+ayfNX3ZdegyQUCX9oGcjady+WDlsmNghHBXNrCbWd/KrO5UfrCQlbahpvPGBamwm
	 H3t8GOUTQyApB6azBLVNRcpZuRxsNGVFpxo1eM76EXuvZVO/LsNE2KjGmpx5rO62mt
	 X98bzDuTGoFbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI: Fix BAR resize for devices on a root bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liz Fong-Jones" <lizf@honeycomb.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io>
References: <20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 23:13:48 +0000
Message-Id: <20260908231349.682101F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Stricter resource assignment check on root bus fails BAR resize if=
 optional resources (like ROM BARs) cannot be assigned.

Pre-existing issues:
- [High] Space stolen by other devices during resource assignment breaks th=
e rollback in the `restore` path.
--

commit 72e60fcada94a7186e28648f6c748fdfeb09e254
Author: Liz Fong-Jones <lizf@honeycomb.io>

PCI: Fix BAR resize for devices on a root bus

pci_do_resource_release_and_resize() releases the device BARs that share a
bridge window with the BAR being resized, but when the device sits directly=
 on
a root bus it skips resource assignment and leaves the BARs unassigned.
When there is no upstream bridge, this patch calls pci_bus_assign_resources=
()
on the root bus to place the released BARs. A stricter validation is then u=
sed
to fail if any unplaced resources remain.

Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2159596

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d3c12..ed16ef7c26fa7 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c

[ ... ]

> @@ -2415,13 +2418,21 @@ int pci_do_resource_release_and_resize(struct pci=
_dev *pdev, int resno, int size
> =20
>  	pci_resize_resource_set_size(pdev, resno, size);
> =20
> -	if (!bus->self)
> -		goto out;
> +	if (bridge) {
> +		ret =3D pbus_reassign_bridge_resources(bus, res, &saved);
> +		if (ret)
> +			goto restore;
> +	} else {
> +		/* No bridge window to adjust; let the core reassign the bus. */
> +		pci_bus_assign_resources(bus);
> =20
> -	down_read(&pci_bus_sem);
> -	ret =3D pbus_reassign_bridge_resources(bus, res, &saved);
> -	if (ret)
> -		goto restore;
> +		list_for_each_entry(dev_res, &saved, list) {
> +			if (!resource_assigned(dev_res->res)) {
> +				ret =3D -ENOSPC;
> +				goto restore;
                                ^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but does jumping to the restore
path risk leaving the device unassigned if the original resource space was
stolen?

If another device on the same bus is assigned into the space just freed by =
the
target device during pci_bus_assign_resources(), the restore path in
pci_do_resource_release_and_resize() will fail to claim it back:

	list_for_each_entry(dev_res, &saved, list) {
		...
		if (pci_claim_resource(dev, i))
			continue;
		...
	}

Since pci_claim_resource() fails when the space is occupied, could the devi=
ce
be left with unassigned BARs and completely broken?

> +			}

[Severity: High]
Does this stricter check unintentionally fail the BAR resize if an optional
resource (like a ROM BAR) could not be assigned?

If a driver requests a BAR resize and pci_bus_assign_resources() succeeds f=
or
the resized BAR but leaves an optional ROM BAR unassigned, the check for
!resource_assigned(dev_res->res) will trigger a rollback with -ENOSPC.

Could this functionally break valid BAR resizes on root buses just because =
an
optional resource was unassigned?

> +		}
> +	}
> =20
>  out:
>  	up_read(&pci_bus_sem);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-pci-rebar-=
root-bus-v5-1-a210f405ea81@honeycomb.io?part=3D1

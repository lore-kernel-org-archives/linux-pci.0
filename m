Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1F448B90
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784912756; cv=none; b=CZkm23/aRYmRIJXAtGm3MIswZkBA+5IBnQHGHpe89N5wcVUqs6sNAx0YSR+SdKomkGbf7ZzirURrq7Ct01YO8LsU3afVYmy+qs83wXs9KID/vMBvdk80lb8+rpQlIJiWkT8JCWDKYAXY6qMkHH4CkohCtl8Cf1Y8cKvyFgV12SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784912756; c=relaxed/simple;
	bh=YZY0iA86WFPIDawFMi6W/mItvM4jAPBXEndO9IUY0xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rLVRhce39NDROjbATxA5hB7ATnDml/nVWuWGHCkjplzwhLstQrV89Q3EhjRjkUO0LpXsXk93h3z1Xcln+uxV3w+tCzLowmlDyaxwHQltNdoNyCopgVhWVP9gSdBewEdSChdSdPgGIBcmrj1vg8fvfP/iutHl/TP8N1ealw5YxfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT7/K3pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT7/K3pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397EA1F000E9;
	Fri, 24 Jul 2026 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784912752;
	bh=/adB0zgBx2dDSRMM6dg7GSeuKf5C1PPeHNjV3Y+lmSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iT7/K3pe/fpnmu4AYgxukx109c5Iiz2HMbgO+gbznXFEu1DuyIqG/mVfaAqBtiPTS
	 i23mbsqEG/+LIM5fjaEuLogAdoFr/8XYWyj+arPW9yG7NaK9fg1H4wJ0NC5AXwudSJ
	 fsacaa/5/kL60SPqwM7R5xVSn546u9FX4x8lBgu6YaYsAmfuviTm0ziPmCw5gAF+jN
	 enDTTCLqNjF0RBGc1cFl1ZimMWGk+8S+xuysXafJygcSkpja+44eHc1Iy2B/Smx4cr
	 ko/3BP+7I0Sps+qP5sByY2Bh2LiGyl6vaxq6YhFzkc/3AguPN1A/OZNwN2Y6XdYHAS
	 x5R8Aq0X1O+xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] thunderbolt: Add device links for Apple T2 NHI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260724164641.2239-3-atharvatiwarilinuxdev@gmail.com>
References: <20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com>
 <20260724164641.2239-3-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:05:51 +0000
Message-Id: <20260724170552.397EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless traversal of the PCI bus devices list exposes the driver =
to a use-after-free race during concurrent hotplug or sysfs device removal.
--

--- Patch [2]: [PATCH v4 2/2] thunderbolt: Add device links for Apple T2 NH=
I ---
commit ee5a1e7f9e85d72f9c6e9327c898de2f33a51e3d
Author: Andre Eikmeyer <andre@negmaster.com>

thunderbolt: Add device links for Apple T2 NHI

This commit adds device links for the Icelake Thunderbolt NHI on Apple T2
Macs. It finds the root ports (TRP0, TRP1, etc.) in ACPI and creates device
links to ensure PCIe tunnels can be re-established after sleep.

> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index c69c323e6952a..625451ff3ea08 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c

[ ... ]

> @@ -3305,21 +3307,73 @@ static const struct tb_cm_ops tb_cm_ops =3D {
>  static bool tb_apple_add_links(struct tb_nhi *nhi)
>  {
>  	struct pci_dev *upstream, *pdev;
> -	bool ret;
> +	bool ret =3D false;
> =20
>  	if (!x86_apple_machine)
>  		return false;

[ ... ]

>  	upstream =3D pci_upstream_bridge(nhi->pdev);
>  	while (upstream) {
>  		if (!pci_is_pcie(upstream))

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this function
I noticed a pre-existing issue further down in tb_apple_add_links():

	for_each_pci_bridge(pdev, upstream->subordinate) {
		const struct device_link *link;

		if (!pci_is_pcie(pdev))
			continue;

Could traversing upstream->subordinate without holding the pci_bus_sem read
lock lead to list corruption or a use-after-free?

If a user concurrently writes to /sys/bus/pci/devices/.../remove for one of
the downstream ports while the Thunderbolt host controller is probing,
pci_remove_bus_device() could delete the device from the list via
list_del(&dev->bus_list) while this lockless traversal is happening.

The newly added T2 Mac path safely avoids this by using pci_get_slot(),
which handles the locking internally. Would it make sense to acquire
pci_bus_sem for the older architecture paths as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724164641.2239=
-1-atharvatiwarilinuxdev@gmail.com?part=3D2

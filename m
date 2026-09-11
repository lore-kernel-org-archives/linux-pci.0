Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF44749C9
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132522; cv=none; b=MbvyAFGaOtSF8FAgBc1SYOrM2IN5CQjDTsQ6OEv1RIybTohhSmDvH+MeAWB4P2Ci14IKvaTNWH6WqI2zcAT/f98KQL1wMxBV2EvtA5fu1gg32P3qcpCIr4mg2PwvmWTIIsSDiDplLwpqyjAltn8DQYsW7UNQEuuRx1eLMiAyN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132522; c=relaxed/simple;
	bh=eWRuRkFbOMBJ3z5WzNHBimXlqZ5VSjHeVrK9+7P3zlY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SmzJ+BNaCpivmOcQRBoVHhw4HpPOPhljc+xZLI+YI5RAnR6KuiG9ljp4ERy9WX1eW6rwL/DqQis3S+LX4mPeeXOmRBkLHEGHHh9n84bynPmryIBIsXjkcGMklke3OSib0p/+1IFOjHcTXLEQkQqw9T+ZNgNXsCeQJGHbBCl2xAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvQ8BLf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvQ8BLf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD6C1F000FF;
	Fri, 11 Sep 2026 13:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132519;
	bh=82k+1lQ+KS2c+I1tXl3+x3BsDlqBb2LDinYoOo0TnIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HvQ8BLf6WN0D4Azk31PyDDXBlhwW+u8N7aHtauolRb50UncBGUYDUkI75v1h94qLQ
	 krpDfnGdBYev12PjR3t30eyPjsYfuNs6IVaAZVSd0l4QhztooKyOkL5ihJ3+bK3HPV
	 OQU9QMK86tj23+vj4O9TdBkY3qe/U77xIHWtdgalTxH94BFE66eTog0gtV9V1jYFNV
	 7NhrFrC6wz6Uj3J7/VUROg1t6Bq7HcPiHlsXQN7NtbHHrk97N9yjrNMOYjMw5w8LwN
	 BQifRN5EhZs8O1ePriER8BuQbiviig+7EhgKCkRYLYnJ8Qj4jsmSv5kEiiBuZGq26y
	 dmGynP9c7fGPg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] iommu: set up the default domain outside
 iommu_probe_device_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911125907.67105-3-sakacpav@amazon.de>
References: <20260911-vfopt-s2-v1-0-fff3db7e01c2@amazon.de>
 <20260911125907.67105-3-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 13:15:19 +0000
Message-Id: <20260911131519.9BD6C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] A sysfs linkage failure for one device causes the innocent initiat=
ing device to be removed from the IOMMU group and fail its probe.

Pre-existing issues:
- [High] Concurrent device hot-unplug can trigger a Use-After-Free during `=
bus_iommu_probe` list traversal.
--

commit bbc77bf7c83c2e939356c6c9d4fe1de6d5066ed7
Author: Pavol Sakac <sakacpav@amazon.de>
Subject: iommu: set up the default domain outside iommu_probe_device_lock

This commit defers the default domain setup in iommu_probe_device() until
after the iommu_probe_device_lock is released. It moves the setup under
group->mutex and uses a group_list for deferred initialization, similar to
bus_iommu_probe(). It also updates error handling and rechecks for default
domain setup to prevent races.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a5e3327aeacaf..48fe22bbd1bc2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
[ ... ]
> @@ -735,6 +728,9 @@ int iommu_probe_device(struct device *dev)
>  		return ret;
> =20
>  	mutex_lock(&group->mutex);
> +	/* Only the caller that queued the entry may unlink it. */
> +	if (!list_empty(&group_list))
> +		list_del_init(&group->entry);
>  	/* iommu_group_link_device() is all-or-nothing. */
>  	for_each_group_device(group, gdev) {
>  		if (gdev->linked)
>  			continue;
>  		ret =3D iommu_group_link_device(group, gdev);
>  		if (ret)
>  			goto err_remove_device;
>  	}

[Severity: High]
Does this loop abort the entire group setup and fail the innocent initiating
device if a different device's sysfs linkage fails?

If another device in the group has a sysfs linking failure, this loop will
abort and jump to err_remove_device.

[ ... ]
> @@ -765,8 +775,15 @@ int iommu_probe_device(struct device *dev)
>  	if (own) {
>  		list_del(&own->list);
>  		__iommu_group_free_device(group, own);
> -		iommu_deinit_device(dev);
>  	}

[Severity: High]
Down here in the error handler, it unlinks and frees the innocent initiating
device (own) instead of handling the broken device that failed to link abov=
e.

Can this create a permanent cross-device failure state where one broken dev=
ice
prevents other devices in the same group from probing successfully?

> +	/* Members left behind stay attached; give them the DMA ops owed. */
> +	if (group->default_domain)
> +		for_each_group_device(group, gdev)
> +			if (dev_has_iommu(gdev->dev))
> +				iommu_setup_dma_ops(gdev->dev,
> +						    group->default_domain);
> +	if (own)
> +		iommu_deinit_device(dev);
>  	mutex_unlock(&group->mutex);
>  	if (own)
>  		iommu_group_put(group);	/* iommu_init_device()'s reference */
[ ... ]
> @@ -2077,7 +2094,10 @@ static int bus_iommu_probe(const struct bus_type *=
bus)
>  		 * that the cross-group default domain type and the setup of the
>  		 * IOMMU_RESV_DIRECT will work correctly in non-hotpug scenarios.
>  		 */
> -		ret =3D iommu_setup_default_domain(group, 0);
> +		ret =3D 0;
> +		/* A hotplug probe may have finalised this group meanwhile. */
> +		if (!group->default_domain)
> +			ret =3D iommu_setup_default_domain(group, 0);

[Severity: High]
This is a pre-existing issue, but can concurrent device hot-unplug trigger a
use-after-free during the list traversal in bus_iommu_probe()?

Earlier in this function, bus_for_each_dev() populates group_list with
group->entry without incrementing the group's reference count. If the last
device in a group is concurrently hot-unplugged after bus_for_each_dev()
completes but before the group is processed in the list_for_each_entry_safe=
()
loop above this block, the group's reference count drops to zero and the
group is freed.

The subsequent list_for_each_entry_safe() traversal then reads from the fre=
ed
group (e.g., group->entry.next) and attempts to take its mutex.

>  		if (ret) {
>  			mutex_unlock(&group->mutex);
>  			return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s2-v=
1-0-fff3db7e01c2@amazon.de?part=3D3

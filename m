Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D9475341
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132465; cv=none; b=TpHZzMrvhu+wZ60EEmVp79ZmEWTOewSNBJJKMNSeSPqqb2z9gQOhZTZrQBX+3uYFeNr20/5dGG9xA+Zp4JY3XElhE3NTcuiIc+EokYlXJftL49IR5KFnww0sPbWphiSoRvWqnXQ4HcgQG9qr3KuWoFMswqhqlMUEISuXCft7rIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132465; c=relaxed/simple;
	bh=AcUVEtSO5OsLEWQL86jCN2f60qrElqlZquoq13JAJ5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HkmVRDP7ATm5tRX3hgzAqRtPMR6Vho85J6ounI/oSVCo5DA0A5BK91UOdDrb55V8cPQG2feOodH1H1l1T0YbBRgaq+kiUhJd9P/lyoIflnx91PFOa5ww1bb87g6risSoOKA+p+jR/4G4pkJG6sanNzsoZy8MCKmPdcJc2IwEjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLsgKsc/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLsgKsc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF821F000FF;
	Fri, 11 Sep 2026 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132463;
	bh=q0aReGAstp/DeEbFo5RnOlKHEmEXrzA9lgXczEpYTNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLsgKsc/XfKYF2iqxZpT36nQ9SvRlnVjH3GjzjhjGNX0DeeXs+Wd0135qFCzzv6Yv
	 vUqiVYskQhmYStpT1E3ybdprCfaX5nCPv6AXgAtzRDoq0BLgoKl9aIYPdXf5gL75y8
	 r0m+FGfpxZn4ALWdolcGv3Q3Z+g6ZbegUvIzuCg8YpFnDdUfzUCbWbije2CiG4/qvG
	 Tt15Satq6UistoLvdWqi0cLZJT/TbWUUKvCx/XmRtKKFZK4E+qM39Wh1pkBN+jUGF1
	 s45eeg/80yojSE/qoSTXNQYTloza6CUKWKdmYD029fGKetmFHMaH5Ck2hdIHT8a5zn
	 ulr4F7h72n76Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] iommu: split sysfs link publication out of
 iommu_group_alloc_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911125907.67105-1-sakacpav@amazon.de>
References: <20260911-vfopt-s2-v1-0-fff3db7e01c2@amazon.de>
 <20260911125907.67105-1-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 13:14:23 +0000
Message-Id: <20260911131423.BCF821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dangling stack pointer in `struct iommu_group` when `bus_iommu_pro=
be` fails.
--

commit 40e2c611e51a4bd6297705c58373104232dd8541
Author: Pavol Sakac <sakacpav@amazon.de>
Subject: iommu: split sysfs link publication out of iommu_group_alloc_devic=
e()

The patch separates sysfs link publication from iommu_group_alloc_device().
It moves all per-member sysfs publication into a new helper,
iommu_group_link_device(), which sets a linked flag to handle teardown
correctly. This change prepares for a later commit by providing a single
seam for sysfs publication.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9af..5f92981d9f345 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
[ ... ]
> @@ -667,6 +663,11 @@ static int __iommu_probe_device(struct device *dev, =
struct list_head *group_list
>  	 */
>  	list_add_tail(&gdev->list, &group->devices);
>  	WARN_ON(group->default_domain && !group->domain);
> +
> +	ret =3D iommu_group_link_device(group, gdev);
> +	if (ret)
> +		goto err_remove_gdev;
> +
>  	if (group->default_domain)
>  		iommu_create_device_direct_mappings(group->default_domain, dev);
>  	if (group->domain) {

[Severity: High]
This is a pre-existing issue, but does returning an error from
__iommu_probe_device() (either here or later in the function) lead to a
dangling stack pointer in the group_list?

Looking at the later part of __iommu_probe_device() in drivers/iommu/iommu.=
c,
it adds the group to the stack-allocated group_list:

	} else if (!group->default_domain) {
		/*
		 * Defer setup to the caller draining group_list; both in-tree
		 * callers pass one.
		 */
		if (list_empty(&group->entry))
			list_add_tail(&group->entry, group_list);
	}

If a subsequent call to __iommu_probe_device() (or any probe failure during
bus_for_each_dev()) returns an error, bus_iommu_probe() will return immedia=
tely:

drivers/iommu/iommu.c:bus_iommu_probe() {
	...
	LIST_HEAD(group_list);
	int ret;

	ret =3D bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
	if (ret)
		return ret;
	...
}

Does this leave long-lived struct iommu_group objects with their group->ent=
ry
pointers pointing to the discarded group_list stack frame? This could corru=
pt
the internal state of the iommu_group and permanently skip deferred setup f=
or
these groups in future retries, because list_empty(&group->entry) will
incorrectly return false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s2-v=
1-0-fff3db7e01c2@amazon.de?part=3D1

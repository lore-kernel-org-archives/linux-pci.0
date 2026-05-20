Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3352C11CF
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313533; cv=none; b=R0NaZd040Mp64v2TJ9/Ccwj9L7nYyuIlh5yxV9JO2Ru23NsqZSvak0E8P2Jt9IhrLj8q2vmkTXaOGwFxaFcElKkqW0UC7u8lsYY2+RYEBX0RTJbYLNuendkNHrkMZA854lmGKKVPbTWk6+GWK2z0CNlHmMS+zboMBZS+jDOxZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313533; c=relaxed/simple;
	bh=Aa3fqoKZm3j64VZe4oIttfwO4JjnS9EFHMB8RESJC7U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQpR8Rw9fwpRq/JV10p70GZEqPvjyv4BH/DOqhTyNPeV8OlQYiwbP2LLU7L47eULpxeQwGIHd+Z/sBmigTDaMxFcn2lVYcLRES4deRGX8SsQkdLCYdCEbeeIWNyBHewhk0+Jfg9Lg+SN2ZKaiuDMLyaS7ushjtyXhSg63spd51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZh/FKLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZh/FKLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E74B1F000E9;
	Wed, 20 May 2026 21:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779313532;
	bh=JDo+o7R4vlDoYJj3JNYPDC5dAAgJB4yuyOyeeAUKP1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OZh/FKLmU13c9NJTG0IXwNrza/HuAYxyAQwJb+fcy32DXCG5z0Lk5e8FPE1Dj/RpB
	 +E8SCDK9rxF7vHipPvSOH0j4Wznqo94+ATD54kS0h/dxdIUqDAunghJF0hQlpO1dvo
	 kpwZQpVisS74eVY//7MZlXG2nX6Af9vS3V+U/wISTO+q2gaJsWLzsogrd+5a5xWFv/
	 z2VsbLPbd7+JDcqWd9+O4Trq62KiUQSp2aw/L/ZvpYK8IqCapc4ePivSa2LNYN/h+C
	 BZO65AA6VDYQt76jNl6Xj1gSeq93p/pKwYwkI9aY/P/DFDjKBkYlAtDxtRbJBV6W4W
	 8Pq5M1UXwSmeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/sysfs: NULL res_attr slot after kfree as defence
 against double-remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gianfranco Dutka" <gianfranco.dutka@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260520211306.3301893-1-gianfranco.dutka@arista.com>
References: <20260520211306.3301893-1-gianfranco.dutka@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 21:45:31 +0000
Message-Id: <20260520214532.1E74B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Invalid kfree() causing slab corruption in arch/alpha/kernel/p=
ci-sysfs.c
- [High] Concurrent execution of pci_remove_resource_files() allows a data =
race resulting in a Double-Free/UAF
--

commit e4e0ea2861eb8f50c9e5303035a956c3614b2023
Author: Gianfranco Dutka <gianfranco.dutka@arista.com>

PCI/sysfs: NULL res_attr slot after kfree as defence against double-remove

This patch clears the pdev->res_attr[i] and pdev->res_attr_wc[i] slots after
calling kfree() in pci_remove_resource_files(). This is intended as
defense-in-depth against double-remove scenarios, such as out-of-tree hotpl=
ug
drivers re-entering the teardown path.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d37860841260c..11961bb31301e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1195,12 +1195,14 @@ static void pci_remove_resource_files(struct pci_=
dev *pdev)
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);

[Severity: High]
This isn't a bug introduced by this patch, but does NULLing the pointer
prevent a double free if this function is executed concurrently?

If a user writes to resourceN_resize via sysfs, __resource_resize_store()
executes and acquires device_lock(). If no driver is bound
(dev->driver =3D=3D NULL), it proceeds and calls pci_remove_resource_files(=
).

Concurrently, a hotplug remove event triggers pci_stop_dev(), which calls
device_release_driver(). With no driver, this briefly acquires and releases
device_lock(), then proceeds without the lock to pci_remove_sysfs_dev_files=
(),
which also calls pci_remove_resource_files().

Both threads can enter pci_remove_resource_files() concurrently, read the
same non-NULL res_attr pointer before either sets it to NULL, and call
kfree(res_attr), resulting in a data race and double free.

> +			pdev->res_attr[i] =3D NULL;
>  		}
> =20
>  		res_attr =3D pdev->res_attr_wc[i];
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);

[Severity: Critical]
This isn't a bug introduced by this patch, but could this kfree() corrupt
the slab allocator on the alpha architecture?

In arch/alpha/kernel/pci-sysfs.c:pci_create_attr(), when creating both
sparse and dense files, a single memory block is allocated for two
bin_attribute structures:

    attr =3D kzalloc(sizeof(*attr) * res_count, GFP_ATOMIC);
    ...
    pdev->res_attr[num] =3D attr;
    ...
    attr++;
    pdev->res_attr_wc[num] =3D attr;

When pci_remove_resource_files() executes, it will first kfree() the base
pointer at pdev->res_attr[i]. Then, it calls kfree() on pdev->res_attr_wc[i=
],
which points to the middle of the same slab allocation.  Passing a mid-slab
pointer to kfree(), as well as freeing the same block twice, will cause
memory corruption.

> +			pdev->res_attr_wc[i] =3D NULL;
>  		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520211306.3301=
893-1-gianfranco.dutka@arista.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97137C91A
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416538; cv=none; b=dNP6bghe0TaIViXiUR6heOcz0+O7AqOMg8VOkFzcVQ5n/GQzmUtDwZccVyqQm7mnyaQCIiGp1TC72C1tze+4PKQzTwMvAoh1wspwcsBEz6jMJTG72vTqHs14mX96cs2tIJ+asCBXr6XPjhz6Nvx/Z9SMu/c/ACGXuwPisCyqu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416538; c=relaxed/simple;
	bh=FsAbeCq8CouPpZ/E3e8TvwDvcMbEDm1XRKUpPc0JbhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PCKrRxlNbOJcRfXrO50ufGQ9tmeSOxP+d2olxP9LKUdEmTzOwuuqpqtiufLBO7G9fXKinBTgpEU+yqU4+KG7RoeCi2+scBSk1NPoLPVXBaT0jxfrDIgCPbDWVCvFg/EPFgl/NxhSL8mebsXO+fGYVqxrd9rzNPYZcDT0bPt7Iso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ9kuxX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ9kuxX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813D71F000E9;
	Thu,  3 Sep 2026 06:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788416536;
	bh=8I0ISwPeWENwW848PQXqlC0T6Kwt6UeWfsbecBLLVLs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQ9kuxX7os4mdE4SNO3F9DZgDpSvlrt6LjdC3jUwHCsGFvqlJiSnZy5Ezw3mpWRLc
	 aMs2gg3HlrDO4r7/U9KVRJtwF7t+OlKQLMebvfkf4EsceCFd0OmOIBv+/JP4KhnZ5r
	 DRfI/VlJ+x6Z+TJpT1uazr9LLXkTU5Yeav6FaWAMPuv2vdLsSGWze4NJeek6ngV7Jc
	 Hl4WesujBE3LFzReRftZzSJYyfSVkvxgaikk6BSJ8/bibFL7JWQanLYNWcdgbVMOdo
	 oIFEwNtablxdHWdSvij0bNrovz4bIrw5Esw8rDFSvSKxxiU9m7nv2Qe61jqk2NZ90T
	 gWtqyAqFCkzSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: fix use-after-free in pci_pme_list_scan()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Torsten Hilbrich" <torsten.hilbrich@secunet.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <f2e43015-19ca-4e58-9b86-bdd855ff6496@secunet.com>
References: <f2e43015-19ca-4e58-9b86-bdd855ff6496@secunet.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 06:22:16 +0000
Message-Id: <20260903062216.813D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional list addition and reference acquisition in `pci_pme_=
active()` creates duplicate entries, leading to a permanent memory leak of =
`pci_dev`.
--

commit 441d645c73e4a6fdd2c7556f46a08da0b787984e
Author: Torsten Hilbrich <torsten.hilbrich@secunet.com>

PCI: fix use-after-free in pci_pme_list_scan()

This commit addresses a use-after-free in pci_pme_list_scan() by taking a
reference to the pci_dev for each list entry in pci_pme_active() and
dropping it when the entry is removed. This ensures the device is kept
alive as long as its entry is on the list.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..b3a4b710d7c8d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -2497,7 +2498,7 @@ void pci_pme_active(struct pci_dev *dev, bool enabl=
e)
>  				pci_warn(dev, "can't enable PME#\n");
>  				return;
>  			}
> -			pme_dev->dev =3D dev;
> +			pme_dev->dev =3D pci_dev_get(dev);
>  			mutex_lock(&pci_pme_list_mutex);
>  			list_add(&pme_dev->list, &pci_pme_list);

[Severity: High]
Does this unconditional list addition and reference acquisition create dupl=
icate
entries, leading to a permanent memory leak of pci_dev?

For example, during suspend, __pci_enable_wake() calls pci_pme_active(dev,
true), which allocates an entry, takes a pci_dev_get() reference, and adds =
it
to the list. If the subsequent platform_pci_set_wakeup() call fails,
__pci_enable_wake() exits without setting dev->wakeup_prepared =3D true.

On resume, __pci_enable_wake() returns immediately because wakeup_prepared =
is
false, meaning it never calls pci_pme_active(dev, false) to remove the entr=
y.
On the next suspend cycle, pci_pme_active(dev, true) would add a second
duplicate entry for the same device, taking another pci_dev_get() reference.

>  			if (list_is_singular(&pci_pme_list))
> @@ -2510,6 +2511,7 @@ void pci_pme_active(struct pci_dev *dev, bool enabl=
e)
>  			list_for_each_entry(pme_dev, &pci_pme_list, list) {
>  				if (pme_dev->dev =3D=3D dev) {
>  					list_del(&pme_dev->list);
> +					pci_dev_put(pme_dev->dev);
>  					kfree(pme_dev);
>  					break;
>  				}

[Severity: High]
Because of the break statement here, only one entry is removed during device
teardown via pci_pme_active(dev, false).

If duplicate entries accumulated (e.g. from the __pci_enable_wake() failure
scenario mentioned above, or if pdev->pme_poll is cleared and reset by a
driver), the remaining entries will stay on the list permanently. Since this
patch introduces pci_dev_get() on addition, these lingering entries will ho=
ld
permanent references to the pci_dev, preventing it from being freed by
pci_destroy_dev().

Could we check if the device is already on the list before adding it, or ha=
ndle
duplicates during removal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f2e43015-19ca-4e58-=
9b86-bdd855ff6496@secunet.com?part=3D1

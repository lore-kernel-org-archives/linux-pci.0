Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909A3F23D0
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489755; cv=none; b=HNTA0yA7Eji3jL2vP7DinMt0FgTCn7GEWuNHD4eO5IKxbY3rcRPlbOZycjuEE5HHot9YPiiKU9XSaj2442//4E9N025L81gyTgC3rym9Msy9ahzf8eduKdroBObov4AidWupb4VRRZHiFkI4j3Ghh7FSwglQ5narqarU6OuhxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489755; c=relaxed/simple;
	bh=584x8wcKvC32S7d0FMlW09O1JlrMicxrfy7TcrEURdY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NfeIeR2THsJM/WyZcaVzYHERzeabVR/HKqPDodznp7Z4V0glJknr8gGneApe4EHYgj6cUidbGdAsfWFm56MLbeu0BNpyguJoh0IGYX/N5LBLLDkePiYxjRRZTivnXUnRqKzzhvKMriKff8cwU1tMiBnu7AXQfQ5yUymejWleMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYiNjsWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYiNjsWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4851F00A3A;
	Fri, 26 Jun 2026 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782489753;
	bh=3YZZT3f1rFS/pBJNWRLifWiwV0N+bqftiZh3DDXQ2rI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYiNjsWIyK3GKqVRnLZWU4t+TYziH6+Esix+edFPSj4KQHJROjkXgMIdq+Hy0NHbI
	 8wuxJpyBOBQ/KjG0CmiMZEvnU5R/lI4W18JuWXhUA2VsWHuZF+BzXHAZ3auKhm4Bgi
	 1PwnkdJmGv5cLM/DtZLh6IvG6C9fl7xDvR3V8ttjtwj63t/fwBdZYLj5OTCiOfVYVC
	 DV5cQtJXSyFDDD/dR4n6QKbnkjfFDKOsVJhSs/AY0GN6s1ldiwYeFm/fVLrkYPRO3g
	 6sgzsANq9qsL8X5tXkdInfBlC4kdsY4IY0iflwxSUvXWLhDwdzMrRvYUPtzAst2kyO
	 ZcvpsEYmfLqgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: PCI: pci_iov_remove_virtfn: fix unmatched
 pci_dev_put for PF device
Reply-To: sashiko-reviews@lists.linux.dev
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260626155042.53862-1-vulab@iscas.ac.cn>
References: <20260626155042.53862-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 16:02:32 +0000
Message-Id: <20260626160233.8B4851F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Refcount Leak of PF device

Pre-existing issues:
- [High] Premature Release / Use-After-Free of PF device in VF teardown
--

commit f1226b4e04690771e292377b3796f15f2ab401f4
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: PCI: pci_iov_remove_virtfn: fix unmatched pci_dev_put for PF device

This patch removes a pci_dev_put() call for the PF device in
pci_iov_remove_virtfn(). The commit message states that the reference was n=
ever
acquired by the function, potentially causing a refcount underflow and
premature release.

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index b0d24839c0840..87a2f3b278683 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -426,7 +426,6 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int i=
d)
> =20
>  	/* balance pci_get_domain_bus_and_slot() */
>  	pci_dev_put(virtfn);
> -	pci_dev_put(dev);

[Severity: High]
Does removing this call cause a refcount leak for the PF device?

Looking at the VF creation in pci_iov_scan_device(), it appears a reference
to the PF is explicitly acquired:

drivers/pci/iov.c:pci_iov_scan_device() {
    ...
    virtfn->physfn =3D pci_dev_get(dev);
    ...
}

Because the core release function for the VF (pci_release_dev()) doesn't
currently drop this reference, doesn't removing this cleanup result in a
persistent leak of the PF device every time SR-IOV is disabled?

[Severity: High]
This is a pre-existing issue, but there appears to be a lifecycle design fl=
aw
with when this PF reference is dropped.

If the VF object outlives pci_iov_remove_virtfn() due to elevated references
(like an open sysfs file or concurrent VFIO access pinning the VF's kobject=
),
does dropping the PF reference here leave a dangling virtfn->physfn pointer?

If the PF is subsequently removed and freed, any later access to virtfn->ph=
ysfn
by the surviving VF object could trigger a use-after-free.

Should the balancing pci_dev_put(pci_dev->physfn) instead be moved into the
VF's actual release handler to ensure the PF is kept alive exactly as long =
as
the VF memory object?

drivers/pci/probe.c:pci_release_dev() {
    ...
    if (pci_dev->is_virtfn)
        pci_dev_put(pci_dev->physfn);
    ...
}

>  }
> =20
>  static ssize_t sriov_totalvfs_show(struct device *dev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626155042.5386=
2-1-vulab@iscas.ac.cn?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA034C98C;
	Thu,  8 Oct 2026 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440732; cv=none; b=Z9eRWHzBntpt12uKLZa52by57tDoaUPjt/PiHvsTSNy0bPEp0ru+KbfmxrF6Q29mW7u/eiWhXRM+WOGIiXNasMkeqPt/IqQWfpc/m9nolNj9uSFMtOTZdFuXJ5F3KdrzQq6lGoEEWjflWruynJLUcbXxBVXNqPozTgtKZKomcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440732; c=relaxed/simple;
	bh=WFZITcam3/iS38U/HaceZBPb+QgUNVkeu+rrplRai1c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Jp4PEVgXNDxWG7dIB8CwuBL9YFZ5Ey+UCxxLzLRGdICh2WiNoTAPbd5xT612c/CP2wlpQg3v9PL81OLTm9VwSbQchlQGUyhUqtQGubWw8JjdNb1TLiU9UcH/gErGkcY+YXvtooE+j946bYohXEvGa9bsKGkIlU2zDR8nik71hBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSf31xAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSf31xAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6110F1F00893;
	Thu,  8 Oct 2026 06:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791440730;
	bh=V+AjqRmgFnbTeorhSm7OmLb1+Y5ZRnjPLIFE3mv7Ito=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WSf31xABWl/CYwDsQ3I+AqOFWF+BvwyopBdEUsrWEuokzaqK9N5GsiWYlTVRufIM6
	 pVaVtUW+jAknO0Cw6fRa+Q+cl7xmRQVWdK1QarqnQGaA/GWzQgt9gvL9cEv0fSfF4X
	 GXpbxq9Twr7YAK01VfTihr2hI1ADu32NYgJOcwlmI4RFkUL0tjMjhzsx1eb42uurTY
	 oYWcBGSsoPoODYQ0yznEKXxmnucuh2ZZZNOEd/6FojWgdh57gYXk3ARy8FqfscqYGt
	 Nu7sux818DhrBqW/g0/Strx//aljmL6yeKfK56YXRFCNQkzou58jLOtFaD9/evB58V
	 uTYiGEAQj8kMA==
Message-ID: <sashiko-outbox-163687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/16] PCI/TSM: wait for vdevice contexts before
 removing a DSM
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-17-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-17-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:25:29 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI/TSM: UAF due to bypassed drain wait in pci_tsm_unregister()
--

commit 70b40a7c8d41eb1bbe070cea07e7f252f47338e8
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

    PCI/TSM: wait for vdevice contexts before removing a DSM
   =20
    A PF0 DSM can be removed while a sibling function still has a vdevice.
    The context pins both the pci dev, but those references do not keep the
    PF0 DOE mailbox alive. Ignoring -EBUSY from link disconnect lets PCI
    continue to pci_doe_destroy(), leaving the vdevice with a stale mailbox
    pointer.

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index c8603867e09df..8aa74ba31932b 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
[ ... ]
> @@ -751,8 +769,44 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, =
struct tsm_dev *tsm_dev)
> =20
>  void pci_tsm_destroy(struct pci_dev *pdev)
>  {
> -	guard(rwsem_write)(&pci_tsm_rwsem);
> +	struct pci_tsm_pf0 *pf0 =3D NULL;
> +	struct completion *drained;
> +	bool interrupted =3D false;
> +	long rc;
> +
> +	down_write(&pci_tsm_rwsem);
> +	if (pdev->tsm && is_link_tsm(pdev->tsm->tsm_dev) &&
> +	    is_pci_tsm_pf0(pdev)) {
> +		pf0 =3D to_pci_tsm_pf0(pdev->tsm);
> +		drained =3D &pf0->contexts_drained;
> +		mutex_lock(&pf0->lock);
> +		pf0->removing =3D true;
> +		mutex_unlock(&pf0->lock);
> +
> +		/* An unused DSM may never have completed contexts_drained. */
> +		rc =3D pf0->context_users ?
> +			try_wait_for_completion(drained) : 1;
> +		/* Context release needs the read side of pci_tsm_rwsem. */
> +		up_write(&pci_tsm_rwsem);
> +		while (rc <=3D 0) {
[ ... ]
> +			if (!rc)
> +				pci_warn(pdev, "TSM connection is in use, waiting for vdevices\n");
> +		}
> +		down_write(&pci_tsm_rwsem);
> +	}
>  	__pci_tsm_destroy(pdev, NULL);
> +	up_write(&pci_tsm_rwsem);
>  }

[Severity: High]
This adds the context drain wait loop when the PCI device is destroyed, but
what happens when the TSM provider device is unbound and calls
pci_tsm_unregister() first?

Looking at pci_tsm_unregister() in drivers/pci/tsm.c, it directly calls
__pci_tsm_destroy(pdev, tsm_dev) bypassing this new wait loop:

drivers/pci/tsm.c:pci_tsm_unregister() {
    ...
	for_each_pci_dev_reverse(pdev)
		__pci_tsm_destroy(pdev, tsm_dev);
}

If contexts are active, __pci_tsm_destroy() skips clearing pdev->tsm
because pci_tsm_disconnect() will return -EBUSY:

drivers/pci/tsm.c:__pci_tsm_destroy() {
    ...
	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev)) {
		if (pci_tsm_disconnect(pdev))
			pci_warn(pdev, "TSM connection is still in use\n");
	} else {
    ...
}

tsm_unregister() then drops its reference, and the provider frees the
underlying pci_tsm memory. Later, when the PCI core calls this modified
pci_tsm_destroy(), won't it dereference the already freed pdev->tsm and
pdev->tsm->tsm_dev pointers here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D16

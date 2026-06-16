Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB13C13FC
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579471; cv=none; b=JRxObRehyapUgEXLtnhJ+8qSRnMC8uqm2JF2H9z9mHKzSIxGOlBcHKaeTp+r1CG8+WRqOgo4girwV6NmfZdAGJGJzIVLQVL38TG8tDa4fU+TXxr7wr2GkQVHGLXGggQOMcRS9c+hkFTjHKYhZ2zv0SyLBOZmEoGDTJwouLUaHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579471; c=relaxed/simple;
	bh=M1tWtbsfYEAhOrR7I/WyaZQl7JpY/21cvclbLa95cEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dHX8Y200TOnqvQEyl1IGDhOGQ8GG4C1Iuz6ud6WHa0UIM0Be8epH/y3pISj1+xPlV3Xb3vaAUWYC4waCpcKAnWFibCkXqRkx8xam/bonkUP+Z0i58LIc4HQkk6eXXhu6glEZO+1CUcCEJodQLqycBy2rDC4np7L/h6hnOEALVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhWoKTPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhWoKTPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501921F000E9;
	Tue, 16 Jun 2026 03:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781579469;
	bh=b1W4dLQ8DUwqVPqmIygfZb2gKu4i51eoLC6xmsznzWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZhWoKTPC+T7pqeXq4QbHvtf+3PAGwTkFZBs12q0fDBYhQnyuNlejVPBPULXVk4wXJ
	 fzp72uWiBQiraiMK0qaI75BrWsVKobiPdbW1QTE7Eq+jnziTQ+p02ALhixtZ1GoLzk
	 XYdanoRhWhKD6QxAluiAxiXGnEW1pieXaZa1E+uZETeGnu+OxyBNIRkwjA2VMGbKlH
	 J2/aq7PfyINEF1Z4dYgoAZnfIENuvmWNQTAqJT7pIeCtfvZ8e21d4G3hIUUNC0qsjY
	 31eWdx5yy3vGgdLQKMwExyV3NAoc8WuQEU17byNfMH7tpFVjQqoFqWeWVMICreGkhG
	 5QW9hFz60sDFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/TSM: fix use-after-free in find_dsm_dev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260616030243.1661791-1-vulab@iscas.ac.cn>
References: <20260616030243.1661791-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 03:11:08 +0000
Message-Id: <20260616031109.501921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a `struct pci_dev` reference count leak and c=
reates inconsistent return semantics by using `no_free_ptr(pf0)` to suppres=
s reference cleanup.
--

commit b3a70e32ce3263a0eaca05ff9a117ad34fac7def
Author: Wentao Liang <vulab@iscas.ac.cn>

PCI/TSM: fix use-after-free in find_dsm_dev()

This patch modifies find_dsm_dev() to return no_free_ptr(pf0) when returning
the pf0 pointer. This suppresses the automatic cleanup of the reference=20
acquired by pf0_dev_get() and transfers ownership of the reference count
to the caller.

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 5fdcd7f2e8207..dd4e0cb0c6aae 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -670,7 +670,7 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *p=
dev)
>  		return NULL;
> =20
>  	if (is_dsm(pf0))
> -		return pf0;
> +		return no_free_ptr(pf0);

[Severity: High]
Does this change introduce a reference count leak for the struct pci_dev?

The original code returned a borrowed reference to the device, but using
no_free_ptr() suppresses the cleanup and transfers the reference count
ownership to the callers.

Looking at the callers of find_dsm_dev(), such as pci_tsm_init() and
pci_tsm_link_constructor(), they expect an un-refcounted pointer and do
not call pci_dev_put() on the returned device:

drivers/pci/tsm.c:pci_tsm_link_constructor() {
	...
	tsm->dsm_dev =3D find_dsm_dev(pdev);
	...
}

Since these callers do not appear to manage or release the reference, the
device reference could be permanently leaked, which would prevent the
device from being properly unloaded or hot-unplugged.

Additionally, other return paths in find_dsm_dev() (such as returning pdev
or uport) continue to return borrowed pointers. Does this create
inconsistent return semantics where the caller cannot know if a reference
was taken or not?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616030243.1661=
791-1-vulab@iscas.ac.cn?part=3D1

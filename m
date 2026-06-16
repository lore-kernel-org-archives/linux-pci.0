Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA983542D4;
	Tue, 16 Jun 2026 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607626; cv=none; b=XaNwxzs3IzVw/KhBNUF78PCzqet8qN28lflM8w0evpA+58+enOMF6JYqXZKyHIZe/Gb1mianozJ6s4dIKgL5YB5ezc5qWgpFHXnz1Guh7a/5kEaVcgHPgTaaS4tASWsL3c81fKa9hP1TwPuBEP+FIA3/b5frxWnKRWd9nxYxDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607626; c=relaxed/simple;
	bh=RqQDXZvXQ7Oo+6YhssoeFrUSKovX8++B0/kuM+YBjPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dwElX3kSqcFnZ1HzRS2ecH4KzpL4kIuQbrR0Jsj4IiAcjxa0gVsV7j3QckJVup44DdHwaZyVxvZKfu4ZyzfKqCfsmer6rbnFRPNrELdC2wns7lCvL8PRNPNlvBUdEqsC+4F5ernQPuM7lqfeN98YbXaY5oSt17R8shB3dkpKiBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkUq66aA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkUq66aA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415611F000E9;
	Tue, 16 Jun 2026 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607625;
	bh=aAi/YXeWgtPanNCFI6mXYtp0ocuFwAE7fLv3QOs3Um0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HkUq66aAyQN4sIloH2x7Dj/KUJr4I7N/dJLju74afof9reMhbEQd5PR47m7r/EysX
	 An4QYnoOmKGKC7hp4oxFir8GlYXXH2UFOOEwWSPL7nWRIxAGnirhOuMYXiXFuR7Ekv
	 dCMQR7gEvDpVS0vfgRTUlb/1hAAZAA46/RbE96LSGgxPrqleQTp5iwx7W0fVH2V1YX
	 O3lK45MlK0oGyOqdjLPAABgqtmQh6tl6ZLbq7bkPTbnsSC5mkqcMI8YI33OO/T6J68
	 QxPrNywZunmqrRAE9FemdrqplZ8vjM4uektwmvP5s08Wk4HwdXYWEXn1dmGnNsj0Zy
	 k1Bdfgc4gEQRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 01/12] PCI/TPH: Fix pcie_tph_get_st_table_loc()
 field extraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260616104621.41915-2-fengchengwen@huawei.com>
References: <20260616104621.41915-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 11:00:24 +0000
Message-Id: <20260616110025.415611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Surprise removal (PCI disconnect) or a malicious PCI endpoint can =
trigger a heap buffer overflow in `pci_save_tph_state()` and an OOB read in=
 `pci_restore_tph_state()` due to a TOCTOU evaluation of the ST table size.
--

commit fe1abb4bbf50a2222b456026a8b0caa06ea99438
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction

pcie_tph_get_st_table_loc() incorrectly uses FIELD_GET(), which shifts the
field value to bit 0. But the function is designed to return raw
PCI_TPH_LOC_* values as defined in the function comment.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d951..bef3a55539c46 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> @@ -185,9 +188,6 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
> =20
>  	/* Check ST table location first */
>  	loc =3D pcie_tph_get_st_table_loc(pdev);
> -
> -	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
> -	loc =3D FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>  	if (loc !=3D PCI_TPH_LOC_CAP)
>  		return 0;

[Severity: High]
This is a pre-existing issue, but does this function have a TOCTOU race
that could cause a buffer overflow during a device disconnect?

pcie_tph_get_st_table_loc() indirectly reads the PCI_TPH_CAP register.
Shortly after, pcie_tph_get_st_table_size() reads it again:

drivers/pci/tph.c:pcie_tph_get_st_table_size() {
    ...
	loc =3D pcie_tph_get_st_table_loc(pdev);
	if (loc !=3D PCI_TPH_LOC_CAP)
		return 0;

	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);

	return FIELD_GET(PCI_TPH_CAP_ST_MASK, reg) + 1;
}

If a device disconnects exactly between these two reads, or if a malicious
endpoint provides PCI_TPH_LOC_CAP for the first read but ~0 for the second
read, the FIELD_GET() calculation evaluates to 2048.

Since pci_save_tph_state() iterates based on this dynamically queried size,
could it write up to 4096 bytes of disconnect error data into the
save_state->cap.data buffer, overflowing it?

drivers/pci/tph.c:pci_save_tph_state() {
    ...
	num_entries =3D pcie_tph_get_st_table_size(pdev);
	for (i =3D 0; i < num_entries; i++) {
		pci_read_config_word(pdev, pdev->tph_cap + offset,
				     st_entry++);
    ...
}

Similarly, could pci_restore_tph_state() be vulnerable to an out-of-bounds
heap read if the table size evaluates to 2048 on disconnect?

drivers/pci/tph.c:pci_restore_tph_state() {
    ...
	num_entries =3D pcie_tph_get_st_table_size(pdev);
	for (i =3D 0; i < num_entries; i++) {
		pci_write_config_word(pdev, pdev->tph_cap + offset,
				      *st_entry++);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D1

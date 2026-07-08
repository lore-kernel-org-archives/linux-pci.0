Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124B379EFC
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521883; cv=none; b=Vl0aX0uQkQ+ozizz46ylMGaeZI7RxZKmfAs/ib+ENSlhc9mILVHTtvxcccD+cpaiHpg1m15jPwjqfGFRvsZRehAAI8Xf4bE3ymTJnfUnA1S9TnBDmjJDaZWrjRN6+cEmko0rozplzazMLNrzccDkWr72fgaQwLT+qvfa+v7GPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521883; c=relaxed/simple;
	bh=43HFjfmsVLMy8syAsRJ1YSNKe16qnQmDj65AjIMNFzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AhTGMMsudCDbUMSDGFa9zM3WxffLXVO5IQ8ZJdSbu75uWrb2vgbSzZwmdnI8NTKbvOGDTxnzBtUjSRIK1y2EIUy56PIDa3F4u+jq1UmvGKm0SjwR8Y3tvqLAKeTlhs1OWtklIOmajJBAn4jPeZBttbZ+MVmhiLwUFtxH6008TH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK081+5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK081+5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4621F00A3A;
	Wed,  8 Jul 2026 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521882;
	bh=Cztmn3QpJqjHHXrjEfoXxRCFmX7RD7ET2NZY9Ch4HHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TK081+5o+4cN4YWBOEAdNMQ2U1C/PlNi/YQOQcfGfoloYP5eVIV5V4iEeuPWBzKSO
	 I0OtAP1tbBACBtNM+S9atbjAmw/WjN+P1alWzgl9jDf2D3LCBnz/EsLN8367neldvg
	 OQUt9s2ri+dYVgq13LQ+5iRw1uXx4ZEljblgATEjA/Kv/rPqgHp9pU9qULdauXEe1B
	 +1G32+GaahpFUYMfa3vDEbDO1zCLzZm4uPf7+0+vsBWX3sWWCLEQ990/pH1klv0Vlb
	 hoR9GH8hTjWlmHl0ZTHxfF7GYEeeqxvuR1U9US0MFNqR7Alz1mGWoLrEEkT8EOSiQI
	 Ce8rf9iq3bF3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] PCI/ASPM: Always disable ASPM when driver
 requests it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708-pci-aspm-fix-v3-1-6bd72451746e@kernel.org>
References: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
 <20260708-pci-aspm-fix-v3-1-6bd72451746e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:44:41 +0000
Message-Id: <20260708144442.5F4621F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition leading to Use-After-Free in ASPM link state manage=
ment.
--

--- Patch [1]: [PATCH v3 1/8] PCI/ASPM: Always disable ASPM when driver req=
uests it ---
commit 3f3308cae9c38dfb61e4a9d6f6d9f1413c0e0c87
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI/ASPM: Always disable ASPM when driver requests it

This commit makes pci_disable_link_state() unconditionally disable ASPM so
the motivation for drivers to use custom ASPM handling code is eliminated.
This ensures ASPM state changes are properly tracked by the service driver.

Link: https://lore.kernel.org/all/CANUX_P3F5YhbZX3WGU-j1AGpbXb_T9Bis2ErhvKk=
FMtDvzatVQ@mail.gmail.com/
Link: https://lore.kernel.org/all/20230511131441.45704-1-ilpo.jarvinen@linu=
x.intel.com/

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1449,16 +1449,23 @@ static int __pci_disable_link_state(struct pci_de=
v *pdev, int state, bool locked
>  {
>  	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
> =20
>  	if (!link)
>  		return -EINVAL;

[ ... ]

>  	if (!locked)
>  		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	link->aspm_disable |=3D pci_calc_aspm_disable_mask(state);

[Severity: High]
This is a pre-existing issue, but could this lockless fetch of the link
pointer lead to a use-after-free when we write to aspm_disable here?

If one CPU calls this asynchronously (for example, from a network driver TX
timeout handler) and another CPU concurrently removes a sibling PCI function
on the same bridge, could we hit this sequence:

CPU1
__pci_disable_link_state()
    link =3D pcie_aspm_get_link(pdev);

CPU2
pcie_aspm_exit_link_state()
    // acquires locks, frees parent bridge's link pointer
    bridge->link_state =3D NULL;
    kfree(link);

CPU1
    mutex_lock(&aspm_lock);
    link->aspm_disable |=3D pci_calc_aspm_disable_mask(state);

Could this concurrent removal cause the link pointer to be freed before
CPU1 acquires the locks, leading to memory corruption when modified?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-pci-aspm-f=
ix-v3-0-6bd72451746e@kernel.org?part=3D1

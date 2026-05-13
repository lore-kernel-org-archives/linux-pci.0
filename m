Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442A36A03B
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715663; cv=none; b=fnxgpPQwOBMgktXRobKNsxYQsfpS7ALObsQyPbxTkLeXhKJ2rvJUekKds7/C70eqk8ojd0s2Rd5gc6AJ96JO/Sq2YApt/jqGA397q7XsbHWrT0d1u4M+pcQh5OXERv8l52Ih7ILdk500slM30jumwNRfn2E6RPKpH2gRcyw81ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715663; c=relaxed/simple;
	bh=TtRIk1pTTxJSlEbvbkevi5DqKJetQhzcPYAw5nnGSLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LrWn+73m6DdNnthmoOay6vXj3WepTJZEKFVYS6k4z0wZvVr8FErgSRIhC1sx8dyrLxrzIoHJl+JHeDBr68VTe3TFy3Tyatp24Bec8cMKizX+tFQqAfloVfEHy8IQafptTRIqtSjIRcBL+x85pxu871Y1RW2a/6cgR0nDHPmZWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWfzqDBt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWfzqDBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F362C19425;
	Wed, 13 May 2026 23:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778715663;
	bh=TtRIk1pTTxJSlEbvbkevi5DqKJetQhzcPYAw5nnGSLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kWfzqDBt+pVA9Lc/uIy/mC2heraNdqBvvdH2otuqYPCwbyj1kxliWDWhW0SRoig6J
	 sRjhbXxtoEyMSk9qWxNdc84DNxCG3haFKzdFYoY+Q/6TMmJ2luD+2fkcOF4N7yR232
	 Y2ucWPw86rBK0igxZyFNrx6i9Lv5FJUrVPon1ukC8FxFS38CadSBMJyKDmcHAL2Skf
	 T5FELjT5oYO+26QRy9XByCW6TaYzb2ubZIfOSSrO3qBjDtvpsiJFsWxhlX1KICRJ8c
	 /eFJlVdCV/vJj3OmZ3hdYhT7uplQAuvNX3lBss0NL3RKO+kYoe2e+rpzFPjiLG6+6f
	 yIy0puCy1CraA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Save/restore Device 3 control and clear stale
 14-bit Tag enables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512163012.2336191-1-vidyas@nvidia.com>
References: <20260512163012.2336191-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:41:02 +0000
Message-Id: <20260513234103.0F362C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Premature downstream config accesses before child device readiness=
 causes child fixups to be silently skipped.
- [High] Incomplete bus hierarchy traversal leaves endpoints behind switche=
s with stale 14-bit tag enables.
- [High] Unsynchronized C bitfield assignments cause data races that corrup=
t device and bus state.
- [High] Incorrect bus flit_mode assignment for downstream ports corrupts p=
rimary bus state.
--

commit cfcee5167fd2cdd929f8d6d46c5515889aa39e42
Author: Vidya Sagar <vidyas@nvidia.com>
Subject: PCI: Save/restore Device 3 control and clear stale 14-bit Tag enab=
les

This patch saves and restores DEV3_CTL across pci_save_state() and
pci_restore_state(). It also clears stale 14-bit Tag enables when the link
mode changes to non-flit.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..a146db4ca358c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -1695,6 +1695,199 @@ static void pci_restore_pcie_state(struct pci_dev=
 *dev)
[ ... ]
> +static void pci_restore_dev3_state(struct pci_dev *dev)
> +{
[ ... ]
> +		pci_read_config_dword(dev, pos + PCI_DEV3_STA, &dev3_sta);
> +		dev->fm_enabled =3D !!(dev3_sta & PCI_DEV3_STA_SEGMENT);

Is this bitfield assignment safe against concurrent modifications?

Compilers implement bitfield assignments as non-atomic read-modify-write
operations on the entire containing integer word.

If this runs concurrently with sibling resumes, or asynchronously during
probe or suspend (which modify adjacent bitfields like is_managed or
state_saved), could this clobber those other states and cause a data race?

> +
> +		pcie_capability_read_word(dev, PCI_EXP_LNKSTA2, &lnksta2);
> +		flit_now =3D !!(lnksta2 & PCI_EXP_LNKSTA2_FLIT);
> +		if (dev->bus)
> +			dev->bus->flit_mode =3D flit_now;

For a downstream port or root port, LNKSTA2 reflects the status of its
downstream link.

Would assigning this to dev->bus incorrectly update the port's upstream
primary bus instead of the secondary bus (dev->subordinate)?

[ ... ]
> +static void __pci_dev_clear_stale_14bit_tag(struct pci_dev *dev, bool fl=
it_now)
> +{
[ ... ]
> +	pci_read_config_dword(dev, pos + PCI_DEV3_STA, &dev3_sta);
> +	dev->fm_enabled =3D !!(dev3_sta & PCI_DEV3_STA_SEGMENT);

This is another C bitfield assignment that might race if triggered
asynchronously.

Since pci_bridge_refresh_14bit_tag() holds only down_read(&pci_bus_sem)
during bandwidth notification events, could this also result in data
corruption?

[ ... ]
> +void pci_bridge_refresh_14bit_tag(struct pci_dev *bridge)
> +{
[ ... ]
> +	/*
> +	 * Walk the secondary bus.  pci_restore_dev3_state() only fires on
> +	 * paths that go through pci_dev_restore(); DPC release, hotplug
> +	 * link status updates, and similar paths do not.  Fix those too.
> +	 */
> +	down_read(&pci_bus_sem);
> +	list_for_each_entry(child, &bus->devices, bus_list)
> +		__pci_dev_clear_stale_14bit_tag(child, flit_now);
> +	up_read(&pci_bus_sem);
> +}

Does this iterate deeply enough to catch endpoints behind PCIe switches?

If the bridge is a root port connected to a PCIe switch,
list_for_each_entry() will only visit the immediate child (the switch
upstream port).

Should this use pci_walk_bus() instead to recursively visit all downstream
devices, ensuring endpoints beneath a switch do not retain stale enables?

[ ... ]
> @@ -4758,6 +4956,14 @@ int pci_bridge_wait_for_secondary_bus(struct pci_d=
ev *dev, char *reset_type)
>  		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>  		msleep(delay);
> =20
> +		/*
> +		 * The link has had a chance to come back; refresh the
> +		 * bridge's (and subtree's) DEV3_CTL 14-Bit Tag enables
> +		 * against the live LNKSTA2.Flit_Mode before we issue the
> +		 * first config TLP to the child.
> +		 */
> +		pci_bridge_refresh_14bit_tag(dev);
> +
>  		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
>  			return 0;

Will calling pci_bridge_refresh_14bit_tag() here cause child devices to be
silently skipped if they are not yet ready?

pci_bridge_refresh_14bit_tag() walks the secondary bus and issues downstream
config reads via pci_find_ext_capability(). Since this occurs before
pci_dev_wait() verifies child recovery, the child may respond with CRS.

If it responds with CRS, pci_find_ext_capability() fails and skips the chil=
d.
When the child finally becomes ready, it will retain its stale 14-bit tag
enables.

Could the child traversal be deferred until after pci_dev_wait() guarantees
the devices are accessible?

> @@ -4785,6 +4991,13 @@ int pci_bridge_wait_for_secondary_bus(struct pci_d=
ev *dev, char *reset_type)
>  		return -ENOTTY;
>  	}
> =20
> +	/*
> +	 * Link is up.  Refresh the bridge's (and subtree's) DEV3_CTL
> +	 * 14-Bit Tag enables against the live LNKSTA2.Flit_Mode before
> +	 * we issue the first config TLP to the child below.
> +	 */
> +	pci_bridge_refresh_14bit_tag(dev);
> +
>  	return pci_dev_wait(child, reset_type,
>  			    PCIE_RESET_READY_POLL_MS - delay);
>  }

Similarly, could the child devices be missed here since pci_dev_wait() has
not yet completed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512163012.2336=
191-1-vidyas@nvidia.com?part=3D1

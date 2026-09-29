Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF133D565F;
	Tue, 29 Sep 2026 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704227; cv=none; b=XHG83D4LFo4c2n98i9JhtkKYYhNHwpkXPcpDwNdnDne+t0Vvz3omJs3gL/DazrldUKzRZPW64/+YElNr2yEeY5nAo1w4uRX+NT+5oBTiIsRs5pwUF15dzPRDnEN2tFJQTnYYqjQbVKU96SaGkUzxW1AHVwthnk1ZHwiU3eAFm2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704227; c=relaxed/simple;
	bh=v3NmZcRO+vYe1haQ0HT/OoGeroupg6PlbAMJcX4HSOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TsB3txezJhr/WYMh1TxWkCP+NDXA8vHePyCoIXDI0LLdSQRSYEQl8tcUj/I8FAr9UFc6kkaRPVgKXQPG6Umv+9z/oFfFB4+W3CtTxRZmL3yxXsYxnLPvRDlZAH0HItPQSxn1VfeRiW2t7dtWc5NfG3bSrv7iVMzuSDrjC9+STfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8bFiCSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8bFiCSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3494C1F000FF;
	Tue, 29 Sep 2026 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704226;
	bh=kBs9NE3ib85Td0rQ4YNB3mki33KQNJrghJQEurmw7XQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T8bFiCSAUq0G6zOoq0EdUElfdodTR47g8Anm+ZxyGSBbuw7UxPYHE8u8F/MZezYW3
	 58MK9FuaKKL5nK/RYINy0ixl186/+w7cUUuAlTTh7hrHdrVswDrsAdzVn3MW5DlyaT
	 uZJ2kfGOLjpplkaktKkBz6PVtSkE+enSryuwUEzvuQX7vitK4me/CHJdZqIFk+5S8/
	 57N7NVJ9ALMhoE4ujGAgVdQ7ZI/uwKWgB9/eWfGdLtBmiRxKr0OoFczYLuWgSfkI3W
	 oSBcLRfhkreMRDzoOfQLOSIp6zTNOqZRvzWdsJqOrrxUhzZJ5lFwP1Qv5kI/AF56b8
	 i1wsn0uq1Stug==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 12/16] vfio/pci: Restore device state from
 slot_reset()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929173305.204856-13-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-13-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:50:25 +0000
Message-Id: <20260929175026.3494C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: rwsem ABBA/starvation deadlock in AER slot reset via pci_set_=
power_state
--

commit 6afd5feca9e35f2a1b59b9d3719fa0d9dbdec2ca
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Restore device state from slot_reset()
   =20
A host reset clears device configuration. Add slot_reset() to restore
the state saved at open before tearing down interrupts. MSI-X shutdown
requires the restored BARs to access its table.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 667c5813f6c7c..a7b7499e071c1 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> +/* Caller holds memory_lock. Discard the pre-reset PM snapshot. */
> +static int vfio_pci_recovery_restore_state(struct vfio_pci_core_device *=
vdev)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	int ret;
> +
> +	if (!vdev->pci_saved_state)
> +		return -ENODATA;
> +	ret =3D pci_load_saved_state(pdev, vdev->pci_saved_state);
> +	if (ret)
> +		return ret;
> +
> +	kfree(vdev->pm_save);
> +	vdev->pm_save =3D NULL;
> +	ret =3D pci_set_power_state(pdev, PCI_D0);

[Severity: High]
Can this introduce an ABBA starvation deadlock with pci_bus_sem?

During an AER slot reset, pcie_do_recovery() already holds a read lock on
pci_bus_sem via pci_walk_bus(). The AER framework then calls
vfio_pci_core_aer_slot_reset(), which calls into this function and
attempts to restore the device to D0 by calling pci_set_power_state().

Internally, this transitions ASPM via pcie_aspm_pm_state_change(), which
unconditionally executes a nested down_read(&pci_bus_sem) because the
locked parameter is passed as false:

drivers/pci/pcie/aspm.c:pcie_aspm_pm_state_change() {
    ...
    if (!locked)
        down_read(&pci_bus_sem);
    ...
}

If a concurrent thread, such as PCI hotplug or another subsystem, attempts
to acquire down_write(&pci_bus_sem) between these two read lock
acquisitions, the fair rwsem implementation will queue the writer. The
nested down_read() will then block waiting for the writer, creating an
unresolvable starvation ABBA deadlock.

As noted in the commit message, the final patches in this series do not
appear to address or resolve this bug. Are there plans to address this
deadlock before merging?

> +	if (ret)
> +		return ret;
> +
> +	vfio_pci_recovery_mask_saved_intx(vdev);
> +	pci_restore_state(pdev);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D12

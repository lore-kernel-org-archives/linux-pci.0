Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9476346E5D
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400614; cv=none; b=XRuYyZgqvIni1smOkall/pp4QMnSiIdpjBi4kjUfYWpDCHSlwpSYt+5szRYauAG/YKJDShIkdPN3SGYtuE3qURf8k6pgB6Ijhmt0cDtzha4mg6YSoF2cKprE/nxxbcDQCdNJsdpfvmrtkbUNNxUMRvaQ+JBR7QLwXgHu0bVfF1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400614; c=relaxed/simple;
	bh=mJ5T+MCnWvt+sUQeHHLGMRJ6RnhtB1lo8QTwW/RMRtM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=CrzXq2vJ9fOIvWx54oyP7+Us9Oex/edqJTXs4MpKt7/YdBBiaN1xK+BuN1I0tabPJPRWuOX0odk4vnch/r7Fr2uRkC0Qgb377pFjPAg9qErPBTudiU9uZUop5/NqS0aoh+AkHLmH9KUPE4F9xRiMBRWYXALckhYtSXadhub3f+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV5KBOtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV5KBOtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A571F000C5;
	Mon, 19 Oct 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792400612;
	bh=sdzBDjNH3kMQdfcV3dMcPy9z86kn6OMwHDy6PiiVxBY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fV5KBOtp5mmLyWvKoRjhCLkkI3AlkRygK7w+dL1Mzs6iKxkYMA7PeI5XL1IemCSXW
	 LvEDRlz+rDzs4fbMFAT8MJVGrPP1dUrsdNtn1Tznm85Su7PM1/9Un2TCG4WvuhNhQZ
	 JM9i3nXq4pQqvRty3hsthjSFb8d9raQcE5p1IUNEZqzup3M/gU/z1+gaANYJlbaLDA
	 UzqYhYwrUIVoIyuhQDsb4acWzVkyj3LhDDs+pQZ8hGtA2ApmiL4qh2Lf8+DuDPk5Ae
	 MVoDkAUnvMx26YBlmoYTrmDxjuayvlFcTkw6dlBiCynSlmggRRSirkXVV3NSv/M3Wi
	 oBWThjns6QYzg==
Message-ID: <sashiko-outbox-176858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/13] PCI/IOV: Allow VF drivers to handle resets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-5-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-5-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:03:31 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI/IOV: bus and slot resets fail to lock VFs on virtfn bus or oth=
er slots
- [High] PCI/IOV: VF reset_prepare() before PF reset_prepare() deadlocks hi=
si_qm FLR
--

commit f7e0f3b0fa0caf7e168b1c2965897910aa159a0a
Author: Micha=C5=82 Winiarski <michal.winiarski@intel.com>

PCI/IOV: Allow VF drivers to handle resets

This commit saves and restores PCI configuration state for all subordinate
VFs across PF resets and notifies VF drivers via reset_prepare() and
reset_done(). It also updates bus and slot resets so that VFs are managed
through their parent PF rather than walked independently on the bus.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95452c11dea55..ba8553011daea 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -5164,6 +5195,17 @@ static void pci_dev_save_and_disable(struct pci_de=
v *dev)
>  		return;
> =20
>  	pci_save_state(dev);
> +}
> +
> +static void pci_dev_save_and_disable(struct pci_dev *dev)
> +{
> +	struct pci_dev *vf;
> +
> +	for_each_pci_vf(dev, vf)
> +		pci_dev_reset_prepare_and_save(vf);
> +
> +	pci_dev_reset_prepare_and_save(dev);

[Severity: High]
Does calling pci_dev_reset_prepare_and_save(vf) on every VF before calling
pci_dev_reset_prepare_and_save(dev) on the PF deadlock HiSilicon QM resets?

During pci_reset_function(pf), pci_dev_save_and_disable() now runs
reset_prepare() on all VFs and then on the PF before pci_dev_restore() calls
reset_done() on any of them.

In drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c,
hisi_acc_vf_pci_reset_prepare() sets QM_RESETTING on the parent PF's
qm->misc_ctl (hisi_acc_vdev->pf_qm) and only clears it in
hisi_acc_vf_pci_aer_reset_done():

    while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
        msleep(1);
        if (++delay > QM_RESET_WAIT_TIMEOUT) {
            dev_err(dev, "reset prepare failed\n");
            return;
        }
    }

When the first VF sets QM_RESETTING on pf_qm->misc_ctl, any subsequent VF's
hisi_acc_vf_pci_reset_prepare() spins for 60 seconds and fails, and the PF's
hisi_qm_reset_prepare() -> qm_reset_prepare_ready(pf_qm) ->
qm_wait_reset_finish(pf_qm) in drivers/crypto/hisilicon/qm.c also spins on
pf_qm->misc_ctl for ~80 seconds before timing out with -EBUSY ("FLR not
ready!") without stopping the PF.

A similar self-deadlock occurs when VFs are bound to the host hisi_qm drive=
rs
(hisi_hpre, hisi_sec2, hisi_zip) in drivers/crypto/hisilicon/qm.c:

    static int qm_reset_prepare_ready(struct hisi_qm *qm)
    {
        struct pci_dev *pdev =3D qm->pdev;
        struct hisi_qm *pf_qm =3D pci_get_drvdata(pci_physfn(pdev));

        if (qm->ver < QM_HW_V3)
            return qm_wait_reset_finish(pf_qm);

        return qm_wait_reset_finish(qm);
    }

On Kunpeng920 (qm->ver < QM_HW_V3), the first VF's hisi_qm_reset_prepare()
sets QM_RESETTING on pf_qm->misc_ctl, blocking subsequent VFs and the PF's
own hisi_qm_reset_prepare(). On Kunpeng930+ (qm->ver >=3D QM_HW_V3), each V=
F's
hisi_qm_reset_prepare() sets QM_RESETTING on vf_qm->misc_ctl; when the PF's
hisi_qm_reset_prepare() then calls qm_try_stop_vfs(qm, QM_PF_FLR_PREPARE,
QM_DOWN), each VF's mailbox handler qm_pf_reset_vf_prepare() calls
qm_reset_prepare_ready(vf_qm) -> qm_wait_reset_finish(vf_qm), which waits f=
or
QM_RESETTING on vf_qm->misc_ctl to clear and times out.

[ ... ]

> @@ -5551,6 +5631,11 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  	return __pci_bus_trylock(slot->bus, slot);
>  }
> =20
> +static bool pci_dev_skip_bus_reset(struct pci_dev *dev)
> +{
> +	return dev->is_virtfn; /* VFs are managed by their PF */
> +}
> +
>  /*
>   * Save and disable devices from the top of the tree down while holding
>   * the @dev mutex lock for the entire tree.
> @@ -5560,6 +5645,8 @@ static void pci_bus_save_and_disable_locked(struct =
pci_bus *bus)
>  	struct pci_dev *dev;
> =20
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (pci_dev_skip_bus_reset(dev))
> +			continue;
>  		pci_dev_save_and_disable(dev);
>  		if (dev->subordinate)
>  			pci_bus_save_and_disable_locked(dev->subordinate);
> @@ -5576,6 +5663,8 @@ static void pci_bus_restore_locked(struct pci_bus *=
bus)
>  	struct pci_dev *dev;
> =20
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (pci_dev_skip_bus_reset(dev))
> +			continue;
>  		pci_dev_restore(dev);
>  		if (dev->subordinate) {
>  			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
> @@ -5595,6 +5684,8 @@ static void pci_slot_save_and_disable_locked(struct=
 pci_slot *slot)
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot !=3D slot)
>  			continue;
> +		if (pci_dev_skip_bus_reset(dev))
> +			continue;
>  		pci_dev_save_and_disable(dev);
>  		if (dev->subordinate)
>  			pci_bus_save_and_disable_locked(dev->subordinate);
> @@ -5613,6 +5704,8 @@ static void pci_slot_restore_locked(struct pci_slot=
 *slot)
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot !=3D slot)
>  			continue;
> +		if (pci_dev_skip_bus_reset(dev))
> +			continue;
>  		pci_dev_restore(dev);
>  		if (dev->subordinate) {
>  			pci_bridge_wait_for_secondary_bus(dev, "slot reset");

[Severity: High]
Can pci_bus_save_and_disable_locked(), pci_bus_restore_locked(),
pci_slot_save_and_disable_locked(), and pci_slot_restore_locked() operate on
unlocked VFs when VFs reside on an SR-IOV virtual bus or do not match the
PF's struct pci_slot?

When pci_dev_save_and_disable() and pci_dev_restore() run on a PF, they
iterate over all VFs with for_each_pci_vf(dev, vf) and call
pci_dev_reset_prepare_and_save(vf) and pci_dev_reset_done(vf), both of which
require the VF lock to be held and assert device_lock_assert(&vf->dev).

However, __pci_bus_lock(), __pci_bus_trylock(), and __pci_bus_unlock() in
drivers/pci/pci.c only walk bus->devices (filtered by dev->slot =3D=3D slot=
 for
slot resets) and recurse into dev->subordinate:

    list_for_each_entry(dev, &bus->devices, bus_list) {
        if (slot && (!dev->slot || dev->slot !=3D slot))
            continue;
        if (dev->subordinate) {
            if (!pci_bus_trylock(dev->subordinate))
                goto unlock;
        } else if (!pci_dev_trylock(dev))
            goto unlock;
    }

First, if any VFs reside on an SR-IOV virtual bus created by virtfn_add_bus=
()
in drivers/pci/iov.c:

    child =3D pci_add_new_bus(bus, NULL, busnr);

that virtual bus has bridge =3D=3D NULL, so pf->subordinate is NULL and tho=
se VFs
are on the virtual bus's devices list rather than pf->bus->devices. As a
result, __pci_bus_lock() and __pci_bus_trylock() never lock VFs on the
virtual bus.

Second, during a slot reset (pci_slot_trylock() / pci_slot_lock()),
pci_dev_matches_slot() in drivers/pci/slot.c only assigns dev->slot =3D slot
when the device matches the slot number:

    static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *=
slot)
    {
        if (slot->per_func_slot)
            return dev->devfn =3D=3D slot->number;

        return slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
            PCI_SLOT(dev->devfn) =3D=3D slot->number;
    }

Any VF with a different PCI_SLOT(vf->devfn) (when slot->number !=3D
PCI_SLOT_ALL_DEVICES) or a different devfn (when slot->per_func_slot is set)
has vf->slot !=3D slot and is skipped by __pci_bus_trylock(slot->bus, slot),
while pci_slot_save_and_disable_locked() and pci_slot_restore_locked() still
visit all VFs of the PF via for_each_pci_vf(dev, vf) without holding their
device or config access locks.

Should __pci_bus_lock(), __pci_bus_trylock(), and __pci_bus_unlock() also
skip VFs with pci_dev_skip_bus_reset(dev) and lock/unlock VFs via their PF
using pci_dev_lock_vfs(), pci_dev_trylock_vfs(), and pci_dev_unlock_vfs()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D4

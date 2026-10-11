Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556D32ED34;
	Sun, 11 Oct 2026 08:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791706049; cv=none; b=cF7sVirt1LYNMQ6HI4EDDtEDQyZLDrB3ow5EUVa8EJIj+CqFzt/gxmoxvlSp0JwwDjDg0y5zQtAlVbF6J8WZQSu8x1olz3egaqVllaeGM5seUP8XpqgFZnIlPJjizgeVqM8znrcr/0ihvHXS54A4TfN22bfhGc7z4znu4TKhCLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791706049; c=relaxed/simple;
	bh=vhBLYBayTbCGdJdsLoiRFDXoLngEs6vbsgDoHnI2RUw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Y3O6Uo3njKjnSm/4LEfqQR8W63jO9m/lcU57vwdwGKN0XQULu7j+VW4t71KBKH3pPnDRDQ8LGfsii+6ddb3OqyTxg7FWkuF4v+FSrNpNurjzYwKxp40uThaQZWQ6i6NUql90AoJax6UdXbuVOnJR+h7kV5dq3w2oWfA+QHcVjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnZfmcQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnZfmcQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0751F0089B;
	Sun, 11 Oct 2026 08:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791706047;
	bh=vb12y1oDzeW+k2aU0A6/EDxhKy7FXd1uRr2geB4QMXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WnZfmcQ48TfNIy35PU/GGY4eBQgEqjPaGbUjRwEwRAhC2gT+t1Q42JCNfOiCbsj4E
	 TPGEggefVI7sNnecvV+B4s04M4Lls+OTp9XITf1Z6LeTO+CGjNm60I8OaKMd6GG2Ij
	 JKOw3JdPeTDIOzTrZdg3szlMCRvJK+SsM0/a+o1CnyTKWRzjP8f3SAmdWcpSmxIDi5
	 2EC04mEIQSkMT81+3fqu/sVAhdf6f9UzSUyDuaHqfkiv2Cqu4dRenVf59NJ6scenSZ
	 xGQoQbWTgiyCYufgVh+/63zynTwbYI1eyd2GsawI4pdRsqCf1ulStBus9msBBoxijl
	 yauQCYWy9kMsA==
Message-ID: <sashiko-outbox-167119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] vfio/pci: Add qcom-vfio-pci variant driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011074514.515894-4-jtornosm@redhat.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
 <20261011074514.515894-4-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 08:07:26 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] vfio/pci: stale MSI cache on VM soft-reboot
- [High] vfio/pci: endianness bug exposes corrupted MSI config to big-endia=
n guests
- [High] pci: writing virtual MSI configuration directly to unassigned phys=
ical PCIe space triggers AER UR
- [High] vfio/pci: qcom: host kernel panic via TOCTOU in qcom_vfio_pci_ioctl
- [Medium] vfio/pci: unratelimited kernel warning DoS via SET_IRQS
- [Medium] vfio/pci: missing memory barriers for lockless MSI cache accesses
- [Medium] vfio/pci/qcom: MSI config cache bypassed by non-exact reads
--

commit a2f13f43e82ecd07210fb028cbc53419856cb4cb
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: vfio/pci: Add qcom-vfio-pci variant driver

Add a VFIO variant driver for Qualcomm PCIe devices (ath11k and ath12k)
that require MSI address passthrough for VM operation. This driver caches
physical host MSI values and writes them to a designated extended config
space offset so the VM can discover them automatically.

Link: https://lore.kernel.org/all/20260930140833.576941-4-jtornosm@redhat.c=
om/

> diff --git a/drivers/vfio/pci/qcom/main.c b/drivers/vfio/pci/qcom/main.c
> new file mode 100644
> index 0000000000000..8773661d29a10
> --- /dev/null
> +++ b/drivers/vfio/pci/qcom/main.c
[ ... ]
> +static void qcom_vfio_pci_close_device(struct vfio_device *core_vdev)
> +{
> +	struct qcom_vfio_pci_device *qdev =3D
> +		container_of(core_vdev, struct qcom_vfio_pci_device, vdev.vdev);
> +
> +	qdev->msi_cached =3D false;

[Severity: High]
Does this flag also need to be cleared when MSIs are disabled or the device
is reset?

During a VM soft reboot, QEMU typically disables MSIs (SET_IRQS with
DATA_NONE) and issues VFIO_DEVICE_RESET, but keeps the device file descript=
or
open. Because qdev->msi_cached is only cleared on full device close, won't
a soft reboot leave this flag as true?

If so, the driver might skip updating the cache and serve stale host MSI
addresses to the new VM instance.

> +	qdev->msi_addr_lo =3D 0;
> +	qdev->msi_addr_hi =3D 0;
> +	qdev->msi_data =3D 0;
> +
> +	vfio_pci_core_close_device(core_vdev);
> +}
[ ... ]
> +static long qcom_vfio_pci_ioctl(struct vfio_device *core_vdev,
> +				unsigned int cmd, unsigned long arg)
> +{
> +	struct vfio_pci_core_device *vdev =3D
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	struct qcom_vfio_pci_device *qdev =3D to_qcom_vdev(vdev);
> +	bool is_msi_trigger =3D false;
> +	struct vfio_irq_set hdr;
> +	long ret;
> +
> +	/*
> +	 * Pre-fetch SET_IRQS header to avoid TOCTOU from
> +	 * re-reading userspace after the core ioctl completes.
> +	 */
> +	if (cmd =3D=3D VFIO_DEVICE_SET_IRQS) {
> +		unsigned long minsz =3D offsetofend(struct vfio_irq_set, count);
> +
> +		if (!copy_from_user(&hdr, (void __user *)arg, minsz)) {
> +			is_msi_trigger =3D (hdr.index =3D=3D VFIO_PCI_MSI_IRQ_INDEX &&
> +					  (hdr.flags & VFIO_IRQ_SET_ACTION_TRIGGER));

[Severity: Medium]
Can this condition evaluate to true for an MSI disable command?

If userspace passes VFIO_IRQ_SET_DATA_NONE and count=3D0, is_msi_trigger wi=
ll
still evaluate to true. Later in qcom_cache_and_write_msi(), msi_first_desc=
()
will return NULL, triggering an unratelimited pci_warn().

Could this allow an unprivileged user to flood the host kernel log by
repeatedly disabling MSIs?

[Severity: High]
Is there a time-of-check to time-of-use (TOCTOU) race condition here despite
the pre-fetch?

The header is read via copy_from_user(), setting is_msi_trigger. Then
vfio_pci_core_ioctl() is called below, which performs its own
copy_from_user() on the same userspace memory pointer.

If userspace concurrently changes hdr.index to VFIO_PCI_INTX_IRQ_INDEX
between the two fetches, the core will configure INTx (which doesn't alloca=
te
MSI data structures). However, qcom_vfio_pci_ioctl() will still see
is_msi_trigger =3D=3D true and execute qcom_cache_and_write_msi().

Because MSI was never enabled by the core, won't __msi_lock_descs()
dereference a NULL dev->msi.data pointer and cause a host kernel panic?

> +			if (is_msi_trigger)
> +				pci_dbg(qdev->vdev.pdev,
> +					"SET_IRQS: idx=3D%u flags=3D0x%x start=3D%u count=3D%u\n",
> +					hdr.index, hdr.flags, hdr.start, hdr.count);
> +		}
> +	}
> +
> +	ret =3D vfio_pci_core_ioctl(core_vdev, cmd, arg);
> +
> +	if (ret =3D=3D 0 && is_msi_trigger && !qdev->msi_cached)
> +		qcom_cache_and_write_msi(qdev);
> +
> +	return ret;
> +}
[ ... ]
> diff --git a/drivers/vfio/pci/qcom/msi_quirk.c b/drivers/vfio/pci/qcom/ms=
i_quirk.c
> new file mode 100644
> index 0000000000000..b717aff37ffc8
> --- /dev/null
> +++ b/drivers/vfio/pci/qcom/msi_quirk.c
[ ... ]
> +void qcom_cache_and_write_msi(struct qcom_vfio_pci_device *qdev)
> +{
[ ... ]
> +	qdev->msi_addr_lo =3D addr_lo;
> +	qdev->msi_addr_hi =3D addr_hi;
> +	qdev->msi_data =3D data;
> +	qdev->msi_cached =3D true;

[Severity: Medium]
Are memory barriers required when setting this flag?

Because this flag is read concurrently in qcom_intercept_msi_read() without
locks, can the compiler or CPU reorder the store to msi_cached before the
data stores?

If so, a lockless reader might observe msi_cached =3D=3D true but read
uninitialized or stale addresses, serving garbage to the guest VM. A
smp_store_release() here and smp_load_acquire() on the read side might be
needed.

> +
> +	pci_write_config_dword(pdev, qdev->msi_offset + QCOM_VFIO_MSI_MAGIC_OFF=
SET,
> +			       QCOM_VFIO_MSI_MAGIC);
> +	pci_write_config_dword(pdev, qdev->msi_offset + QCOM_VFIO_MSI_ADDR_LO_O=
FFSET,
> +			       qdev->msi_addr_lo);
> +	pci_write_config_dword(pdev, qdev->msi_offset + QCOM_VFIO_MSI_ADDR_HI_O=
FFSET,
> +			       qdev->msi_addr_hi);
> +	pci_write_config_word(pdev, qdev->msi_offset + QCOM_VFIO_MSI_DATA_OFFSE=
T,
> +			      qdev->msi_data);

[Severity: High]
Do these writes trigger Unsupported Requests on the physical bus?

Since qdev->msi_offset points to unassigned capability space found by
pci_find_free_ext_cap_offset(), writing to it on the physical device can
cause the hardware to return an Unsupported Request (UR) per the PCIe
specification.

With AER enabled on the host, this could trigger error interrupts, PCIe bus
resets, or host system crashes. Also, since VM reads are intercepted in
software, are these physical writes actually necessary?

> +
> +	pci_info(pdev, "Qualcomm WiFi MSI cached at offset 0x%x - addr_lo=3D0x%=
x addr_hi=3D0x%x data=3D0x%x (magic=3DQMSI)\n",
> +		 qdev->msi_offset, qdev->msi_addr_lo, qdev->msi_addr_hi, qdev->msi_dat=
a);
> +}
[ ... ]
> +static ssize_t qcom_intercept_msi_read(struct qcom_vfio_pci_device *qdev,
> +				       loff_t pos, char __user *buf, size_t count)
> +{
> +	u32 tmp_val =3D 0;
> +	int msi_magic, msi_addr_lo, msi_addr_hi, msi_data;
[ ... ]
> +	if (pos =3D=3D msi_magic && count =3D=3D sizeof(u32)) {
> +		if (qdev->msi_cached) {
> +			tmp_val =3D QCOM_VFIO_MSI_MAGIC;
> +			pci_dbg(qdev->vdev.pdev, "Intercepting MAGIC read at 0x%llx, returnin=
g 0x%x (QMSI)\n",
> +				 pos, tmp_val);
> +		} else {
> +			return -ENOTTY;
> +		}
> +	} else if (qdev->msi_cached) {
> +		if (pos =3D=3D msi_addr_lo && count =3D=3D sizeof(u32)) {
> +			tmp_val =3D qdev->msi_addr_lo;
> +			pci_dbg(qdev->vdev.pdev, "Intercepting ADDR_LO read at 0x%llx, return=
ing 0x%x\n",
> +				 pos, tmp_val);
> +		} else if (pos =3D=3D msi_addr_hi && count =3D=3D sizeof(u32)) {
> +			tmp_val =3D qdev->msi_addr_hi;
> +			pci_dbg(qdev->vdev.pdev, "Intercepting ADDR_HI read at 0x%llx, return=
ing 0x%x\n",
> +				 pos, tmp_val);
> +		} else if (pos =3D=3D msi_data && count =3D=3D sizeof(u16)) {
> +			tmp_val =3D qdev->msi_data;

[Severity: High]
Will this copy the wrong bytes on big-endian host architectures?

qdev->msi_data is assigned to tmp_val (a native u32). When count=3D2 is
requested, copy_to_user(buf, &tmp_val, count) will copy the first two bytes
in memory.

On big-endian hosts, won't this copy the most-significant zero-padding bytes
of the u32 rather than the actual data? This would cause the guest VM to
receive corrupted PCI configuration space data. Using cpu_to_le32() and
cpu_to_le16() before copying to userspace might be required.

> +			pci_dbg(qdev->vdev.pdev, "Intercepting MSI_DATA read at 0x%llx, retur=
ning 0x%x\n",
> +				 pos, tmp_val);
> +		} else {
> +			return -ENOTTY;
> +		}
> +	} else {
> +		return -ENOTTY;
> +	}

[Severity: Medium]
Is it intentional that non-exact read sizes bypass the cache?

If the guest VM reads this gap using unaligned, bulk, or byte-sized reads
(e.g., count=3D1 or count=3D8), the code returns -ENOTTY. This causes the V=
FIO
core to fall back to a physical hardware read.

Since the physical hardware has no implementation at this offset, won't it
just return 0, breaking the virtualization contract for guests that don't do
exactly 16-bit or 32-bit aligned reads?

> +
> +	if (copy_to_user(buf, &tmp_val, count))
> +		return -EFAULT;
> +
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011074514.5158=
94-1-jtornosm@redhat.com?part=3D3

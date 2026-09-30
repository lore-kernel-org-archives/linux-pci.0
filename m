Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129D4EB866;
	Wed, 30 Sep 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779558; cv=none; b=SSkofh6iebV/dlF5YSh84KuWXAU6kYoBbVvwvMdH2XV5biXkXHf23lh1XNrQomBUC1XbyqEgqiwCxQTcZsTpMR1WhPU62CDqgnPK/+BUqqFeyEJdal8flN5cUj/e4v2Hr0OmVwBm35l0HJycTqeHlLjAN+Yh+6gE0/vgPYOLy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779558; c=relaxed/simple;
	bh=ak6ouoSv/CM7ryAwul+PhUJ+L+JLUOgnRGK+43y5IYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KfymJhmysU7i/9CopSdXTrgV71r+3Vfe26gEENLq0K1ybNXzzbacww2qrP2E5mpJfjNEvmQuQVfABJvpFDguB8VfV5rKb0RpU94Sco8wy7yeKsLZtIly+dPuZy0pi9q7vYWw88Mu6aJplfmERedPBjf6dm3qHIiJ8DQdGgizSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQthhs0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQthhs0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7A71F000FF;
	Wed, 30 Sep 2026 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779545;
	bh=qqHkRcU5OHYkLfz71VoY5zYBFazAk8P/siXmi1+tzKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IQthhs0feyh2i3ilgyybMtSySSKtnaWc+vafnHNPYd3sS4HVJrADQwCZn11Ny/Bf/
	 Dp83WTTP5ibm2+JdN0C8WYAJYUTpJgDo+qb56FXZyqZ6FLOYCKB5JJCa7iwFQ0W/lj
	 Pe9z2xUgUIMelNX1zatrsFr1EmEfElkIZ6rtDLT6wFPKtNpKIC9OEWB09M4vbAhzJH
	 wKequOmDeASjgcVmkng0lKlFe+wQTqM5tfz0PdxQ63ek9TjPGezfWSXlU22sss7CSm
	 Bx/ZEl+WqoNVpkTBEw56iFDd3hCgtL/TWbVXKfQ5UlrJ+1HSShZh596zJsJBATjRLT
	 d27hAQ55T5qlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] vfio/pci: Add qcom-vfio-pci variant driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260930140833.576941-4-jtornosm@redhat.com>
References: <20260930140833.576941-1-jtornosm@redhat.com>
 <20260930140833.576941-4-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:45:44 +0000
Message-Id: <20260930144545.1C7A71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] vfio/pci: TOCTOU in ioctl double fetch leads to NULL pointer d=
ereference
- [High] vfio/pci: hardware corruption via writes to unassigned config space
- [High] vfio/pci: stale MSI cache across VM reboots due to missing state r=
eset
- [Medium] vfio/pci: data truncation and swapped bytes on big-endian hosts
- [Medium] vfio/pci: sub-dword reads bypass MSI cache and return hardware g=
arbage
- [Medium] vfio/pci: data race in MSI cache updates allows reading uninitia=
lized values
--

commit 6afc81e503658e11a186e8970fd3ac931221f37d
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: vfio/pci: Add qcom-vfio-pci variant driver

Add a VFIO variant driver for Qualcomm PCIe devices (ath11k, ath12k) that
caches physical host MSI addresses and passes them through via extended
config space.

> --- /dev/null
> +++ b/drivers/vfio/pci/qcom/main.c
[ ... ]
> +static ssize_t qcom_vfio_pci_read(struct vfio_device *core_vdev, char __=
user *buf,
> +				  size_t count, loff_t *ppos)
> +{
[ ... ]
> +	if (index =3D=3D VFIO_PCI_CONFIG_REGION_INDEX) {
> +		ret =3D qcom_vfio_pci_config_rw(qdev, buf, count, offset, false);
> +		if (ret !=3D -ENOTTY) {
> +			if (ret > 0)
> +				*ppos +=3D ret;
> +			return ret;
> +		}
> +	}
> +
> +	return vfio_pci_core_read(core_vdev, buf, count, ppos);

[Severity: Medium]
Will this fallback to vfio_pci_core_read() leak hardware garbage to the gue=
st
if a sub-dword read bypasses the MSI cache interception? Since
qcom_intercept_msi_read() strictly matches exact 4-byte or 2-byte sizes,
unaligned or smaller guest reads will fall through and return -ENOTTY, caus=
ing
a real physical read from the unbacked capability gap.

[ ... ]
> +static long qcom_vfio_pci_ioctl(struct vfio_device *core_vdev,
> +				unsigned int cmd, unsigned long arg)
> +{
> +	struct vfio_pci_core_device *vdev =3D
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	struct qcom_vfio_pci_device *qdev =3D to_qcom_vdev(vdev);
> +	struct vfio_irq_set hdr;
> +	long ret;
> +
> +	ret =3D vfio_pci_core_ioctl(core_vdev, cmd, arg);
> +
> +	/*
> +	 * If SET_IRQS ioctl succeeded for MSI and MSI wasn't cached yet,
> +	 * cache the MSI descriptor values.
> +	 * Only intercept MSI index (not INTx, MSI-X, ERR, or REQ).
> +	 */
> +	if (ret =3D=3D 0 && cmd =3D=3D VFIO_DEVICE_SET_IRQS) {
> +		unsigned long minsz =3D offsetofend(struct vfio_irq_set, count);
> +
> +		if (copy_from_user(&hdr, (void __user *)arg, minsz))

[Severity: Critical]
Can this double fetch of the ioctl argument from userspace create a race
condition leading to a NULL pointer dereference?

The copy_from_user() happens after vfio_pci_core_ioctl() has already
processed the buffer. A concurrent thread could rewrite hdr.index in usersp=
ace
to VFIO_PCI_MSI_IRQ_INDEX after the core validates it. This would cause the
driver to execute qcom_cache_and_write_msi(), which takes the MSI descriptor
lock (__msi_lock_descs(dev)) on an unallocated dev->msi.data, resulting in
a kernel panic.

> +			return ret;
> +
> +		if (hdr.index =3D=3D VFIO_PCI_MSI_IRQ_INDEX) {
> +			pci_dbg(qdev->vdev.pdev,
> +				 "SET_IRQS: index=3D%u flags=3D0x%x start=3D%u count=3D%u cached=3D%=
d\n",
> +				 hdr.index, hdr.flags, hdr.start, hdr.count, qdev->msi_cached);
> +
> +			if (!qdev->msi_cached && (hdr.flags & VFIO_IRQ_SET_ACTION_TRIGGER))
> +				qcom_cache_and_write_msi(qdev);

[Severity: High]
Does skipping the MSI cache update here break interrupt delivery if a VM is
rebooted or a new VM attaches to the same device?

Since qdev->msi_cached is initialized to false in qcom_vfio_pci_init_dev()
but never reset to false when the device is closed (e.g., in
qcom_vfio_pci_ops), a subsequent VM attachment will see !qdev->msi_cached as
false. The driver would then silently fail to cache the new MSI allocations,
leaving the guest with stale MSI addresses from the previous VM execution.

> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct vfio_device_ops qcom_vfio_pci_ops =3D {
> +	.name		=3D "qcom-vfio-pci",
> +	.init		=3D qcom_vfio_pci_init_dev,
> +	.release	=3D vfio_pci_core_release_dev,
> +	.open_device	=3D qcom_vfio_pci_open_device,
> +	.close_device	=3D vfio_pci_core_close_device,

[Severity: High]
This appears to be where a wrapper around vfio_pci_core_close_device would =
be
needed to clear qdev->msi_cached back to false when a VM shuts down,
preventing the stale MSI cache issue mentioned above.

[ ... ]
> --- /dev/null
> +++ b/drivers/vfio/pci/qcom/msi_quirk.c
> @@ -0,0 +1,163 @@
[ ... ]
> +void qcom_cache_and_write_msi(struct qcom_vfio_pci_device *qdev)
> +{
> +	struct pci_dev *pdev =3D qdev->vdev.pdev;
> +	struct device *dev =3D &pdev->dev;
> +	struct msi_desc *desc;
> +	u32 addr_lo, addr_hi;
> +	u16 data;
> +
> +	if (qdev->msi_cached)
> +		return;

[Severity: High]
This early return relies on qdev->msi_cached, which appears to never be
reset across VM reboots, as noted in qcom_vfio_pci_ioctl().

[ ... ]
> +	qdev->msi_addr_lo =3D addr_lo;
> +	qdev->msi_addr_hi =3D addr_hi;
> +	qdev->msi_data =3D data;
> +	qdev->msi_cached =3D true;

[Severity: Medium]
Could this lack of a write memory barrier before setting qdev->msi_cached
allow a concurrent reader in qcom_intercept_msi_read() to observe
msi_cached =3D=3D true but read stale or zeroed MSI addresses?

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
Are these physical writes to unassigned configuration space safe on PCIe
hardware?

qdev->msi_offset points to a free capability gap discovered by
pci_find_free_ext_cap_offset(). PCIe endpoints are not required to implement
registers in unused gaps, so writing to them using pci_write_config_dword()
violates the PCIe specification and risks causing Unhandled Request (UR) fa=
ults
that can trigger AER cascades and crash the host.

Given that guest reads are emulated by the driver in
qcom_intercept_msi_read(), do these values actually need to be physically
written to the hardware?

[ ... ]
> +static ssize_t qcom_intercept_msi_read(struct qcom_vfio_pci_device *qdev,
> +				       loff_t pos, char __user *buf, size_t count)
> +{
> +	u32 tmp_val =3D 0;
> +	int msi_magic, msi_addr_lo, msi_addr_hi, msi_data;
> +
> +	if (!qdev->msi_offset)
> +		return -ENOTTY;
> +
> +	msi_magic =3D qdev->msi_offset + QCOM_VFIO_MSI_MAGIC_OFFSET;
> +	msi_addr_lo =3D qdev->msi_offset + QCOM_VFIO_MSI_ADDR_LO_OFFSET;
> +	msi_addr_hi =3D qdev->msi_offset + QCOM_VFIO_MSI_ADDR_HI_OFFSET;
> +	msi_data =3D qdev->msi_offset + QCOM_VFIO_MSI_DATA_OFFSET;
> +
> +	if (pos =3D=3D msi_magic && count =3D=3D sizeof(u32)) {

[Severity: Medium]
Will this strict size and position check cause sub-dword guest reads (e.g.,=
 a
1-byte read) to fall through and bypass the interception entirely? This rel=
ates
to the fallback in qcom_vfio_pci_read() returning hardware garbage.

> +		if (qdev->msi_cached) {
> +			tmp_val =3D QCOM_VFIO_MSI_MAGIC;
> +			pci_dbg(qdev->vdev.pdev, "Intercepting MAGIC read at 0x%llx, returnin=
g 0x%x (QMSI)\n",
> +				 pos, tmp_val);
> +		} else {
> +			return -ENOTTY;
> +		}
> +	} else if (qdev->msi_cached) {

[Severity: Medium]
Does evaluating qdev->msi_cached without a read memory barrier expose the
driver to race conditions, as mentioned in qcom_cache_and_write_msi()?

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

[Severity: Medium]
Will this zero-extension of the 16-bit msi_data into the 32-bit tmp_val
cause the subsequent copy_to_user of sizeof(u16) bytes to return zeroes
instead of the actual MSI data on big-endian platforms?

> +			pci_dbg(qdev->vdev.pdev, "Intercepting MSI_DATA read at 0x%llx, retur=
ning 0x%x\n",
> +				 pos, tmp_val);
> +		} else {
> +			return -ENOTTY;
> +		}
> +	} else {
> +		return -ENOTTY;
> +	}
> +
> +	if (copy_to_user(buf, &tmp_val, count))

[Severity: Medium]
Since PCI config space requires a little-endian presentation, does copying =
the
host-endian tmp_val directly to userspace here without endianness conversion
truncate and byte-swap the MSI values on big-endian hosts?

> +		return -EFAULT;
> +
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930140833.5769=
41-1-jtornosm@redhat.com?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2BB401A38;
	Fri, 21 Aug 2026 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341592; cv=none; b=nt09XHOOqhznTQCcgnyte7N3qwjD7rzMQOLs77bTeC467J3dXs8nIBXfiKR4T+lyaLa9ykZYPWbel95m+AGIsTj8BqXKCPs89CFRUe9yiwoBPSqaeOB5vnuS3Yp9MiNMlmOEHLcm99nNec75gX0+fTTWkfXQV3CBfnRi1rw8i5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341592; c=relaxed/simple;
	bh=kEYf/ZM1563EBMSULOWZ4RIeW59jvIi0bc/DQ0Xq02M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lvmc/gYnGTGH24ylNHJn98x4NYvC2vyTUCLGuOMEMdEH3PPNe52HgCAaWLPsRnW2mNEMXqzABsJ8IPzSA46YZV+J1W8kJQUBGS8H5m1q3vOkrzBoD3k1/l/ZCT9yWqwM5jV3WioDXxIcQZqaP0efNS/cUFCxM845sCnTA7m21R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzUkz/Hr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzUkz/Hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329291F000E9;
	Fri, 21 Aug 2026 19:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341586;
	bh=8E7j+WSPEkNMU8WH7c2g9fRHfdvG7X6pOhb0utTtiV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NzUkz/Hrm+EhOSCy9idsujXD4vBEBvAQ4oP+p/0An0RmiE6O210XKvPM7fem7DuMx
	 jLjgInSOl03WriVkA2gfY2Bgnk3xpxMouZZ4J9K0lcxRB/nirr34XthrmE7rrXGuVN
	 P7vafjJm5Gl3w7lrRdugIwSl6krZy//wQTCgCtwAjv+et5aMhAk0xHEfWlPdgDYJ4c
	 XBw/A4ni7iqfTa8s49NfatbshONZnXeeijCn5kSEj/EeCPP2+0cE7ST0ACAPsj/8G2
	 P9H8ioSFlfK6tuzSy1vEJL/p95EjM7T+zcs3z9f5ajhMFSNkxm8qSPbg3GNKc7oaa2
	 Nf/FnRZzEZx6w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/1] selftests: vfio: Add mmap fault and device
 reset test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260821193502.92431-2-vipinsh@google.com>
References: <20260821193502.92431-1-vipinsh@google.com>
 <20260821193502.92431-2-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:46:25 +0000
Message-Id: <20260821194626.329291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A circular locking dependency exists between `mmap_lock`, `vdev->m=
emory_lock`, and `group->mutex`, leading to a potential deadlock.
--

--- Patch [1]: [RFC PATCH 1/1] selftests: vfio: Add mmap fault and device r=
eset test ---
commit 3fb77a6912d6cc2309856fef1f82986ea816df96
Author: Vipin Sharma <vipinsh@google.com>
Subject: selftests: vfio: Add mmap fault and device reset test

This commit adds a selftest to verify VFIO PCI device reset on an mmapped
and faulted device. The test maps all available BARs, triggers a page
fault on them, and then initiates a device reset via the VFIO_DEVICE_RESET
ioctl to expose a circular locking dependency.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c b/to=
ols/testing/selftests/vfio/vfio_pci_mmap_reset_test.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c
[ ... ]
> +TEST_F(vfio_pci_mmap_reset_test, mmap_fault_and_reset)
> +{
[ ... ]
> +	if (!has_mmap)
> +		SKIP(return, "No mmapable BAR found on device\n");
> +
> +	/* Trigger device reset under memory_lock */
> +	vfio_pci_device_reset(self->device);

[Severity: High]
This is a pre-existing issue, but does this test sequence reliably trigger a
host kernel deadlock by exposing a circular locking dependency between
mmap_lock, vdev->memory_lock, and group->mutex?

The lockdep cycle appears to start when a page fault holds mmap_lock and
acquires vdev->memory_lock:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_mmap_huge_fault()
    scoped_guard(rwsem_read, &vdev->memory_lock)

Separately, a device reset acquires vdev->memory_lock before initiating the
reset:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_ioctl_reset()
    vfio_pci_zap_and_down_write_memory_lock(vdev);

While held, it calls into the PCI reset functions which eventually prepare
the IOMMU and acquire group->mutex:

drivers/iommu/iommu.c:pci_dev_reset_iommu_prepare()
    guard(mutex)(&group->mutex);

The cycle completes when another kernel path holding group->mutex waits on
mmap_lock or memory_lock. Can a malicious guest VM or local user with VFIO
access trigger concurrent page faults and device resets to exploit this
cycle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821193502.9243=
1-2-vipinsh@google.com?part=3D1

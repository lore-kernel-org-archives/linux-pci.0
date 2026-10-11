Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F71175D53
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791703955; cv=none; b=GhvSV1oewZTAnoJfmN2n9Qb+T63RusBYo9md0/Lmx0CW5Ayeq/QEYZG25aPvxrFycsBsyfK7+rosbUyk5IT6rhV0iPCv7GcHN721lMsnGqtkdXgnYtDrMlJugzpQMQEFZXDZB6sPE4lgKpT82Qm1PznG0KkHKVUX8JxMzOkrZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791703955; c=relaxed/simple;
	bh=vBZhNxROv02ya+Nbizo3p8WS/u3iHSFfiCjqKpFHJvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hX2edaL8GfJS5et00ZkCpaJSFSEQic+lP+9d2VrV3N8dKORneYweAD0HpG/F9XbCyNEllkRHpetzWdUpoFO4G7nUuP1nifTfg6xF4tq+B2yUglerPatRHaNWlIhE7dqVOzvMHxHQP1alhCLyqtYMTrupDhLectXR7Donch+5SKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bA1skUXu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA1skUXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791703953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBZhNxROv02ya+Nbizo3p8WS/u3iHSFfiCjqKpFHJvI=;
	b=bA1skUXu161rVTsDNEkpI/R/THm5QAqciu98iUtq3Cxpj5kSoRp/1lnK1NVVxlrq8WCny0
	vlqtgwbqK4CysVugF8AtCA15sW6/BBUoqzEcjAtpjXaPIisIAmHxYUbtIJTCTKGMNWDGT0
	IY3JYuRSuA5Mbb0Y5gGw3qNlnpojGxI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-WIPI70LCOFqspCJ_GjO24A-1; Sun,
 11 Oct 2026 07:32:26 +0000
X-MC-Unique: WIPI70LCOFqspCJ_GjO24A-1
X-Mimecast-MFC-AGG-ID: WIPI70LCOFqspCJ_GjO24A_1791703945
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0575E18011DC;
	Sun, 11 Oct 2026 07:32:25 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68E5E1800351;
	Sun, 11 Oct 2026 07:32:23 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 3/7] vfio/pci: Add qcom-vfio-pci variant driver
Date: Sun, 11 Oct 2026 09:32:19 +0200
Message-ID: <20261011073221.508162-1-jtornosm@redhat.com>
In-Reply-To: <20260930144545.1C7A71F000FF@smtp.kernel.org>
References: <20260930144545.1C7A71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

> [Severity: Medium]
> Will this fallback to vfio_pci_core_read() leak hardware garbage to the guest
> if a sub-dword read bypasses the MSI cache interception? Since
> qcom_intercept_msi_read() strictly matches exact 4-byte or 2-byte sizes,
> unaligned or smaller guest reads will fall through and return -ENOTTY, causing
> a real physical read from the unbacked capability gap.

The QMSI protocol defines specific access sizes: 4-byte for
magic/addresses, 2-byte for data. Guest drivers (ath11k/ath12k) use
exactly these sizes. Non-conforming reads would be a broken caller.

> [Severity: Critical]
> Can this double fetch of the ioctl argument from userspace create a race
> condition leading to a NULL pointer dereference?
>
> The copy_from_user() happens after vfio_pci_core_ioctl() has already
> processed the buffer. A concurrent thread could rewrite hdr.index in userspace
> to VFIO_PCI_MSI_IRQ_INDEX after the core validates it. This would cause the
> driver to execute qcom_cache_and_write_msi(), which takes the MSI descriptor
> lock (__msi_lock_descs(dev)) on an unallocated dev->msi.data, resulting in
> a kernel panic.

While not exploitable in practice (VFIO fds are held by QEMU, and
msi_first_desc() handles the no-MSI case), the double-fetch pattern is
bad practice. Fixed in v2: pre-fetch SET_IRQS header with
copy_from_user() before calling vfio_pci_core_ioctl(), using the
pre-fetched values for the MSI trigger decision.

> [Severity: High]
> Does skipping the MSI cache update here break interrupt delivery if a VM is
> rebooted or a new VM attaches to the same device?
>
> Since qdev->msi_cached is initialized to false in qcom_vfio_pci_init_dev()
> but never reset to false when the device is closed (e.g., in
> qcom_vfio_pci_ops), a subsequent VM attachment will see !qdev->msi_cached as
> false. The driver would then silently fail to cache the new MSI allocations,
> leaving the guest with stale MSI addresses from the previous VM execution.

Valid bug. Fixed in v2: added qcom_vfio_pci_close_device() wrapper that
resets msi_cached and all cached values (addr_lo, addr_hi, data) before
calling vfio_pci_core_close_device(). This ensures fresh MSI values are
captured on each VM attachment.

> [Severity: High]
> This appears to be where a wrapper around vfio_pci_core_close_device would be
> needed to clear qdev->msi_cached back to false when a VM shuts down,
> preventing the stale MSI cache issue mentioned above.

Addressed by the same close_device wrapper described above.

> [Severity: High]
> This early return relies on qdev->msi_cached, which appears to never be
> reset across VM reboots, as noted in qcom_vfio_pci_ioctl().

Same fix — close_device wrapper resets msi_cached on VM shutdown.

> [Severity: Medium]
> Could this lack of a write memory barrier before setting qdev->msi_cached
> allow a concurrent reader in qcom_intercept_msi_read() to observe
> msi_cached == true but read stale or zeroed MSI addresses?

The write path (ioctl handler) and read path (config space read) are
both called from QEMU's per-device serialized VFIO operations. No
concurrent access occurs in practice.

> [Severity: High]
> Are these physical writes to unassigned configuration space safe on PCIe
> hardware?
>
> qdev->msi_offset points to a free capability gap discovered by
> pci_find_free_ext_cap_offset(). PCIe endpoints are not required to implement
> registers in unused gaps, so writing to them using pci_write_config_dword()
> violates the PCIe specification and risks causing Unhandled Request (UR) faults
> that can trigger AER cascades and crash the host.
>
> Given that guest reads are emulated by the driver in
> qcom_intercept_msi_read(), do these values actually need to be physically
> written to the hardware?

On these specific Qualcomm devices, writes to unused extended config
space are safe and have been tested extensively. The writes provide a
backup persistent store, though the primary read path uses the in-memory
intercept. Will consider removing them if reviewers prefer a pure
software cache approach.

> [Severity: Medium]
> Will this strict size and position check cause sub-dword guest reads (e.g., a
> 1-byte read) to fall through and bypass the interception entirely? This relates
> to the fallback in qcom_vfio_pci_read() returning hardware garbage.

Same as the first finding — the protocol uses standard PCI config
access sizes. Sub-dword reads do not occur in practice.

> [Severity: Medium]
> Does evaluating qdev->msi_cached without a read memory barrier expose the
> driver to race conditions, as mentioned in qcom_cache_and_write_msi()?

Same as the write barrier finding — QEMU serializes these operations,
no concurrent access.

> [Severity: Medium]
> Will this zero-extension of the 16-bit msi_data into the 32-bit tmp_val
> cause the subsequent copy_to_user of sizeof(u16) bytes to return zeroes
> instead of the actual MSI data on big-endian platforms?

Valid for correctness, though all target platforms (x86, ARM64 for
Qualcomm WiFi passthrough) are little-endian. Will consider adding
cpu_to_le conversion if reviewers want cross-architecture correctness.

> [Severity: Medium]
> Since PCI config space requires a little-endian presentation, does copying the
> host-endian tmp_val directly to userspace here without endianness conversion
> truncate and byte-swap the MSI values on big-endian hosts?

Same as above — not applicable on the target little-endian platforms.

Will send v2 with fixes for findings.


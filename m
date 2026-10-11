Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803B369219
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791703031; cv=none; b=gvoZ5BLzyzrZE6B5x7dHJJCMVU55MtSFbrnRyqiCJPPev8fw/G9ez4ddFHBl/mdAdDS9DPRZloSysuqp+ZVlfjAyCF4b01Fdy0kot4vIyGFFPa//rhxdHMmMLYvT/z0HpFr13/DssJ2PEn8ZnqIWN7Y/kT4fQxwgklbYzZijfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791703031; c=relaxed/simple;
	bh=ZUK9rcSpEpSUHzdYNfZiRBtcugeL0hHAv5lcPoIRWo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPWgwYcldVmVQWGFjX4oIIw2XoKl727Vu5w1ldKDmcrxS/WeS5ExkRbL2dLzJ9FkN5RxjIXFvvgY1BKss7+WAk8I4LAKk6DTvkS4oYlTNZhvGUF3C47DcPAzBuaY2FvMsB3LXTMtUXNSk1RGKrAZGC+qWN+VyI8d/a+lY8vuBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXVEYliz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXVEYliz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791703029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Po4kqLt9W4SvS9uRrM6O/FVIkG+dWT3ks06Hqz7p2LY=;
	b=PXVEYliz42N9NRGejnbHfT8thywZPi6F92z+AFeDncibsXGDVkhARk/W3p1xxlhFswXjn9
	uUs6PTf8ZbxY9PHfUS7FMJizdDb+EtD2iykJ2/Q5sGYkYUH6Ua0FYX6Ktop+LfcafGIpmd
	mivB2vOYfMSMaGpKH0+pi7tg62fGN5k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-C-dfqTKKOqSyT6MWEVKWmA-1; Sun,
 11 Oct 2026 07:17:07 +0000
X-MC-Unique: C-dfqTKKOqSyT6MWEVKWmA-1
X-Mimecast-MFC-AGG-ID: C-dfqTKKOqSyT6MWEVKWmA_1791703026
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55AD91955F76;
	Sun, 11 Oct 2026 07:17:06 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88D0718004D4;
	Sun, 11 Oct 2026 07:17:04 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 2/7] vfio: Add qcom_vfio.h header for MSI cache protocol
Date: Sun, 11 Oct 2026 09:17:03 +0200
Message-ID: <20261011071703.506995-1-jtornosm@redhat.com>
In-Reply-To: <20260930143149.0F62D1F00893@smtp.kernel.org>
References: <20260930143149.0F62D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

> [Severity: Critical]
> Does using pci_find_free_ext_cap_offset() here risk corrupting active
> hardware capabilities?
>
> pci_find_free_ext_cap_offset() relies on a heuristic that assumes the last
> extended capability is exactly 64 bytes:
>
> drivers/pci/pci.c:pci_find_free_ext_cap_offset() {
>     ...
>     free_offset = last_cap_start + 64;
>     free_offset = ALIGN(free_offset, 4);
>     ...
> }
>
> If the final capability is larger (such as AER, DPC, or VSEC), this
> allocation would return an offset inside the active capability. Will the
> host driver physically writing MSI data to this offset silently corrupt the
> device's hardware capability state?

Already addressed by v2 of patch 1/7. The new zero-scan approach only
returns genuinely zeroed space, so there is no risk of overlapping
active capabilities.

> [Severity: Medium]
> Will this loop prematurely terminate and fail to find the MSI cache if the
> offset is allocated above 0xf00?
>
> The host driver uses pci_find_free_ext_cap_offset(), which can legitimately
> return an offset up to 0xff0 in the 4096-byte PCIe extended config space.
> If the cache block is placed between 0xf04 and 0xff0, the guest driver
> would silently fail to discover the magic signature.

Valid, fixed in v2. Changed upper bound to
PCI_CFG_SPACE_EXP_SIZE - QCOM_VFIO_MSI_SPACE_SIZE to cover the full
extended config space range. Also replaced hardcoded 0x100 with
PCI_CFG_SPACE_SIZE.

> [Severity: High]
> Does blindly reading every DWORD in the extended config space risk bus
> errors and unintended hardware side effects?
>
> Iterating through the configuration space without walking the PCIe
> capability linked list means reading active capability registers
> arbitrarily. This can trigger unintended read side-effects, such as
> clearing Read-to-Clear (RC) status bits.
>
> Furthermore, reading unmapped PCIe configuration space can generate
> Unsupported Request (UR) bus errors. On some systems, URs escalate to
> Advanced Error Reporting (AER) faults or system hangs.

Not applicable. qcom_vfio_find_msi_cache() is a VM-side function:
config reads go through QEMU's VFIO config space virtualization, not
directly to hardware. No URs or RC bit clearing will occur. Added a
comment clarifying this in v2.

> [Severity: High]
> Could this lead to false positive MSI discoveries if active registers or
> payloads contain this value?
>
> Since the loop scans the entire config space instead of parsing
> vendor-specific capabilities, a legitimate device register, statistics
> counter, or VSEC payload might naturally contain the 32-bit value
> 0x49534D51 (QMSI).
>
> If falsely identified, the guest driver would interpret the subsequent 12
> bytes as physical MSI addresses and mistakenly program invalid addresses
> into the device firmware.

Extremely unlikely. The magic "QMSI" (0x49534D51) is an ASCII signature
chosen to avoid collision with real hardware register values. This
function only runs on known Qualcomm WiFi devices. Even if a false
positive occurred, downstream addr_lo validation (non-zero and
!= 0xFFFFFFFF) would catch it.

Will send v2 addressing the above.


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30F273F9
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108531; cv=none; b=F2U8c3qaiCR+g6f/nSWhfPm3g8F8L610/X3rbZEGgpHnnh8f6hUBxMxRS4QkbxLv/Jau/m3XXEiZHwsd4S+Ff3zit5kzV86X6wEXMJmBfLEh2lrwp2z9HW+UhZ3gCHBg3FHBpsWzXwYqNDDFePaC3CQbyDj15gyGbwScJPAFnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108531; c=relaxed/simple;
	bh=JYB4xcqf2Y+nm+qn0K0DXNw0JOT9+QHkuwgPUCtRtB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BKnM2EsO5ae1TB7iYlwsuLLFzLd01WL/OmmxtRrKrWMg1KgWZzOh8DiPnPBW4Migqc6fEt8AZbB81TrNVLcbD3QafVUDkI93M4QdTsnCmuZzQCkmXZcZXdu1hZ4cDlfM3AEnXZxTtYtlgNO+mFWoxtakITY3X37ceyqju1Of+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ga5u+kgC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ga5u+kgC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779108528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fWKXXzlPxSMXwep0dyvpF8yvgGbqwsYVfwGp+Whm1XE=;
	b=ga5u+kgCuOE7GefDadjois+2BYE9h+UN0v3McJP6wrX8dyTjxIfqtPDVPQ1BzWHoC0m6hM
	TN3f3w4nPDAiW/5s6vwlqIYAdBJIRi4FVmDb1SotcV1NpyxHLZh4MpA91Frw8O4+v06HjC
	Pye32ZYpuCsm5DFq1nB8yD+R70LvcHw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-bCzyeZiWMC6GfywKrs_T8w-1; Mon,
 18 May 2026 08:48:47 -0400
X-MC-Unique: bCzyeZiWMC6GfywKrs_T8w-1
X-Mimecast-MFC-AGG-ID: bCzyeZiWMC6GfywKrs_T8w_1779108526
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6607D180056E;
	Mon, 18 May 2026 12:48:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.67])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89AA01956053;
	Mon, 18 May 2026 12:48:44 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v4 0/3] PCI: Add d3cold/soft reset methods for devices with limited reset capability
Date: Mon, 18 May 2026 14:48:32 +0200
Message-ID: <20260518124836.460805-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Some PCIe devices lack working reset methods for VFIO passthrough scenarios.
These devices typically have no FLR, advertise NoSoftRst+ (blocking PM reset),
and have broken or unavailable bus reset. When a VM crashes, VFIO cannot reset
the device for reuse without a working reset method.

This series addresses the problem by adding two new reset methods and a
device-specific quirk:

**Patch 1/3: d3cold reset method**
Adds D3cold as a general reset method with strict _PR3 requirement. Only
attempts true power cycling via platform control (ACPI _PR3), never falls
back to D3hot. This provides genuine power-off reset on platforms that
support it.

**Patch 2/3: soft reset method**
Adds "soft" reset as absolute last resort when all other methods fail.
Performs D3hot→D0 transition without checking NoSoftRst flag. Only becomes
available when both pci_pm_reset() and pci_d3cold_reset() return -ENOTTY.
Provides "better than nothing" reset for devices that would otherwise have
no reset capability. Users retain full policy control via reset_methods sysfs.

**Patch 3/3: Qualcomm quirk_no_bus_reset**
Disables broken bus reset for Qualcomm ath11k/ath12k WiFi and SDX62/SDX65
modems. Testing proves this is device-specific: MediaTek MT7925e works
correctly with bus reset using the same passive M.2-to-PCIe adapters where
Qualcomm devices fail, confirming PERST# is properly wired and the issue
is not deployment-specific.
mt7925e needs quirk_no_flr to work
(https://lore.kernel.org/all/20260511123936.36054-1-jtornosm@redhat.com/)
other cards using this adpaters are using flr method with no problem.

**Changes in v4:**
- Split v3's d3cold method (which fell back to D3hot) into two separate
  methods based on maintainer feedback (Alex Williamson)
- d3cold now strictly requires _PR3, returns -ENOTTY otherwise
- New "soft" method handles D3hot transition as last resort
- Extracted pci_do_d3hot_transition() helper to avoid code duplication
  between pci_pm_reset() and pci_soft_reset()
- Updated Qualcomm quirk commit message to reference new architecture

**Testing:**
All testing performed on 2023 desktops with M.2 WiFi cards via passive
M.2-to-PCIe adapters in standard PCIe expansion slots (00:1c.x ports).

Evidence for device-specific reset issues:
- Realtek RTL8922AE: 00:1c.1, reset_method="flr bus", FLR works correctly
  (Proves FLR signaling works through passive adapters)
- MediaTek MT7925e: 00:1c.1, reset_method="bus", bus reset works correctly
  (Has separate quirk_no_flr patch due to broken FLR, proves PERST# works)
- Qualcomm WCN785x: 00:1c.4, reset_method="bus", bus reset FAILS
  (Same adapters, same slot type - proves device-specific SBR issue)

All three devices use identical passive M.2-to-PCIe adapters in standard
PCIe expansion slots. The fact that FLR works for Realtek and bus reset
works for MediaTek but both fail for their respective broken devices
confirms these are device-specific hardware issues, not deployment or
adapter issues.

D3hot transition testing (documented in detail):
- Command register cleared: 0x0002 → 0x0000 → 0x0506 after driver init
- BARs preserved: 0x84200004 maintained throughout
- Device successfully reusable for VFIO passthrough after VM crash

Reset hierarchy after this series:
1. device_specific
2. acpi
3. flr
4. af_flr
5. pm (unchanged - still checks NoSoftRst)
6. bus
7. cxl_bus
8. d3cold (NEW - strict _PR3 requirement)
9. soft (NEW - D3hot last resort)

Jose Ignacio Tornos Martinez (3):
  PCI: Add d3cold as general reset method
  PCI: Add soft reset method as last resort
  PCI: Disable broken bus reset on Qualcomm devices

--
2.53.0


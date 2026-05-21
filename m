Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBF3C0611
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368736; cv=none; b=qcIb7UY7Qkkh8T3x0eZIN7sta4+l/EVLCikUJ/faXt8apsbeJIrZWZLLEjREQ7m6IYe2Px9KU53v8LDN9lB5j0XMuzJfL77F08Ra68GRwfzamQes1HCk+4PNA7AGA+VdvyberWOf2Mgdla5Etc4rmyl6zkKvT5FscYL5fyXqBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368736; c=relaxed/simple;
	bh=Ib5ByKeo6zitzSzeO5pNVNT3kOEjDX3ae1mb1IuqAiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXiscdMMDm6JT+Y/ifpEhquE0/bhweW919R7NMZGPztYpuv/XlsUvgUCqmTFbI4g6drfxbF0UxtuLmhYNaF0rFCGA5i/9/Gc6ZIY7C02dYO9zc+sGSkXEFGlHUa2Yrp29mZczLipNHnuCk/S3VenViEtJW/3wISv+88Zi5yqyhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ps/8/WMA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ps/8/WMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779368733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kjbbv0dnP6ZeqA3kIPSiLYlXFdYbC6xubLnsKzppoSo=;
	b=Ps/8/WMAgliO8MxrvX7q6LXRmxU84MJX1ieXQFtYltnP5shcNBh80QoFI1LFW8QjSMi3dg
	xzmv1zoIXXAgydH2dw++ewaya1IhrnqEUOfuFhugX8Gv5zloxWTt3kbjrGJpT825yT/GLt
	OGs5ADi8SELb5Okps7iO7QGozLrzdBg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-26ocLX1fNlqDOl0iuJNHwQ-1; Thu,
 21 May 2026 09:05:29 -0400
X-MC-Unique: 26ocLX1fNlqDOl0iuJNHwQ-1
X-Mimecast-MFC-AGG-ID: 26ocLX1fNlqDOl0iuJNHwQ_1779368728
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FBEE180076A;
	Thu, 21 May 2026 13:05:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7071F1800465;
	Thu, 21 May 2026 13:05:26 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v5 0/3] PCI: Add d3cold and device-specific reset for Qualcomm devices
Date: Thu, 21 May 2026 15:05:09 +0200
Message-ID: <20260521130512.515125-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Some PCIe devices lack working reset methods for VFIO passthrough scenarios.
These devices typically have no FLR, advertise NoSoftRst+ (blocking PM reset),
and have broken or unavailable bus reset. When a VM crashes, VFIO cannot reset
the device for reuse without a working reset method.

This series addresses the problem by adding general d3cold infrastructure and
device-specific reset for Qualcomm devices:

**Patch 1/3: d3cold reset method**
Adds D3cold as a general reset method with strict _PR3 requirement. Only
attempts true power cycling via platform control (ACPI _PR3), never falls
back to D3hot. This provides genuine power-off reset on platforms that
support it.

**Patch 2/3: device-specific reset for Qualcomm devices**
Adds device-specific reset entries for Qualcomm ath11k/ath12k WiFi and
SDX62/SDX65 modems using D3cold power cycling with automatic D3hot fallback.
Uses pci_set_power_state(D3cold) which automatically falls back to D3hot on
platforms without _PR3. Extracts shared pci_dev_d3cold_d0_cycle() helper to
avoid code duplication with general d3cold method. Device-specific reset is
position #1 in reset hierarchy, providing immediate working reset for these
Qualcomm devices.

**Patch 3/3: Qualcomm quirk_no_bus_reset**
Disables broken bus reset for Qualcomm devices. Testing proves this is
device-specific: MediaTek MT7925e works correctly with bus reset using the
same passive M.2-to-PCIe adapters where Qualcomm devices fail, confirming
PERST# is properly wired and the issue is not deployment-specific. Acts as
safety net to prevent broken SBR if users override via sysfs.

v5: - Follow the advice from Alex Williamson, replace v4's general "soft"
    reset method (patch 2/3) as too broad by a device-specific reset using
    pci_dev_reset_methods[]
    - Address the suggestion of AI review (sashiko.dev), add IOMMU handling
    (pci_dev_reset_iommu_prepare/done) to prevent IOMMU faults during power
    state transitions 
v4: https://lore.kernel.org/all/20260518124836.460805-1-jtornosm@redhat.com/

Jose Ignacio Tornos Martinez (3):
  PCI: Add d3cold as general reset method
  PCI: Add device-specific reset for Qualcomm devices
  PCI: Disable broken bus reset on Qualcomm devices

--
2.53.0


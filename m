Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B3401A06
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675051; cv=none; b=ujBKnJk8CpukulE7GFzIDcIXRPDDpcG3MqpIJAa0EulTZvgrbRGzF16gR8NDu8heWb4ZAtV/73c91bs3k2Qf0pQjFch7hitdlJTB2AUE0+mdzx4aOzn8lbsnf+5xk4vRjkKZUWtHJM6LwSLycxdnE+NmvNzIaA+JU4x0zqJxfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675051; c=relaxed/simple;
	bh=Qw7EmANXXZ/3LVJG07S3ZA5FOZib+h+6FFOJe1eDYwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrXiNJSUssyAH/Di+8K5DRjvCIBFb5siDVlXfxPWlu7BwAXJN68JwIiySR/gcWc9M6jS7M7XBNaPWMgS02JYcEiMKLd5mGwyYizyNhc7B65w2F0jebfxlgefZf8UCPVxrOpLR5mgPhBHLGEq8GA7gEBfHjC6QNQVZ/sdSIuRttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgxgamXA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgxgamXA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778675048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VibxllrwfZ+Olr8/pslJuB6WWRQE69TiRFLko78sNoM=;
	b=HgxgamXAmjpoUmCBiIJVBFVCtr6drTUwpEyVIJyQqRJGoAeYXfUeN2yb9rhN3Es5VDo9Mv
	1VgPKa953MxSDAqISGJFedNLCNaLSKTlZgpnS26RH/qu9663DMaZcXm3GbY5co0jcWOl9I
	CXzXwi7eff92Nfbtav4i1VmcxP9jU0c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-de5PqA9bOvyeOQD16-IoyA-1; Wed,
 13 May 2026 08:24:05 -0400
X-MC-Unique: de5PqA9bOvyeOQD16-IoyA-1
X-Mimecast-MFC-AGG-ID: de5PqA9bOvyeOQD16-IoyA_1778675044
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B901195608B;
	Wed, 13 May 2026 12:24:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.110])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94A7A1953952;
	Wed, 13 May 2026 12:24:02 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v3 2/2] PCI: Disable broken bus reset on Qualcomm devices
Date: Wed, 13 May 2026 14:23:49 +0200
Message-ID: <20260513122349.268753-2-jtornosm@redhat.com>
In-Reply-To: <20260513122349.268753-1-jtornosm@redhat.com>
References: <20260513122349.268753-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Some Qualcomm PCIe devices do not properly support Secondary Bus Reset
(SBR). These devices have no FLR capability and advertise NoSoftRst+
(blocking PM reset), leaving bus reset as the only available method.
However, bus reset does not work reliably for these devices.

The problem manifests in VFIO passthrough scenarios with these affected
devices:

- ath11k WiFi (17cb:1103): Normal VM operation works fine, including
  clean shutdown/reboot. However, when the VM terminates uncleanly
  (crash, force-off), VFIO attempts to reset the device before it can
  be assigned to another VM. Without a working reset method, the device
  remains in an undefined state, preventing reuse.

- ath12k WiFi (17cb:1107): Same behavior as ath11k.

- SDX62/SDX65 5G modems (17cb:0308): Never successfully initialize even
  on first VM assignment without proper reset capability.

Disable bus reset for these devices (following the pattern of other
Atheros/Qualcomm devices) so the d3cold reset method (added in previous
patch) is used instead, which provides working reset via D3cold power
cycle or D3hot fallback.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v3: Try to address Alex Williamson comments:
    - Change from PCI_DEV_FLAGS_FORCE_PM_RESET quirk (v2) to quirk_no_bus_reset
    - Rely on d3cold general reset method (patch 1) instead of forcing PM reset
v2: https://lore.kernel.org/all/20260508145153.717641-2-jtornosm@redhat.com/

 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 000000000000..111111111111 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3789,6 +3789,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x1103, quirk_no_bus_reset); /* ath11k */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x1107, quirk_no_bus_reset); /* ath12k */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x0308, quirk_no_bus_reset); /* SDX62/SDX65 */

 /*
  * Root port on some Cavium CN8xxx chips do not successfully complete a bus
--
2.53.0


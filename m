Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6B346760
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108546; cv=none; b=Q8IM2L79ityRIaVNJVi8fpCGjW3CQP9EoFJ1Rp3db7kHJGAmeWIHVXvI6m3ENjf0C2k/nOXAX1pDPO2L/duaLmUBkaCFpOihYHUknbBnEGXEoF5mCveQtRG8cDF9ZxJGCq45L/RYktZekczolluPEyfdWiHbVhcBFqHnh/KNIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108546; c=relaxed/simple;
	bh=NGhn92bjbKeZbl/Rw0SzkTMSIgZEgfYGhZoEdlkMBX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bo0TcaLnZd484G56yJv9O7lceLhmsTX55ARMeq3w4VKDB+/am1VLRXOnUqZQGHP5e2GpceHkkrs6SilApbdr9WXjLfOBPEBfy5R7bVM9mz2oZoxLiyQvBJDH6Nt19mxqEzO68p8VxrKcR7MM62kdPlJDadmx++Xmln4vt2u+bv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPm/z9hO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPm/z9hO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779108543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaN6mdNe6nCA5Muna4+m3kjnQawmIX1VJ9iTiwFR7x8=;
	b=LPm/z9hODrPahA+qfunQ3YpstLpxu+jYHKkjTmACdjPN+2DnrIwJCCfzOEqsPI15PT68Ph
	uaNSkrfO5YDO+fbOFJupVpUjx8hZYFOYDMJi7WX13AZktUSQxg8EFGhWR4/hcUrpTpszZ2
	DrIwoHEsyMUUHuQank8lTp3vZ0Fo4ng=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-j-1XKhn1MA6RGWaq-gL_rA-1; Mon,
 18 May 2026 08:49:00 -0400
X-MC-Unique: j-1XKhn1MA6RGWaq-gL_rA-1
X-Mimecast-MFC-AGG-ID: j-1XKhn1MA6RGWaq-gL_rA_1779108539
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 087821800371;
	Mon, 18 May 2026 12:48:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.67])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15267196B09E;
	Mon, 18 May 2026 12:48:56 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v4 3/3] PCI: Disable broken bus reset on Qualcomm devices
Date: Mon, 18 May 2026 14:48:35 +0200
Message-ID: <20260518124836.460805-4-jtornosm@redhat.com>
In-Reply-To: <20260518124836.460805-1-jtornosm@redhat.com>
References: <20260518124836.460805-1-jtornosm@redhat.com>
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
Atheros/Qualcomm devices) so alternative reset methods (d3cold or soft)
are used instead, which provide working reset capability.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v4: Quirk code unchanged from v3
v3: https://lore.kernel.org/all/20260513122349.268753-2-jtornosm@redhat.com/

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


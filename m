Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD2349CE5
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433621; cv=none; b=XV7Ak/N2R6u9iBebYMoGiydqfhgFK515mPKMzonYE3O8cEC6j7CCCFoX3i93kVWrsXZPe2oiW0Sgh30q6vcOFuyvRhPinINBkSeCKqx8Tep/IY/TWFF5UNNDmh2bwNNuY9qCeZ4l3btdc6HDirW0wXuLa/z/YKLzq6P2xc4G89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433621; c=relaxed/simple;
	bh=P9MOhIWU2KhJYcz93oQhJm8IcIldYEI/rv8czT5+HSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HovqLdjOFLUFLQDV/Es0DHmtEREsaCuvGvvUeFQ27nofvCm9nEgU5lRoLKNw5y9ZTnvOv4BCnCmVyVQqZD7XDFLwtSAX/J5+3n3WRR3RwD0bDKFSENhTKWYmeGdr1z1gejmllR9HuL4QGtHnFbq71UWLzndtPvj/fw8X3rSCr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmH18Bol; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmH18Bol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779433619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EQSZbxFMvydM7eWNYZIjBkKA+JnbUPHmD6VpfhXawtk=;
	b=gmH18BolQ8di5Q5t1fH5xehahi49pNWaJBnKiRv2puJ0vYn6D2tj61mQ6UEujtXsnsnHHg
	bcZ0PwzyKCdTp8MMoTx7LSH83XSeXS3nVElQJ1MIxjk1MzAtK2ROH0wPG+9fypf+G+sze5
	XGINhHKxIhiFfVbbMAl4mVZDL+Am3MA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-cWmmDW5_PeCzyPYX4vfDtA-1; Fri,
 22 May 2026 03:06:54 -0400
X-MC-Unique: cWmmDW5_PeCzyPYX4vfDtA-1
X-Mimecast-MFC-AGG-ID: cWmmDW5_PeCzyPYX4vfDtA_1779433613
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE429195608E;
	Fri, 22 May 2026 07:06:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5107300019F;
	Fri, 22 May 2026 07:06:48 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v4] PCI: Disable broken FLR on MediaTek MT7925
Date: Fri, 22 May 2026 09:06:46 +0200
Message-ID: <20260522070646.203115-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The MediaTek MT7925 WiFi device advertises FLR capability, but it does
not work correctly. This manifests in VFIO passthrough scenarios: normal
VM operation works fine, including clean shutdown/reboot. However, when
the VM terminates uncleanly (crash, force-off), VFIO attempts to reset
the device before it can be assigned to another VM. Because FLR is broken,
the reset fails preventing reuse.

This is similar to its predecessor MT7922 (see commit 81f64e925c29 ("PCI:
Avoid FLR for Mediatek MT7922 WiFi")), but with different symptoms.
The MT7922 issue manifests as config read failures (returning ~0) after
FLR. The MT7925 shows different behavior: config reads work correctly
after FLR, but firmware communication fails.

First VM start with MT7925 works fine:
  mt7925e 0000:08:00.0: ASIC revision: 79250000
  mt7925e 0000:08:00.0: WM Firmware Version: ____000000, Build Time:
    20260106153120

After force reset or VM crash, when VFIO attempts FLR to reset the device
for reassignment, firmware initialization fails:
  mt7925e 0000:08:00.0: ASIC revision: 79250000
  mt7925e 0000:08:00.0: Message 00000010 (seq 1) timeout
  mt7925e 0000:08:00.0: Failed to get patch semaphore
  [Repeats with increasing sequence numbers 2-10]
  mt7925e 0000:08:00.0: hardware init failed

The driver cannot acquire the patch semaphore needed for firmware
initialization, indicating that FLR does not properly reset the firmware
state. The device remains in this broken state until physical power cycle.

Disable FLR for MT7925 so the PCI core falls back to Secondary Bus Reset,
which successfully resets the device and allows reinitialization for VFIO
passthrough reuse.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v4: Improved commit message with specific dmesg evidence showing firmware
  initialization failure after FLR (Bjorn Helgaas feedback)
v2: https://lore.kernel.org/all/20260521061205.12727-1-jtornosm@redhat.com/

 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 000000000000..111111111111 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5607,6 +5607,7 @@
  * Intel 82579LM Gigabit Ethernet Controller 0x1502
  * Intel 82579V Gigabit Ethernet Controller 0x1503
  * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
+ * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
  */
 static void quirk_no_flr(struct pci_dev *dev)
 {
@@ -5617,6 +5618,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);

 /* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
 static void quirk_no_flr_snet(struct pci_dev *dev)
--
2.53.0


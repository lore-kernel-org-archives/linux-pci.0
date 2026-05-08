Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4183EDAA7
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251925; cv=none; b=cvCxWOP5k9wJ6QuufkA0wgcX8oZo32kvcujC8P7rqB6Db9AmQfF8aYZY1JStVr3q+5WkKYa/MUtK8wL0F9NGBbXmE/1A6ivbCMLr6lVMDDPzjcG1l63oSuolMjPktX+A3nBzdBaMj/4TBdReCSzxcR+dya29hx50C7vbaoZPVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251925; c=relaxed/simple;
	bh=tMxc8tD5koE3vTO4Xfkix684EAa3iK8l4SkoTFR5tOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfFtbzdpb514TH3wnNKBhxHtItSFNoiKu37Ai7lhr6YMAvDRI58KJHUhnlymFlTi4brMKO/7sRGGgmSqgoEqEujcAw2/2ZSYkNZ2iF02/i48D9CvAGiZehERKbpBrZ8LynnnNhpDwE9zXFAP46OmTXNgdkihRox4K7oK5Uum7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgudvaHd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgudvaHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778251922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pc0TXbTtQ74b8v8dq0wfYtNbxh6d69DJ2mLcLE2Q8v4=;
	b=AgudvaHdlwBLtxABXH3B4/Mg472Dhk6CNZber9Y1p1PWPSlkaRPDzFDwEwEQoO5XX06u8E
	NIxzKCPl9RPgUUS7y9wKiNMtfgZu0bli1Dvth3MCdbyhH8lfNt8e/5AUAz5psfM9Cy/wXV
	huDLDp5ETqHHHl+KBewE5r5mpPj24W8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-XQv1DklJOwOWIkkmTgbgMw-1; Fri,
 08 May 2026 10:52:01 -0400
X-MC-Unique: XQv1DklJOwOWIkkmTgbgMw-1
X-Mimecast-MFC-AGG-ID: XQv1DklJOwOWIkkmTgbgMw_1778251920
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 519F4195608A;
	Fri,  8 May 2026 14:52:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F15773002D2F;
	Fri,  8 May 2026 14:51:57 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v2] PCI: Disable broken FLR on MediaTek MT7925
Date: Fri,  8 May 2026 16:51:52 +0200
Message-ID: <20260508145153.717641-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The MediaTek MT7925 WiFi device (14c3:7925) advertises FLR capability
but the implementation is broken - reset always fails, leaving the device
in an undefined state.

This manifests in VFIO passthrough scenarios: Normal VM operation works
fine, including clean shutdown/reboot. However, when the VM terminates
uncleanly (crash, force-off), VFIO attempts to reset the device before
it can be assigned to another VM. Because FLR is broken, the reset fails
and the device remains in an undefined state, preventing reuse.

Disable FLR for this device so the PCI core falls back to working reset
methods (PM reset or bus reset).

This follows the existing pattern used for the MediaTek MT7922 WiFi
(14c3:0616), which is the predecessor device and already uses this quirk.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v2:
  - Change from device-specific D3cold reset to quirk_no_flr() approach
    based on maintainer feedback (Alex Williamson)
  - Follow existing pattern used by MediaTek MT7922 (0x0616)
v1: https://lore.kernel.org/all/20260507142916.392983-1-jtornosm@redhat.com/

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


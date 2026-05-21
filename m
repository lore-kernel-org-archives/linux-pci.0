Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFD3E7BBF
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368765; cv=none; b=dN1Z/rFMj+fQAboplNVEnIKnnQ4EVbGDVX0iZaks2Cai1BofDUUQMuFYM/agF6lW3wHsN/T+t/+LmUB9XVoDz4k+zwSTmhwCzynmF1gndVEGboadzpRPIdan5FRzOFjhW+Wvv9G/6SHW135sKWEkUd4OMjtaxTLeto3EOLxhdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368765; c=relaxed/simple;
	bh=7TyepHpJCeUoIamRjMl9q6IcHiLs9ym16CIt82vWnFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+cJLfnxHkrq+w1V8d837YBglbl1SwVVGNij4Z0cpEmjFO9NtA05MgKs9iuHu2ABN6mjCkvS3UHY3hpMv5G0KlzDNdKAH0c0YaDEiz0WLDXK9tgSD9xnN6ctzZxoyR/PxXw6Kl5ziJW+RrWOk0BvlY8gc4waWQxusPlo/h01ZXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGpUTK9r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGpUTK9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779368763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk4JvNmeuAYkDAaDLDOEujKlpnWSwUoxU3N1T8rerUY=;
	b=eGpUTK9ro79J2J4yCjiK9oEeNjoWIXTs7TE1IrZWlt+BqW3rXee2I95NiEBmpLuZ0cJqXG
	TStGBL74qBsqM2WFxZdWgmT0P1a3DYtSdsyd9hfGdDuGI6mI9WFnUKOmez4CXd2wJ1emTN
	toN7+cX4ITgiUGqJ8iiSMVe9u3qOKh8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-9iXTnHttM2uiINIyJgiBbQ-1; Thu,
 21 May 2026 09:05:58 -0400
X-MC-Unique: 9iXTnHttM2uiINIyJgiBbQ-1
X-Mimecast-MFC-AGG-ID: 9iXTnHttM2uiINIyJgiBbQ_1779368757
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F25DF19560B7;
	Thu, 21 May 2026 13:05:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08B621800591;
	Thu, 21 May 2026 13:05:54 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v5 3/3] PCI: Disable broken bus reset on Qualcomm devices
Date: Thu, 21 May 2026 15:05:12 +0200
Message-ID: <20260521130512.515125-4-jtornosm@redhat.com>
In-Reply-To: <20260521130512.515125-1-jtornosm@redhat.com>
References: <20260521130512.515125-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Some Qualcomm PCIe devices (ath11k WiFi, ath12k WiFi, SDX62/SDX65 modems)
do not properly support Secondary Bus Reset (SBR).

Testing confirms this is device-specific, not deployment-specific:
MediaTek MT7925e successfully uses bus reset through the same passive
M.2-to-PCIe adapters where Qualcomm devices fail, proving PERST# is
properly wired through the adapters.

This quirk acts as a safety net, preventing the broken bus reset from being
attempted if users override reset methods (device_specific or d3cold when
available) via sysfs.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v5: Quirk code unchanged from v4
v4: https://lore.kernel.org/all/20260518124836.460805-4-jtornosm@redhat.com/

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


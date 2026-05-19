Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2D270545
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168963; cv=none; b=GSC1x5CTmC2aOYLf7tHnBOALX0n6p+es35Kx7RPsBClERdB0Ez/MJ88wd2AI7+pEul0pFzAn9IreDHq8WWkaMOD7Ti+gebGfPzAiBQZmWwhH+L5dLvQEpVG2jeBCGk3LqhpeazUErCIqGxQ5NWp7EkSp5TLJjgi0wqt0lk9sZ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168963; c=relaxed/simple;
	bh=mS5ZHatrQcZnwyep88Dua36lPiUzUwDT6Z2H7gEisKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZM90/ElTHTCBDOultVzXwTuzHDd9Reyi8b0ERPXG8gxlqHrIp01iwh5tp+slmwEq0SHoKsZRZ6LtfxFcdvhKmo4r2+aJkAbwN3drsHYHgn+iSEGc2PbyGjrgc7MhDFDFc+w4pNOMw7mmbFq2GO7ZRf07HVayOtrMFDA7VhyWYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNyoa5aj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNyoa5aj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779168961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVAXV2PrcG8dxOHhuQEbdUEMvv5aAA/BeSUe0DXx2Io=;
	b=NNyoa5ajdTq0DDuGtkoyvO69hCYrlbxqakxoLfmKtun2HKuF5JpWlQ01oQ800nWmvfxDAa
	xWb4X0Z4NeqUPyG9+RjOtMWh1Gu1e2eZ4y2MoiMcp8c6vYUlzlAbjVRMRgwvGSBLmGO9y5
	3O4FpvyD5XxpH3BO+9oeeL7OYvNHSB0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-IH28EAS9MxGn47yHAxCQYw-1; Tue,
 19 May 2026 01:35:56 -0400
X-MC-Unique: IH28EAS9MxGn47yHAxCQYw-1
X-Mimecast-MFC-AGG-ID: IH28EAS9MxGn47yHAxCQYw_1779168955
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DD291800578;
	Tue, 19 May 2026 05:35:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.46])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A3001800465;
	Tue, 19 May 2026 05:35:52 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: alex@shazbot.org
Cc: bhelgaas@google.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/3] PCI: Add soft reset method as last resort
Date: Tue, 19 May 2026 07:35:50 +0200
Message-ID: <20260519053551.7140-1-jtornosm@redhat.com>
In-Reply-To: <20260518111555.6b1ce60d@shazbot.org>
References: <20260518111555.6b1ce60d@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello Alex,

Thank you for the feedback. I understand the concern about reporting reset
capabilities for all devices.

Regarding the sysfs power state approach: I tested this, but the challenge
is that VFIO needs automatic reset during VM crash/reassignment. When a VM
terminates uncleanly, VFIO calls the device reset path automatically before
reassignment - there's no opportunity for userspace to manipulate sysfs power
state in that flow.

For the device-specific approach you mentioned, what if I modify the "soft"
method to require an explicit quirk flag? Something like:

  static int pci_soft_reset(struct pci_dev *dev, bool probe)
  {
      /* Only available if device explicitly quirked for soft reset */
      if (!(dev->dev_flags & PCI_DEV_FLAGS_ALLOW_SOFT_RESET))
          return -ENOTTY;

      if (pci_pm_reset(dev, true) == 0)
          return -ENOTTY;

      if (pci_d3cold_reset(dev, true) == 0)
          return -ENOTTY;

      if (!dev->pm_cap)
          return -ENOTTY;

      if (probe)
          return 0;

      return pci_do_d3hot_transition(dev);
  }

  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x1103, quirk_allow_soft_reset);
  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x1107, quirk_allow_soft_reset);
  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x0308, quirk_allow_soft_reset);

This way:
- Only proven device IDs get soft reset capability (no broad reset reporting)
- Device-specific version matching device IDs (as you suggested)
- Generic infrastructure but explicit opt-in per device
- Different from v2: new method with quirk, not modifying pm reset behavior

Would this approach be acceptable?

Thanks

Best regards
José Ignacio


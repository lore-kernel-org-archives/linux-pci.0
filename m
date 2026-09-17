Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FE5013D6
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649166; cv=none; b=bfScy1s2cz8PqJrytwCiBdMIGibK4+7z2ujAO3gJl57LMbOdJaiCeK1pZbsK056f8TO0lbd1VvdxsEE+XMptlICaEfr8NHBTG+EEhtsCcc7oD4vFOG0JOulXkjSCP7c0MYzPyO0TCVZwH5mbBXWvbIV3GhmpEA/+1bpTpTmbmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649166; c=relaxed/simple;
	bh=IcqJ5QjcXa7dC1ErZ97Ku/rkqOnOuufPwsDqcFfskd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joiF1sMIg1D7YcYvERCgk5F5yM1vQ1cdzJbMAr48I3IkUZDvGsy0iiGga5jA8Msmk55+SzayFimQMUBMd4T5fB9/xrTQ+vk8fUkmC5PPEeR5sl/zegm9mgOanLVbGAxLgASIyfbYzApLFysZlTZb2W9gJCGdALn2mJW1YNgwCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSIp31gH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSIp31gH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789649151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcqJ5QjcXa7dC1ErZ97Ku/rkqOnOuufPwsDqcFfskd4=;
	b=VSIp31gH48kxop3iV3oUIEqIqlQ97nzrO2w52+1f2VIk1atVabDByEJC/FhBJMhikXIAY0
	LpHys9MeJKaufB31FJ3L2nTouMgyzAUZWnsPlIaJxqzs0YFrvIa4rm99ki5yh5mW/SxRQp
	yWNEdySMQa8/g6vlRsZHKIqETJ8SDzw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-A4MrZ0goNYaicxW9-LsQaA-1; Thu,
 17 Sep 2026 08:45:48 -0400
X-MC-Unique: A4MrZ0goNYaicxW9-LsQaA-1
X-Mimecast-MFC-AGG-ID: A4MrZ0goNYaicxW9-LsQaA_1789649147
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4733B1808981;
	Thu, 17 Sep 2026 12:45:47 +0000 (UTC)
Received: from fedora.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E46B4214;
	Thu, 17 Sep 2026 12:45:45 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v14 1/2] PCI: Add device-specific reset for Qualcomm SDX62/SDX65 modems
Date: Thu, 17 Sep 2026 14:45:44 +0200
Message-ID: <20260917124544.9030-1-jtornosm@redhat.com>
In-Reply-To: <20260917073528.A47E61F000FF@smtp.kernel.org>
References: <20260917073528.A47E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

> [Severity: High]
> Does this unsafely enable memory decoding on a hardware-reset device with
> zeroed BARs?
>
> If the caller did not explicitly clear PCI_COMMAND_MEMORY before the reset,
> cmd will have PCI_COMMAND_MEMORY set.
>
> The hardware reset zeroes the device's PCI configuration space, including all
> BARs. Restoring cmd with PCI_COMMAND_MEMORY set will immediately enable memory
> decoding while the BARs are still 0, potentially causing severe PCIe bus
> conflicts, IOMMU faults, or kernel panics since the device will intercept
> memory accesses to physical address 0.
>
> Should we clear PCI_COMMAND_MEMORY before returning (e.g.,
> cmd & ~PCI_COMMAND_MEMORY), relying on the caller's subsequent
> pci_restore_state() to safely reprogram the BARs before memory decoding is
> formally re-enabled?

The MHI SoC reset is a device-internal firmware/SoC reset, not a PCI-level
reset. It does not zero the PCI configuration space or BARs, the PCIe link
stays alive during this reset and BARs are maintained by the host PCI
subsystem.

Additionally, the PCI reset framework calls pci_dev_save_and_disable()
before and pci_dev_restore() after the reset method, so config space is
properly managed by the caller.

The reset sequence replicates the existing MHI driver code (mhi_soc_reset(),
mhi_pci_reset_prepare()) which works in production.


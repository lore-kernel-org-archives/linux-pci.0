Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E9D2367D3
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219475; cv=none; b=cOvOKu86QleCuVHAKBEFPbqUiHAGSFOCHnqV07P/ICECyb+V2JVmj38Xq8klYL5LkUs3V3R0FZPrenO0EoCv62/HDdjO9MSFqyFAyAGsI/8OPcHXR76awC9/y0zgeveQnMcpDodyA9JAhisNpIVz53ndgN0o9uGlXKtHSjUPmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219475; c=relaxed/simple;
	bh=m0c4tLuBDb8dVN7iShZ9BiQoIw7SYRkSb2UZsD6lR2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhgpsq156IB02izkFXqC8YG3hg6FWSZf3MD7gsSJw2Bjo1greOswstHmlDv/q5zfApOJbcN3JZkBBvuDekZENzYZQOFr3bbMvgO++XLSQTfcw0wr0iO+B15nJS6j/ICCqc6c/3aG51QXC9PunG1pm5+2cBZvoJ1VUtRB4TDmFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYoiztPA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYoiztPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782219473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0c4tLuBDb8dVN7iShZ9BiQoIw7SYRkSb2UZsD6lR2k=;
	b=HYoiztPAc4C/+yWNrp6N527lyH6+jTDt17XuJ9uwWmgqXLRI6h/Or8M/CbNCSvIZmPgtaq
	kPG5HPskIksPuJRKiym+A9Beyakp504BpOiV3FyMefnWeDls2w7tBh/vAz+KcSj7DdQHDA
	d0zS3/LBXJcRYVN0jaWT8gsQBTvX8co=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-vj2Kf3YuNxC8J4DH6BZXUA-1; Tue,
 23 Jun 2026 08:57:50 -0400
X-MC-Unique: vj2Kf3YuNxC8J4DH6BZXUA-1
X-Mimecast-MFC-AGG-ID: vj2Kf3YuNxC8J4DH6BZXUA_1782219468
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAAB11955E8E;
	Tue, 23 Jun 2026 12:57:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F06618005A2;
	Tue, 23 Jun 2026 12:57:43 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: baochen.qiang@oss.qualcomm.com
Cc: alex@shazbot.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	bhelgaas@google.com,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mani@kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Date: Tue, 23 Jun 2026 14:57:41 +0200
Message-ID: <20260623125742.1188945-1-jtornosm@redhat.com>
In-Reply-To: <5abb5812-cdd8-47d4-b5a0-33f7351589ea@oss.qualcomm.com>
References: <5abb5812-cdd8-47d4-b5a0-33f7351589ea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Baochen,

> what is the difference between a clean VM shutdown and an unclean termination?
> specifically, will pci driver's .shutdown callback be triggered during the clean VM
> shutdown, and not be triggered during a unclean termination?

Clean VM shutdown: The guest OS shuts down normally, so the guest kernel
calls the driver's .shutdown/.remove callbacks. The driver can properly
deinitialize the device, leaving it in a clean state.

Unclean VM termination (crash, force-off): The guest kernel never runs, so
driver callbacks are not triggered. The device remains in whatever state it
was in (DMA active, interrupts enabled, etc.). At this point, only VFIO on
the host can interact with the device to reset it before reassigning it to
the next assignment. Without a working reset method, the device stays in this
undefined state and can't be reused.

That's why VFIO calls pci_try_reset_function() - it's the only way to clean
up the device when the guest driver couldn't.

Best regards
José Ignacio


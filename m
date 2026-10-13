Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9C524B03
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906169; cv=none; b=ZxNAsKxsms1EsFVD8uXqkPFGu/V4nclQyB0rJcJWz+HY+CPdeL/y4LM/B3bBKI9f+aTQgAeE56qSOapXNVF2A7SMkJOsWF/CNRqiauKu6+IbyuVcTShjGmQ+TZuculajeeqoBXwVIxNobjAH8QMBR6Fk+k0yEKJJNaRK6jvyRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906169; c=relaxed/simple;
	bh=HyjwC2WBuD3zNw2RX08XNRIFsnb2jRmWsy8BXsOZxS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucpbARxZ/zC0gqcrpnsE01G+pYoXERRBbOSNZ1JUNSzpBuPrltGa9TmqyleaDHlhjJR5zRMOGcyaDGq2VmXj5IwhsaVph+88N6q35NWX1ZkUHf1SwRefeLCR/LuVe5c7bO1BKS+b15K9nJ3QOwyh0sPG54RuzV5zDTMnIxmOAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMPpX0Qc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMPpX0Qc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791906167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyjwC2WBuD3zNw2RX08XNRIFsnb2jRmWsy8BXsOZxS8=;
	b=dMPpX0Qc2vPa5n3m1gNbQrCKqadXg3B7+R28g9EM5tVFklpb0a848Imt+OZVGUhbLBNVdI
	k7MYSfvoTl4t5zVpdLledg+aE+SP+Wjfcpo3Mkq+4eYLCZUqDCff2HeN79T26I4rYhXDRi
	UfQ2mZM2w3GpWBR/SJP/Yhr7Hf3E9G0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-iy-R_dc5MQuOD1Wh1XsSUw-1; Tue,
 13 Oct 2026 15:42:35 +0000
X-MC-Unique: iy-R_dc5MQuOD1Wh1XsSUw-1
X-Mimecast-MFC-AGG-ID: iy-R_dc5MQuOD1Wh1XsSUw_1791906153
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31E421964CEF;
	Tue, 13 Oct 2026 15:42:32 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C209B1956041;
	Tue, 13 Oct 2026 15:42:26 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jgg@ziepe.ca
Cc: alex@shazbot.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	bhelgaas@google.com,
	jjohnson@kernel.org,
	johannes@sipsolutions.net,
	jtornosm@redhat.com,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mani@kernel.org,
	skolothumtho@nvidia.com,
	yishaih@nvidia.com
Subject: Re: [PATCH 0/7] Enable Qualcomm WiFi PCIe passthrough to VMs
Date: Tue, 13 Oct 2026 17:42:25 +0200
Message-ID: <20261013154225.214531-1-jtornosm@redhat.com>
In-Reply-To: <20261013140345.GK14213@ziepe.ca>
References: <20261013140345.GK14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Thank you for the direction on device MSI domains. The Hyper-V
reference is difficult for me to follow for this case. Could
you point me to some existing KVM/VFIO equivalent, or similar
example for my use case? Any pointers to relevant code,
documentation, or previous discussions on this topic would be
very helpful to get started in the right direction.

Also, where would this need to be implemented? Kernel only
because it is already supported in QEMU in a general way, or
kernel and QEMU for some specifics?

Best regards
Jose Ignacio


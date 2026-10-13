Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115951597F
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899014; cv=none; b=nCKHQ+LdTdeTeaxNy/Bt5gWfsbpEp0oZoaVAcLx3AKgcIN7baN4M6ftAT9gk5q6QAjqT0ybnwkKVvAuxKIoWf+kAiGeH8tKms6PYSlxZfpRGqEgaH49b5wQTgYJuiR5Z8gYMCNf2Ni7lWKV1Ms9fyfLJT49RxGvCXHz4uzEqU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899014; c=relaxed/simple;
	bh=nuNOjwtGxdFWi5b1GBEExDlpsvyC11ZHFEhl4qwDTFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6pdgfDwGdS8wskYTfIquQskYyqWyJ6nVY68Nc9MnrE4/OzR8tiHgNprZwsD3KZQsDHefh5XpzoRosUwUYc/PqyphsyeEc6AZzNnJJ8foB+4RGOE0+MpWNBiLJG9q1o0IbQnTPJV1EM/VbAAZqOzymo7AqQvUnuWAtzfBI798YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtyaMRnI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtyaMRnI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791899011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nuNOjwtGxdFWi5b1GBEExDlpsvyC11ZHFEhl4qwDTFQ=;
	b=NtyaMRnITa3sJgS0zx8IwGRCEg+9a2NO++jvhe+VqeL2i6asaHFK8R1Sk0MhgfKynYdr/t
	mIwitjYGSefBem0jE+sNgP+O9qMzY81Fz2skODzlrUdHCgeEDHw0M++xrjxt0L5eZoU0Tr
	UtUojIaRmmFUy7YUBUiAitgdybA08bQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-Eo4ETPSKPqS56a6pMauarw-1; Tue,
 13 Oct 2026 13:43:28 +0000
X-MC-Unique: Eo4ETPSKPqS56a6pMauarw-1
X-Mimecast-MFC-AGG-ID: Eo4ETPSKPqS56a6pMauarw_1791899006
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEF501945CBC;
	Tue, 13 Oct 2026 13:43:24 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA6391800592;
	Tue, 13 Oct 2026 13:43:19 +0000 (UTC)
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
Date: Tue, 13 Oct 2026 15:43:13 +0200
Message-ID: <20261013134317.174234-1-jtornosm@redhat.com>
In-Reply-To: <20261011132558.GD14213@ziepe.ca>
References: <20261011132558.GD14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Jason,

I understand the concern about compatibility implications, but to
clarify, my intention is not to create an ABI or a "MSI caching
concept". It is simply passing the necessary information from the
host driver to the VM driver so the device can work. The mechanism
uses the existing VFIO variant driver pattern, but I'm open to any
other mechanism that achieves the same goal.

I can explore converting ath11k/ath12k to
platform_device_msi_init_and_alloc_irqs(). However, if I understood
correctly, the VM problem remains identical after that change — the
firmware still needs physical host addresses, and device MSI domains
in the VM would still provide virtual ones.

I'm happy to do this refactoring if it opens a path to get these
devices working in VMs. What VM mechanism would you accept for
exposing physical MSI values through device MSI domains?

Jeff is escalating to Qualcomm engineering again (thank you for
that), but users with deployed hardware need something working in
a reasonable timeframe.

Thanks

Best regards
Jose Ignacio


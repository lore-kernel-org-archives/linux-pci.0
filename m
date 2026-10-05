Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095947F3B5
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201608; cv=none; b=N2/p9u0IS9A98OK1VXT9XiAPJhQmxjcnogVjgV9udPGrIc26ZaKzzrJYaAi7i9BZRyFNpxT53bDGbKflpQoxTi9cROrYcLkN5cswpJ0nenVWbiLgDquBjqpKIh+TndFoUchZcZWPygv37va8VVY8aO8IhmHUOJCeCpXtn7Njkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201608; c=relaxed/simple;
	bh=GCmzFD31HGDwSmNmw7p7ULvr9ryMPUnoF0U3WobUjaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbxRtq9ELf4WG1q9zWQMCC1QWkVbbc6rb4e2ctpP5xjUDyPtDu7bmXZ011eGTj0eiG0gjZf+Eyskl9VMoW8KQiqZyH4mLYmFrf8vKB6BxgTlmyWBhzq0BJ+yWTyWMi3s0eKMKRnuGutdXT+MrSivOKZgb9sUliACqaxkrPzuADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzV4PaTl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzV4PaTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791201606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCmzFD31HGDwSmNmw7p7ULvr9ryMPUnoF0U3WobUjaU=;
	b=BzV4PaTlw8Mv+0BdDSYlh9JPJZLmaLzLEP7yVK0Q6+k3yslMyHz7wkb8tqHl+0k7+nIpxe
	PmP8OVyvNsnpMBXakj1rN1sv/AMKD0hBuK75NcKN1xUaYgwgfbvAdYfIg5mdpyl/jzutEu
	ZXpcYYDlIEMuH94V3QgiANjYbJxM/FY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-pI1EBY8LM2mNqb2drLdyMg-1; Mon,
 05 Oct 2026 08:00:02 -0400
X-MC-Unique: pI1EBY8LM2mNqb2drLdyMg-1
X-Mimecast-MFC-AGG-ID: pI1EBY8LM2mNqb2drLdyMg_1791201601
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AFFC1944B38;
	Mon,  5 Oct 2026 12:00:01 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8EFD1800446;
	Mon,  5 Oct 2026 11:59:59 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v15 2/2] PCI: Add device-specific reset for Qualcomm WCN6855/WCN7850 WLAN
Date: Mon,  5 Oct 2026 13:59:58 +0200
Message-ID: <20261005115958.111415-1-jtornosm@redhat.com>
In-Reply-To: <20261005110524.81DFC1F000FF@smtp.kernel.org>
References: <20261005110524.81DFC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

> [Severity: Medium]
> Could this lead to an out-of-bounds MMIO read if the device's BAR 0 is
> shorter than 0x300C?
>
> The code unconditionally accesses offset 0x3008
> (QUALCOMM_WLAN_PCIE_SOC_GLOBAL_RESET) here without verifying if the mapped
> memory region is large enough. If an untrusted hardware actor or a spoofed
> device exposes a smaller BAR 0 (e.g., 4KB), this access could exceed the
> mapped memory boundary and cause a kernel panic due to a page fault.
>
> Would it be safer to verify that pci_resource_len(pdev, 0) is at least
> large enough to contain this offset before mapping and reading it?

These are device-specific resets matched by PCI vendor/device ID, so
the BAR0 layout is known and fixed for these devices. The BAR0 size
for these Qualcomm WLAN devices is well above 0x300C.


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605758;
	b=Z851w3sS7bWWymd/ipG3nckzkeGBR1mz6gu/3BnKB59dn+l5qpYrEhn2nRkuWVk0zJ7L
	 bdZ3ZLCexlAN2WX6y7dpM9Q7ZnBwIygntW7ZM0cjeu0G/kWkjBXDv8s9hCPdp4Z9/MPDU
	 WwwXjGamZBFv7ZKb7GPpuqomitJXwVXswUFSMkVUwVKNwJ7DkHSSKKcvGumQU0+3QF+G9
	 BO34/Rb2LzUvJoUrn3CxRVY7ejJkEVGMo3psBroGFa91OZzw48HzTcLz1UO1sDmWjTXpd
	 JvzrItfx5MXiMDqbjFvDpndAk5h9ybiiWSEbMZtPRfJOsOsCEEdxiJCb5w2cEIk0hkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605758;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=9E0zGD2ODat2SvttteActsyR0xXKqRS4RgBIccVpIig=;
	b=SQCRjQ5NTxiL5uFzBs76NJHwiScgLsdb1x7umnT1UbFYptW22d0a5Xip/1rDI7GMf/Ux
	 ZLKJsCJCF6VPUmOqDzKZ0q5pmaf7feVFGs6UWnCtjfia4qpEIW9Fo1yfwBhQnzUTl5il0
	 TlR9qNeruliHn6GVBbXufZGY/5hXiPVwJ32VBijhMgmpw4NZ183pOr0w6HSvOLlE/blkJ
	 8tBlABmZDuDnr/C5+/dd5b99nTxcCaa3rj2DjdQcxFzEBV6RWFkby5QPIEXD97Mey3X32
	 /Yf23DPcdNBInK6kHRCKGi7eqOVjMZ5vHKGemMiuXVTzYeXRlNz2BXtqpH2cpOB4JYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YYct9oqD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89AE606A33D
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 07:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A89AE606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YYct9oqD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793605756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9E0zGD2ODat2SvttteActsyR0xXKqRS4RgBIccVpIig=;
	b=YYct9oqD/kOA9gsdpB7akaMu1hL849JiW2X1bgs5hTLJL6VUbqqh0Zcbm+9k15bydZsazH
	lfbeZ+2afI2aNoF6Frb2AX3itO+jCXQRruq5qzhtsf4rNJC3owUYYRuIQ9DtoSsIfuRjQ+
	rfvoX6fpsBGsii7LrldXI35KGk6p3F8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-rafnIFLNMu2yIqXetp5ebg-1; Mon,
 02 Nov 2026 02:49:11 -0500
X-MC-Unique: rafnIFLNMu2yIqXetp5ebg-1
X-Mimecast-MFC-AGG-ID: rafnIFLNMu2yIqXetp5ebg_1793605749
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C42019560B8;
	Mon,  2 Nov 2026 07:49:08 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BF2E300019F;
	Mon,  2 Nov 2026 07:49:03 +0000 (UTC)
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
	kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	pbonzini@redhat.com,
	robh@kernel.org,
	seanjc@google.com,
	vkuznets@redhat.com
Subject: Re: [PATCH v3 5/8] ath11k: use KVM MSI domain for VM passthrough
Date: Mon,  2 Nov 2026 08:49:02 +0100
Message-ID: <20261102074902.27907-1-jtornosm@redhat.com>
In-Reply-To: <20261029170044.GR1685504@ziepe.ca>
References: <20261029170044.GR1685504@ziepe.ca>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

> This connection should be done through ACPI somehow, and I think
> Thomas would expect this to be modeled on the platform msi domain,
> just ported to PCI instead of this.

Thank you for the suggestion. I will explore the ACPI-based
discovery approach and study the platform MSI domain model for
the next version.

Best regards
Jose Ignacio


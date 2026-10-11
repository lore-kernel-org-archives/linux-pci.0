Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E334107F
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791704222; cv=none; b=psI4Q7phCOsrvNMeuTrSTMRpbTqeXNRwY7i2HR38scxLkMeQZSzd3nTGBoC+pGU3GY6kEra+grgUtE7pnPBrQ5mhWb4BBibL9qBMz8YUpFBt2SczwtkvOqeYxLdWYFiblNmXpsFRElWgv6zW01DY7GvTET4oV2r880IAH613ClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791704222; c=relaxed/simple;
	bh=rdczSkYC7XsIfBdtvu8HOlOKEv9nQpJ7p0TV5uGl+uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hc8DuQJYpSFUHC9NoTsMdTOvSi9752zzjJUKjsOL+Yowif3aRpfTqiaUW2Sd4JGZ7Z+uIc+j2R6nTpjswnDNjSBtvOCMGcNm15ulw+kxIiVSVqtGI5gJykfR6ES/URZYimNu03L+v8xGlxFqy7+ZayUJS3ZATJOmweIgXTtNd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oc++uVgQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oc++uVgQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791704219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRWJKD2DKbKbicq3PqnamltAWg4843Ig3wLGVaneCHo=;
	b=Oc++uVgQdQhizug+VLcoAsyHQDfcvWY8CiDGbNB3kzAKwAPfiPGwC7NYBQKpaJXAxct41i
	84yWtCFzZofO1qnWYAPQV2Z/Cky3cz/K5WIbTkhhcgmEPEVK5lmvNVtxp+VjFIMuXL/cA1
	DQd/4EY1vYuB/c8EfFOmVt+FmP5+P1A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-KFdXAsn_MOmNN54KvjPaDw-1; Sun,
 11 Oct 2026 07:36:57 +0000
X-MC-Unique: KFdXAsn_MOmNN54KvjPaDw-1
X-Mimecast-MFC-AGG-ID: KFdXAsn_MOmNN54KvjPaDw_1791704216
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 648FC1954115;
	Sun, 11 Oct 2026 07:36:56 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0E511956086;
	Sun, 11 Oct 2026 07:36:54 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 5/7] ath11k: Use VFIO MSI cache when available
Date: Sun, 11 Oct 2026 09:36:53 +0200
Message-ID: <20261011073653.508592-1-jtornosm@redhat.com>
In-Reply-To: <20260930150856.8ED211F00898@smtp.kernel.org>
References: <20260930150856.8ED211F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

> [Severity: Low]
> Does this unconditional linear scan of the extended configuration space risk
> unintended hardware side effects?
>
> Calling qcom_vfio_find_msi_cache() loops over the entire extended
> configuration space reading 4 bytes at a time instead of using the standard
> PCIe capability linked-list traversal.
>
> This could trigger side effects if there are clear-on-read registers present
> in the configuration space.

Not applicable. qcom_vfio_find_msi_cache() is a VM-side function:
config reads go through QEMU's VFIO config space virtualization layer,
not directly to hardware. No URs or read side-effects will occur.

> [Severity: High]
> Will this host physical MSI data be unconditionally overwritten later during
> the probe sequence?
>
> After ath11k_pci_alloc_msi() correctly sets ab->pci.msi.ep_base_data from the
> VFIO cache, the probe sequence in ath11k_pci_probe() continues.
>
> Later, ath11k_pci_probe() calls ath11k_pci_config_msi_data() which does this:
>
> ath11k_pci_config_msi_data() {
>         ...
>         ab_pci->ab->pci.msi.ep_base_data = msi_desc->msg.data;
> }
>
> This appears to overwrite the host MSI data retrieved from the VFIO cache
> with the guest virtual MSI data, which could break interrupt delivery in VMs.

Valid concern. Although ep_base_data is always zero in practice with
interrupt remapping (both host and guest values are zero), the overwrite
is technically incorrect and could be a bug if the data value is ever
non-zero. Fixed in v2 by guarding config_msi_data() to skip the
overwrite when VFIO cached values are already set.

> [Severity: Medium]
> Does returning early here skip ath11k_pci_msi_disable() and leave the device
> in an inconsistent initialization state compared to the bare-metal path?
>
> By bypassing the ath11k_pci_msi_disable(ab_pci) call just below, the device
> is left with MSI enabled prematurely in the PCI configuration space.

Intentional. In the VFIO VM path, MSI is already configured by QEMU
through the host vfio-pci driver. The device MSI state is managed by
the host, so disabling and re-enabling MSI in the guest is not needed
and would interfere with the host setup.

Will send v2 with fix for findings.


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E527A92D
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791704492; cv=none; b=rjPINFTjcxN59WGAMYTIDGnaV8VsH1I/hUpC78JFZLatZq1p2yG/fHgx6JVKkG1OkrP628KSD6Vp4qUmE3mFaSVceKZLThY0NSDd1oqiwLM4lb/hpGqKIVpJQob9MrSyDScSmuVSesoXoADIst7WUEZp+Uu0hJ7VmYSfusMYI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791704492; c=relaxed/simple;
	bh=2rcjMaYqftwPEJRAhprBosWMGxGFl9YA/VCQJK3GQBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6u9G75Rk26MMmIB17Lyx6K9FWpSu3OfP+W490jn1Jl4LXBtoBlk6xIoKsLxzjXT28Ciz7yR2P3ymVUaUedM62Ur8l72LdnmaNq2H+xHg+rB9zZgmBDNTJ7Cro69B49vJLLbX8bLkHYPOP0kka71yFHdn+PrbXny1aeAHsPqtuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D98JjSRR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D98JjSRR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791704489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vfGuwDobNwqljv3Cuh7gaHfxKkx9FOqgdSA97Px7Dg=;
	b=D98JjSRRknOEW95u0KEPtfLNROur4UggFqa3tLTZVWnDwwQnyYFVR/Zk8EbBY/+/aWhVJ8
	Yc2oAuv3SA2Lt+l3Y+VTj0ofE/E7+WeCkID+KAaB4mYSllZCptBv5y0LN+hSA+c79K8Lad
	rVlXpqvYjm5ISej3hU8iBtINhvhsPy0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-oMfAPxjUND-lHOJbeooiKg-1; Sun,
 11 Oct 2026 07:41:25 +0000
X-MC-Unique: oMfAPxjUND-lHOJbeooiKg-1
X-Mimecast-MFC-AGG-ID: oMfAPxjUND-lHOJbeooiKg_1791704484
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C32DE1955DB5;
	Sun, 11 Oct 2026 07:41:24 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6649818004D4;
	Sun, 11 Oct 2026 07:41:23 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: sashiko-bot@kernel.org
Cc: jtornosm@redhat.com,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 7/7] ath12k: Use VFIO MSI cache when available
Date: Sun, 11 Oct 2026 09:41:21 +0200
Message-ID: <20261011074122.508957-1-jtornosm@redhat.com>
In-Reply-To: <20260930152902.571EE1F000FF@smtp.kernel.org>
References: <20260930152902.571EE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

> [Severity: Medium]
> Does this call perform an unsafe and unstandardized linear scan of the PCIe
> extended configuration space?
>
> Looking at qcom_vfio_find_msi_cache() in include/linux/qcom_vfio.h:
>
> static inline int qcom_vfio_find_msi_cache(struct pci_dev *pdev)
> {
>         ...
>         for (offset = 0x100; offset <= 0xf00; offset += 4) {
>                 if (pci_read_config_dword(pdev, offset, &magic))
>                         continue;
>                 ...
>
> Performing a linear dword-by-dword read of the entire PCIe extended
> configuration space violates PCIe specifications. Reading unimplemented space
> can generate Unsupported Request (UR) errors, potentially triggering Advanced
> Error Reporting (AER) events or system machine checks on certain platforms.
>
> Could this traversal use the standard PCIe linked list of Extended
> Capabilities (e.g., standard DVSEC or VSEC headers)?

Not applicable. qcom_vfio_find_msi_cache() is a VM-side function:
config reads go through QEMU's VFIO config space virtualization layer,
not directly to hardware. No URs or read side-effects will occur.

> [Severity: High]
> Does this cached host MSI data get overwritten shortly after it is saved here?
>
> When the driver probes in a VM, ath12k_pci_probe() unconditionally calls
> ath12k_pci_config_msi_data(). In ath12k_pci_config_msi_data(), it directly
> overwrites msi_ep_base_data with the guest's virtual MSI data:
>
> static int ath12k_pci_config_msi_data(struct ath12k_pci *ab_pci)
> {
>         ...
>         ab_pci->msi_ep_base_data = msi_desc->msg.data;
>         ...
> }
>
> Will this defeat the VFIO cache mechanism by replacing the host MSI data with
> the guest's virtual MSI data, preventing the device from receiving hardware
> interrupts in a VM?

Valid concern. Same issue as patch 5/7. Although msi_ep_base_data is
always zero in practice with interrupt remapping, the overwrite is
technically incorrect. Fixed in v2 by guarding config_msi_data() to
skip the overwrite when VFIO cached values are already set.


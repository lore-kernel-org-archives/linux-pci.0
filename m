Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657933ADA9;
	Thu,  4 Jun 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586770; cv=none; b=aCcYu1pLnio/df7gpYfuqyUnscYXR7nOrOJQARJ6xMqw0pIAxvJ5PXD0Cqlzoe+mKjyuYSmYZS8crZFbSYKmQePr51R7Sw57dQK1eCN7r3CIW+tQZCSRLBji5Eh5zwErPQjGV33VxP87X/ulx4QWvfjTerELNngXfDTlRuKjKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586770; c=relaxed/simple;
	bh=kT4wDOqtNJdeD9o0Tbf+pjaBqIo7g4jnk31UTXEM8sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRGCzbP+0nVTMJri60jdaDjUAKrpjcd5woeXhVI//QACLULw+67ofVldRG227bxeCMCQrmnZX1/Sz96tQB8Zattg0qJZtCaeSlcF6OeA3tcpbk4x9tY0HcfPXeaVhTDBex52qM9wuqUzxZiHlgCbNMQ3uluAIZXA5oUEtPYYomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 6D3EF38B;
	Thu, 04 Jun 2026 17:26:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 519AE600C2BD; Thu,  4 Jun 2026 17:26:07 +0200 (CEST)
Date: Thu, 4 Jun 2026 17:26:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: w15303746062@163.com
Cc: airlied@redhat.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v2] char: agp: amd64 - fix broken error propagation in
 agp_amd64_probe()
Message-ID: <aiGZD7c3bYb47viQ@wunner.de>
References: <20260504074823.99377-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504074823.99377-1-w15303746062@163.com>

On Mon, May 04, 2026 at 03:48:23PM +0800, w15303746062@163.com wrote:
> A NULL pointer dereference was observed in the AMD64 AGP driver when
> running in a virtualized environment (e.g., QEMU/KVM) without a physical
> AMD Northbridge. The crash occurs in amd64_fetch_size() when attempting
> to dereference the pointer returned by node_to_amd_nb(0).
> 
> The root cause of this crash is broken error propagation in
> agp_amd64_probe(). When no AMD Northbridges are found, cache_nbs()
> correctly returns -ENODEV. However, the probe function erroneously
> checked the return value against exactly -1, rather than < 0.
> 
> As a result, the hardware absence error was masked, allowing the driver
> to improperly proceed with initialization. It eventually called
> agp_add_bridge(), which invokes amd64_fetch_size(). Since the hardware
> does not exist, node_to_amd_nb(0) returns NULL, leading to a General
> Protection Fault (GPF) when accessing its ->misc member.
> 
> Fix the issue by correcting the error check in agp_amd64_probe() to
> abort properly when cache_nbs() returns any negative error code. This
> prevents the driver from erroneously proceeding without hardware, thereby
> resolving the subsequent NULL pointer dereference at its source.
> 
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Fixes: a32073bffc65 ("[PATCH] x86_64: Clean and enhance up K8 northbridge access code")
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v2.6.18+

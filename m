Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFBD45199F;
	Wed, 29 Jul 2026 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350614; cv=none; b=MgbeygUSPXqCjJ/50gd/9I8+QJFgefxAMMDO8tPRWSA7i1IehOFZMJpVuQeLuyksAK4FjFjibxnSCu/dJizS9qAuUXmLSiS3Wq5ZtF3av+xMnHyqZMnnfxgoIZoqf/euLvWB0u/46XFz+XOfOMAdqTL6TIyXF8xK4M+o7MRwZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350614; c=relaxed/simple;
	bh=okEet98TfVaMMuJY3tLXwJAuLs2k/dxlcXAfQ8YVsxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+egnS18+es0kUFnv3valqS2a5cCo4Ur905g8E6t15NKhnO4YmTgBPIgzIhN/IbBWo2XLUssf2v4U3j7zZx0PYDZoQdIR9q90t1p3xW0rtTMIyHOWACTs8w8/gEvNHwzssckJZ5M3Kzr4+GZ+NI6v7ZLGG/BTo6o/ikHLYc91i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id E701910615;
	Wed, 29 Jul 2026 20:43:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CDD9D6034322; Wed, 29 Jul 2026 20:43:29 +0200 (CEST)
Date: Wed, 29 Jul 2026 20:43:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Rick Warner <rick@microway.com>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rhoughton@microway.com, ssingh@microway.com
Subject: Re: [PATCH] PCI: Fix Intel Xeon 6 x2 quirk collateral damage on
 adjacent x4 endpoints
Message-ID: <ampJ0dIhz1J-a0sk@wunner.de>
References: <20260729144508.12337-1-rick@microway.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729144508.12337-1-rick@microway.com>

On Wed, Jul 29, 2026 at 10:45:08AM -0400, Rick Warner wrote:
> commit a22250fe933d ("PCI: Add Extended Tag + MRRS quirk for Xeon 6")
> introduced a traffic mitigation quirk for Intel Xeon 6 root ports that
> negotiate down to an x2 lane width. However, that patch manipulated host
> bridge properties globally via 'bridge->no_ext_tags = 1' and by hooking
> 'bridge->enable_device'.
> 
> Because multiple unrelated root ports can reside under the exact same
> global pci_host_bridge domain structure, this overly aggressive mitigation
> causes severe collateral damage. When a low-speed or bifurcated secondary
> device (such as an onboard ASMedia SATA controller or BMC graphics link)
> matches the x2 condition, the kernel strips away Extended Tags and forces
> a 128B MRRS restriction across that ENTIRE host bridge. This instantly
> breaks or starves adjacent high-performance, unrelated x4 endpoints
> (such as NVMe drives), resulting in controller timeouts, initialization
> failures, and missing drives at boot.
> 
> Fix this by refactoring the quirk logic to be completely per-device and
> downstream-isolated. Remove the broad host bridge structure assignments
> entirely. Instead, convert the hook to an explicit
> 'DECLARE_PCI_FIXUP_FINAL' sweep. When an x2 bifurcated root port is
> discovered, leverage 'pci_walk_bus()' to step down only that specific root
> port's subordinate tree, manually clearing 'PCI_EXP_DEVCTL_EXT_TAG' and
> 'PCI_EXP_DEVCTL_READRQ' directly in the endpoint Device Control
> configuration registers.

One problem I see with this approach is that it won't work for hotplugged
devices below a bifurcated Root Port:  You're only adjusting Extended Tags
and MRRS once on enumeration of the Root Ports, leaving devices that are
hotplugged later at incorrect settings.

But perhaps you could simply amend limit_mrrs_to_128() to walk up to the
Root Port, check whether it is bifurcated, and bail out if it's not?

Thanks,

Lukas

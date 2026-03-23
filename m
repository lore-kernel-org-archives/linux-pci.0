Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDF29AB02;
	Mon, 23 Mar 2026 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270423; cv=none; b=lXD5+gVGJUPtfiFs4dJz8DODL4RSGp+6BeBgxwGmmP0PFbn7aaYT1WXDOhgq4NpNS1c2cMAdW8q+Sfa+vcgEh8319Ln7n44bzozd4C7cJMJ6LaOwIqQdj0WAR5ogYP1BllDqEPyjPAGENWr1/+wmLIomehYl3aV8ZKhuodKFy8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270423; c=relaxed/simple;
	bh=zbNWCP9URJvskoAaxlf55k+zG6hTbd1fzKSQDJhK4aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbaXFMwk0UKDK/oY1BTIAXrj/2CvJT3yggjpW8Noupc2yWF1CzTLWivZd2D8ZXorvpUMVDTioZm/Kn4P2Puh+tcfD/Gxah0Gc1/iNNKMTw+LLqanRuoaSxZPYJ6Tz1Vb10cOT/ILE7/RKlR4+nwjpQPWvKz6cK6uEpTdyGZ+3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 5545F1062A;
	Mon, 23 Mar 2026 13:53:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4148B6020F68; Mon, 23 Mar 2026 13:53:33 +0100 (CET)
Date: Mon, 23 Mar 2026 13:53:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <acE3zUJ6oi1BiyOD@wunner.de>
References: <20260316220807.2433661-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316220807.2433661-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Mon, Mar 16, 2026 at 03:08:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
> update PME status registers (PME Status and PME Requester_ID in the
> Root Status register) during D3hot to D0 transitions, even though PME
> interrupts are delivered correctly.
[...]
> Work around this issue by introducing a PCI_DEV_FLAGS_PME_UNRELIABLE
> flag for affected ports. When this flag is set, pciehp keeps hotplug
> interrupts (HPIE) enabled during D3hot instead of disabling them and
> relying on PME. This allows hotplug events to be delivered via direct
> interrupts rather than through the broken PME status mechanism.
[...]
>  drivers/pci/hotplug/pciehp_core.c | 11 ++++--
>  drivers/pci/quirks.c              | 60 +++++++++++++++++++++++++++++++
>  include/linux/pci.h               |  2 ++
>  3 files changed, 71 insertions(+), 2 deletions(-)

Just one minor nit, the lines added to drivers/pci/quirks.c should
really be added to arch/x86/pci/fixup.c (or alternatively
arch/x86/kernel/quirks.c) because they only affect x86 platforms
and do not need to be compiled into the kernel on other arches.

We've had complaints in the past from people with low-memory mips
routers that the quirks needlessly occupy too much space:

https://lore.kernel.org/all/1482306784-29224-1-git-send-email-john@phrozen.org/

With that addressed,
Reviewed-by: Lukas Wunner <lukas@wunner.de>

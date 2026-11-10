Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305066;
	b=Ml4sM8R8kFF5jMnzVKynqvrnZF98prNN+z9VqfRmCuR9wdtfzrsr+WA5KqfvxPjggt0s
	 uOCHuqUDF5s3hfYKIyoZqg+J/83xX9REfadQKq+JXJ9f2kGMweQSAlAYQzA0m6E1QKIYa
	 cejguoxd1VCJpaKCGhf0P8c8/8bUqWXhBl2O2Sw03MasfYueY5i0p6WHz3X8D/seKMONB
	 +YLUJZneu6xiR4dqahyiqDX7jQMhWhxJYOK2rs/xplubeXzmk1AGgNHaCDgFHx3wjSw4Z
	 aU6gM5rVMqscBwrWq2JTSGytahycFBb0hrujc4fWFDdmMptxz55SgKhH2N6Hub4uuNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305066;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GoNOJqcRqjeQb2g2/l4ayWzBoE+3dxWfsruAyLz+/qo=;
	b=ycpu/mzrTS0HXlGnthUJS4oGlOb+2uMGDmZHYW+fiMR9p82ac+Z5Kr5aQ5/XrsF+UJ04
	 fN+h9g+D890Vp9brMSz0qvwUWBaLXzSbvcMCVQJft+xb3/rDtJZSAVfxtUX3naQdgBZya
	 2UMhiar+mhzMbMIpZqNFSRNMS9P75OSWSYYQFwOf7PgJTe4XLXdIlDqb9gR1q9c/VZVlL
	 DJb0YErsbtCpmAontEHU3BPkJBIP8XlZbQ14fxKyHAEhjuqB93VtF7kBDeVPffjBGsJQ8
	 c5nb9ceTK+RoTn4nilhk4HQzNsSPqSVttUqtVNtMxmCDPKVPue8x6wjgrnlxQcbLCWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5BD606A32E;
	Tue, 10 Nov 2026 10:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A5BD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id B7F461AFD;
	Tue, 10 Nov 2026 11:04:15 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9ED4F60FC73F; Tue, 10 Nov 2026 11:04:15 +0100 (CET)
Date: Tue, 10 Nov 2026 11:04:15 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Ricky Wu <ricky_wu@realtek.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Fix NULL pointer dereference in
 pciehp_configure_device()
Message-ID: <avLsH4a-l_uxlWfU@wunner.de>
References: <20261012-pcie-hotplug-nullref-v1-1-6e21c2e89ea4@google.com>
 <sashiko-outbox-168676@kernel.org>
 <20261109215339.1841223-1-rathodpriyank@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109215339.1841223-1-rathodpriyank@google.com>

On Mon, Nov 09, 2026 at 09:53:38PM +0000, Priyank Rathod wrote:
> On Mon, Oct 12, 2026 at 10:16:29PM +0000, sashiko-bot@kernel.org wrote:
> > While this allows devices without Function 0 to be successfully hot-added,
> > will it lead to spurious teardowns upon system resume?
> ...
> > Could this spurious teardown issue be avoided by modifying
> > pciehp_device_replaced() to handle missing Function 0 devices correctly?
[...]
> Regarding the bot's question above: pciehp assumes Function 0
> (PCI_DEVFN(0, 0)) represents an occupied slot across all four of its
> lookup sites -- the -EEXIST check at the top of
> pciehp_configure_device(), pcie_init(), pciehp_device_replaced(), and
> the DSN read at the end of pciehp_configure_device() (consistent with
> PCIe r6.3 sec 7.9.3 requiring Multi-Function Devices implementing DSN to
> expose it on Function 0).

I'm not even sure whether pciehp is actually used with jailhouse,
s390 or loongarch.  pciehp assumes in multiple places that function 0
is present, so guarding against a missing function 0 in a single place
doesn't really make sense.

Note that there's a patch pending which moves the cached dsn from
pciehp's struct controller to struct pci_dev, so the days are numbered
for the lines you're changing:

https://lore.kernel.org/r/20260902133933.2992457-7-terry.bowman@amd.com/

Are you actually observing a crash in practice because of a missing NULL
pointer check?

Thanks,

Lukas

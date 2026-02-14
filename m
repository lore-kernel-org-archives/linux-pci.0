Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3372627;
	Sat, 14 Feb 2026 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771048885; cv=none; b=p+REKLC1vWEDWKsPwAUwhR/kNamUXE3Kq9KhgL8WkC8p/AYdzbzCJR16voAhkWzuOibdOb+PSR9LAdKeo707oNQJzTgTWZwd4vIlbZGKnr3+S/Puz8I++UDEDfGYDX7sNLsWuGVV55rrWhLrRA6V6yYsZjylOZplxKRm3/rCQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771048885; c=relaxed/simple;
	bh=ueGrL9IclvInRIQA2Pg8K2okcqM2pcDFBnz3KSTkUiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW0qbwcTYGNj0m4soEj6+PPy9aFp0JoQ1b866d8gdh5jBesvcObjAWCaTQ+uukcprdifwnH/DjI3Ypbu26gJf5mlur7iV4pgs1HL6RF8EexdyJUqB4/YamuZ0j8xpgoJD0XUm0LeARNT6GzuUFTLU1Lt4HtPorbDJXqPegkslrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 82F452C0524A;
	Sat, 14 Feb 2026 07:01:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 388BE1FB82; Sat, 14 Feb 2026 07:01:13 +0100 (CET)
Date: Sat, 14 Feb 2026 07:01:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <aZAPqQTiGQiDvX52@wunner.de>
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Fri, Feb 13, 2026 at 03:14:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
> update PME status registers (PME Status and PME Requester_ID in the
> Root Status register) during D3hot to D0 transitions, even though PME
> interrupts are delivered correctly.

Hm, so in theory we could amend the PME driver to walk the bus below the
Root Port and see if anything has PME_Status set in the PMCSR register.

But the PME interrupt is shared with hotplug, bandwidth control etc,
so we'd end up gratuitouly (and frequently) runtime resuming switches
below the Root Port to see if there's anything below which is requesting
wakeup.

So just keeping the Root Port runtime resumed all the time, as this
patch does, is still a better approach IMO.

I'm wondering though if this causes a power regression.  Does keeping
the Root Port in D0 prevent the Package from entering a lower power
state?  Or is this irrelevant because the PCH is a different chip
or tile?

If you respin, please cc Rafael and linux-pm@vger.kernel.org to see
if PM maintainers have any objections.

> +++ b/drivers/pci/quirks.c

Since this is x86-specific, it could live in arch/x86/kernel/quirks.c
or arch/x86/pci/fixup.c to prevent being compiled in on other arches.

(I don't know why x86 quirks are spread out across two different files
and there doesn't seem to be a consistent rule which one to pick.)

Otherwise this is
Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas

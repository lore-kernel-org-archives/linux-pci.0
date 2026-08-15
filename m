Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700C3BF676;
	Sat, 15 Aug 2026 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778102; cv=none; b=g7CIBvTATHIMw7q/9DwIeU8JvboVxikgUZv/EudZ1cSkdOmMDXM8/cv+dLj3ILGhPS9dS5DntAW7Q3lhrHNN7xZ3fJrh1S15LATWYCKKDuBbStvA2r11fmpSpPCLCMFMNyglNlUsgd3d0510tUJ7sv6Ck7yL1IkVtYAyT5gtsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778102; c=relaxed/simple;
	bh=Q0TeHpUc2Ky1yR2+EqYbfXx3pCStBfXUjvDONym/hi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR1s9XfhZ72ZZ8rvYV7byoVCuxgFb+26Z9imV/jq7fAI6/lKKKftI7gLDJgHJt6Ja/e3uaSXUxd/bXFo6UNZU6d+fm6qy9v3Ba6VdyGKYM0nPMaUVnPDuL4VuHVk1sXbZiMGpgGI/FMX/h2YXTsBK8TLxKIr0l++HamuqmLwY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id CE945C2D;
	Sat, 15 Aug 2026 09:14:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 99A866031472; Sat, 15 Aug 2026 09:14:57 +0200 (CEST)
Date: Sat, 15 Aug 2026 09:14:57 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	kthota@nvidia.com, mmaddireddy@nvidia.com, kumarahul@nvidia.com,
	sagar.tv@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/5] PCI: Re-evaluate DEV3 14-Bit Tag Requester Enable
 on link mode changes
Message-ID: <aoAR8Zxo4CIQXm8w@wunner.de>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814201621.2281245-1-vidyas@nvidia.com>

On Sat, Aug 15, 2026 at 01:46:16AM +0530, Vidya Sagar wrote:
> DEV3_CTL.14-Bit Tag Requester Enable is only meaningful while the link
> operates in Flit Mode.  In Non-Flit Mode the upper tag bits are not
> transmitted on the wire, so a requester that still has it set emits
> requests whose completions it can no longer match: the completer does
> answer, but the completion comes back with the upper tag bits zero.

Please include a pointer to the spec section.  Looking through
PCIe r7.0 sec 2.2.6.2.1, I don't quite see anything that says
"14-Bit Tag Requester Enable is only meaningful [...] in Flit Mode".

It does say:
"A Function that supports Flit Mode must support 14-Bit Tag Completer
capability"

But that's different from what you're claiming.

It also says:
"In Non-Flit Mode, Tag[8] and Tag[9], are not contiguous with other Tag
field bits in the TLP Header. These bits were Reserved prior to 10-Bit
Tags being architected. Requesters in Non-Flit Mode that do not support
10-Bit Tag Requester capability must set Tag[9:8] to 00b."

Also not quite what you're claiming.

So where is this coming from?

I think if the link reverts to Non-Flit Mode and 14-Bit Tags were
only meaningful in Flit Mode, then the hardware should automatically
stop using 14-Bit Tags.  Relying on software to clean up a protocol
inconsistency before issuing further requests seems dangerous and silly.

Thanks,

Lukas

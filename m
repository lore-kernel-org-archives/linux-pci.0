Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B93A0B24;
	Fri, 18 Sep 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741671; cv=none; b=IbrG8sOHNug+m9M1UUvL3L1hmvtAO5MsJ5n57xvqsPruurxEKlwFNYpEGv1RdaFvRkXAvc5/bty7ycttsanQo0n+8LCUlYYF+UhXvDJA1R1qyqgrO87lhgjAehyhkqvX6K3kNV+D/n+GjMRInuXiA1yf3d6oOcGOozHzJ3wOcs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741671; c=relaxed/simple;
	bh=V1lRZxI8LoEqwUJG4lY2i/vSqSmEfgU723g1AP5AanM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW4kJhvABiqJTtB2t7TPAdeabVYTBdFYg5lf9m0VPXUnl2nkWUUsnry0WQG3ff7I8HLA8/5rysikLsj2KU3+0XdL52Oi92wq6Nk5uTCiqpui2PeyQZIC/lumhvMtnDhYj9Gi11+ttR19+Gi+LnSappSVMPso2SCjz2xj5YtCs/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id C07581ADA;
	Fri, 18 Sep 2026 16:27:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 89B76614CFE3; Fri, 18 Sep 2026 16:27:37 +0200 (CEST)
Date: Fri, 18 Sep 2026 16:27:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Michal Clapinski <mclapinski@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DOE: Poll briefly for a response before sleeping
Message-ID: <aq1KWUXAqQ34ybRP@wunner.de>
References: <20260917230323.3701743-1-mclapinski@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917230323.3701743-1-mclapinski@google.com>

On Fri, Sep 18, 2026 at 01:03:23AM +0200, Michal Clapinski wrote:
> doe_statemachine_work() waits for a response by sleeping
> PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status reads,
> which is 7 ms at HZ=1000 and 4 ms at HZ=250. Exchanges are served from
> the device's local mailbox logic and typically complete within tens of
> microseconds, so nearly all of that sleep is wasted. Every DOE-capable
> endpoint pays it once per supported feature during enumeration.
> 
> Poll with usleep_range(20, 50) for the first ~2 ms before falling back
> to the jiffies-based wait. On an Intel Emerald Rapids system, time spent
> in pci_device_add() for a DOE-capable endpoint drops from 41.8 ms to
> 14.0 ms.

Polling is just a poor man's replacement for interrupts.  DOE supports
interrupt-driven transfers but we're not taking advantage of it so far.

Perhaps you could look into adding that?  It would seem more worthwhile
than optimizing polling.

Thanks,

Lukas

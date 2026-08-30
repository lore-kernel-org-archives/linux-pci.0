Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A49A224AF1;
	Sun, 30 Aug 2026 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124218; cv=none; b=VCEUBjYl0DAIeJE+c0b+GiKs7jpVkPEJ46ZU1XaduzQ1OQYlMqlpP61/zl/7sDRZazK47WEvqKof6G/Gmg6YeNxyg93VYrDyYPTm0QrRLxdb+60OOfLBp7urlVUIxEg6Fk3SRoNynsnIZT1qpKNNSUGiUZrN+5wai/oJfeue5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124218; c=relaxed/simple;
	bh=ggxmeT/T/9SbhIY+9GsVq9jcxavj3Q50UeuFvcP9N/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnY9q4JYbW8ty4AkE+2gthA7C/1SfDJsK4jcHLXW3YraPJljNaiKp1QI7LNe27xf2WL/GerrsjW66J3XlhPCTK3o6lQ1izkH6hZ3IIBlBnCxclQZG5aXBb2ffXr+2IWKKssjhw7oFhGeZb7UOOxMA63nqC4B4+yTPlbjdvhmojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id A865210629;
	Sun, 30 Aug 2026 23:02:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6E59760FB887; Sun, 30 Aug 2026 23:02:09 +0200 (CEST)
Date: Sun, 30 Aug 2026 23:02:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stefan Roese <stefan.roese@mailbox.org>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Fix struct pci_dev reference leak in
 aer_process_err_devices()
Message-ID: <apSaUQIc2ig-Icgq@wunner.de>
References: <20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com>

On Sun, Aug 30, 2026 at 08:28:28PM +0000, Priyank Rathod wrote:
> When an AER error occurs, candidate error-source devices are identified
> and recorded into e_info->dev[] via add_error_device(), which increments
> each device's reference count with pci_dev_get().
> 
> If is_error_source() matches a device purely by Requester/Completer ID
> match (e_info->id == pci_dev_id(dev)), the device is added to e_info->dev[]
> even if it lacks the AER extended capability (dev->aer_cap == 0).
> 
> Later, during aer_process_err_devices(), aer_get_device_error_info()
> returns 0 when dev->aer_cap is 0 (or if no active error status is read),
> causing aer_process_err_devices() to skip handle_error_source().
> Previously, handle_error_source() was responsible for calling
> pci_dev_put(dev). When handle_error_source() was skipped, pci_dev_put()
> was never invoked, permanently leaking the struct pci_dev reference.

The problem is real and the fix looks fine...

> Fixes: 1ab4a3c80508 ("PCI/AER: Stop ruling out unbound devices as error source")

... but the Fixes tag seems to be a hallucination.

Thanks,

Lukas

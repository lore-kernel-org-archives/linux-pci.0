Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7D16F288;
	Sun, 30 Aug 2026 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124977; cv=none; b=kAwsEvpJAaoSiI2zPZiwd58QkuRjndI2KCHPSvN3pjgnyRRf4Mi49zHRUGEXyBGIGR4nglHpP/TDIfnJfiIB4aYgZ0p33Hi8h8FIjwTLGxDIPtlQKzSYIGqT46ptZtghBkMyS6sfmWPpSKqKnIX9cJ0IV4emv9rWrw9PSt/KXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124977; c=relaxed/simple;
	bh=WQ/IXl/OpTD5uewQ/EiL1rbKfLw1OxjhO4kGhLECfB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKD4ITEWwLfjZpMet2kOraxpmeI49lQWxO7oCQQP9QAfBGk5NvxosGKU9f61STN31uixgnORi/tsH5N3D37pY1xXJJch1FGZ2AHFOVQA1usM9dr+S/tCIjintfidR8rqYjpnFcxJe9mpRaL5uXKKoP7vMWip1P2yNXSM1Gf927U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 31ED837A;
	Sun, 30 Aug 2026 23:14:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0E4A160FBB96; Sun, 30 Aug 2026 23:14:34 +0200 (CEST)
Date: Sun, 30 Aug 2026 23:14:34 +0200
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
Message-ID: <apSdOnbdLdrJ7ksF@wunner.de>
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
> If is_error_source() matches a device purely by Requester/Completer ID
> match (e_info->id == pci_dev_id(dev)), the device is added to e_info->dev[]
> even if it lacks the AER extended capability (dev->aer_cap == 0).

Hallucination, we do not enable error reporting on devices without
AER capability, see pci_aer_init().

> Later, during aer_process_err_devices(), aer_get_device_error_info()
> returns 0 when dev->aer_cap is 0 (or if no active error status is read),

The "no active error status is read" is the only scenario where
this *could* happen.  However if no error bits are set in the
status register, why did the device send an error message upstream
in the first place?  That would be a broken device.

Another theoretical possibility would be that the device becomes
inaccessible by the time aer_get_device_error_info() reads the
status/mask registers.  They'd both be read as "all ones",
hence info->status & ~info->mask == 0.

> On the ID-match fast path (a), is_error_source() returns true without
> checking whether the device implements the AER extended capability
> (dev->aer_cap != 0). This creates a real, non-exotic situation in several
> common hardware topologies and operational states:

Hallucination, this is by no means "real, non-exotic",
it's an unlikely corner case.

Thanks,

Lukas

Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C93093D7;
	Fri,  6 Feb 2026 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412256; cv=none; b=h5GQTgpQkz+azy+hvre8HUuowZKYEr+rTYPXscNp0ESZnEs8mLT47Re+2V2LgLgHoHirAU4IOY/kjQngkfb8Or9byo/M9b5VYPtAyGmNZ61SuCAYLrJano6ZvjmCgARM1cEE0kdfnwu9H9VdA7MvkeZh7pKNOyAaMrUrsiR4oi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412256; c=relaxed/simple;
	bh=rqvftc6NKAdmy/FYINCo5ZPuutP1eJkXz+ClzPeV8SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpgfILqvA2EvGVXHGbaIrdVR6zECt8nk6+QG71hqe7bzwY8MQuZ/ogx024zxKw1viH7XL5fqBHBNIAi0Vo42JGpRjj8gUPHU0diC7ypBCeL4HCMwF8X2FRf7TdMupU44dPmVuFCRSHnTfb9rGO6kCB6T5V9rLppV3NEqXly6KkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 246912008014;
	Fri,  6 Feb 2026 22:10:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1F9F0473B; Fri,  6 Feb 2026 22:10:48 +0100 (CET)
Date: Fri, 6 Feb 2026 22:10:48 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Breno Leitao <leitao@debian.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, dcostantino@meta.com, rneu@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH] PCI/AER: Add option to panic on unrecoverable errors
Message-ID: <aYZY2KgtSnqUWXbu@wunner.de>
References: <20260206-pci-v1-1-85160f02d956@debian.org>
 <20260206185232.GA70936@bhelgaas>
 <aYY_hMZyVp7GZvX2@kbusch-mbp>
 <aYZU09qCN3u-_byj@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYZU09qCN3u-_byj@wunner.de>

On Fri, Feb 06, 2026 at 09:53:39PM +0100, Lukas Wunner wrote:
> So I wouldn't consider 918b4053184c to have been a universally successful
> approach and I fear that this patch goes even further.

Forgot to mention -- there's another problem:

PCI_ERS_RESULT_NO_AER_DRIVER is obviously AER-specific.

powerpc (EEH) and s390 have error recovery mechanisms separate from AER
and we've been trying to align them more closely so that drivers don't
need to be aware of platform-specific behavior.

eeh_pe_report_edev() does not modify the pci_ers_result for unbound
drivers and those without pci_error_handlers.  And the default is
PCI_ERS_RESULT_NONE.  eeh_report_error() also returns PCI_ERS_RESULT_NONE
for drivers without ->error_detected() callback.

In the PCI_ERS_RESULT_NONE case, EEH seems to perform a reset and
assume successful recovery.

It's only AER that is this strict about unbound devices and drivers that
lack pci_error_handlers.

If anything we should try to *reduce* deviations between the various
error recovery mechanisms, not double down on increasing them.

Thanks,

Lukas

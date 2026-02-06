Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05827E05E;
	Fri,  6 Feb 2026 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403302; cv=none; b=N9TJ4EfqqB4x/nJrPxddz7CiCQYv2hr5rZWF8r2yJ3ol+rKUXDKG53qbYykFwWwLy3Oz5sFR4+Mq/Xrz3mErhboQrTTQP2U9r+ox4vsouBQCWAgTJEbDpYh8VX2zugisarx/w0n8/XXLkQZB/1XPNp5AON1+iDJcGmVx2GqvO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403302; c=relaxed/simple;
	bh=KcyvPouTwUTQFLiWrDgdg7dd3uWbXwZVDxEOyYXtOC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxWqcCKmxBEx7o3u8v0zmXKuYH1aYGsEoVow462eLOEUTuR+XkTyQRaVw1aEyg8FfcMkvUySkKcpVfH582WEj8cYvgDC9olkygx8RSp021KZ62OzW8WRE6VT38ke+aQ6L5xjlYZFqK0AenSCsyvrPlWNeRbuPMmgxNVqoTBhgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id ACA912C03E87;
	Fri,  6 Feb 2026 19:41:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 89013473B; Fri,  6 Feb 2026 19:41:33 +0100 (CET)
Date: Fri, 6 Feb 2026 19:41:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, kbusch@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	dcostantino@meta.com, rneu@meta.com, kernel-team@meta.com,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH] PCI/AER: Add option to panic on unrecoverable errors
Message-ID: <aYY13T00wmo-toap@wunner.de>
References: <20260206-pci-v1-1-85160f02d956@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-pci-v1-1-85160f02d956@debian.org>

On Fri, Feb 06, 2026 at 10:23:11AM -0800, Breno Leitao wrote:
> When a device lacks an error_detected callback, AER recovery fails and
> the device is left in a disconnected state. This can mask serious
> hardware issues during development and testing.
> 
> Add a module parameter 'aer_unrecoverable_fatal' that panics the kernel
> instead, making such failures immediately visible. The parameter
> defaults to false to preserve existing behavior.

There's a parallel effort by Terry Bowman (+cc) to introduce a
PCI_ERS_RESULT_PANIC return value for error handling:

https://lore.kernel.org/all/20260203025244.3093805-4-terry.bowman@amd.com/

Please consider using that as the basis for your needs.

Thanks,

Lukas

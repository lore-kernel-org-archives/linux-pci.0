Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D663BBFDD
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785308532; cv=none; b=MSdUpFVOUvpyXqwMSMC/fVU93PdygXsdcFaEjv7gZB48huVyP1qP65LDrzsTixpVSE9Ogc3z31crbynqXz3osk4wHrSK80UgVf1yFxKvGbJvpAeweWPFlYtKIeOLIYJpMJvIfSPGiINY25x3A5Zox2hZ68a5iSIJBOZQJsqOEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785308532; c=relaxed/simple;
	bh=MDRnYj2DaX5veZOZZgQm7I8zJHTGQcDaxq6oo5/egYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqEYop1S3fHy58LiPXyMwRhPIwbjEqlB5CWegfu+xTcUbI4NCw1iWZdxEGnaDOwY/Vkq59XzlWNW6wDoWxY5ELeHvQBFE/e/82AWr+LipTFgsavWN11u7Qpgj0MQB2U0kTztuqI/vCt+esIyxeXd+c1IFsDTLZqSgsVAB/TM224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 7132810624;
	Wed, 29 Jul 2026 09:01:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 55AA86021789; Wed, 29 Jul 2026 09:01:59 +0200 (CEST)
Date: Wed, 29 Jul 2026 09:01:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-pci@vger.kernel.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v1 0/2] PCI: Add pci=nobwctrl to disable the PCIe
 bandwidth controller
Message-ID: <ammlZzv7QSxLm9LC@wunner.de>
References: <20260729034505.469107-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729034505.469107-1-kanie@linux.alibaba.com>

On Wed, Jul 29, 2026 at 11:45:03AM +0800, Guixin Liu wrote:
> Enabling the PCIe bandwidth controller sets the Link Bandwidth Management
> Interrupt Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable
> (LABIE) bits.  On some (typically old) platforms this has been observed to
> cause boot hangs; commit 46a9f70e93ef ("PCI/bwctrl: Disable BW controller
> on Intel P45 using a quirk") works around one such platform with a
> per-device quirk.
> 
> A per-device quirk only helps once the offending device is identified and
> a quirk has shipped, which is awkward for a boot hang since the machine
> cannot be booted to report the culprit.  The only existing escape hatch,
> pcie_ports=compat, is a blunt instrument that also disables AER, PME,
> hotplug and DPC.

Ideally we want to identify all devices that have problems if the
bandwidth controller is enabled and add quirks for every one of them.

In a sense, a command line option disincentivizes reporting and
fixing affected devices because users can just work around the problem.

Additionally, there is a general dislike in the community for
adding new command line options.

Are you seeing issues on different devices than the one that's
already been quirked?  If so, a patch to add quirks for them
would be welcome.

Thanks,

Lukas

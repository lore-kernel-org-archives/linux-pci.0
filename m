Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614937AA9A;
	Tue, 19 May 2026 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184422; cv=none; b=SkCzihFgk8z4gTd1jNPZVg+ZO7p/MHqkdE9RRK7wRvDyRxna/87M0GfwTxiNgvH2U6UWZ7flCaObJV4SCymWpHSbdAjkQ59cBgybS/tiKHM2ffUoHYRFWyEH7UOhsCunDJBvsAmma5bS8So0L+VT4rqVXnS9woXajo1A9/8P7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184422; c=relaxed/simple;
	bh=WqFh7s1xUQVkKHmAGJkPlse0GgMe/GXpTN2xUy/9XHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktBXdDSqQ6HD/h3/Pgx2qmxEv3Z1j/PpNwrI27dnsuuOLcWsLyfdQoK/AG77b05bzJLV/Hy40BYlQq3UZYenTbJdRYQrDyeG2Mx4rgKdmmA2GCK/ShOwaq9PlF4uxvyWXs3yNSvPTintZaMYw+mdLXSfXDpiqwpHKuu4qoNswsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 9BF5935C;
	Tue, 19 May 2026 11:53:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 75CC560B03E9; Tue, 19 May 2026 11:53:35 +0200 (CEST)
Date: Tue, 19 May 2026 11:53:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Yury Murashka <yurypm@arista.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
Message-ID: <agwzHzF3bpPM6jcC@wunner.de>
References: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>

On Mon, May 18, 2026 at 02:23:36PM +0100, Yury Murashka wrote:
> pci_aer_clear_nonfatal_status() is not called when AER recovery fails.
> If a new AER error is subsequently reported, the AER driver calls
> find_source_device() to find the source of the error. It rescans the
> whole bus and picks the first device reporting an AER error. Because the
> previous error was never cleared, the error is attributed to the wrong
> device and AER recovery is started for the wrong device.

I guess the rationale of the current behavior is that the devices
affected by the failed error recovery are basically in a broken
state once error recovery failed and so user intervention is
required, e.g. a remove/rescan via sysfs.

My question is, why is error recovery failing for the devices
in the first place?

And what does the hierarchy look like?
(lspci -tv and lspci -vvv output please)

I also don't quite follow your assertion that (only) the first device
reporting an error is picked.  The algorithm tries to collect *all*
error-reporting devices in the affected portion of the hierarchy.

Thanks,

Lukas

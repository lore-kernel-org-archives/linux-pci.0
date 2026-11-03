Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730303;
	b=VpGXY3lLHHBGWzD0s5KCNoeRX6QhsSTSPpA7WXzoFDFjv/lcbuQwopUOo8bKBwcESc16
	 X2Po0Xhz7Ltw3NjLIFOEt/3g3tbAMJYMy/oxWWEnW09vG9kaSf3jOh0/FY9l88b6HAxxu
	 4k+vs6bFB4/Z9u1GxLgve/E2RIQKLUn2q0rdK9rnY6Dpwq7rQPBBX/OCXb5yGtFV5327x
	 znYrIkrpQkDyUYhHNj5ueR8eztbAV7hrB2LVh1FpglBjChfW02sVLAwgBgYm2g7N7upc9
	 u1aKPkSg9eh9N4d+Cqp3cugP4z8F5CDs3Gx7yXgHAa4aHfDyFRMyjwZcAxy5ZXopyBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730303;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cw1nPp6gtYuMPpv8xpD/+xrEUnqo5ELKlrwfbjJ3TG4=;
	b=qQNF9xWGrYsRwlTGfXKXzxR5RcndoWcDjTwtteFTTRGDitHTl21pNIDdQPDn9GLZNmEX
	 f5NPvOdQlIZ7ffJ8NGdDeMom1TLIVGQv5lnv5hw+G2Ug7ckHtlrzSjzWZL9s/tsBab2ii
	 3AnArjw5mbDOobUM22usXTVcrePqD+D4ckN45jwOODwpe0YBgvV5EYsGQ/bErCxnkQlxk
	 49Czaw12VtdPlcBASjGRpKj9L6x6jKLKee2jGajuOUfXii1gybbuHMNiJA38sYEu2X/zQ
	 aZVJLEixT2h3plIuiFQgfiNZ13grcOBH5rFKYzvgWFQIuLeuW8BCqOjbAyRff1KPUqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpJlexKu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6E606A31B;
	Tue,  3 Nov 2026 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpJlexKu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4584B1F0093A;
	Tue,  3 Nov 2026 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730302;
	bh=cw1nPp6gtYuMPpv8xpD/+xrEUnqo5ELKlrwfbjJ3TG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gpJlexKu0aije/Zg9DEtyhR70HVdCt5MBrVJ+Ndoet2JmDV87MaSCFK7zrgn8aYYE
	 8HhaQAToC8NWXmV3bx1Jc5WwYeXnfns6Cd0O0BBRJ2ZD2hsIBF4iRsbkaXNL4Jx7d1
	 oQTZorxSuf2soGsbUc+qist5zWum7SuKA6P/2+eqerQ6rsJJM3m4jmcvTAP1rcXiT0
	 0/092dhBWEz5IhMwJNCFAMRunGu+G3aKev78qX2sR45/IH/Pk48/Jv1/ZV8rBKon43
	 xX+kVfHMyTIxVHb1/rXFZmVfCDhsyqCDybYJxwl0dbmwk9Hw7podw4cUsqezUcw8uj
	 4xUb4xzFpV9Pw==
Date: Tue, 3 Nov 2026 11:25:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org, Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: Re: [PATCH v2 5/5] PCI/sysfs: Use user config accessors for
 serial_number
Message-ID: <auom_DjFYTR-tKta@kbusch-mbp>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
 <20261029192032.1325629-6-thepacketgeek@gmail.com>
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
In-Reply-To: <20261029192032.1325629-6-thepacketgeek@gmail.com>

On Thu, Oct 29, 2026 at 12:20:29PM -0700, Matthew Wood wrote:
> serial_number_show() reads the device serial number with pci_get_dsn(),
> which uses the kernel config accessors which don't check
> block_cfg_access, so a read that races with a reset goes to the device
> mid-reset and can fail with -EIO or report an all-ones serial number.
> 
> Do the capability walk and DSN reads with the user config accessors
> instead, as the "config" attribute does, so each access waits for any
> pci_cfg_access_lock() holder (e.g. pci_reset_function()) to finish.
> Also wrap the reads in pci_config_pm_runtime_{get,put}() like the other
> attributes that read config space.
> 
> A reset can still start between two accesses, but the next access just
> waits for it to finish, and the DSN capability is unchanged by a reset.
> 
> Add a check that both DSN reads are successful, unlike pci_get_dsn(),
> and fail with -EIO instead of reporting an all-ones serial number if
> the device is disconnected between the capability walk and the reads.
> 
> Unlike pci_find_ext_capability(), the walk doesn't check dev->cfg_size
> first. serial_number is only visible if pci_get_dsn() found the DSN
> capability when the device was added, and cfg_size is final by then.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

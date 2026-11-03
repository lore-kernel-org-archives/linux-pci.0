Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730331;
	b=Lu67V5jL9nNLfKxYS/qdEvTL+p/6pjERyc5muZYVpXQ7DsTIsFgIZD/nHs9WUWkDOfrQ
	 bLyUMpObg3jYda5QEtr7QOC5/k/Apsz51+ponABBUxcpy1qeR075WoJR9L3wLaoYNNM/o
	 vuK0fWXHnHWCK1mbvh6IBV58OG6QeXulc7X3tILJ6H/g/qB4hocq8jIY8z7+1ZW9hBvsT
	 2RnD6p63tmZ/VJaq3FkWN1K/jwPOiD/5Nm2zus5drsOghjVxfd2p6PI6UInecd3YB1JxL
	 zWGuEzvV5okmieU4Jk3b5hXozIqcXFObbkOZ2biZFnHE6xnLQfoDiScscHOFErbhUOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730331;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r8O0om8gMPqDYlnVjQMs2W8xeag/1ZP5kbE3Hq237fU=;
	b=sli3fuyOXnvVV4yA7J+JnanWLpmJtRaIJJfFaocqy+5AGJMuMPsEN4DMaJV8K7XjAM8y
	 7fAYZ/lmgO3H8NcNAuKOqXFmjCinEMhhlc0trzZmuJB4lW282Q+O4SW1s7hHskeprq2VX
	 t9qj899EOMKSkdHDITzTwh/1KWx7rjLHALeeTzU8bMeKDLUYKCQCRUK4VI33GNRoigrYK
	 qtC7WRLmPw1/pq8Q7aneFHM1EovoeIVRKTugsqFxQO11GmjGVs/E8WxLef5TULZ8GnAfM
	 1O4jdFRuSBXf7aqMLmdvIJUyCQOmjJBGKMVLgmkzED0YZM17cvB2qj3tZHOg+ko+86A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqnpSrES;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD9606A32E;
	Tue,  3 Nov 2026 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqnpSrES
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C661F00A1B;
	Tue,  3 Nov 2026 18:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730330;
	bh=r8O0om8gMPqDYlnVjQMs2W8xeag/1ZP5kbE3Hq237fU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CqnpSrES9HZMUCW/LXggOhURulrxidnokibG9KmJS/t939nnsHn7Bf3sijmWcQVnt
	 7A8m7Y0YMah5NDuHx7zw7sgMe/fTtzrQoc1sj/3Zi7h2FaZc3HsyovSkoPLRahzJD6
	 tuDkDiaJaic0pkxgNmev0Oxno/1p155JZqn39PU4lJV258cm7/rfkRknrhKggEW4zU
	 3lsCqOEgAIpUV/QS0qJ+Oe9TpdThPMynIiJQgiH7FvydhGdC/khXLD7L51uFHDY9PY
	 8fx3Cr0xpFeOloeXGw+ywqVyq7CqceQX1gb1TorVTjG0vsV6npjgR9HGiZ0PquXTio
	 X5v6T/rgE350g==
Date: Tue, 3 Nov 2026 11:25:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org, Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: Re: [PATCH v2 1/5] PCI: Add disconnected device checks to user
 config reads
Message-ID: <auonGbUxnZKA1A34@kbusch-mbp>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
 <20261029192032.1325629-2-thepacketgeek@gmail.com>
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
In-Reply-To: <20261029192032.1325629-2-thepacketgeek@gmail.com>

On Thu, Oct 29, 2026 at 12:20:25PM -0700, Matthew Wood wrote:
> Since commit 4b1038834739 ("PCI: Don't attempt config access to
> disconnected devices") the kernel config read accessors skip devices
> marked disconnected, returning PCIBIOS_DEVICE_NOT_FOUND and ~0 data.
> The user config read accessors still issue the read, and if the host
> bridge completes it with ~0 data and no error, they report success.
> 
> Check pci_dev_is_disconnected() in pci_user_read_config_*() as well,
> failing with -ENODEV and ~0 data. Do the check after waiting for any
> pci_cfg_access_lock() holder so a reader blocked behind a reset also
> sees a device that was disconnected while it waited.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

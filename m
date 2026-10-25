Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792947497;
	b=3J99QDu1leY5Zh5UV+ZYQR3eo1jadAFMDYKOVgo9hYweZtaIx6WXIAC+Rm7vlTYgCOxj
	 k7s+c/hLDAWLyImv3sY2fLnhzD6RJIMHvHajd9lpXQIbm5kq0NlbK3mSubvQcj9xAaToy
	 csfpbb1jXiIcDkE2RmME0VsMnDZS+RJhVPPuxE9ZUGx4egzI/6Hu4yR0NaATNDBfIym73
	 Q1xnAphUDWg7TAkBcPjKZI4jfICVNcz2I/8azvmyBcjiKsz71eiuMPTggtAGWXVpOvZC5
	 QyHkGucaGq6r1bVK/WRbxb42+JvwHXLtEmMX5IX/cz6q7tdGy3ygWczhoFfZXP7S40g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792947497;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=brbbFStdV2oWVkFUuvww/DPjCHH85W9kbHM3AyXaI7g=;
	b=Dalkw+Ztq0fc7/w7D7CXVB6GfrFW8H/QI8B2RDGZufwBfADEc8MoON5AsOIiFaoKmNGH
	 Kzp653IflKRE4qLQgLsO4KoU33IdLzRs95a/UGPDsjrgIPKwVfb82bI2pyoWGY+MCLHIt
	 GFEIYaP8X/23bbGrvD9z811pb682t6lb/M0MWKUUgZHvOAOZ3vmgj3yb6Re19HDFyTNnj
	 hNODRP42D5+nezbLwpVwDUlXfLbAAkvXfWMcqsZho3AzfTudRhGqDjgiTtQ60s6rUJiSi
	 4pcAqjc4Mkny/0J9uBzL6HaDK4Ofh5WQ3ARW2hcIzeX3yPZ9DNRrRZ/zrAeBIPIRzXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=144.76.133.104
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC302606A31A;
	Sun, 25 Oct 2026 16:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC302606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id F0A48C18;
	Sun, 25 Oct 2026 17:58:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B82A460A9C9F; Sun, 25 Oct 2026 17:58:05 +0100 (CET)
Date: Sun, 25 Oct 2026 17:58:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Patryk Janik <patrykjanik1710@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, alex@shazbot.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH RFC] PCI: Don't restore state of a device whose config
 space is inaccessible
Message-ID: <at41Hdy8ATMj9LRC@wunner.de>
References: <CAOz=NNVc4C3aSC+VL59V31==P_sfgCkjSK+nG3LAByUF84OVVQ@mail.gmail.com>
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
In-Reply-To: <CAOz=NNVc4C3aSC+VL59V31==P_sfgCkjSK+nG3LAByUF84OVVQ@mail.gmail.com>

On Sun, Oct 25, 2026 at 05:37:39PM +0100, Patryk Janik wrote:
> After a failed reset, vfio_pci_core_disable() unconditionally calls
> pci_restore_state(). When the device did not come back (FLR timed out,
> config reads return ~0), restoring state walks the extended capability
> list and rewrites the whole config space. Every one of those accesses
> stalls for a completion timeout, so the host spends minutes in soft
> lockups instead of failing fast.

Config Space Writes are Posted Requests.  There are no Completions
sent in return and consequently no Completion Timeout is observed.
So the above paragraph doesn't really make sense.

> - "PCI: Avoid FLR for NVIDIA 5090 GPU" (linux-pci, 2026-04-16), where the
>   underlying FLR failure was described as a known device firmware defect.

I assume you're referring to:

https://lore.kernel.org/r/20260416070707.3242381-1-yuan.gao@ucloud.cn/

The outcome was that there's a firmware fix available and a quirk
should at least differentiate between good and bad firmware.
Or the fix is to update the firmware and then we don't need a quirk.

Thanks,

Lukas

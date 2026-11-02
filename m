Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642353;
	b=F4PsE+ZCwJ2XBpogsDyhpqCDTr0YKdR+DKp76m2NXGvEJnxI2iH4pvkz7UP5W+w7B03S
	 twCGqu0PG73Tp90EBTLumNjeluY77XLWFJyLKkDsRyD2T1nlmEAWwAM46dSPoA/LrLXcu
	 37XtEPDyKGWwbfbwme4QkIDANVbzZc+2n/HpZtjHNdRzxryA7Mj4M6co/tg6l1DAcmTGF
	 z2Te4lY+/eQt/wvme/bDvNUjYupN0w7M+STAhbaFAxtBM3aFGUvj7axNrpwzm8Dz1EAKk
	 tuYfzwDK8MhVJhtJQWwuQS3DX12dX1LmGoC2QnbewXEPPqFBLFLJZWr8YrKi7GIhwRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=m7tPpvbpgcoiAh3sChsRS5bXVIS45B8HnNpJ8ocbh1+guXsrkGCPJ0C+X0TxqPvZl9VM
	 bLD9greK8RXMZhPSZXKAVCw2BtGz3p5XXs+KLtPPUPMLsWd9el2/spFMP/x30dOjQoufV
	 RjgtISJKiCpAAvgyIYewNMxTSWnFXlg5MBasrgIfzX81XTMLxgIsSejnm7oy0lIPQ/CX3
	 QAUhAFYbQl6VNeiShonkycLaTIAi/h1qB2dKJ4Xwe5SB+c4FKuzzB0X1L+hxU2s3++TjS
	 q0GxnR2H+NVxiXv3zqgSCLHiRkHFdmC0eNL+bfKkaI6hZ7GQnscB6zZ2W5I/4OvYq9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ekg5TOf8;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69296072C45
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 17:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C69296072C45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ekg5TOf8
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c169ae1cb26so692092366b.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 09:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642351; x=1794247151; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=ekg5TOf8PXlbMPoS4qdrUH0qtWO732M+jubYVeFRHzubEalPOb+31Lw828wpBa++rq
         hzAaV9LYLYH4oiPKof8252Jsp9PZHQCBmEyGXQ16X2cSkMFbWYT0UcG8eZrNpE8TZTsq
         aQpK1vS0JWFQvV2YncXbbT/3XzBR73lEvrSrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642351; x=1794247151;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=j6uQ8USFOyT3aMme0mcRuis/v8zR0hpbAavxZnGbFwP4WdjrCNtN2AtJpO0hWeH1RO
         LTcSxhMHBebesfnACwhk4cVadJBpuIoBvJEuqT+mzGdKEupahHky5St1MzWRQYNndU+s
         m6t4JHR1H7XukFwQLnydkdiq7FbOmiJvPb1XcyOMS0B+AhU+5wgYFqyJ5taLtfXsD4/D
         UTs+3VWWI5BkZp3ZI30LMnPFl5ddCWpPo8YyC3dW95ogQ00rWavahYj+6Es4/GrXgW72
         RJPjTqi548rSHfY7AD56eRrUr9SSQWUCdFihWbRSzb6GKrDnp74478LznHUj7MAnkBX+
         xa7g==
X-Forwarded-Encrypted: i=1; AKwUvBwoC+yCd2Rq1bjJhiMqc2cuFMRDTwy8wZve3HMSUMbK3BF14yW2XJf2EFauQD02Zp8XCfD+3Z8YGls=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Z6OllPuxVrHtw6KLDSQKW1JaBNtsgNjMOELU7q+B8AvpNbXEK
	I4dLzFUqxcc9XajpFJL9/MImP9k8k/qDiBQgu4fTbKLBxBi/rU3GPMm95iumZ/JboS9G7sWaC1E
	omLmXHAI=
X-Gm-Gg: AYBFou3/3HZx1zIaZR/4YoqoTWRCt3PhQg9bnleqsMzFfsPxCs/R/d2TrZ0/ZSuqUL9
	PEsyRNQko+DOzE8jNjbhCfMSe2nK+YeCChJJVIG5GLRoYA9/Xyq0RbmIdgdbpsp9c1EyanFoeK/
	OSlabBCEEZaS+8fBQhbr9Pvsf2NLPZj9W9AuYArrD1pjuWis2/UKc61Miww3FZaqSdk492yd1dM
	kwHrBv5N8OGz9HzcYVSSWWjuckh9xnD1wI0Y2mDOYYliCPvXvx5nS9Bc51+Quez7ugeHzD14CMY
	ja00AbxYsOV3lbd1JQbbc6RrAm01vebW3QVFTiEHP81UtGRBwVQYe7NLWOHYQGIoVI1VX8VKRIv
	rhoxwxp3Re4AOk2N1uRrh2dXERcRtbVki/FCtYWDHArSqo7B6x4fyTlV/6nVcyVaH0kv7T91vNE
	mqH9FgojESqSRynkV58YkBjiMC1cQhLVS8M8rfXg9B2XxiLwaM1ArjK3QVspUp5z/QjIpf5kdjn
	ohWgi6+HcLwwN4tPYJxEKu6eSt7xbeErDnlChLu1d+QywF0CNL908WBoLEgfvsrBXmZkL4rOM1Z
	e2jGT5yzBMJeZKZb2ndHcabovLZ9ukJfxfVqn66ZNbW36GJDcPwyo1hF7a4ikp565HvIMI70OUI
	nPO4=
X-Received: by 2002:a17:907:3f25:b0:c46:9711:e30e with SMTP id a640c23a62f3a-c49d14dbc5emr1144032366b.29.1793642351002;
        Mon, 02 Nov 2026 09:59:11 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebf37c9bsm12412566b.48.2026.11.02.09.59.08
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:59:08 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c434376dbebso693422466b.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 09:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByl3oO5vS/B+ebXk9ROrvP7OSs6JiQyCI83p2ZVYSFM6veXfU2K3nvKenqFQk4SVgIdWUn19w9jZvc=@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus

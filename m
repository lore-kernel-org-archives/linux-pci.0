Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=Qb6PhjJAieNC/zNtGPCFz5V6XW/0xl3Kpd96JmWtDvzUzVtbQDKfxQQhxcNE09KxSG0i
	 7NSf+rfaR7MSpC1/ElTRgjfs5BOMQfIiTPqnG+MBn0UTxvqIQW8AejJ/KAcLS02jY1i0O
	 EO0rZu6wRHR5Tut54sEAFPrkWPKwWi8WeGNl1PguD6XxYGCZYm9FmDGdfyH6SSXoIOXds
	 6ry0Vfz4jlhJPRzSoaT3RC4xl2lh/DnGmNcOkxXGHU4pIjt6wDwLKDcTnw26dRRds4ueQ
	 IS4alQoW5kNL0X9L7wnnAKuA+dJ4OJByc+35MHdW3wj/ml4XXl5XOW+DHwk5hbQGL3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=EAKT/DfDiOvEJ+lujiA7u2vG2JSsyRs7qhcvgnAzKCUyA8XtC7ZcL+/kWCsS19p+cxFW
	 sCf70SVpuFUeYgQqvyF004LyuS/kWGkaBMviANRFDHAcGZBW/xbZGF/w405iGDQXJpSFJ
	 68G/EyQTHCFkN2YS4jL3sRjCzxXaly/G6cLlIAbU8iXXL44lxCANTuHCukme5+Kl2yj1G
	 hWbVMHF8REWjejOpPLkArwN8m/VrJQp/8t4ahNHLTAserzzxiScrRwxl0OmOZlLeXbcv7
	 VGqI2wN5fsdT7bVWTGrGLKzRCyiSgFOXhvv/lsOAYYky7vXwkP0mVaLnWxXzRtd26Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E7606A332
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 347E7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso1791375e9.1
        for <linux-pci@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=XrEUEgHUwv+lt2Z0T4RzlOQuYT1yMbnY/MJrtF5HY2pc8m0ujKE+1IGJbqc3A1SsPJ
         Pz+po0Wh7ECcrOl1hyNdZBme+OsO/r11IeCA1lW9KMbstFhlOkC0Hm7Ef+TTavGsfrDk
         7T2AE8nlcorDhYFpLo0KTCt4xOv09AacMRilfH2h4PS2mZ0iBReAF8XAcgtI3iT+qlRY
         EJQPYUIUlDRCCjadf1+24R8V0flZyhCZpLCroCVsidoQ510350k4POOaAcSXgGRrBTWF
         rbpUnz5O6K0TOR8uz/zwLHiObwDAqnCJFWP0+ssCNYCBYnXJwQ2yMfUqdKkv6ro/lp/q
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=jmQRMFZGnpo0IDHM7w3nHXJ0v3b/pbRscGwnWZCEx0kBgwpbsI96NGIauCyk51JrqN
         HJPMD14TUy+V7/DsUC/GXhXNFj6b1cccvygcbBmyFJ1TgxrQf4AgtIC8Ta4UK+SEaPPa
         1BwzNxj21Rg/4OK70LdyX0TcZa+V++1D9Nye5RwUMaiVqB3kt+mXmJ3b/hgr6JWZezJ9
         TNCnqz2OY4gjNZqH9XrFKGwKY7kfVr4yBYjVZHq3AZgtcKyZkxPRIyZK9mb5vc/5pqlF
         HqX8wq6WF6rCb83gcCzqCSRTuYDNgeEMOKmVWb6X9Wp6LQiQdnhGdyUetk9gBYlj6MX3
         4q/A==
X-Forwarded-Encrypted: i=1; AL+hErG2ErX7IrR1NrCaqtLRU4s06ViA75xRNPLMqqqkXQnoTOy63GV5sEeyLxmPJ9BG46UUilmGZ6o+jiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z914gnDBVoGcLPAezSd8e41qLVEbZw/NY5Xwlz2gbnASyribLt/
	YhphIXhO6eDxtnbsRTZzZazr3FOgXNr+jG59fnRd8QQCOOp9lbFMNxnR
X-Gm-Gg: AYBFou2lQwV3cMFkwqMw93bw+9zP8AHb8gtpKYxorcLhLBI3R3AVnu0F+eNFLa+Wb4X
	EZ4KVzLqVX60SQ5jdZcZNqvtHlkcqoTm/VTmtrbcwHcVh8//99mnzw+oiau7fdP/SXVSlTEDmRB
	4hLBGOTCoL9xs3KHEwD5BviOFNM8pLfuw6xF5lJ+svNU7ux6qvuq5JqmV4Mr/m7XgtXhGyK7z3m
	Ts0OVqtI1duufgFP34nGUIEBraHmKzqNSvZ2vzorIrDDfLxNvKgLbOp8iTA53V7KR8hVqEuLd6H
	9ZnO3RAcdo6lo6BoaZM2UEsicZVP0l0OWmBg+JGZf7QfLodBG3cL5U2eRvmqPTrIASvep8QHSVc
	zBVWUOkvZNUsv7B94ycXRGNb8RyPHaFP86XKjNci3wXUMaNVCZ99X7q57QUAQf+au7g6NuRdEip
	CWHUj5xiLyUr85/YI0j85Y9fSkNJ22J/ijgnrkKpG9Y0w8obiV2ctaV6jutR79KhbOKIpXjILHG
	JTEkLyrPS41grmxFswRYtC8Wj5vLxJDNA7dGZh9TH7SSy+AXDt6QulQyo1Vltz5YtxQ30w73WIW
	vw8EAvUxU2lULhPZ8wsC4kHmhQ5wnsf9TqNBlDd0je4ZOm8oIKXkDTnKLE5uHdNL
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David

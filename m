Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273693;
	b=eIT3uhQx6XWevGKMf5IV//YIk4TeFBbyefTfrStyIkzwqw6WU3lJx/cWCnCbmvb4IsXq
	 GSf1ydxIxk+mVbCp7Ss5JlKAJ5MZ//z+CZeFBB3A7eAPtk90SmZYQQ4ABlXPpStPw9bVM
	 mBiC0T8P0OXLoc1xiesRhDEQ/rh4lsxtCnHwWQ3TaZvlOeF4wG8EHms8lbwNl8AfMrkK9
	 ZTGOFa4pOc7+pE4TwDT6JY0SFNSJVMvuY9HlYakMMRf/QVSIlVc/aPsoyqWLRsdyiulCQ
	 RKVrlAQ3YackXyTq1qPp/NrEwLTa7TGcCsw8cczLc2PDdJeNcriNgW4tC9HUTDvCT5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=sSZHxAe5lZ+eE+77Uubg3KJ782HIZ9B9bmdeh+KVUyh4vA9YP1uybPHtm5VlCvRAGiff
	 L/eh+t2bnL71GtNUcAKBySNXAjbwM3fgldjq3GpoLND9ijWw2ldyJi0fCmY4P3vtGKNTo
	 /6G/J9SdqowbhpWhYLz4qzanb/ugw6TeUj2+Fpq/6BvH6UIXJuEKttxBONSUGHVU985Do
	 /OO1pNFr7Ma8OA/HcW/ADE0jFPP5K2bWZSEGiZluk93ga9TzeApA97rArJxa3EHbZe2FH
	 Ri7wW+fCLzKrjYsngYHIrNv/QRXaJZBgraD8HdvTHpnoKpPrE2Ywd5OWapuLU0NLYZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HaJIMw9j;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726F606A339
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 01:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D726F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HaJIMw9j
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so1963734a12.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 17:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273691; x=1794878491; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=HaJIMw9jqRo96w9SYXfuretnxmjRsVaSN7dohK+4XaK+SxX928E0AyT4yBbsHxjLFs
         mq7BAXjNCGZnIOeUZcHxijcgypBHt9KpkEEDa5qhf+w1vs5u0/S+XB2lGhesrtw7FIWC
         MKE1IHmktHN8tlqk3tZkXVTHGdIvf7+KlH2z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273691; x=1794878491;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=hRQ/zyaPrwTZ79yw3w9IrUUPwd2IsVcPdFWURfbmh8tcHJYRLabtfyn/xWzx6GcgTy
         90mhIb2FMlTvc1jsfUDF5azpZbMWgjhwxzMhBh664OvH9k4Yk+XdTwYLV3yMKK20oC6o
         jhGmRm2SdcrNhmPtQYBZf7C+ThlYbY3BWAnQnluuqKa+PqLjdp78F9npScYuvRbQMa/F
         8MNgtlEfpg+Lc0bcrQLd8I5Ok2sft/ICuKl9tfU2ze/If53W3vP/Yd4UQPAyLKvkE+ll
         Q2JvNkXUDBIQfA96d5YI5rNjbbv6UfGy2z0N7zPji4lcO2d2F1/NBMAz3xdStVQJEbZH
         ZTEw==
X-Forwarded-Encrypted: i=1; AL+hErEoq3K5IraESekY32UhS4YMYmNn++LiNDOK/OC3tAx6jkR1A7UxZ2O46x4EGpw+eBLM7cVUdNkK1AI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qx0KomaPmV4gdnAsSkhe+LofPE/FChhhePZiyc4zpmNW5YHLl
	faHNdVrJat/qeNbKxfoHxvwzdJVd9RX4oB0EJBn4OH4/v2P9lYVmhcWtDN6dnNIK4mv+EP6M/SJ
	7q6SMGMU3ow==
X-Gm-Gg: AYBFou3tdk2zXkvmyXuNbqwNyljRgzp/wP8bU1g//M8fjQwMLM/zPR1p+G/e2HEqKiK
	pATE6HjthhF7zo0kUrWzSsjRAKYqWGYACafIPaQT2P8wpzkZBb0HBPEcz9umabI9XFQme58z2sj
	7EsXJFF8mtmddJ539Brh5VEGAzHOwFxZH3faynR4RDmxlN4q8mGAbp/E48AiKrZt38CCcwdrLAd
	7zoy3HwxiLzJ70Pc7MusAmOpIoGEqZxyNSz3A/mT6IgiIss8Gy/dZmK3EEA4wL4MU03jl5CxD0p
	9fQEVuJ3PhMcVcByJUGHRZ/YK6ntMZuMoGZ6PUfbO11gWYFl2EwBHbOThCY9ROjGwlPI+sZQ48I
	wmwownLO/zdyzZZ8qQjrEY/JEDSfvBthJk6rEsWzf4svMI3hPhiSkUCIrLYXlCktkb9zQ04CSWh
	fxd6yNny8arCW2xd4baI30N3WIcHg08RXA54TLqueHqoYXn5n6cINPHcL+UHtlYZRP5MRbfrAAO
	NxryWi1Jz21xCt9ovqw+toxmTIjcadrzBmQKzxWDiD10qDQjT7z1PO8AIscddJj2Wb5pm9QDjk5
	xnDvix2pY1o7qMMW8Gab/V9qpoptM/P3blKoW6Gz7uIuqpO0pRmIwgcAVqTSt3NUeF55aiHmV6k
	skQ==
X-Received: by 2002:a05:6402:4404:b0:6b4:1d53:5185 with SMTP id 4fb4d7f45d1cf-6b7568dbadbmr989410a12.16.1794273691330;
        Mon, 09 Nov 2026 17:21:31 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578bdb26sm444378a12.13.2026.11.09.17.21.31
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:21:31 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b577addee9so2037547a12.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 17:21:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGZFOGMtpbbbdg+huIn9ShrGEWXtfU50YgYPwpGRFHTnXsmledFSUY/W14L9PKAryM44ic2Iccq69E=@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus

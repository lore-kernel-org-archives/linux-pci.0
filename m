Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823151;
	b=5c/fL3oto/bbkWaOLxxJbtappfAIeuD+8xJNYJbyAf8d6Uu00BOaL+RdvnKgRjoPdhiz
	 98c1w2XPdyJ0W8+65I+TFRFXBHnLb8kdUNNg/3jTHzz29ew+9hjcTFM4q/ntBRr8O/8qz
	 cbLfwBVpl7vwKc6wyfNDs4CV0GuMkpkZ7luzEawqxXFelIA4yIAm1wQNRZIGaTVQfOf3F
	 jFv3qJvZzL3pRuMqK8pS8HxN2aV94OYZXwhTK9Ez43fYxUbYjZW701NR2BtbZn+Vx8EBZ
	 yYHjqJu9RV6o7x+G1LrcHiesWqyn6qIaQRIaytqbK4s5w1K3qaYMY6ictGP1mQnaU4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=y/zLbrYlA0y9wlhc7IqlWosd6EZqe8IYY04pTvKfhqBRIM7EpxiBbu+OYNtpQwIETTyq
	 LeGujPS4DI7ysVav/pn9ECCIy4PYp9AlEphWoMaZloDjKcJsqZU3InLuh3Bo1qv3+cAup
	 sGUNemEGZRb4VELu0WLOgUX9k1ooesP/Hf4lHqimDxGQSomWG/tXakhyGYHmXJ7wCU2U1
	 q8rvW0u4+aX62IaggJIGC2ZPtqPnWJLSXSib/wIwm5uXta8XhPxUPfpgEUDdDXkoovqcc
	 L2citBwQ1h73RYyV0n+6C1d5fOB5/zng5PLB/ytJtB4WA7y4rNFRHBLcpPUZOSmw1gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=TkLoyc+x;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C4607F2A9
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 20:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 090C4607F2A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=TkLoyc+x
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c445c95d553so164961166b.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 12:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823149; x=1794427949; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=TkLoyc+xYLSLsvb8Zbk+/XiX3fPoLFOHFZE4JuPBoDqYMikhkYuWx/0mb3rb+zjiJv
         rXbr7EMrCw45QONq83MBgij3O+q6rzRr1063mSf8r+1rpwcmaaMxVipqEEXL6YGsZn+c
         doyKsZFZdgJWN9g8uvbh5ukErxm7qR5nXhQcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823149; x=1794427949;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=InRmVqXGOV7LpmzUMe5ZSxMRs3n8j9/N7Drw918BFjSbSW4cZjFgU3xALxtmnREnCB
         sTab+kFf+KIpkc63tLN8dNnjIYbfFHI8+KPLwzhgR6U6AHOZeja1yVIKPO9M3xFQkdvO
         3Y9fKlWm3apL9LX8r6VLpt/5hfMDYrxxC838Y7723Ltt3WOCVBlMED8/8GEXGYbM6rxl
         VlEufHuhpM4pS28KsKKMcmfgsuQBLyLtvSUKjNpOQO9OmxYNtQcSD+W7Z6CSym3+0pOb
         zoEGNTKd0DGGfyK4kPqWp7Y7n1UDU8zU5LyQimhmXPVONgK+QaMHitBhdQk8ZhLT8+IH
         Hepg==
X-Forwarded-Encrypted: i=1; AKwUvBz/eycj/1bEQHea7WpvpCgHfDgiQrLIOSe11TR74WyI7mYMSp3DWwYB+eXIxWNYZvd2a2hw6FUegcs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/azej2x+3yFyLu6HyHsHoVTK95OHS+qw2sWaGxNnGIvDe8LyxI
	JT9gvuKEj1dEfp1AV7xDt/hNsdBuTGNfUVFbeVeF/Gc8LA26E5As9WU8hsvPRT47lF4+Q6yFqlX
	vRupm5D6jRA==
X-Gm-Gg: AYBFou10kxYO/PJYDIb5df6bpEmYnPdQUbsPdREJCjEJpwVefwqlVfOv/WRHBsUU5Pi
	QKXASp+Wqid/8eyS8Pcf3xTM+64QwZqQD+IK5x7/OmvO55rEVTo+DELRYSRS7z7JPf6+dpelAC5
	zVzKOnPpvXeMxTUKN9ykEndCRtblk22ANkjDZ82WjryhmzoN5I8Ip+xHjOEPA4+mqjWvNyZrHOf
	AwkDot8b8QHWn/ASEsPA8G2nJp7U4gkh9O2VMLbxOzxn/bEAQhGzUB3OjFziMOO3ZQFxGWvcs0d
	sZ9AfbHDSPV8vBEuKIMx7eYPRhAU0HEip7hc+oKU5k2+Izw9OV8B0M3HsZ8WZvegCfop0kTZkE7
	axFp/5+leXB/Wo+gmr1h3J1gH9HXaGuHElicbFHehwWCuFKhDhyLd0NEvxMMqTduTGhXRJ6x2M3
	NEpFYhAIGYc+DPFg0SteaPWdhWeQ39+LBsLSjgzTjBoPXMZW959+BiXmtnnXd+HQH5GOyeEjC8C
	z5b+pKu/+Xi81+pNA5cSX+R5+zbplXXnglrlO49miz2FVd/NAtfZnodlNnQtkbOnVcl/tUdN9zu
	SZaXrU0K9NHX5Av0pR4/MSPsFqe3Ttv/jHUBev4YPbUfv+JG4g7WkJi2LC0L9PrfFooR69v+b4E
	dAPf5JZpBjHmW7RvzfrXZTh4=
X-Received: by 2002:a17:907:3e1c:b0:c45:c030:732a with SMTP id a640c23a62f3a-c4ca7ac582emr1566488966b.35.1793823149356;
        Wed, 04 Nov 2026 12:12:29 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e495f70sm104573466b.76.2026.11.04.12.12.29
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:12:29 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b566cf56c1so862752a12.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 12:12:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByyH9JCgfDbM+7HNjxDdwmWo2u/0RHEN6QRMZU8Y/W0fbBejwRTwRswUqVIucRYi5MdBOrRerGnWLE=@vger.kernel.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus

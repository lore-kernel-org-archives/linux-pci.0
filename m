Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872942;
	b=u84wJrbk/H07HzJJtq1XZVz4Q6nfgdgZEiZIKp2PXcmRdKd3bcRTejCACZI4yE76fQjC
	 rMNRzmSf4LHAAXlT5DKP3Dx62+RPYKQNrJFcsKmOrA46KUfFawtPtTJbnwEdzvfYk3NAx
	 MV1txMo0RwsmhuAGnQNgDU+h/SvH1bDkNVID+z0PFeHt6xXhUacHIJJUZ5qin5xao+b56
	 jDGdOMVfW76lNlP247OR/okcf4hoTz2CLL8nNSyPVU667g3WGulagWztS3pIblG0AR9QK
	 4WQYr89krzOrhbJ1DPYP1hheAkjzl3G/EA9rVeqP27xW/xmp4c1CPv3gAl+YpHZrlUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872942;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
	b=aG6ryYoqL45iKVPDq3pmdLVKbEJo5Hni3zep52qpxILBBDY6qaaanw4CceKktOoYIwPD
	 5G1ivyvbUNnmXc81dZUsIz6d1dKfLAbHiLc/II8lUovIkDgIGlxhmaJ8UjZkgDTdP5D8w
	 fxI6kkVcCSvNQH4TvZnh/jpUNzL9XnOC4kLPMG2CPWkyKmDu4qQvtYS9km5islzvyri++
	 /ur2TF2Lw84Sj59l7crcyVWcqTjHI9d2YJjRqkuN5cCrVNHZMtFpMvKl9DOYpc+FCCz9P
	 0Bu2MADQ4+ka+Nd1kud+raFzakPnMdXUUs85Q4puRbKThhj2+emPsp/1iS3iuAejfoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C52606A33D
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 10:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C52606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91b8306b9f8so25767016d6.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 02:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872941; x=1794477741;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
        b=W0lkvOcM2YSdNeWyej8XUCKXn9AzEQrom9KWxvjHIBMR67uXitH8LwKQ1wpqtqHPRm
         TuF9a/gg88+lx2C3tn4IS4+ncSWP0xfldshb/vS+Q4l3q//nV7UUyFTRZK3FwIp7RsXa
         NtQe1tW/VZ5TIticFARP/Mf6oPjAaTjoyZCCGigRa+xU0s1APVPqt57JYr5RUpUliXs0
         mcGG7w9ZnAaxd4a20H864aYO/hjRE4xk/Im/axV3g9lE0lzFVkJsOKzkakbzo0pS/aFa
         ZvxlZPuCY4DeSPw2smpbJ12wIU/X1iwifPVs+b4LvYBPp0tuDytk6TLCu+2L8wa5Wf2n
         ZK0g==
X-Forwarded-Encrypted: i=1; AKwUvBwQykAUUKlJ3wj6EdU3Sdi9Hxu1qbmit1+2s0HvdHSPlQn3XK8HcZdlr7dWFv/K6on/Ol+SIbRPn8E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lakwcVufTk+rObNyywH7dBRfs46n/sK4fhxIJXbE47EED+sRF
	uFJgxJkQ/kzaAgXgvPH6Arh5PaWYAAgOg59xhdx8vQxCk1mNCcTR6uT7e6wBa/uNkek=
X-Gm-Gg: AYBFou1hm7WpLt9chWuwji04DK0H/Zlc6E0M77d2u5N4skbZbTPRaFuWxrLqfjdTSDv
	IDDVwjkjkGnqSbqpRWwNQbx66D8GOhB0Fp47s4QSbbJTW78pRFYOA5FLTszZ1SNCdkaJjWrTnFT
	8o0kH/QxYKiEAtxMPVcOKUwHKNw8taJAPiSmWBjDHTzB3/2Wg+WcPMbzo6whkuecWHujYMzsTWf
	fXYTYYQnHvnwW6PTIoRRZvTqOlTWEu85J1WUcsfKFIV0yrg/3YtcuQTAeJAAKOGCpNGaweF9M5A
	iEFM0IYunwI5N66gS7jG8IK6Wt5D2Rn1hZSIH+iP8jqclHWnmXYUOZEFUODurYb9uHTytGfn929
	3wbdsPDYM9kpp7Yn+7hDjnD97/JH7rpxFnnX5T6G2TyvEgQRnvLcjjxjM37UkWojK1THTUgZit2
	AzHOlWBscLLxbYVPRi920fcZdZdUkurYcQCg2xWBeAPKTXmm5VWiO0k4PeR2d2yH4+D5FgNTadw
	NxVOYKu9qaTLAyiQxjqvf/lADY0IUk6NGKUgeaEncVfP7VVpROhRqZ7MZWezwaGjgC6jLKy2Ewl
	6JUahUPRmVcvsAggviDNreuWzDNCZKK4GyTo3PUqussFHPqkX2bbNOerP+Dds8CS1Gf5Cg==
X-Received: by 2002:ad4:5c61:0:b0:91b:5d39:e13b with SMTP id 6a1803df08f44-91ca4bda1d7mr314399416d6.48.1793872940861;
        Thu, 05 Nov 2026 02:02:20 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e70f84dsm43393426d6.32.2026.11.05.02.02.20
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:02:20 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5365d26ccbdso19507401cf.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 02:02:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwj8q+hO3E7QEaVyZvwF04796Z0r7ZyWx+3fUYEuPsZvFtrfrFKqJomQGY+eSpZtfQFCgZb9wjxVNI=@vger.kernel.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
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

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873268;
	b=n05s8opOOojGcHmszBGU5DJaVyGe+G2yAdO+aPRCEBVfjk1me/ZgB54VWUUfuQabIMUq
	 U58m15Oais8Xg1Ya5ZLYfQdlESiOliXL0+r/jibHtcJKMsvqyl0DFsZzWHWL/I1zjLgde
	 mjwELqlMwasvf2G4KIye9IcFtoZ/ZbXlm2yaRzskFJK6ujYIbwDaZr4v1c3ovKRtl+UiZ
	 YkqrNnV4ErsSJr5DPXbADRhzin1DK5dv9AbRAUXIo9/ei/l/bjPhzJDgPOLW6qM/plgJq
	 gSdE1LL3DlOPHbw9iEvWc3OS273X8zE3rS5l2c7gD2N8bEyMLy63I5dLMos3h/WxRpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873268;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
	b=pWBzcohKSo/YiTuj5i09N5elzCFrROpHThOp2/7PIkz2a1QVDXvgYYzi1neUXeLdJ3Ru
	 kLpgwjVDdk1H8htIM84Pj7x4XcKuSlwuuPFAdAbE39+pGE2VMJsG4wNvoMVcJb83ywzKE
	 n7UcmPL49sVZUmCkbicGgEo/s8niQ9LUwY3FzkNm7XPPv+BwLSPGCNoFAdU2Exw7T8MHW
	 qrUJsJknPF/towjBaqXZ0t9ujm2FbwqKPUUDmVnrqQVc/txepJLmGlMNsbGcSXP+u7dUc
	 dAhfc0Jh6VzvlN/SvV3PbTLIPBbY5paYbE/2PuTr3m41CK2JLufJZWNrIHpF1RsbI9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FAA606A32C
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 10:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87FAA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so591140137.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 02:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873267; x=1794478067;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
        b=ETINgP3CCFLRYbNQiA7q8R1KhaSKZ5EmM5hy00K3prZW2KqnBbRO+8+NAfLdMKOYkt
         73MCrISPyIsIMdpdGtB9HDHmoPn6gsI4/h8FS/pAfeQfr6Wkv5bRzxli+YLChqO0HqJ2
         lpz3F4/vb7WuqZ0whZdhuj+oLRZZeQO9wxFvE2phrq228v1EQCFziAjpRn8R2kpj4izW
         uQAMLXzmgBdvSrmOo/GfELFGCHT5XPNyH1oV0mT3tlZr9/ZM+WHKiKYHgosFerUcLEQC
         e05xW3VlYJuFRhxcY/cdVjxZloTQwpPo0RpaXPRzeuqkk6YLshfGUehgz464hbpUnIV+
         tAbw==
X-Forwarded-Encrypted: i=1; AKwUvBw7ExJdWMg/RVqSjBp/KJbwU8oMUhq8laPXojQCDcR77Us9y7IjzVUqYXUxi5axVePQKf9YrJVRQUQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EheGkmdYI3khjP/Ito6HUwPsRPpobkJiEq2XTnjc9F2GM+AAI
	ccru9i4VtmiweMhA87YJ+SmqIbLCtbquR3Nanezc7GQzolPExtw7lrzg7YYPxHcZrIA=
X-Gm-Gg: AYBFou05g7ZoWgJ63lC+2zoeAkR1LXNtD170dFTWr6/X9LvBJ4rCDfn5IsgpSYTXQXo
	AvH4vDfy3KFz6N0Xg1kLvqspXmApTq8TT1zOdXF8T/ObsRjIUCUd6WsVQpX3E5AdspZJ7Mae7v3
	tPHqWnNbzH3rq9ArBuC6ZANi7hcb78OuywcM6xBmmR4kau8OkjcV8tdInQVVwJ5umAQjZC2H6Qs
	jHabAuUEtQDNUcF+YunaUlduxNlucf8LNnhscS0F5qfKzCUpCTU1gs8iHXVJH/tqFDFOkeGax8x
	2iWipcShOJ9WRkHs7K0SRvCDgcerY5pm5+iVKxVL4Y4rBKLkqxKz7e103eLDK5JqBzuIUXtM8vg
	1qVYCarYg+wyFGRfH7K79xe90Aa4MhwaoArAk++/crRwsq5SCgOlrpM5WHPigQu1U8hgl9mXX0w
	0lxYh0JkEoUa/fLl0tGBssvCTkaIOQMQh5k6mNN7vSdomxBzs5SKvdExh0iP1LLRe2z1vX7k3bH
	dI46M2LAnIa7v3gR5mZG1TyqU/CzkbzVohWRKNtd5MOmHSRplxq4Fgb3JTuaBTBDGGH0714Kr27
	2ZPCqR0VuLBv5dgEsPbckpQy/BS5ngtX9hUmW6LYCDgJkOFyRxWvUHs293N+kC5NRg==
X-Received: by 2002:a05:6102:f86:b0:7cd:3218:362e with SMTP id ada2fe7eead31-7d072701e2amr7913493137.29.1793873267402;
        Thu, 05 Nov 2026 02:07:47 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d69af021sm4029349241.1.2026.11.05.02.07.43
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:07:45 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so583571137.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 02:07:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzyurF1RvxPs7Wu1hlfmdAZfEWWM9HBX69KbDdkNVVkf8cDMIAFCznNEWpYqLtvYMpuXDCjsO1kNII=@vger.kernel.org
X-Received: by 2002:a05:6102:374c:b0:7cc:1a41:20e8 with SMTP id
 ada2fe7eead31-7d07227a940mr8060714137.5.1793873263361; Thu, 05 Nov 2026
 02:07:43 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:07:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
X-Gm-Features: AclHuK9naqg5CZQ7lhJVrMhg9TNH44f-SpA5WbUGCGBsAlcoOw2midTd7doJSmk
Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
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

Hi Christian,

On Wed, 4 Nov 2026 at 20:32, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_write() pins the entry and calls ->proc_write() which copies
> from userspace itself. A page fault in that copy can take as long as
> the writer wants, just like the copy to userspace of a read, and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for writes as well. An entry that implements
> ->proc_write_buf() gets a NUL-terminated kernel copy of what was
> written. procfs makes that copy before it pins the entry. The copy is
> capped at ->proc_write_size bytes, or at PAGE_SIZE - 1 like
> proc_simple_write() if the entry doesn't care. Larger writes fail with
> -EINVAL. The proc_ops go away with the entry, so procfs remembers the
> limit in the entry when it is registered, like the size of the seq_file
> state, instead of pinning the entry just to look up a number.
>
> Entries that take binary data in pieces, like the PCI config space,
> ALSA's data entries or a firmware image, can ask for
> PROC_ENTRY_SHORT_WRITES instead. procfs then copies in the first
> ->proc_write_size bytes and the write comes up short.
>
> ->proc_write_buf() gets the position like ->proc_write() so entries
> that write at an offset keep working.
>
> Note that procfs copies in the whole write before the entry looks at any
> of it. So a write that is too large or whose buffer can't be read fails
> before the entry's own checks run, permission checks included, even
> where the entry only ever looked at the first few bytes.
>
> An entry that implements ->proc_write_buf() and still has a
> ->proc_write() fails to register.
>
> No users yet.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -67,6 +74,16 @@ struct proc_ops {
>         const struct seq_operations *proc_seq_ops;
>         int     (*proc_show)(struct seq_file *, void *);
>         unsigned int proc_state_size;
> +       /*
> +        * procfs copies what is written into a kernel buffer and calls
> +        * ->proc_write_buf() with it. The buffer is NUL-terminated and holds
> +        * at most ->proc_write_size bytes, PAGE_SIZE - 1 if that's 0. Larger
> +        * writes fail with -EINVAL unless the entry asks for
> +        * PROC_ENTRY_SHORT_WRITES. The position is NULL for a stream, like
> +        * for ->write().
> +        */
> +       ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);

"const char *"?

Seems like you have to drop several const attributes during the
conversion from "const char __user *buf" to "char *buf".

While at it, I think it would be good to use this conversion as an
opportunity to replace "char *" by "void *", which will probably let
you drop several casts from users.

> +       unsigned int proc_write_size;
>  } __randomize_layout;
>
>  /* definitions for hide_pid field */
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872803;
	b=bP+iFICNBd4HQOxFGVGakwCq7+P7g4X0KQSfqWGmvuJ82JPF/YtaQUOS4RgK/0rFGqy6
	 MbrgkL30XCD8/8VpTva1IfOIB5ChxnvEWwUBn98eYO9srpMofRJdMS7bning+tectbkSG
	 pppGvJ4LOsDKOd5O37/yKENViApboGCQdAyGNJHOQFQGOzoBuWPyU/5zEy2IMFc/H4fau
	 NDxwTLhujNNLqJsnWyKKMbg7d+TMrxthDuyn/Zh3ub07fI4gYtFpW3z/i4Vxtadx0IgMF
	 prki/EV9GMyVGuWwf46iLV3DCXVoh/RxQ/jBYNF+qHKlv2hV2JhiJpCtS/Ch+orY9Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872803;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	b=fVKzQfIxiEvky6Z3Ql51Rjq2q/4X3ZPdNX88U/8QxPa0iCtKfCcztq2zBLU/ZBhoOf9V
	 Hu7FEPxKEcGjEfvTp6x2dmIUwPartwr6fhLF3ivyNXgySP8l7w8nrFSyEpbNjFGm4GcAV
	 O8+lQQ6h57aVK8APU9YNPAped0OfKlfSPgP1EdTTRPw3UQ0e/p6WQlFN9oP40F2JzLd1v
	 u/vp8F80MRgOCy+ZfBc/P3nb5M2YFLLW02KPi+qpvFUsJJ3Nvzq4gSlSr6tDhKxFbE2J8
	 9rp5riij2+svpTsWgEswVMB0JVnc/67sLrEhWZkGC/jwt5dZ0SD6EN4c1ZSe2mUGUkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8E606A328
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 10:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE8E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c6ce60697so22202316d6.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 02:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872802; x=1794477602;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=C6dfDrjCvcogrsT7SQAFL2s85w6M7mRRZxahzh9ZGUsX4o13j/co8GCPTErhBPp2K6
         RCzdgdw32C3DKwspLnefieqzy2qQZDERnwjx0H+43nNPmV+4qYLzjUvj6fHzkBYedqTh
         sAvB0k3YVOzzaVDQ4f3DaS8QgRKSCNgmkKOvAVixX1y18h3blxoD5vMr/lMuRJn19K9e
         Wn00ZPGWT+Gw8rUmSqMcJexWbN85UpDB4WLvAqv2LRGnN/K7OkuFhSXjK9k7JMHT3ciI
         euAAVBnFXkSVzu6kijjHgulX0PXzh7k3QpIYcSHepOYjlMTsqixTBX6XrteaDdvTIybq
         bcaw==
X-Forwarded-Encrypted: i=1; AKwUvBx5i+dyhlSMIJmFJrnwwuUOtagzsQfyi+SGsGwtZJKgniAKHysiWcMTBqabPVGfEqnh9ZuvktyPyjk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tlX1iekLBYhg4oGrwLAk0rdit3fpFRdT9xBQXkZIikK8vg6Dl
	jSY0ip6eTyHM4YBFbJYDwZHlBkBQj9jpTg/DAj7u/9Y5FF/qDTKGM5iUPunIuir2bVk=
X-Gm-Gg: AYBFou1i1CgQ4eSYMMJjDPYO6VQrmLUCdzITynFlKrxDlaJqmz+IAerlSon3FsUFJyI
	nwTazXJoeBriaGRQauPAVUHgRqqlY+5JV9gk/C+Qob/vMJFywFfaCKofJ7KCrPsv2+fuQoEv7Vo
	ze3RT9PCWn4+t2k5NncLO65ipza8ZllNJiDSK4lTG3U5LWqCzl6aRpmPkmMqv8ozwgVl3n9rdli
	w+Sdc3yRnb7Bz6KXe0M+EtLbURxyUyus6MeDbWRZ26jSHf8A4SKw2KsLzQ63RMw0AyEZsYOAKew
	w8Qoce19PJBzk6kdf0n/jbUqG5hbytJOmrFOpv98iE+DbT8v3sos8DiZtfxaiyJG+rEMDVDfPzT
	QQsFjCuu8mOBkOxrdilbbehrevO/FOH/NvDDpNhrkELPR9LkGA8t+DSTr1nKM11DUkKB5DFCRxh
	QruImB7IWH83Hk88ExnNZ3Mb02GX5NfAsl9I5YQF+7/v0GbjAXEcDQLlrJHOrMA8zMloU2nTM2q
	8/U9dBavhUdT+P+32Yb1A0dYW7kzpxXNh1bRElrm8JwCzKltoW1LfN4N/7Y+CDtSEfq8nbMTkVV
	5nI/FXnl1yjAEllHpHLW7z7SA/mN2u/+UI41aRwiWLfP3mI8ZmcI7ERm6sEYtuMFuQ==
X-Received: by 2002:a05:6214:483:b0:915:e732:33b4 with SMTP id 6a1803df08f44-91ca4ae2ecfmr308820306d6.19.1793872802428;
        Thu, 05 Nov 2026 02:00:02 -0800 (PST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e9c4e656asm6904866d6.42.2026.11.05.02.00.01
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:00:02 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c7a0c1617so23356736d6.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 02:00:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxEUXk+yFOVm3ueWAq2AJ6eUUZJQHGVMU9Flr2CSCrDdA7qzpcjtGctk30XBJUvCrAJbJLTsRArlvs=@vger.kernel.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
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

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
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

Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E9368950
	for <linux-pci@vger.kernel.org>; Sun,  9 Aug 2026 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259807; cv=none; b=QG+0VbMJ5h1eIciDvPd/VzcxSvXG1nUng02b99vzlnTpajRrHcb8EtkE2PDBfWayOiwaowENdS83d5VFe2c/YgwjfUdTLznANagoVr1ByZEdNMaXjZlT4bmfCsdwcBnfJRapKKAOzJ4LI01ITCHl1f5QhSEt4ZS+cWzPBXj5gF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259807; c=relaxed/simple;
	bh=Ng0dHs3X9wQVhe1ERH80lRumo9icxJFHkEBbVAZydvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biAsxrXgbJgiyfVObactVHCvJY1b0YHWV1jAA2XJf+SBcVueIca6hmKqLcZOcfC+RxZosthkjOmnniHWhGX+Rzgy5pqww7CFZm+bm1U5odHb0ElvFxox8sG2G3hkzGHIUJXDHMD7IcKZ0Lt6rzCJmpnJXTdBjCWhJt/UkrOmIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtyV5DbP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtyV5DbP"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso868433a91.3
        for <linux-pci@vger.kernel.org>; Sun, 09 Aug 2026 00:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786259805; x=1786864605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6/zrl6clmXEtZvk4idWU7qHREwz822KaQXUlYrmnYcY=;
        b=YtyV5DbP+kMs3JWcWLXVYMTmTfTcrPk7IQF3UlZR9+LWALGRYrNY8gSTinRW7ADjLV
         0km/hs7l4zYzPFVx1M6ioua45woval+PN/zmF3c0zd3B8HZN/4p6+YHbzvmB+sf1RVP9
         1ohBcwVVxWPm/ZeoDg1QY7xN3WAxWii4SpI+wQAXBYeYPDgZbNeOXEBO85RVeWv0z01t
         AEhIT0h07Y6R5dzyE+e80P/16lOEX/hf+ixq9yTgAYP+wbVtL/AHWZtCzSxx0Dj6tsU6
         fFvWpzZNBsJTxhyffm47OWMJYf6OU7ZuMGopdg7jk4GdUoxfk34ECKWto9EwbZRDZQsz
         SoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259805; x=1786864605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/zrl6clmXEtZvk4idWU7qHREwz822KaQXUlYrmnYcY=;
        b=dMya0SFbx/FSDztppaamMOuyDCYosEZGUIdrz6alTskPlB5vIJ0g7peH/2GPKw3hga
         vfH1Xmc0ju5L7ZOKhGkbIhWIO/7rq7vAYH8X+ybd1+A+Z1aGmO6j81fLvaK231Wbz7RK
         7KS59MPC80j1kiC1MFloZlvPtZxI0Ga+Ld8nbrt9OV3cUvia1l7z5n/1uDfy0Rrf3T/R
         MRQhFeNZHkyVcdntIBWurw8CTnZvZ3n5WcobdgANsVEXHIQ28EffqQ5TcUQa0aakvzE+
         wWWy2w07NRNmQ8Wdik4TlwPLml3rQcu0WvKzJljAiiypT0ACJ8xd/+Yn6BklTQbSY7fP
         0/9w==
X-Forwarded-Encrypted: i=1; AHgh+RodqCBnys1GTx2LLTwzGIHsr/jFkzesOjIJQtXBoejz6E4Z6UX+A3LNKtwg9a1F0ofdPGD2UPU9gDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywSMePVV1MInTTEbc+zRrnTeveEE0th8c9nFVuCQLO6hW1QaNn
	jDSv3Jm4346/6b+TW6Qk3YNWqsIpGBYyFxoFvgn9eU6bdn4fOW3sQIhb
X-Gm-Gg: AR+sD13fJ7wy4jmiH58qKi998+RjDSrG+hkByIL4QJbF5umtaTlB5mFGVARfU3TTpwo
	3offAcl/X6RIgJY4/4YyIJO17XOPblQlVwpfTbr0XOpewUwSs/TKyOHJbhh7G9AAiLFVXCOMUWE
	sgRc4bZ469yySSzvQVsuQxzFlP2ln8MNVKo2ovZPpB7iNyFM9AeA5cUzT1dJpJVR7c3JTMUhZV/
	eoj1w6tJov2LfW+NlXmTeKXgvZi2mzW6UYHMbqmil9/y+HxZsotzipEYeWLiys/N/+3mSOT/veM
	7bxa0obWT3KMxVRM25AB7Yfj7PINAPz3TsJqAt0ObmmaE8HmkmM7KbE6/tx+1QTeBJPQLprqJtJ
	KwTOyIREweGWrG9xJt4mVN2xk9hcWq4OMsdcSi+9L7b5Q1VfKK18eEqtbGKw6PEDWSLWCPqiqXW
	aoyvyeilujWsWMMZxtM7IZRt8lcg5G1CUZd6f4LJs/CFk/AGhXJpvvLgRcBh9X
X-Received: by 2002:a17:90b:1e43:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-392b509b300mr415412a91.14.1786259805247;
        Sun, 09 Aug 2026 00:16:45 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b343e662sm3296002a91.2.2026.08.09.00.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:16:44 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: kartikey406@gmail.com
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: Re: [PATCH] PCI: sysfs: Reject unaligned resource I/O port accesses
Date: Sun,  9 Aug 2026 16:16:39 +0900
Message-ID: <20260809071639.21204-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809045946.15638-1-kartikey406@gmail.com>
References: <20260809045946.15638-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun Aug 9, 2026 at 4:59 AM UTC, Deepanshu Kartikey wrote:
> +	if (!IS_ALIGNED(port, count))
> +		return -EINVAL;

You beat me to it :)  I had the same change under test here, so rather
than send a duplicate patch, here are the results.

I had already run the same diff through a syzbot test.  Quoting the
result for reference, since it went to linux-kernel and not to
linux-pci:

> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
> Tested-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         ba5cc80f Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=15898149580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ccf4bea59f67007
> dashboard link: https://syzkaller.appspot.com/bug?extid=7134530b25073b4ef373
> userspace arch: arm64
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1431e132580000

I also tested it locally, on v7.2-rc4 arm64 defconfig under qemu 9.2,
with and without this hunk, over every offset and width on an I/O BAR.
The unaligned 2- and 4-byte accesses go from oopsing to -EINVAL in both
directions, and every aligned access is unchanged.  Widths of 3, 5 and 8
return -EINVAL before and after, so the IS_ALIGNED() point the bot
raised makes no difference in practice: with a non-power-of-two count
the test is meaningless, and the switch rejects the width anyway.

Tested-by: Rihyeon Kim <rihyeon8648@gmail.com>

I wonder if it is worth mentioning in the commit log that the two
directions are not the same here.  You already say pread64() hits it
too, but pci_write_resource() calls security_locked_down() with
LOCKDOWN_PCI_ACCESS while pci_read_resource() has no such check, so with
lockdown at integrity or above the write is refused and the read still
faults.  Both need root either way, since the attribute is 0600, so
maybe it is noise; feel free to ignore.

I went through the same thing in the syzbot thread earlier today, if any
of it is useful:

  https://lore.kernel.org/all/20260809012855.109608-1-rihyeon8648@gmail.com/

Thanks,
Rihyeon Kim

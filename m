Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7191DE4E0
	for <linux-pci@vger.kernel.org>; Sun,  9 Aug 2026 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786238941; cv=none; b=MTJ86y0LsxVWt3lPDPGHfCgaVcacofsQxhl7MP61gIUj8Ou55GeKqyM1IoHQOtpIp6SH7u2u9yk5ftSwLgdLybVniZAF78yhvY8DvoW+s1UGn5J72WUnx3I5xGSTcqkVv9wKCbcz5PyH1vmhvuNRAu4sJjIcuCh3GGF8YKUpqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786238941; c=relaxed/simple;
	bh=QziYzalYqJqEO9wkxAYZemeJLDTeF0VAxkUjX8sRizk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYc4Mo9tJ0ccSAzxnmjXg2RipIr/EV2+V0mfbwL04Z1ufYwk0dkLyxDAERBiNSTmk9a6dXidCi0G+ArOk3jZ8o5WBCW3XK07GNqUhfQvvO71gs7EMeGgfYg+J0L4lTpbOBhBC7URtO9xvntgEHfS06bkxWAuSj0iamlm39YkUO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DILSTd/E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DILSTd/E"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc891373e0so7983695ad.2
        for <linux-pci@vger.kernel.org>; Sat, 08 Aug 2026 18:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786238939; x=1786843739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=unnrLiRG1r18nJZN1a5a6TML6nSi3RB1Ndbj2CmlTck=;
        b=DILSTd/ETGLcLoirPRk3i+6pJhuUHj+bqi7sBUM3ZJIiyh3gmx+nHblHDfrlN+7/ks
         1zQtr02g1AMRoAiSfka2eRpSstoRY4U0CDFZWJpR7kebkKet01wMOBTCKSPVRVHQ0vw8
         aRyuQKFOBm4KHbbB+BbTZPBHd8dQYy99+bNoAXP9aGCHVuEgrZ/4cvpdlHz0ZT8naTQo
         S43KoYA4+ODyF3Uf2M47Xl/pM/z07uqzrc47zzgOpPrHL+ImbSgWDbR+5kaviCgyZ1va
         4Fd7kxGphUg8gz4+enH/hZOJh3sggDhKEe8MazPGoD62YPMpmC6U3PvB8z5kak9rltIQ
         /YzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786238939; x=1786843739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=unnrLiRG1r18nJZN1a5a6TML6nSi3RB1Ndbj2CmlTck=;
        b=OEp2pLJZFFPR62PSfaG9TR21fzCLtRODLBMAZRFXPlkN7TgtWpqF2iG6DAozTrLqmR
         gkVpKiKYpV4uLf3khiiQsuvEWxjDUav/W9fpkAmwXG4+p0hAhhBmSJnUWxk/epu7aA+1
         AhxgTVoagKxAez0c+OE2I9mNtXcEnfqLGQo39XV0X+NiaGzOFaWOtdF4k34gqhe808Xm
         injRubi/FdC+s8Qim6VwWnDkIasIcwQBo102rLd7h92vp6NYsY6Gc2HzyjWO6y3z3KEX
         NYytLnSsLajkV6cO0mixewzhZ3uRZ7Jc43vtOZ0bfbNwC+ThGUeAOq3AQFPX3t7LtMBE
         sc/w==
X-Forwarded-Encrypted: i=1; AHgh+RqEb3Wx9mEPHvjnG92vICzzVSmmJWHZ8FEItLX8zJQaVvlfciOE8dKNIHx4xe5SOM+J0rNmi7+D3YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHAvOILQXaYSuLVl9VkI3kgcNltaORLt/eRiEgQqJx8o/8DV4
	L54cfAXVyX6ygMlhj9qK8SCQBPHaHjYlugHfMiQ9lrJfVGatCtfkD1AH
X-Gm-Gg: AR+sD13jZMtRoYsnheIwtJvGOhbt5GA3rYp3kXp5kXo+AQPJcr9rvtOwkfv9Ohz5rXV
	/uE6Xq+s1aoxsd5EgMSkoFjuv0oqXOFUbRv5ECBYMw/MJuFJdx7og+T+0/8YGLoEYqWlK9AfZn5
	zLMed2euBty86gajj/WdY8oOBn+H5aSvHG/jO5yRso4mxbbfacAnlJgfV9eDDk+rU4SVb+AJmkl
	lwvt2EKVdbbRChUKcSf4SgaDPVSwIT0ucCv7yp01WVpgyHzrK1bwVoWf8Q16SLtnZpzUDZ6Wuxt
	vnLIT/oX7r4HphE/A4GFuPNINrZXKtly9hiHWNBbeox58yuNcorugjmOyAzexITLdDEqfMI2krw
	JpoPzaitfFl0Vll1IjHHPeC8oGt5mFzlI6EUHc41yHypijEkxOyMIGWZTyqfqb/2v63olWy7R8R
	AqBI2ICnvNdKpH3H6RFZaejzyhB+mxQ+k0usNvfTfLWw2ND8SiD4WYD29Cio+6
X-Received: by 2002:a17:902:d2c9:b0:2cf:b330:e0e8 with SMTP id d9443c01a7336-2d0ca7599d6mr344811355ad.10.1786238939305;
        Sat, 08 Aug 2026 18:28:59 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a35c0sm20768965ad.63.2026.08.08.18.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 18:28:58 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pci?] BUG: unable to handle kernel paging request in pci_resource_io
Date: Sun,  9 Aug 2026 10:28:55 +0900
Message-ID: <20260809012855.109608-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a778f12.b50370da.49fe0.002d.GAE@google.com>
References: <6a778f12.b50370da.49fe0.002d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat Aug 8, 2026 at 8:18 PM UTC, syzbot wrote:
> Unable to handle kernel paging request at virtual address ffffffffc0801001
>   FSC = 0x21: alignment fault
> pc : logic_outw+0x58/0x124 lib/logic_pio.c:305
>  pci_resource_io+0x1f4/0x3dc drivers/pci/pci-sysfs.c:1187

I'm interested in this one and had a look at it today.  I can reproduce
it here, with the same faulting address and the same ESR 0x96000061 as
the report.

It seems that pci_resource_io() validates the access width (1, 2 or 4
bytes) and the range against the BAR, but never checks that the port
itself is naturally aligned.  The port is the BAR start plus the sysfs
file offset, so a 2-byte write at an odd offset reaches outw() with an
odd port number.  arm64 has no separate I/O address space, so outw()
becomes the __raw_writew() to PCI_IOBASE + port that the report shows in
the pc line.  The pte in the report has AttrIndx 4, i.e.
MT_DEVICE_nGnRE, so that window is Device memory and the unaligned store
faults.

The registers in the report seem to agree.  x22 and x23 are 0x1001 and
0x101f, which is an offset of 1 into a 32-byte I/O BAR at 0x1000, and
x21 is 0xffbfff, i.e. MMIO_UPPER_LIMIT, so logic_outw() took the _outw()
branch rather than the indirect PIO one.  PCI_IOBASE is 0xffffffffc0800000
there, and adding the 0x1001 port gives the faulting address exactly.

The read path goes through the same helper, and an unaligned pread()
faults the same way in inw().  If anything it is easier to reach, since
pci_read_resource() has no security_locked_down() check.

If I'm reading this correctly, rejecting accesses whose port is not
naturally aligned for the width should be enough, and it would not
affect any aligned access that works today.
I will prepare a patch.

Thanks,
Rihyeon Kim

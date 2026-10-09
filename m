Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A672F7F0F
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514267; cv=none; b=MUjCKSttSAMk/pJ6H70ORgj6aG7G7IxEmeMiAI6Pufaqn4D+eEx8J53aIRn35iVhZ4MOHqJ5DnxegWFtfJSWtZ0Khj+cQS+YWHCpoFFjEFLcLxPGMlmzFOyABPIBvsRSeiQuOXfxGOh5mCQpwqnxTjbyjUGKXUxdmgNcb9HVU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514267; c=relaxed/simple;
	bh=NGhGyWBd5XtgeNmO5aOxgvDdwmO9txqX+TtFYdrDA5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7Q951H2gxNmWiJfLOsGxkotVSY1JuhIogTG1vuHeFNbP+clOvjggnHds/6632TUFmIaW+OzJ2vq1EKmID4CNMHaMAmqMU1TM9DzlI/zD5xZCGk7HSeRteP5hhOE7xH4z73MAiTxeFagqqyQpw34cuiTq1X2kyszi250WvgsPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp/06fK/; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp/06fK/"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-988ccb8da15so838620241.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 19:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791514264; x=1792119064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TI154vCGJt6eYFa0Z4ivT78Q0lANyQelPlGETBwLtck=;
        b=Sp/06fK/yQb/TssSvQhld6MRlgM+ofnWfDWbX+c5dk9tHasQf/Zwi3C4LobOg6N9QU
         o+Wtx7sNqCaNtMlZasAPwqrr/MIfj5yv91VHyD7gjRHy3U44do3TiNNdjOEXZF4Tey5b
         GMuRV0oy1seZgIaPbhsF34LLsxeW8kdAbgYmv8Nav0kkwTDks6U5SWPlr1Q08k7viiPK
         V5iSKQP2ZxHorPJl71+F308NBzwoRWhPBqVFGAbrukKK1AYoMLSJcYtxxR/c2lBEvCvq
         rIPXlN19d+IzGiD2PZfzI7GKPE7N7aN8HnmTbVqCFXIdyzPFP0LgzHTQEOX2+KWVKnSp
         oF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514264; x=1792119064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TI154vCGJt6eYFa0Z4ivT78Q0lANyQelPlGETBwLtck=;
        b=L4pGPxVVmCa3gCexkcJJx625Q4KaPvuvZa7XY0GfIqCoGiSQWDdccanmVo8UrIMisS
         bj3xUk13cO7AZ5MfxYiKz4vXlbBiZUkKoEPiQ7G+N6wpPpG+q/vU1GoKAus4TN4m2DJL
         bKWgXFI1K1St0EBZQhuYkxWK24viuZjYpkKD2H7mfMNseSy3lzpg+jrAfgI3tbHkVfJu
         uAUv4mRwCwK6zrJLnrwk/PvkkDcY2vwVFgfZkekrJo/sU0Uk5n2YqhQyBVIivm5auKu5
         1vT2ui/nRGGXoHm/NLcmGpmWbiIYOThfL6dFYPCMveipm4nLe8+EbW5cAKtQ/2V0EVXz
         yq1g==
X-Forwarded-Encrypted: i=1; AKwUvBx52o8ClCaO/Jgogo6WKaQ6ySF7NZ2atFkvN0PVCUANLHxHEyrIZ100XtSwnUmJ/n56g0hi44Nxl9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIeWEqA+Ucp7/+N3OUGNIMO9TTdeB7X4OdJLv7p+AeJwYA88Dg
	wTF+isRnY51fZl9X8btPuzWT60b22r6AlwgTWCGnbH9cQ7/E5MfSJhQL
X-Gm-Gg: AYBFou10VJik8Xkbe4m3VDdrouDGGsEx3ykebHOzv0yGEBomqjobeJ8JzjdUoZDTZwY
	UlouIDYqV+0bppX4P4fHQ9+X1YFOgVPd5LACRWpVNTvPupgqwPFJDfBBSKj0pCNXAzdih8jnX8f
	t3y30GWkW93EGLo3C0d9qCOC9NVeww2ZkMYG2xNOskBwvAO7O1U2Zjm0XaxhtpCQ7iW3B5uaj27
	Qe8457jZmEbXdgr1k+xwZYBYBtBpcKMdvDr32viUpJTEWXfbDkvpcxAi7XyWdCwgjvpFKwTYiu6
	fvDV49fmEPcSx79YdRAMje90rKzc4aow8rQ/hadziIuuR3yvg72pA+roBnhultJxKne8N4/WmnI
	NOOMJNHvbhH1yzNPH+/+Vt1CHnyj48nSfCABkkIM80sWKoFvzU52YMbatgcZWGsyifzekWqTCyE
	hdwb3tCmalPCJM2jwN0gsamdmAQSHDgZcIi2W3A++DLZEN58DeF5ouNQ9db9yz8uRZiZQQvqMHM
	zwjsqtg
X-Received: by 2002:a05:6102:6b09:b0:779:5049:87b2 with SMTP id ada2fe7eead31-7cb361f5f1emr208448137.0.1791514263916;
        Thu, 08 Oct 2026 19:51:03 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:1c75:eeaa:b22f:20dc])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb354a9565sm688041137.12.2026.10.08.19.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:51:03 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreas.noever@gmail.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	lukas@wunner.de,
	linux-usb@vger.kernel.org,
	d@rrell.co
Subject: Re: [PATCH] PCI: Extend Apple Thunderbolt power quirk to Alpine Ridge
Date: Thu,  8 Oct 2026 23:50:47 -0300
Message-ID: <20261009025047.16129-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008231744.GA938694@bhelgaas>
References: <20261008231744.GA938694@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn,

Thanks for looking at this one as well, and for copying the Thunderbolt
folks.

On Thu, Oct 08, 2026 at 06:17:44PM -0500, Bjorn Helgaas wrote:
> Thanks for all this detail.  I think it's too much for a commit log,
> but it would be good to have it after the "---" where it's in the
> email but not the git commit.  This is easily accessible via the
> "Link: https://patch.msgid.link/" tag that we add when applying.

I'll move most of it below the "---" in v2 and keep the commit message
to the problem and the fix.

> Wrap these to fit in 80 columns like the rest of the file.  Ideally 75
> or so; that allows minor changes and typo fixes without overflowing.

I'll fix that in v2 too.

Before v2, though, I found something this week that changes the patch,
so I'd ask you not to apply this version.

The quirk works today partly by accident.  On resume, the firmware of
these Macs tries to write to the Thunderbolt controller through the
PCIe2CIO mailbox of its upstream bridge, and on Linux those accesses
currently go to the wrong device: ACPICA works out the PCI address of
the bridge's config region while the bridge's bus numbers are still
reset, and caches 00:00.0.  Each access then times out, which is where
most of the ~16 s noirq resume that Darrell reported comes from.  There
are two pull requests for this in ACPICA:

  https://github.com/open-acpica/acpica/pull/1235
  https://github.com/open-acpica/acpica/pull/1236

With that fixed, resume drops to about 4 s, but the firmware's writes
now succeed, and one of them sets bit 26 of dword 0x3c of the
controller's switch config space (VSC_CS_20 in the plug events
capability).  With that bit set, SXFP() really cuts power to the
controller, and on resume Linux does not bring it back.  With the
ACPICA change and this patch, and a USB disk attached, the controller
with the disk was lost in 3 of 3 suspend cycles, in two of them
together with the other controller, and resume took about 35 s.
Clearing the bit through the same mailbox before SXFP() runs fixes it:
15 of 15 cycles resumed in about 4 s with the disk still there.
Without the ACPICA change the firmware's write never lands, which is
why this version works as posted and in Darrell's tests.

I also checked whether the ACPICA change makes the quirk unnecessary.
It doesn't: in my test without the quirk, with the disk attached, the
link to that controller still did not come up after resume (LnkSta x0),
as described in the commit message.

So v2 would clear that bit before calling SXFP(), so that the quirk
keeps working once the ACPICA change lands.

Mika, I only know what this bit does from measuring it: with it set,
dropping the controller's power pin turns the NHI off; with it clear,
the NHI stays up.  Do you know what bit 26 of VSC_CS_20 is on Alpine
Ridge, and whether it is fine for the OS to clear it before cutting
power this way?  If it has a name, I'd like to use it in v2 instead of
a magic number.  And if you think this belongs in the thunderbolt
driver rather than in a PCI quirk, I'm happy to move it there.

Thanks again,
Francisco

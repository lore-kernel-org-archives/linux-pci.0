Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164C372EEF
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716677; cv=pass; b=os/QlsW4oTZN5dIAgxW7tgKPq5ZTjHbtlcooVeW88eF1icHJl/wRV/wdB50PDgkHn/9MZ2s1hApW5rxe49MBwEz3F5mMnGlHcJxKetAtm/HGU42HFflnTzFdYWkifnJUSmL7w39qcH5P62cVdaqKrms4vdRO6S0LYMOiLeupA2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716677; c=relaxed/simple;
	bh=8KwSNw9ZvtAfY1zVS+aFK1QsColh8+Nhq/ZwqSFiE4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLLLD3hDlaMo7OIhTw37XDUfZca5BC9YzUgBhxV+uWH1rqmAIlfFb5CBegHD2MakON21gKKGyF68XeDrX09A+OOQQFmZuymxKNcDmEQZn1omK/ujzfA+mXp8IVPU69Z+Z3ogfFDlUFhe2J/svFrO2N9175Pvo3+ZFAYi4fblh/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgzvKRU9; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgzvKRU9"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so235066466b.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 13:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783716674; cv=none;
        d=google.com; s=arc-20260327;
        b=Ntvjl26MWz+qO78emSP//oyS1xMtXpFUqJtGDirI3PU4gCc5cPnoAZ5wtIEfOK0v6Q
         UUDnW2u3r5+7ZxdrnetUgCaJhyxH/qa+b8w3dniwJWB1AoIH/nVSKFKL0UFdPz4eAwMz
         0sKVutlOI/Q3XM4gXtKIk+/6EABs+/XgJ5PcGOktyAeAtnuBPNqgg+FkFIa+9xmRB0Vb
         sDIamR1G0yucE7JM8Vkb0knHMb5z3fUaFegUR06yC+7B2pECdJ2pnYQSV2goYudQ76mB
         FmHT/0CezUkdQKeyveGSHiA8jZLGVyqhnEDyZN62DNgff1hdRmHWj6OKRCteMl5OMRJM
         /yUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DRDrRBW0ubLB217bZ0QmCG1vgcK+gxQZSNiEWvYeS2E=;
        fh=IE4wZ2WJ0MRjzR6agCh6J/ihAuPXftWyGH5XeV/PfeQ=;
        b=Qqux0bSSWjjLDL4lhY8pSCqRPD+zQyH/JiIdPGZ0ZthHvLZ0SO4PBSZVCJIJTgWC7R
         ZuGg7vEGeaB6t/0ZJctMyueZbdW1s+SmDFek2ueqSmSIXBqS0FiAUJ9f9GgScOQ8XfFo
         pkjv/VNXx2wUEt4e0hFeXbdph0s62tfjZI35gB+PmmnN7t1QCDEE5kNdGdD1GJwkY9Tw
         wdGIhJvKxfOLpJQzA697Omj7MmeV5t6p2WwvI2pY8RFVTpmYQJ6Lyb2WDzBFm4qh5zgL
         yko3goVY92aG6p7ZTWTL7peojwWGGhoFFHMbXiP6qGmfzk12MEYpttNzz7lbYvghbG6C
         GJsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783716674; x=1784321474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DRDrRBW0ubLB217bZ0QmCG1vgcK+gxQZSNiEWvYeS2E=;
        b=hgzvKRU9iamVxvGIovYxzKvQlAjX9WuOY3jyADhAaRRODVhdanP+SHI25WrGwnuESl
         2LzC8WskWe5nbuSl6yurAABSPkdrCtPh9Sv0u+Rb8Lo05/sMygGx2h1ba/klDIb2oFJD
         zMfwzG6KhpapTSKhnO8F31qKH9+HHrVjb4pNreKY89MbDc2Ov3eQ69/6gklMAas/YHCb
         DT4erM9ubK7E9U08qED3DKLSNJLw7nmyEuVX/RVT5ToltyvaeROP0NSxRDOH2n0JLTv4
         73a1O5Wlp2D3yVhA3id5Na4+syiSEAkiS0yMjFk5wkOyc9Z1YMI5cyuLxCS5bI/fcDLI
         GmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716674; x=1784321474;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DRDrRBW0ubLB217bZ0QmCG1vgcK+gxQZSNiEWvYeS2E=;
        b=PM2cR8d02qFEsM1wSkOazuuqdImxx+0/LR39YRY6sxtfKtENdyh+ocUG0eb/cX8JKU
         N+F/Glj5Mj1NMVBaS6dUl3sJQMVEgehmKWQ6ufVFVOg2WQnKRSmkErynmTkOB59vnlkA
         jDrpSOllVMPcnQyBXtzKsQsyhQ0Uedc6z9cTYTnJByNTkC9DikmGYVveeYGFM7by4Z6W
         OHEIvvLNj/+stCGG2YfRhR/qjztFR9+jj8PCzwqvhYjdSRyZk7PkhG5ZNq1aKQAMSAru
         ux/vZeTFi7Q7aZbKdTXJFH7ibSLVHVI2kLJ6vp4vS1Y5dNCLYvlSj0R3VtwTw/9W6QBn
         gz4A==
X-Gm-Message-State: AOJu0Yxid9hPVHaGAjhhsFIEr+5+6iM5cMKbhFG70QlYG1geumkwHm59
	rJMJaGt40wkg1ZkZGKt4ikz7c/78QngBx5UbPYhr6/JeIprZsn5kSs8abDsO5B/C1Ol7v+jltYD
	i+4FDgvQAz3yh4tAVU9Pak83VnwFo9Ks=
X-Gm-Gg: AfdE7cnMw0UlLjyPqCRMwGRU1LkiL8aQYSANj1/HVL2ltxA/fWSfIk82H+M+c5P4U1i
	Xwt/muOQfAlHUx8VYM4cycogIZbM+yzoj236/PveoLFENQ7p8lLw5CdB4lGeBeW08IUlfChnxw+
	zrym/kVpSSSn9VGZDeJh9NFAecx/NVs17jaDUNeS9F4/vClVM0A4RypcJCbSEaFqF4luZDbiBGj
	PdKWGoci6rb3E2hG6becogFLdLewI6ltaJw1flf/sUaz0Uz8ToGlD8EqDI0EB4npb34dNb3wNVN
	LFd6cTes2Bp57oVyrA4JhmCl7J0EWD0sR+CDhUpUBKuaXOwTJ6yymO4XClEz7s+NB5LSqQUj5du
	dDRuhNZ35MmXAkcAS76hwmSSCtS0R6LbxkM8vplXeDq5X0bX1V+WbhZP5ylNwlhFOJuk25Kmkgx
	/hoL/Oo0E=
X-Received: by 2002:a17:907:70c:b0:c16:318:34e3 with SMTP id
 a640c23a62f3a-c161e8b6fc9mr17341366b.16.1783716673437; Fri, 10 Jul 2026
 13:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707221800.920270-1-rosenp@gmail.com> <20260710204650.GA998073@bhelgaas>
In-Reply-To: <20260710204650.GA998073@bhelgaas>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 10 Jul 2026 13:51:01 -0700
X-Gm-Features: AUfX_mwMVs6IULTLy8XjiW5wkECCK28UHifagBkQFQ3cmlTMKU0LDFLDNhi-y9c
Message-ID: <CAKxU2N-_HuWVAZznMBqFVde4cKyF=uM_skeW1fZ8xkmLjbFN3Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] x86/pci: consolidate x86-specific PCI quirks into arch/x86/pci/fixup.c
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 1:46=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Jul 07, 2026 at 03:17:52PM -0700, Rosen Penev wrote:
> > This series moves all x86-specific PCI quirks from the generic
> > drivers/pci/quirks.c into arch/x86/pci/fixup.c, where they
> > architecturally belong. This reduces the ifdef burden in the generic
> > quirk file and improves build granularity by gating the x86 fixups
> > behind CONFIG_PCI_QUIRKS.
> >
> > The series is organized as a preparatory commit followed by one
> > commit per vendor/family, keeping each move reviewable.
> >
> > Suggested by: https://lore.kernel.org/all/20161221142607.GA8594@infrade=
ad.org/
> >
> > Rosen Penev (8):
> >   x86/pci: gate arch fixups with CONFIG_PCI_QUIRKS
> >   x86/pci: move Intel chipset quirks to arch/x86/pci/fixup.c
> >   x86/pci: move VIA chipset quirks to arch/x86/pci/fixup.c
> >   x86/pci: move SiS chipset quirks to arch/x86/pci/fixup.c
> >   x86/pci: move ALi chipset quirks to arch/x86/pci/fixup.c
> >   x86/pci: move AMD x86 chipset quirks to arch/x86/pci/fixup.c
> >   x86/pci: move x86 ifdef-gated quirks to arch/x86/pci/fixup.c
> >   x86/pci: move remaining x86-specific quirks to fixup.c
> >
> >  arch/x86/pci/Makefile |    2 +-
> >  arch/x86/pci/fixup.c  | 2284 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h     |    3 +
> >  drivers/pci/quirks.c  | 2330 +----------------------------------------
> >  4 files changed, 2316 insertions(+), 2303 deletions(-)
>
> I don't object to any of this from a PCI perspective, so I guess it's
> up to the x86 folks if they want them.
>
> It looks like the typical subject line style in fixup.c is:
>
>   x86/PCI: <Capitalized-first-word> ...
I'm guessing this means I should resend.

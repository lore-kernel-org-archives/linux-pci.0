Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082E3D667D
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838000; cv=none; b=EkIJZHwgqBwGM7GqdxD5QvSf/c3GChTZDt+AhpsExU/05sFToXln1rWaNB1EXRnETJSKog8GuzSh5bVAGuUUVvl7kKiVcmTAEQLzfnCM86lXOBXPiityeboZG2Ti3bO9nbDeEgBPMAGMVItqH9BOQUS1f0zpR3jakm+uccMpQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838000; c=relaxed/simple;
	bh=3lhSpybk076lhP/tF6VcHyFgOH8VT94fKpwZHP+yAMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TfUX5TlqhyilWblG56zOHrvhzmzDWBguOm4Ryn5cgIpcTMQMWpi5r4B5S63MXMo+7Q07E8j4wejO3UwddBhODHH0U0hAYOn48D/7IbP+0rwDyXr+LT0ZPMRHetgGbDdyl/LB/bInZS2tAqSdX8SIp5rNxC07x75OmbIulQt0E3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i29geCEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i29geCEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB281F000E9;
	Tue, 30 Jun 2026 16:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782837998;
	bh=/7sJO+x51loqBixWHyWWmP7TVxsz35BRSb2SKJ8HnWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i29geCEjfchiZJak084Hx00YADK+l5v8aRTFqgtLOQvJHnB81vEvqGfxh5vH89YzQ
	 iobR0HUtJGhJkru/7sESmX29XdZDhORJt/G2uuo2OEiDj+JZvvsJ/CNGfea+Tdi3F9
	 cvwcq6ys/pUmNDyDGv0TGQNrcfFC5KSm1sUy5Hd6s7o7IRLZQoi5t2lr2zDtFtLn7U
	 9hQ7liP41ylEpUzYvnXsQWGZ3Cp3EM26eL2tKE1a6g76jqXQ0VdHBhRVJlvzqvW1LQ
	 e7OJdH7ngNOSH1m+w0o2maVVhf1APkxB+eItGataVv1hE/hr96xVzpilBRV2PE1XXK
	 7eCgNPluni0Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/VGA: vgaarb: Hold pci_dev references for per-file
 cards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuangpeng Bai" <shuangpeng.kernel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <86061f17ea5f1fb76791ca5cc787ce84b6752f46.1782788237.git.shuangpeng.kernel@gmail.com>
References: <330FD8DD-ECBF-4531-900E-5B976FA9DF90@gmail.com>
 <86061f17ea5f1fb76791ca5cc787ce84b6752f46.1782788237.git.shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 16:46:38 +0000
Message-Id: <20260630164638.8FB281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent `lock`, `unlock`, and `trylock` commands in `vga_arb_wr=
ite` cause data races on `uc->io_cnt` and `uc->mem_cnt`, leading to global =
resource leaks or severe CPU stalls (Denial of Service).
--

commit 17b88a219897b83c9eda1acce8ef44e9f9f96033
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

PCI/VGA: vgaarb: Hold pci_dev references for per-file cards
   =20
The VGA arbiter stores pci_dev pointers in each /dev/vga_arbiter file's
private state to track the target device and per-card lock counts. This
patch ensures each tracked non-NULL cards[] entry owns a pci_dev reference
to prevent KASAN use-after-free bugs if the device is removed via sysfs.

Closes: https://lore.kernel.org/r/330FD8DD-ECBF-4531-900E-5B976FA9DF90@gmai=
l.com/

> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -1422,8 +1468,9 @@ static int vga_arb_release(struct inode *inode, str=
uct file *file)
[ ... ]
> @@ -1439,9 +1486,15 @@ static int vga_arb_release(struct inode *inode, st=
ruct file *file)
>  		if (uc->pdev =3D=3D NULL)
>  			continue;
>  		vgaarb_dbg(&uc->pdev->dev, "uc->io_cnt =3D=3D %d, uc->mem_cnt =3D=3D %=
d\n",
>  			uc->io_cnt, uc->mem_cnt);
>  		while (uc->io_cnt--)
>  			vga_put(uc->pdev, VGA_RSRC_LEGACY_IO);

[Severity: High]
This is a pre-existing issue, but can concurrent calls to vga_arb_write()
with unlock commands cause a denial of service here?

If userspace uses pwrite64 or io_uring to issue concurrent unlock commands
on the same file descriptor, two threads can simultaneously pass the
uc->io_cnt !=3D 0 validation check in vga_arb_write().

Because the decrement happens locklessly after a blocking call to vga_put():

vga_arb_write() {
        if (io_state & VGA_RSRC_LEGACY_IO && uc->io_cnt =3D=3D 0) {
                ret_val =3D -EINVAL;
                goto done;
        }
        ...
        vga_put(pdev, io_state);
       =20
        if (io_state & VGA_RSRC_LEGACY_IO)
                uc->io_cnt--;
}

Both threads can execute uc->io_cnt--, which underflows the counter to
UINT_MAX.

When the file is closed, vga_arb_release() executes this loop:

while (uc->io_cnt--)
        vga_put(uc->pdev, VGA_RSRC_LEGACY_IO);

This loop executes ~4.29 billion times while holding the vga_user_lock
spinlock with interrupts disabled, completely stalling the CPU.

Does this resource counting need to be properly serialized or converted to
atomic types to prevent a hard lockup?

>  		while (uc->mem_cnt--)
>  			vga_put(uc->pdev, VGA_RSRC_LEGACY_MEM);
> +		pdevs[nr_pdevs++] =3D uc->pdev;
> +		uc->pdev =3D NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/86061f17ea5f1fb7679=
1ca5cc787ce84b6752f46.1782788237.git.shuangpeng.kernel@gmail.com?part=3D1

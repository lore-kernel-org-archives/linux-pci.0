Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719E3559F5
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728709; cv=pass; b=Q7cVYXJ53To5apQK4O3Zrzhw932CiTZzw6wJ7VQ8LbNlSiRr2TbDwVP5hcmdL73rbR3i/3217Mp898iDuzbwrIMUc5j0LjyMi6DK+x1jFFrpg6UsAkV93q7pyNY1olTkhABZSObKGClfOGXxCeF6IvigcgSmK1A85/R6sVVFmE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728709; c=relaxed/simple;
	bh=5mBT8E4RWUEdTarUy5JzdlsWHtau/GUsLV7Pb+ZaKoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9tOhyX9Ilzv0qDEBWpejCDbZ42WuZ98qf3yrw5RX2MdrJhvsn5Zc/dOtu9U6old4Lo3FBZ8HhLpyyQfxTLfSeVeWAXkQ+H+PqzbsCTMC/MHw3AvxACveqTYPJbC7r7+XyYbxTI8gv5DJeuu+BnHMylU/FOH0+k7iUWVeCpwQy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Azirvg5b; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Azirvg5b"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8f9568e074so743310166b.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 23:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773728705; cv=none;
        d=google.com; s=arc-20240605;
        b=VPIBbWuTLAshwtE4Opp0w2eg2E2pZM1xH7lhSPahe2yYhOI938WDnz/nsWYuaY6GNE
         hTP94GSTtilOVLi9cdKp+L0Vn3axvF5UbrSBMLhxZghWbZNk6ycX0ThJmRhFyWnahbJc
         +MkdjXEUA/EPotsexVeOVm1koUiA8hFYkVIqgCnsBBkAAIp6P17/o378opCKGuH26nFM
         9rUO+mwU/LvQ0uJsbDF19m9u5VAl3E1+tVgwgbUzCrnKMCYD1DAG8BArqwEFF3PiQxJT
         /GF5XKus8/WsYeAYvndpsTU0BMHnYR+T2PBIiua4amj9aidzj8tU6xq0KOI9VMqKGwmv
         oaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=grG6esplvyUewgvA3Y3jc/bN8nKq9yVtK9UsxaYqAWg=;
        fh=xOGCmfHd/CAHNlOpCFcgHjfYqyOQOqB5khHl7xpBYeI=;
        b=b9AB0lB38eYZxiW4viNN2HTjn/K4z9IAeGhV6bA0IUCjJlynxLRLV1OFGVXv8VH9Z9
         kLCv2MJ9LqFn1KKBRFONE3plV9Ki6OwFgWUUPgyzFhz/AwZkWVbDM2CagOmwuqaAFcgj
         SN+i+u9U2hJ29+CNuBfD+sD6uJYClQJrFGqLfnB+skH5BNCJAsYZB82joxvuvU3X7iKP
         JGjOWwVjv9PFvSrA/c7cnYhsrS8eQs6fXL/v/wbtAT3hLVzaUtf8vVU8DYsH9r8nPHZ3
         GYA4Krq7TO8OImZf1+DVmnRbYeKr9AV9/HUktxOunX1Pm1guOoWdcCn45LNcD4HTwxAT
         Jveg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773728705; x=1774333505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=grG6esplvyUewgvA3Y3jc/bN8nKq9yVtK9UsxaYqAWg=;
        b=Azirvg5bSY7O9GWouVsRqcRbKvy/Q/netns7h+b1OJzx9aYXHOgOIkNVknJRTbVleC
         7muaPP9Q4z2HN56FxjoRiVF3J96Jq9lxenIOegS+IevZOaFdi327tJ8e8nka1+l1FfSP
         GjB+NfEuGr+zQ/WkLlHKfGSJABP6cv7ONY4i/6aCvygtDtVjlg36bYpYGWmRr6/lKx7N
         T/hPF4AV/j2RUJi0vfQC/7lgj7L/2Vx6ixVwAITvpaetsiiXuL3COtnZxllE+4LkiwHe
         wG3n6EA86ePWeO0c1t4Jz7ASYfbMp9OSXWmYZ1ymsycIq9h4wHmOWn/INWkYkr2as8Rk
         Ej0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773728705; x=1774333505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grG6esplvyUewgvA3Y3jc/bN8nKq9yVtK9UsxaYqAWg=;
        b=iYa8/HiAodIvHnm0KRvuJE3IepdfLcfJET/6tIPilE+1CWSy6xYJE4VRZMA8zkShNW
         sZIPUTmFTFOXBDMSijV5YApfxeRzWsN9UKeMSm9OILQ53P3xsLZfdgE0dwFplasMykWA
         gR7HMJ4DxrXlyPlzT69yJSDbPZbKTJaYAj+egmzdy5LurEyqbtUZ7rDgfDjRyj7dJbKu
         QrwTq79t8n2V5/tSv09Ie6QG8gm764tdaplFjlb2IndUbY3+gelnQbkx7EZUoIIqhXN5
         X8NxVx1ex7ndKMHdlGHZfJwXZOuaZ9UYMPBuaF3oJxn+NLZjtBNjXd0iavEIAtxbKYXM
         3vfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLjsK5y4rOf8mKqwmuzNmTRuMBZ3FMep0Jvs7F3M4iOBKlsRBHusE5nqx0kKOJvwZMZEFHFLoIxuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNRCU2NndfLD/1tVNwCq02nLxiGR6XCgyooWUuAV9pVnWXZ/F
	8A4uouE3BkkNGJz5wkWy460T2lY6eU4ZYWyjwe2EHAqqmddIS2buvn4JYQBeb0erZlTdwLz2bXV
	V2jeh3O0HEXNl+A/rn9zO2YrH0zF+Pas=
X-Gm-Gg: ATEYQzxORtMuBGUXaRXM9EsrnpzK7ODGiRAjQhaOoRSEI5n4wrKXhL2jc5z1P+q+AKz
	Rz7Vm+0e2J0YYHiliuWDrIClBk8nMiZo+owfSwdIpT+8gOvqbj5oaUqM8vx+qDRpPgyDU7U+NXE
	Iw1SQIYS3gs+ezRLUj5p7pcT2DiYPUi0Wvh4IYiRvEDX4o+t0XshNtlWImHNvAujJqMmsc+AAS6
	GX18w+Vr1K/+AYzEpYlIdjg+zuLMMJZ+Dz6GVcENJQQGsoGqH6akk0aJ4C6oRk0G4gBSLvES9Xi
	a5L+KA==
X-Received: by 2002:a17:907:a42:b0:b97:17b7:d8eb with SMTP id
 a640c23a62f3a-b9765392026mr1010186466b.38.1773728704481; Mon, 16 Mar 2026
 23:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226101032.1042-1-linux.amoon@gmail.com> <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com> <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com> <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org> <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org> <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
 <DH0TM60TVX5D.20W4O1X696ALA@kernel.org> <6cfe4bda-036f-4bb9-8a08-ed75f61cae24@arm.com>
 <DH1QCLS89ADR.3H0XABP0GEFQT@kernel.org> <4f9fdfc9-f2ad-49b1-a6b9-ae64aaa47cfd@arm.com>
 <CANAwSgQ6eaM=Z=MBmS0=HrLfBxOh+vqnRSkEge_q6y+oe7AU5w@mail.gmail.com>
In-Reply-To: <CANAwSgQ6eaM=Z=MBmS0=HrLfBxOh+vqnRSkEge_q6y+oe7AU5w@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 17 Mar 2026 11:54:47 +0530
X-Gm-Features: AaiRm52xTModvcS_wCghjufMEmds7Entym6jtUGNfqUcYmHWBvki21yZ4UCg2r0
Message-ID: <CANAwSgTVw7Tn7ZHFBqdHkZHbuTDSgbt5L_rhrVVtRwQu7ZS+tw@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Robin Murphy <robin.murphy@arm.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Grimmauld <grimmauld@grimmauld.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Sat, 14 Mar 2026 at 10:42, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Robin,
>
> On Fri, 13 Mar 2026 at 23:07, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2026-03-13 2:39 pm, Danilo Krummrich wrote:
> > > On Fri Mar 13, 2026 at 2:15 PM CET, Robin Murphy wrote:
> > >> On 2026-03-12 12:59 pm, Danilo Krummrich wrote:
> > >>> On Thu Mar 12, 2026 at 1:48 PM CET, Robin Murphy wrote:
> > >>>> On 2026-03-11 9:09 pm, Danilo Krummrich wrote:
> > >>>>>    From a driver-core perspective I think we're rather limited on what we can do;
> > >>>>> we are already in async context at this point and can't magically go back to
> > >>>>> initcall context.
> > >>>>>
> > >>>>> So, the only thing I can think of is to kick off work on a workqueue, which in
> > >>>>> the end would be the same as the deferred probe handling.
> > >>>>
> > >>>> Hmm, in fact, isn't the deferred probe mechanism itself actually quite
> > >>>> appropriate?
> > >>>
> > >>> Yes, I've also mentioned this in [1], including the fact that it technically
> > >>> even complies with the guarantees given by PROBE_FORCE_SYNCHRONOUS. I.e. the
> > >>> documentation says:
> > >>>
> > >>>     Use this to annotate drivers that need their probe routines to run
> > >>>     synchronously with driver and device registration (with the exception of
> > >>>     -EPROBE_DEFER handling - re-probing always ends up being done
> > >>>     asynchronously).
> > >>>
> > >>> However, I'm still not sure how I feel about this, since I consider this to be
> > >>> more like a workaround that just moves things to a "more approprite" async
> > >>> context.
> > >>
> > >> I guess the underlying problem there is that there are at least 3
> > >> different significant aspects to what "synchronous" can mean:
> > >>
> > >> - literally in the context or device/driver registration as documented.
> > >> Off-hand I'm not really sure what useful property may be *specific* to
> > >> those conditions that a driver might rely on, other than for
> > >> super-special cases like platform_driver_probe().
> > >
> > > I'm not worried about this one, as it is already special by not being compatible
> > > with deferred probe. I.e. the caller already has to promise that the
> > > corresponding probe() call will never return -EPROBE_DEFER.
> > >
> > > This is a much more error prone requirement than just "don't call this from
> > > async" already.
> > >
> > >> - serialised, i.e. probes of multiple devices won't happen concurrently
> > >> on multiple threads. This is probably the one hiding the most driver
> > >> bugs, e.g. internal shared/global state without sufficient
> > >> synchronisation. I guess this falls out as a side-effect of the first
> > >> condition, but AFAICS it *can* also still provided by deferred probe
> > >> (given that it's a single work item iterating a list one-by-one)
> > >>
> > >> - in some regular thread context that isn't liable to have issues
> > >> synchronising against other async_func workers (i.e. the request_module
> > >> case). Again, deferred can't have a problem here, or it wouldn't have
> > >> worked properly in general for the last decade.
> > >>
> > >> So it's not that we'd be relying on some dubious "deferred is always
> > >> synchronous" assumption - AFAICS deferred *can* launch async if the
> > >> driver permits it - more just ratifying that deferred is still able to
> > >> effectively honour all the useful properties of PROBE_FORCE_SYNCHRONOUS
> > >> other than "during registration of the thing".
> > >
> > > Yes, and as mentioned above, EPROBE_DEFER has always been a valid path for
> > > PROBE_FORCE_SYNCHRONOUS, which is why I brought it up as a a workaround in the
> > > first place.
> > >
> > > (The reason why I still say "workaround" is because nothing actually needs to be
> > > deferred.)
> > >
> > > Anyways, as I mentioned...
> > >
> > >>> On the other hand, eventually we want everything to work with
> > >>> PROBE_PREFER_ASYNCHRONOUS, so maybe it's also good enough for the time being.
> > >
> > > ...plus there are not a lot of PROBE_FORCE_SYNCHRONOUS left anyways.
> > >
> > > Do you want to send a patch?
> >
> > Sure, I just wanted to check that you didn't see anything obviously
> > wrong with my reasoning-by-inspection - if you're sufficiently happy
> > then I'll write this up as a proper commit message and post the patch
> > (likely on Monday now) so we can all nit-pick the details :)
> >
> I believe the issue lies in the r8169 module, which currently has the
> PHY address hardcoded to zero in mdiobus_get_phy. I have modified the
> implementation to scan the MDIO bus for all possible addresses to improve
> hardware compatibility.
>
> Can you check this at your end.
>
> ----->8-----
> $ git diff drivers/net/ethernet/realtek/r8169_main.c
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
> b/drivers/net/ethernet/realtek/r8169_main.c
> index 58788d196c57..fa99e33eccfe 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5420,7 +5420,8 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>  {
>         struct pci_dev *pdev = tp->pci_dev;
>         struct mii_bus *new_bus;
> -       int ret;
> +       struct phy_device *phydev;
> +       int ret, addr;
>
>         /* On some boards with this chip version the BIOS is buggy and misses
>          * to reset the PHY page selector. This results in the PHY ID read
> @@ -5455,18 +5456,30 @@ static int r8169_mdio_register(struct
> rtl8169_private *tp)
>         if (ret)
>                 return ret;
>
> -       tp->phydev = mdiobus_get_phy(new_bus, 0);
> -       if (!tp->phydev) {
> +       /* find the first (lowest address) PHY on the current MAC's MII bus */
> +       for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
> +               struct phy_device *tmp = mdiobus_get_phy(new_bus, addr);
> +               if (tmp) {
> +                       phydev = tmp;
> +                       break;
> +               }
> +       }
> +
> +       if (!phydev) {
> +               dev_err(&pdev->dev, "no PHY found on bus\n");
>                 return -ENODEV;
> -       } else if (!tp->phydev->drv) {
> -               /* Most chip versions fail with the genphy driver.
> -                * Therefore ensure that the dedicated PHY driver is loaded.
> -                */
> +       }
> +
> +       /* Most chip versions fail with the genphy driver.
> +        * Therefore ensure that the dedicated PHY driver is loaded.
> +        */
> +       if (!phydev->drv || phy_driver_is_genphy(phydev)) {
>                 dev_err(&pdev->dev, "no dedicated PHY driver found for
> PHY ID 0x%08x, maybe realtek.ko needs to be added to initramfs?\n",
>                         tp->phydev->phy_id);
>                 return -EUNATCH;
>         }
>
> +       tp->phydev = phydev;
>         tp->phydev->mac_managed_pm = true;
>         if (rtl_supports_eee(tp))
>                 phy_support_eee(tp->phydev);
>
> > Cheers,
> > Robin.
>
I've submitted a patch to address the issue you reported.
Could you please verify if this resolves it on your side?

[1] https://lore.kernel.org/all/20260317061700.7734-1-linux.amoon@gmail.com/

Thanks
-Anand

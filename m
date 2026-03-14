Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F342D3EE5
	for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 05:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773465199; cv=pass; b=YzGXBgrwlIT7NXwXiOMtF2lXkCFNhsPF30fbE4iZf7AXR4PM2IxNuPusJJR5CzUsEB8ddIDOamIAE5SyJ+HdjMAvkQ9cdJHl2rR+iAlmcUqdK1r+KJ9xhXKv8bVy0xcYwXIkJVKbLVW9vcDBNj3gcYP5bAnY6t4MWbj9BCcGfgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773465199; c=relaxed/simple;
	bh=SzQIXiO7WCG8WN+IgnhZr8P9l0vaLniDCPkwpiqXiHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rkf/6fl2FJTooND2UXiGZ4QXJdS1BzM1qyNH8WlcTPOZw+3m/6B7J2EJTAOqRkFZWnHF7kh3dG9sIB71S6g9rQHTY/TAXyGmGcXLEO29LqqSn5bAtqgx2EMdUJ4aGcIeqHmKLZsWolJ8/11qmMqN232uh5DSYi+BuljBTBYYY6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTPNRrey; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTPNRrey"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6640e55d366so1833876a12.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 22:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773465195; cv=none;
        d=google.com; s=arc-20240605;
        b=eEzyjJzwBKtLKNhMO7FsI1UdQsIgBwc08mR3bI80FaOq4KA2ZSA60l6JXI+ZqVjA+r
         Fphs+BWAC6+1hol+hVEJJXmSeALVWKiwyIVMyv3Nr/aiUK9aWqvibkLUQB2aMA5fHPZ1
         sd2xNU0QuW8cDfoV6axt14YQAvoSkL6QOZq/Z7JW+lunAvkE79Sb3Mb62Zqw2BpUOsn9
         sasXPU/uU4Fz6DsEWfkfxp+76EU8x9J0UQIONOAsfo+p1gNDPzp9bxPJe2FPz6TsMReb
         rll6IMQIO9M5HG0OHG5XH9j9oGMSpYlWU5kB84JzzKkZ+pnex1H6Ym2SzkTbW6XEhTti
         E6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IM7Q6oOyb5nhIw60KEs5pEzxBNhlQ40PGDtJzVWEr0o=;
        fh=e/N4VifZ1tGR80416/yzQX+jEh+R4HWW6RsG7RaiU0A=;
        b=PRM0cZYEiMInNPDdRWcVMaQFg6uvVUE7QB7S4vrj4TlwlC0CWYHRoxZK2LBkSFPu/l
         4hbvoCnAsTW/zosngljMs3f9bALHtFF4GNYSVozPCu3hkR94enc20XdFeRMIHsCeIFL6
         KqMSBVMJwF+8XOwmFj3Bw+8QVgco2pym7DhsrRGF1ookG4HIVdHKJU4WHDLlXY5JfTpq
         FF1IDNAThgRthbUdX7tp1yV4//E9DvweXwDFQf6HgewtRGjKV3kYiMZDYT9oMQgTvH+V
         KC7vUirXtFj/WcDtky46WJeF1XPCQ0+BRhQyE1+Szjlqx50wYk/co01mw9DMdx5s7eSa
         bo5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773465195; x=1774069995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IM7Q6oOyb5nhIw60KEs5pEzxBNhlQ40PGDtJzVWEr0o=;
        b=LTPNRreyiRVF0GtI7csZFOAZDntp2FXr1kZG1o33bQoOm2fbWU2UBN8SFfL7wObn40
         e3/Cqwo/zVoLBZPh93xiYWVrCpDvlY8tEoH09kmmOcqUiKrc6R9UxC/V2xxebPlAem+b
         XXh3Ep1mfPiJ7ShMHYtSakiIwLdtTBk896jR0fEMSJ5J7HtmAlc2hDtLsZ5gsxMUhKfO
         AtTnbfyT86uSWMHkXQEkZMr4LcUtTIimfom+ooBEMyCzYu86E6w1Mo2tgxOWEoT3TAn+
         O9dPfgD5T1BcvwIXjwQnxiY3eG8lCSurOdVY5o9l2C2rEoChyWnxvHwA60Htbu81HT09
         9v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773465195; x=1774069995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IM7Q6oOyb5nhIw60KEs5pEzxBNhlQ40PGDtJzVWEr0o=;
        b=qaZaSq/EcSA9SNzw5sO1LXJXu767+7n/XLG3RCMqeUTRPBxB/bk/4VsMCgcNcJu3bH
         Xu7YbKAIDf1XQl9yXjI0KKVlPR8gXNjDTZgTSOtzQr3fdjc5E0ZPgxd7++QF68qPAiFn
         H2k1vzGAKwfgwuXEMY9BMcyd4bfJNevEXSjZkZzrQhAzrNVLB14qqj+5w7EpUPWPXjJe
         STmTmLPlB4NvLTvSS4myacKQDFwE9n31rs81+oC0T//F/gM4TYT4tMv72SJb6ioomYF0
         xAEEB4OeQRSaxDkqedZM9HhjWXdEbJryB9sthGvn+dBrG1Yum+WF9jYG9/7PCtr6R3KB
         se8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUd+hAEh8d6Y4Ctj1JdpoBXIiK748TKmKYaKKndn3WHcRTdb0yUqNOC7/DZHPjzTHfUhdh5KBfZ0wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr0OcPyoE8x21wwI9LBaxsI5zlL1O4utu26d9I4I+4LOE+UxoC
	Zm8E74th8M7Pvj4vUv9UALLS1xrr8iNA8jpjSwaNxMFIHtGbMozu/ec03uSVai+IRU3RjlEwffJ
	KsQJvHgSx67PnLouLbILIfxabQEd3kkI=
X-Gm-Gg: ATEYQzxw3IjoRJIdICfXxtZgEfkzatNzkhvBefrsRKtLgPyDo27qZDqjY2u3fAulp8z
	VDKq9nCsMJ6B+YNja5jCn8ChbaZMWiBwwGWF8+3dESKCjd79gcI98Lo5jvu2vS28tmandegy/yW
	XAJiLzDNsfnjMECLqIIwraGppeN5SI3CygOqPlUIeDuhaS4oxdDRyGoBETKSUQmVVm6H/udK0DM
	8s337ChldR1yqfrrFzZU1XUx8+wb3J85aUerQA4iMKM+morwzMoRImLEqF08savshY94kCyxLsX
	vIDj1w==
X-Received: by 2002:a17:906:208f:b0:b8e:796a:fd5c with SMTP id
 a640c23a62f3a-b976506440amr202919666b.27.1773465195027; Fri, 13 Mar 2026
 22:13:15 -0700 (PDT)
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
In-Reply-To: <4f9fdfc9-f2ad-49b1-a6b9-ae64aaa47cfd@arm.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 14 Mar 2026 10:42:58 +0530
X-Gm-Features: AaiRm52yI10E6vLq92rcORMoPK2tRdzWpVlxX3dbSjvIMnFFuSiMh3dLe0uhnRo
Message-ID: <CANAwSgQ6eaM=Z=MBmS0=HrLfBxOh+vqnRSkEge_q6y+oe7AU5w@mail.gmail.com>
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

On Fri, 13 Mar 2026 at 23:07, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2026-03-13 2:39 pm, Danilo Krummrich wrote:
> > On Fri Mar 13, 2026 at 2:15 PM CET, Robin Murphy wrote:
> >> On 2026-03-12 12:59 pm, Danilo Krummrich wrote:
> >>> On Thu Mar 12, 2026 at 1:48 PM CET, Robin Murphy wrote:
> >>>> On 2026-03-11 9:09 pm, Danilo Krummrich wrote:
> >>>>>    From a driver-core perspective I think we're rather limited on what we can do;
> >>>>> we are already in async context at this point and can't magically go back to
> >>>>> initcall context.
> >>>>>
> >>>>> So, the only thing I can think of is to kick off work on a workqueue, which in
> >>>>> the end would be the same as the deferred probe handling.
> >>>>
> >>>> Hmm, in fact, isn't the deferred probe mechanism itself actually quite
> >>>> appropriate?
> >>>
> >>> Yes, I've also mentioned this in [1], including the fact that it technically
> >>> even complies with the guarantees given by PROBE_FORCE_SYNCHRONOUS. I.e. the
> >>> documentation says:
> >>>
> >>>     Use this to annotate drivers that need their probe routines to run
> >>>     synchronously with driver and device registration (with the exception of
> >>>     -EPROBE_DEFER handling - re-probing always ends up being done
> >>>     asynchronously).
> >>>
> >>> However, I'm still not sure how I feel about this, since I consider this to be
> >>> more like a workaround that just moves things to a "more approprite" async
> >>> context.
> >>
> >> I guess the underlying problem there is that there are at least 3
> >> different significant aspects to what "synchronous" can mean:
> >>
> >> - literally in the context or device/driver registration as documented.
> >> Off-hand I'm not really sure what useful property may be *specific* to
> >> those conditions that a driver might rely on, other than for
> >> super-special cases like platform_driver_probe().
> >
> > I'm not worried about this one, as it is already special by not being compatible
> > with deferred probe. I.e. the caller already has to promise that the
> > corresponding probe() call will never return -EPROBE_DEFER.
> >
> > This is a much more error prone requirement than just "don't call this from
> > async" already.
> >
> >> - serialised, i.e. probes of multiple devices won't happen concurrently
> >> on multiple threads. This is probably the one hiding the most driver
> >> bugs, e.g. internal shared/global state without sufficient
> >> synchronisation. I guess this falls out as a side-effect of the first
> >> condition, but AFAICS it *can* also still provided by deferred probe
> >> (given that it's a single work item iterating a list one-by-one)
> >>
> >> - in some regular thread context that isn't liable to have issues
> >> synchronising against other async_func workers (i.e. the request_module
> >> case). Again, deferred can't have a problem here, or it wouldn't have
> >> worked properly in general for the last decade.
> >>
> >> So it's not that we'd be relying on some dubious "deferred is always
> >> synchronous" assumption - AFAICS deferred *can* launch async if the
> >> driver permits it - more just ratifying that deferred is still able to
> >> effectively honour all the useful properties of PROBE_FORCE_SYNCHRONOUS
> >> other than "during registration of the thing".
> >
> > Yes, and as mentioned above, EPROBE_DEFER has always been a valid path for
> > PROBE_FORCE_SYNCHRONOUS, which is why I brought it up as a a workaround in the
> > first place.
> >
> > (The reason why I still say "workaround" is because nothing actually needs to be
> > deferred.)
> >
> > Anyways, as I mentioned...
> >
> >>> On the other hand, eventually we want everything to work with
> >>> PROBE_PREFER_ASYNCHRONOUS, so maybe it's also good enough for the time being.
> >
> > ...plus there are not a lot of PROBE_FORCE_SYNCHRONOUS left anyways.
> >
> > Do you want to send a patch?
>
> Sure, I just wanted to check that you didn't see anything obviously
> wrong with my reasoning-by-inspection - if you're sufficiently happy
> then I'll write this up as a proper commit message and post the patch
> (likely on Monday now) so we can all nit-pick the details :)
>
I believe the issue lies in the r8169 module, which currently has the
PHY address hardcoded to zero in mdiobus_get_phy. I have modified the
implementation to scan the MDIO bus for all possible addresses to improve
hardware compatibility.

Can you check this at your end.

----->8-----
$ git diff drivers/net/ethernet/realtek/r8169_main.c
diff --git a/drivers/net/ethernet/realtek/r8169_main.c
b/drivers/net/ethernet/realtek/r8169_main.c
index 58788d196c57..fa99e33eccfe 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5420,7 +5420,8 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 {
        struct pci_dev *pdev = tp->pci_dev;
        struct mii_bus *new_bus;
-       int ret;
+       struct phy_device *phydev;
+       int ret, addr;

        /* On some boards with this chip version the BIOS is buggy and misses
         * to reset the PHY page selector. This results in the PHY ID read
@@ -5455,18 +5456,30 @@ static int r8169_mdio_register(struct
rtl8169_private *tp)
        if (ret)
                return ret;

-       tp->phydev = mdiobus_get_phy(new_bus, 0);
-       if (!tp->phydev) {
+       /* find the first (lowest address) PHY on the current MAC's MII bus */
+       for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
+               struct phy_device *tmp = mdiobus_get_phy(new_bus, addr);
+               if (tmp) {
+                       phydev = tmp;
+                       break;
+               }
+       }
+
+       if (!phydev) {
+               dev_err(&pdev->dev, "no PHY found on bus\n");
                return -ENODEV;
-       } else if (!tp->phydev->drv) {
-               /* Most chip versions fail with the genphy driver.
-                * Therefore ensure that the dedicated PHY driver is loaded.
-                */
+       }
+
+       /* Most chip versions fail with the genphy driver.
+        * Therefore ensure that the dedicated PHY driver is loaded.
+        */
+       if (!phydev->drv || phy_driver_is_genphy(phydev)) {
                dev_err(&pdev->dev, "no dedicated PHY driver found for
PHY ID 0x%08x, maybe realtek.ko needs to be added to initramfs?\n",
                        tp->phydev->phy_id);
                return -EUNATCH;
        }

+       tp->phydev = phydev;
        tp->phydev->mac_managed_pm = true;
        if (rtl_supports_eee(tp))
                phy_support_eee(tp->phydev);

> Cheers,
> Robin.

Thanks
-Anand

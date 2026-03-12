Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE263314C2
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315627; cv=pass; b=ChdQMN4gocfYFGlXO9mH6EScrLUdmKTR2VK56ShWUMStETIq6HyDRQCSoIfNw18YUkDNlxBLN5lkMzpHZYrvY5BVx2p0Dp3/tEwIoUnOxqsor7y1yv9jOFVavX+DJKuLNqXa2mj8Va+GV1OlFwTWb27VuFCs/9Ej1KSJvDL4SAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315627; c=relaxed/simple;
	bh=2TPSG+XCAoBTjV6kl8Kgjsjnn5MIxqg/Bno09qD0lBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgoKpW5rSPatFi2xDcU2dNPSVUVrpOa269onSKM7nG1mt/RryxIvIkfzMewUdfC5+BgPLJK7Wm56PyO8okeDkn+rv6LBwO9zloRL5VfLh2R2b1yOGomeSVE1WUEevtFFDTawVDY+tnBjFfBkn/1lcpSN0Thh2cfAOhwvhBvpUlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAvmaTiT; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAvmaTiT"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b943a880577so117883966b.3
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 04:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773315623; cv=none;
        d=google.com; s=arc-20240605;
        b=EeiS28y5oLBEfM9/T0GQobC7jPTEWcxR6feh7tq7NwrFf5ODxBOVlJ8B9okChmzUIm
         FX8aCcXH5hgfD+gP7rwdBtD8CrwwIQeK8QKPDmCZltvD6jpMqiHxQflFawzV08/vcWla
         CjiDRgqioRgjG4IYWks42za+sLg6GTtK97g2uIL8QYdqJHL1955Z2RR0WpMIPZ4848nO
         rfToatzu67sNispikYWW61RI8iD/2wbzMXtR0FLVOx0/cojpCWTjVIdhsQUy0uPS41h6
         vfuj7OE7rIYX1vuzVHx5CJ80sE+ToVL2k7O/zoNQUgxP1UqtH+tWu8JSJ5spdmffGAwI
         cpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k9kla8PpBQz/94UsEvpzoG2D163jkyCAkG5Jr+I8Q48=;
        fh=wuKhKuIfT+OCTEVzcwUdWf5Wpz6V/oL8MRErBPICVnE=;
        b=XGu9jcT/VTNlfnTK0yzsunsMYls0r2pf6X/MKhoEPhmbW6T77zp1kF5H0taOJ/FmOx
         goHtLBJL49vxGcxbIrl10TLNKx0dXsNP0m16OUEV/1E6P+4T2x2M4SwYthxrE/uDZXeb
         PNgnbvLb5aWPc4f3IVmZGJRT9Mf+jmuL4MSjqsN22P/y7ctkeKs1bauPqKfgPYLctN/g
         +b9BeBED6mo6lixK2cwwtIIIw3fp/0dug90fxX5uFOj1fi5ykvhRmYWyPbpRpCIXUhjK
         zYrlJgokSsNREphU7gP0qdYJks+wfnCfvCQQcHrUz3jCb/y719nQehXVbi/wmu7i9By0
         jX/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773315623; x=1773920423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9kla8PpBQz/94UsEvpzoG2D163jkyCAkG5Jr+I8Q48=;
        b=BAvmaTiTZcclUQ3nXiagA8CGFpXxoGzHW46tbrSSDN73sQ8GUXeMraxwaSW9DEeeQ1
         VXA2VFb4SxJ6ZQHhe5SG5Ra7JWh5o2ojJX4aYFyRW41GuRck4o1tSIHEKRF5jwlgfvAI
         DW7chfMoEIKecV/GfA3Xx8wzOfXdVzkiRpY/r3xZ5jmY3y+SWvs9KlZ+Y2p7SmKonjnr
         Da1JajSv37gaaioTBhoLV7wcy2Bt0tx1TnJE7Vos1OmZeEodxtv8x2j+zmVWbVxwJZwK
         W4sx6NqaCNZx3I7igsMQqnG0UB57blRMBJnxw6lvZQyNDut6OM0t+4aBlik0rAjuL/mY
         Em4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773315623; x=1773920423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9kla8PpBQz/94UsEvpzoG2D163jkyCAkG5Jr+I8Q48=;
        b=Y8N5dyjOXu2BZxCIL0EjlXYZdt3O7sTIVnTWnf4Jx2LYu35YgmfLYQiPbQX2fQZ2xG
         Tefswb6Mf9awvfrl41Uqe74uA6LKWTtjlrIddbev3/la9qwvRleCR82tHXI8mgaITbQd
         4I2uNFf+vPwbZiddo4peP4CFtsbvkwrPUAGi0J43SAFT2BQZtdeIUuP9jChG3m1Ytyiv
         F02xA9p0x+5ienolJeq5UN4ambeGZNSjyrtCLBNtkPTiAAa3IRfkPOxx6f5yRaYGEqzv
         v5LyEKlg9sNcY92w13EfWBoSgDZrSVmEA93pgZ7Ao304HQClF3kByt2ZY8/NlGuArP0Q
         tZdg==
X-Forwarded-Encrypted: i=1; AJvYcCUnOq+L0Qxze225irRgsTrLbCGwf2WwCQ5yMPRkAHwgq8QGC5ma0JB1+Z/WEq0uiu/ugwY+ke4EOiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq63d31rRz3tcYScLTPsZDCOuC1n40v9aaLGqdBWerWLxWu64E
	ct4UAnKBB1LnJxdgOoB0AyZ5xRoMNF8S1V2UMm7is6QfR4MYZh56CMyMWI8wI0HQRsvEWGMG652
	khzmv223yo9eOcrRl9vai6Ox8+V/2X4k=
X-Gm-Gg: ATEYQzwtWEkjsVJpcPbecQjGEAn8SP6RTJnmVU5n+BuCrVmv8BKpHuQHtZLhxysT1fq
	+Z1p2ld1oCX0b18SroqQ2oSK8+/42Wrv1f0MaZXgiTcUMF1AMFC1SC5dn2yzkXmNpp0Dsnwxhz6
	7AAtyPa14TbI+QhfA6hyJaQnhCi8W7r2161U4A1RcYA0doJSNHHNrvvOV8v/boItNmS6y+svQHT
	VvWn8g+0tSTA8heVXjc9y+C6fj+fGkZP6mV73pRfvV9p3FZT14I9KpQeDmrkGSh7+VnSCTD2Bwv
	XbSvnw==
X-Received: by 2002:a17:906:f58d:b0:b8f:f070:8c30 with SMTP id
 a640c23a62f3a-b972e52a19dmr383837666b.49.1773315622489; Thu, 12 Mar 2026
 04:40:22 -0700 (PDT)
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
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org> <7b5592e7-8a9d-2cf0-bb3e-e306a6337165@rock-chips.com>
In-Reply-To: <7b5592e7-8a9d-2cf0-bb3e-e306a6337165@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 12 Mar 2026 17:10:06 +0530
X-Gm-Features: AaiRm52HfWRYYsTJWgJqZ1mPKHzxh5bRhcDvLmP4oDUAAo6L9RCY3sGu0RZ9H3g
Message-ID: <CANAwSgTaZqsHYXD_ACkJGGLgk4knc7N72f4qrJaaenE-cXM8BA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Grimmauld <grimmauld@grimmauld.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn, Mani, Niklas, Robin,,

On Thu, 12 Mar 2026 at 07:03, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Hi Mani and Danilo,
>
> =E5=9C=A8 2026/03/12 =E6=98=9F=E6=9C=9F=E5=9B=9B 5:09, Danilo Krummrich =
=E5=86=99=E9=81=93:
> > On Wed Mar 11, 2026 at 1:28 PM CET, Manivannan Sadhasivam wrote:
> >> On Wed, Mar 11, 2026 at 12:46:03PM +0100, Danilo Krummrich wrote:
> >>> On Wed Mar 11, 2026 at 6:24 AM CET, Manivannan Sadhasivam wrote:
> >>>> I have a contrary view here. If just a single driver or lib doesn't =
handle async
> >>>> probe, it cannot just force other drivers to not take the advantage =
of async
> >>>> probe. As I said above, enabling async probe easily saves a few hund=
erd ms or
> >>>> even more if there are more than one Root Port or Root Complex in an=
 SoC.
> >>>
> >>> Then the driver or lib has to be fixed / improved first or the driver=
 core has
> >>> to be enabled to deal with a case where PROBE_FORCE_SYNCHRONOUS is re=
quested
> >>> from an async path, etc.
> >>>
> >>> In any case, applying the patch and breaking things (knowingly?) does=
n't seem
> >>> like the correct approach.
> >>>
> >>>> I strongly agree with you here that the underlying issue should be f=
ixed. But
> >>>> the real impact to end users is not this splat, but not having the b=
oot time
> >>>> optimization that this patch brings in. As an end user, one would wa=
nt their
> >>>> systems to boot quickly and they wouldn't bother much about a harmle=
ss warning
> >>>> splat appearing in the dmesg log.
> >>>
> >>> You mean quickly booting into a "harmless" potential deadlock conditi=
on the
> >>> warning splat tries to make people aware of? :)
> >>>
> >>
> >> Hmm, I overlooked the built-as-module part where the deadlock could be=
 possible
> >> as indicated by the comment about the WARN_ON_ONCE().
> >>
> >> But what is the path forward here? Do you want the phylib to fix the
> >> request_module() call or fix the driver core instead?
> >
> > Here are a few thoughts.
> >
> > In general, I think the best would be to get rid of the (affected)
> > PROBE_FORCE_SYNCHRONOUS cases.
> >
> > Now, I guess this can be pretty hard for a PCI controller driver, as yo=
u can't
> > really predict what ends up being probed from you async context, i.e. i=
t could
> > even be some other bus controller and things could even propagate furth=
er.
> >
> > Not sure how big of a deal it is in practice though, there are not a lo=
t of
> > PROBE_FORCE_SYNCHRONOUS drivers (left), but note that specifying neithe=
r
> > PROBE_FORCE_SYNCHRONOUS nor PROBE_PREFER_ASYNCHRONOUS currently results=
 in
> > synchronous by default.
> >
> > (Also, quite some other PCI controller drivers do set PROBE_PREFER_ASYN=
CHRONOUS
> > and apparently got lucky with it.)
> >
> >>From a driver-core perspective I think we're rather limited on what we =
can do;
> > we are already in async context at this point and can't magically go ba=
ck to
> > initcall context.
> >
> > So, the only thing I can think of is to kick off work on a workqueue, w=
hich in
> > the end would be the same as the deferred probe handling.
> >
> > Another alternative would be to let the subsystem handle such cases, wh=
ich in
> > this case would probably mean to handle the current_is_async() case in
> > pci_host_probe() or pci_bus_add_devices().
> >
> > On the other hand, this would probably end up to be a subsystem specifi=
c
> > implementation of "kick of work on a workqueue".
>
> Actually, this is exactly what we've been doing in our downstream
> code[1] for quite a long time. We've even pushed this optimization down
> to the individual driver level.
>
> To be honest, I'm not particularly fond of this approach either.
> However, on our platform, we have more than 5 Root Port instances that
> need to be initialized during boot. When all of them probe
> synchronously, it significantly delays the execution of many other
> critical drivers. Our customers have been complaining about the boot
> time, and our downstream team had no real choice but to kick off a
> kthread similar to your suggestion.
>
> The code is very ugly and expose a lot of corner cases problem which
> wasted quite lot of time to fix. That's why I was hesitant to bring
> up the this approach upstream initially. But since you mentioned it, I
> think it's worth evaluating whether we can implement this at the
> subsystem level instead of forcing each driver to handle it
> individually. This way, the complexity would be centralized, and drivers
> that benefit from async probe (like multi-Root-Port SoCs) could opt-in
> without worrying about the request_module() deadlock scenario.
>
> What do you think?
>
>
> [1]
> https://github.com/rockchip-linux/kernel/blob/develop-6.6/drivers/pci/con=
troller/dwc/pcie-dw-rockchip.c#L1764
>
> >
> >> I can drop this patch in the meantime. But holding this prolong wouldn=
't help.
> >
I've reproduced the issue on my end. Following Danilo's suggestion,
I used PROBE_FORCE_SYNCHRONOUS to resolve the warning.
If you agree this is the correct fix, I=E2=80=99ll resubmit the patch.

 git diff drivers/pci/controller/dwc/pcie-dw-rockchip.c
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 5b17da63151d..ecaf1b446008 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -746,6 +746,7 @@ static struct platform_driver rockchip_pcie_driver =3D =
{
                .name   =3D "rockchip-dw-pcie",
                .of_match_table =3D rockchip_pcie_of_match,
                .suppress_bind_attrs =3D true,
+               .probe_type =3D PROBE_FORCE_SYNCHRONOUS,
        },
        .probe =3D rockchip_pcie_probe,
 };

Thanks
-Anand

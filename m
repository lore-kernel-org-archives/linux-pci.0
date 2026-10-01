Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155344F546
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841336; cv=pass; b=Ryz2pp7jNSiqaoyeTjstB/1mzY1xjlq+OTqRN4y5ACkW8HcO5r3zYNrti6UEfeseu0q6BQy0sNL6EP3/ljlQyqJrMlRe7c/SKVJ41xQmuk9qGrqE/qKgBwHhFkoYaAdwY6PzcZJcQOpau2dWlnF7ZWvIriXSfEUFj/OZdy5YTfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841336; c=relaxed/simple;
	bh=XCl8xyjwz1MPEFOUUNwzlCG1qvgeKDlzz49S+/GUXKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOorEh7IIQVrSftZGDlmPz6FfO7SWl3wYBMt2dXqGsF/9JBDS6VBYgyRoG377lC6R4DdlF01z2AtdrTpq9KxmOk8Rp3/1FMCTnsfZLIApuFU1DoFKuB6ABK0/tC2WKT+tHxu11jXTnrLfTD+8wvdtznqsgKJL6IyFYLlp0r89IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwA/ryRe; arc=pass smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwA/ryRe"
Received: by mail-vs2-f37.google.com with SMTP id 71dfb90a1353d-5d4129be80fso906863e0c.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2026 00:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790841334; cv=none;
        d=google.com; s=arc-20260327;
        b=Fvcth4ts8dARC3h+8pQx7QZnmgwTE91ckll0/ruxIVGZsPoTtWgkSeV9xygq5EzSIX
         QaXYBP8K+8uAjjrcmHjcw3ptSDo4qExswbXK403ZqJyB62TlFhfDRb3OPr5J9Rr5/7xd
         lzKrdfSZehhSdBh/cUJfZdTda98CPIQEABNooGDJlGjYo1OB/dnsmaxg3AAm4kv2hG0G
         tmH9Kj+oVjfiLYjYyQofty085OSz2VlR9x6bsYrgcZsYHg0XGpPkjou0zeW8Qzrz3YTs
         tPjKpWxt7u3MeVYjccwXxBD1CG0xp+VUlKGk7nZOZrFaZlzPQkgB+aQxIy2X+f0WPVcZ
         5ESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u5BYYGSPF6Zoletn6ltYDxBcpmXppLLT7dUQEfUfHyI=;
        fh=ty9F2vQgo6Zgkny/gJRculkLN3/KskvIkL2djcV4dpk=;
        b=fcab7WAsOLQuq1q/AZTVnLIYpOq0+7SaJ52MJamEF+7YYt98O2x+rfQ3ERTCIMZqIH
         /N9slTkNUe0cbHclOs+MJWx0V5Kf9FZbqQ8v/7vljXuZJL56BoIA8Gj9hvqfaLyimbcl
         VuO4Zd+Rekr8bfWhPhXewZKBVlnoJ8QkKR4k6IpyP4e95eDZPPD/Kf7j8BcpoqsxjvW7
         MBswauGDPlh2eooOYsTTxplZxnsnOnGoplnwL0F12+gEPUAFSibPCeZ7t0Cl7r61kk8b
         VyMVlZQtij+lUoI49GA1XDV6QuuFN7uEh4JKxzRacPJdpuNGH4CEsfJc6D5emDITwdDj
         +uKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790841334; x=1791446134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u5BYYGSPF6Zoletn6ltYDxBcpmXppLLT7dUQEfUfHyI=;
        b=kwA/ryReat+q89HozFK0MInh3L2nKLZdddZOL8+4hLGkZlADzD5TkwD0x7VK2VuNi+
         62zJ+c8yeqxLa/Gcpf7SB5sKptqeEtp5RRv+nbPD8wakmNuK9g8KqqGls8kSkq/ywiB+
         KkZwHHcc3Zh/YPG3MuN55ZsooKDJeeHpQhroCfWFejdqwbJ/9/cO0kvJ/MaaiNLax3mc
         7Oji21csbl629bRVxCAddU2C191T1OsVsEN9UvR6AXnH0Vs6NZURhTTmRT8ZPr6gq9ME
         sCg6CRxCuMeyJ/jOMBtV+7jyilI0DB05gSEgryKQiAyuuxzyE9Qr7UfGJuOfqJ8gA9bk
         070g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790841334; x=1791446134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u5BYYGSPF6Zoletn6ltYDxBcpmXppLLT7dUQEfUfHyI=;
        b=2h8SpdOj5VHIvB1MfRPbPqfWPv7uhoBox3lBV6Aj/HTxMHlUT/t85xGwsNOBKodhpN
         U/LBu93ERcnq0MA3bW4Sgi4SBImE6yRQC00+NEnwmgwgPIV7fmL1FNAOKJEU+o5QPxzX
         WKmfaN3yDMCseesX/lrZGY3k6bF2I6S6eleTMr+2ToSyHFVC1VbEMRrg9wpzrkoce25R
         fIxQ/zEhMhtMgyOfiTcUVi1ad8Cm07ukppab6zGeb97NCAfth9D24VaP8gFkjnZTBe/t
         aGrdIxuX5lAbriIXiCWSdfAfRGy4MLfZjqMWGYdpLvXPqPHxSPsNB0EGv+LdV/vbm/PJ
         ivHw==
X-Forwarded-Encrypted: i=1; AKwUvBzOb9z+zLRCEb0gyJHI6pMYkaOA9rl2CrKdf8dWO5H6PTAZRS279XEc3urvs3kk+qh14MsDPr8hLcs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKPQuAhmtmKA/mAfWlvrj0/W30n5PRSO0rL+TSlUpGcywK39Nj
	Y2ocl2iDNzaPvthovc8M7O+fDJLytUPgcXD64rYb/OS63ARxTfnZe43OgGpt/oD46LKNOSmMa9v
	RBbf3TH+QzqbJymDF9UxcyZUQiPPVNBQ=
X-Gm-Gg: AYBFou1P8QoTyupEONAxdisfqHJaJuuN06nSaG3rhxwAyrCqhCYJip7B19it3MO9Nmn
	5az+RDjUjfxEgwa/hOFNYewDCTvtaXoKpxC6xkGIF/i/MbjkVWqvxaPSpWYv41aR0mA1Q0+x//R
	vAFg7msX6c7LgygA1XYafRZ2PwNRiH4hiQRJVhcEdDwPHqnHvyhreUThd7qvLfbv9HqAkWcwlu+
	xOITqKhniAFLzMfEW/dS/YT/RWMgFyj8OogkOrpDh2djwoNKo63B+a1nuXPoAeiTEVOLn5PTW3x
	j4UbnZ0uF3ihnmUCZUYzOFZpCdlkM8Oq87/L+4Rd6HSLD8+LwXmrPzsl8I5uQFSpfWw=
X-Received: by 2002:a05:6122:62a6:b0:5c9:a60b:e5ba with SMTP id
 71dfb90a1353d-5d67d65ba04mr1209917e0c.10.1790841329348; Thu, 01 Oct 2026
 00:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFpUU0sqt2VzdGGUcx3fkLyyDSynOhNgAraT7-gL53oBq1aMfw@mail.gmail.com>
 <20260911090800.GZ106095@black.igk.intel.com> <992676e6-6769-d72d-9ef6-94c1ba758992@linux.intel.com>
In-Reply-To: <992676e6-6769-d72d-9ef6-94c1ba758992@linux.intel.com>
From: =?UTF-8?B?6bOl5LqV5Y6f6IyC?= <monogokoro2026@gmail.com>
Date: Thu, 1 Oct 2026 16:55:17 +0900
X-Gm-Features: AclHuK9dURNIpTpFFdfJheY9SY2S733ZRrXjiUeK5gVq-RK-4PMato9U7MvWTGI
Message-ID: <CAFpUU0sXiJyZ=pUo5n+88DwPc4Rxq_c8LTiO81=ZzfOaEqkCRA@mail.gmail.com>
Subject: Re: PCI: Resizable BAR never considered for Thunderbolt/USB4
 hotplugged eGPUs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, linux-usb@vger.kernel.org, westeri@kernel.org, 
	andreas.noever@gmail.com, YehezkelShB@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

Thank you very much for the detailed reply! I'll try the patch when I
get a chance and share the results.

Best regards, s-tory.

2026=E5=B9=B49=E6=9C=8829=E6=97=A5(=E7=81=AB) 21:17 Ilpo J=C3=A4rvinen <ilp=
o.jarvinen@linux.intel.com>:
>
> On Fri, 11 Sep 2026, Mika Westerberg wrote:
> > On Fri, Sep 11, 2026 at 05:58:26PM +0900, =E9=B3=A5=E4=BA=95=E5=8E=9F=
=E8=8C=82 wrote:
> > >
> > > I am reporting a case where a Thunderbolt/USB4-attached eGPU is
> > > enumerated and links
> > > correctly but can never be used for compute, because its BAR stays at
> > > the power-on
> > > default of 256MB and the Resizable BAR capability is never exercised.
> > >
> > > I am not sure whether this is considered a known limitation or a bug
> > > worth fixing, and
> > > I would like to ask before assuming either. I have the hardware and a=
m
> > > happy to test
> > > patches.
> > >
> > > Environment
> > > -----------
> > >   Host:      ThinkPad X1 Carbon Gen 13 (21NS0000JP), Lunar Lake
> > >              BIOS N4BET77W (1.47), 2026-06-30
> >
> > I don't know if we support REBAR or how well in PCIe side, Ilpo probabl=
y
> > knows that. Typically there is just certain amount of resources allocat=
ed
> > for each PCIe root port that gets tunneled so the way to do this is to
> > increase that in the BIOS. Having said that most of the vendors don't
> > actually allow it to be changed.
> >
> > >   Kernel:    7.0.0-31 (Ubuntu 26.04.1)
> > >   Enclosure: AOOSTAR AG03, connected over USB4 (not OCuLink)
> > >   GPU:       Intel Arc B580 (Battlemage, 12GB), driver xe
> > >
> > > What happens
> > > ------------
> > > The card enumerates, binds to xe, and its edge connector trains at
> > > 16GT/s x4, which is
> > > the expected ceiling for a USB4 PCIe tunnel. The link is healthy.
> > >
> > > BAR2 stays at 256 MiB. The card advertises Resizable BAR support for
> > > 256MB..16GB:
> > >
> > >   # cat /sys/bus/pci/devices/0000:24:00.0/resource2_resize
> > >   0000000000007f00
> > >
> > > Level Zero (intel-compute-runtime 26.31.39395.13) prints
> > >
> > >   WARNING: Resizable BAR not detected for device 0000:24:00.0
> > >
> > > and then drops the device from enumeration entirely, so it never
> > > appears to any compute
> > > API. The integrated Arc 140V is enumerated normally.
> > >
> > > Why the BAR cannot be grown after the fact
> > > ------------------------------------------
> > > Attempting the resize by hand fails for every size down to 512MB:
> > >
> > >   # echo 0000:24:00.0 > /sys/bus/pci/drivers/xe/unbind
> > >   # echo 14 > /sys/bus/pci/devices/0000:24:00.0/resource2_resize   #
> > > 16GB -> fails
> > >   # echo 9  > /sys/bus/pci/devices/0000:24:00.0/resource2_resize   #
> > > 512MB -> fails
> > >
> > > BAR2 is placed at 0x2010000000, which is only 256MB-aligned, so a
> > > larger size cannot be
> > > aligned to the bridge base. The prefetchable window of the Thunderbol=
t root port
> > > (0000:00:07.0) is only a few hundred MB and comes from firmware:
>
> The usual result.
>
> > >   PCI: Using host bridge windows from ACPI; if necessary, use
> > > "pci=3Dnocrs" and report a bug
> > >
> > > I measured 711 MiB and 448 MiB for that window across two boots.
> > >
> > > Things that do not help
> > > -----------------------
> > >   pci=3Drealloc                  no effect on already-populated bridg=
es
>
> This was my discovery as well which blocked my Resizable BAR aware
> resource sizing from doing anything. I did some work to solve it but then
> got regressions from the earlier resource work to address so I've not had
> time to look into this for a while.
>
> Solving this is among the last few blockers for the resizable BAR-aware
> resource sizing (sans the yet to be discovered bugs in the resizable
> BAR-aware code itself).
>
> > >   pci=3Dhpmmioprefsize=3D32G       makes it worse: the Thunderbolt
> > > downstream port the GPU
> > >                                sits behind gets no window at all, and
> > > the whole card
> > >                                disappears from the bus:
> > >
> > >     pci 0000:22:00.0: BAR 0 [mem 0x00800000-0x00ffffff 64bit pref]: a=
ssigned
> > >     pcieport 0000:21:00.0: bridge window [mem 0x00800000-0x00ffffff 6=
4bit pref]:
> > >         can't claim; no compatible bridge window
> > >
> > >   pci=3Dnocrs                    the machine does not boot: the NVMe
> > > holding the rootfs
> > >                                fails to get resources and probe retur=
ns -ENOMEM
> > >     nvme 0000:04:00.0: probe with driver nvme failed with error -12
> > >
> > >   thunderbolt.host_reset=3D0     no effect here, and I believe the
> > > reason is that the
> > >                                firmware never enumerates the tunnel a=
t
> > > POST. The eGPU
> > >                                first appears 63 seconds after kernel
> > > boot (16:05:11 boot,
> > >                                16:06:14 first sighting of the card),
> > > i.e. purely as an
> > >                                OS-side hotplug event. There is nothin=
g
> > > from POST to
> > >                                preserve.
> > >
> > > The BIOS has no relevant setup option: under Config > Thunderbolt 4
> > > there is only
> > > "PCIe Tunneling" (on/off). No Resizable BAR, no Above 4G Decoding, no
> > > BIOS Assist Mode.
> > > I have filed a separate request with the vendor about that.
> >
> > BIOS assist mode is a workaround for early Windows systems that did not
> > support native PCIe hotplug. It should not be used in any modern system=
s
> > and I doubt it's not even capable of what you are doing.
> >
> > > What I think the underlying issue is
> > > ------------------------------------
> > > On hotplug, the PCI core reads the BAR at its power-on size, sizes th=
e
> > > bridge windows to
> > > match and assigns addresses, all before any driver binds -- and the
> > > ReBAR capability is
> > > not consulted at any point in that path. By the time a driver could
> > > ask for a larger BAR,
> > > the surrounding windows are already committed and too small to grow i=
nto.
> > >
> > > This looks like exactly what "PCI: Allow BAR movement during boot and=
 hotplug"
> > > (Sergei Miroshnichenko, v9, Dec 2020, 26 patches) was written to solv=
e
> > > -- the cover letter
> > > explicitly lists Resizable BARs as a use case. As far as I can tell i=
t
> > > never landed:
> > >
> > >   # grep -c -e rescan_prepare -e rescan_done -e bar_fixed -e
> > > movable_bars /proc/kallsyms
> > >   0
> > >
> > > Questions
> > > ---------
> > > 1. Is ReBAR-over-Thunderbolt-hotplug considered a known limitation, o=
r
> > > is this worth
> > >    treating as a bug?
> >
> > I would say here that it's not even related to the underlying transport=
,
> > could be something else than TB too, as long as PCIe goes inside.
>
> It's a known problem, but fixing it without introducing regressions is no=
t
> easy. The solution must be able to fallback gracefully to smaller sizes
> as needed. Without that, a regression that will surely come up soonish
> would just lead reverting the improvment.
>
> > > 2. Is there any current plan to consult the ReBAR capability during
> > > hotplug resource
> > >    assignment?
>
> Yes, infact patches already exist to consired ReBAR during resource
> fitting, but they just don't run as is when a bridge is already assigned
> so more work is still needed once I get the most recent set of regression=
s
> out of the way first.
>
> > > 3. What is the status of the movable-BARs series? Is it abandoned,
> > > superseded, or waiting
> > >    on something?
>
> I've no plans on basing anything on that work.
>
> > > 4. Is there a kernel parameter or sysfs path I have missed that would
> > > let the BAR grow
> > >    after enumeration?
>
> In some cases, removing siblings that pin any of the upstream bridge
> windows in place prior to executing the resize may allow the entire windo=
w
> to move elsewhere.
>
> There's even a patch from Geramy Loveless that would do this automaticall=
y
> for empty siblings [1] which is definitely worth a try. It does not work
> universally, however, so YMMV (I don't see your /proc/iomem anywhere so I
> cannot tell whether it likely works in your case).
>
> Somebody was against Geramy's patch as it didn't (and kind of doesn't
> even want to) ensure the unused siblings would be guaranteed to be
> allocated at least some space after the resize (any unused hotplug
> reservation is "optional" so it would be a major change to alter that
> differentiation to address that review comment).
>
> But if that patch works for you, sending your Tested-by tag to its thread
> might actually be helpful.
>
> [1] https://lore.kernel.org/linux-pci/20260428225146.3104063-1-gloveless@=
jqluv.com/
>
> --
>  i.

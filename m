Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B643BDC0
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395491; cv=pass; b=Cq/TumAZcnsMm6C40rXYzb/wv4BoOp3LYnToRiKoTOF/7LIRdZka9GpMIPt9TGa/XI+RzLOlOxoxc5NogEjS7CCRVgi9jy30hfU7M6rxmAIbwqr3Nf15aHY97DuROhMw+mqRZH1QOd0VnVQhjAb3ozgTJbG8VbwgAvFMHSOiVPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395491; c=relaxed/simple;
	bh=lH3lDEWtLOepUU6cjkYS1nVga19A8x9gMp/xRip7C6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCg4IQolZXCOJsuDNCnyfyrkxSHYKGQZxa6f5/6XlOlTJL74qQqFyoSEaBo1asKeH4VH83S9S4cS06JNRHrAfkqXvaiP8inO/fg8Eujp+0WY/lHe6BrTky8+E5rNQvZRg1hpLL0AcQILrCZGLo5aG9q3h1+ZFCxSkTMTm/1najA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Msg9y6Qe; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msg9y6Qe"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfe810293so10303651cf.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 13:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786395489; cv=none;
        d=google.com; s=arc-20260327;
        b=s8WMfDhZKpT11sWXYnF3LvEzr0rZlAkmvX89kLPIbVCyMshIB9FPQhNwqQOmG6pGf4
         WHOlXrjsXI3zXX34LY1wAkA/q4HwpoYKXUvfnEqwvk6+8WRywII7cOlEESASzFJ9lGC8
         B2cuozVrPDsWIxW6kQ+ORCXJr/T6jGtQ2mATDuVAGCbNj5n1tkqlr1/kUyuS7ENLvhc+
         W96u6ZBsAliiyL/TGxj19Sjgq2Q5fFsMTdXf/ComQTz1tsR+J8JRK/DIOBmo9UMwKN9b
         it4naELBXhSXLDlAZJRsdaUYtB+yv4gC1ZmLyPjo/WeJokFuBh5XfTj5VIgyhyHuLucD
         9CRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sovgpc7RE7k+laQpGPfeVgbnKHiv8/B1taktT3esT6k=;
        fh=UAG7th9KFAYL4/vfrkRTyyoeae9lHhcGLnSW1xO4k4k=;
        b=gO1vIZh5FI2SMfyUUYOQOUlvcbDwom4rtw4yWWT2MpmF1hf9xOhqyZ2cg7xTNpDnz8
         HUgyXnTjLteIlknHp5f+9dhzo5OpDU1D92pqh8mUYgjEnsgMq0Gmz1+bk22XXA30kKP0
         WKXFALulRAq6rG5X0QlCoGkEspk5gc/nPyAQAUMglpaRE5Ew4npsf8M5pyn0a28wHRMO
         8+JTPNSSl9GnL+HTBraIx5XxllhMEl6vybpHJ9XCAhjK8XYPI1yIKgJdLPqoRWGv/nLH
         T6+9OtH+itfdRp4CjYuWTY0IkcAYOiI2wcpLpdNpnsHnXVA0gq5HTTYVHbmTl9kwxQPw
         T+XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786395489; x=1787000289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sovgpc7RE7k+laQpGPfeVgbnKHiv8/B1taktT3esT6k=;
        b=Msg9y6QeLBpXE4W4cojPI6S/hMwjo0+EJkwcBI3DeF2G9f1XW2kDQGPeTm6fEHBogK
         jwoXjdrGL5XSHdjSItDNdV03TWUlMzZJ3JQlhIiTep1aedZW0BGDnQwtcvBdzsnksddt
         M4KERVA480+g6c4rlTJ8A4mGKRL82IVtn8wW+q7aiJXJX+A7Sy81O8dhghLtpILwZfF+
         r63ndl9+BHrgOUOvPX9VDtZBhqElt3qfkkUiatzwyWiyE8jL9wqcmeNzVK52s5pjyy0a
         nQa73szuGt2pWDsh7F7H6pmtngE/agAZpwXr8s8oN9k93WkOMzKWjLRJ6B6rMKghIT89
         I3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786395489; x=1787000289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sovgpc7RE7k+laQpGPfeVgbnKHiv8/B1taktT3esT6k=;
        b=DsDSRa2foHrv9FKajez+McrGqB0MdB3vyTDOg//aMhggJZ0LO3lKYWBQbKMp5w4KPV
         Y5i12UNubqrgjBdef71Aksb6vMCncg39xCUOxuyZO8PK7JulI0N3CuBOrjg3PmY1M/aV
         YGAh6gZ45YHAzt6ro8UHV8pvp1P/uN37UHZJa8ByGLPFECe5CwRLuLMcO/sv7t8v9Vhh
         QSab6ZzSo8m19L/FuHkA00ilMKYe8q3mzluIIsLgnVTflRuwuXSgPE9LVoEG3xh9e/df
         NI4xVlO6JUqcRNlMlC4f26Y28roTWszyRdlblKR8Q6nj/Ad8itg9VREPsImpElJstNsb
         ptmA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7tME0GH/klJa1a5HR76AvTLZGFesAK+2o0oiZtHCyIe0jZP3rjgip2rTqWMsmAkTBVXNVbMj22UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj6D882VrIrr5ca2ge5G04GLZogCXHgHSkSLnlaBu645ENk7ut
	0pA4UJPW+LjsUkL71PsIF9m9mgY9tFtzsPsZmSDiS3joBrfcoK7qSeDh8pGwlUAiAWWzQCyoTGD
	zGxx1uqxMerYwCehzu82ZOJJ1gWXx6CU=
X-Gm-Gg: AR+sD11LLR8wJiNjZzbacdWS5vjwOpfEvjMbrpuCfdNPkbuVl3K/jgvqizUtMdSDNqk
	Sh5JiX7PNvWnjoedz7hysEL0mjeOfVTtRI+ia8hKdBWHahRnW7600OW1eAOOr/U5P3KQUrPW1Bs
	344nmBD2VvIDjjorTHBtJRrqbh/xwAYTMm4uRVZz/HgqRa2U47Sab3du7d9at6fpahOoPa4Le74
	0IF+6WsREbwE/hkLRv+qBwpKkLAfXtez3QCyM70zl6th1824beWGr9/IB4+LkG78xpN8yle/x81
	OqVUENVsrMGVRWzqocrDPMvGCEb6rg9rz/J3b6Xnf5uTskDcb4ElhnD+
X-Received: by 2002:a05:622a:a588:b0:516:dda7:51e0 with SMTP id
 d75a77b69052e-52d2095c5f6mr252739971cf.17.1786395489359; Mon, 10 Aug 2026
 13:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
 <anWdGzfD7HxglsOB@wunner.de> <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
 <anbl6j9DWiyVQLqS@wunner.de> <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com>
 <angci4oGyGFtvbSQ@wunner.de>
In-Reply-To: <angci4oGyGFtvbSQ@wunner.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Aug 2026 13:57:58 -0700
X-Gm-Features: AUfX_mz0dO8sNu39CRCAlrYMDZFdFC95KOuzKjp0yKAJyZmcqVsjuqWzY1utyCo
Message-ID: <CAFqHKTkTYtu7U39W7epZptPWBBC0fQyfA-5mOBTi4RTA1Bb1WA@mail.gmail.com>
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 11:22=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Sat, Aug 08, 2026 at 08:34:38PM -0700, Derek John Clark wrote:
> > This was good instinct. I was able to drill down and find
> > approximately where it is hanging.
> >
> > rtsx_pci_remove() ->mfd_remove_devices() -> mfd_remove_devices_fn() ->
> > platform_device_unregister() -> platform_device_del() -> device_del()
> > -> bus_remove_device() -> device_release_driver() ->
> > device_release_driver_internal() -> __device_release_driver() ->
> > device_remove()
> >
> > In device_remove() (drivers/base/dd.c) it gets past
> > device_remove_groups() and hangs before completing this if block:
> >
> > if (dev->bus && dev->bus->remove)
> >     dev->bus->remove(dev);
> > else if (dev->driver->remove)
> >     dev->driver->remove(dev);
>
> Okay, that ->remove callback should be rtsx_pci_sdmmc_drv_remove()
> in drivers/mmc/host/rtsx_pci_sdmmc.c.  Can you maybe identify where
> execution stops in that function?
>
> Basically the rtsx_pci driver creates a child device of the PCI device
> and the mmc host driver binds to that child device.  Removing the
> mmc host driver fails here for some reason.

Hi Lukas,

I was able to drill down further. When the mmc device gets to
blk_report_disk_dead() in block/genhd.c there is an xa_for_each loop.
On the second loop of that it seems to hang in bdev_mark_dead(). That
sets a callback that runs fs_bdev_mark_dead() which then runs
sync_filesystem(). This is all hit because the "surprise" bool is set
to false unconditionally in __del_gendisk().

Commenting out this from __del_gendisk():
if (!test_bit(GD_DEAD, &disk->state))
 blk_report_disk_dead(disk, false);

Avoids the hang.

I'm not sure how much further we want to go down into this as we've
moved quite far out of the driver space and are now well into the
block subsystem. I'm working on a proof of concept that would allow
the driver to inform the mmc core that this was a surprise, but I'm
not sure how that would land. From what I've read the mmc core was
intentionally detached from higher level drivers, though a few
notification methods do exist. If I get that fully working I'll post
it here but it will probably be a few days as I've run into some other
obligations this week.

> > > If you go to sleep and resume without SD card, do you then see in dme=
sg
> > > that the card reader was de-enumerated and re-enumerated?  Normally
> > > there should be at least a "Card not present" / "Card present" messag=
e
> > > from pciehp, if it sensed a replaced device.  ("Card" refers to PCIe =
card,
> > > not SD card.)
> >
> > i get card not present, then card present, then link up.
> >
> > > Also, what's the subsystem vendor/device ID as seen with lspci after
> > > a successful system sleep transition (successful =3D without SD card)=
?
> >
> > it reflects the Realtek device VID/PID. I also tested resume after the
> > 1 cycle with it re-inserted and it works fine after the first cycle,
> > presumably because the device id matches on the second run and beyond
>
> Right, when the device is re-enumerated after the first system sleep
> transition, the Realtek subdevice vendor/device ID is cached and that
> matches on all subsequent system sleep transitions.  So if we manage
> to find and eliminate the cause of the hang, there'll only be the
> inconvenience of the removal/re-enumeration on first sleep.

I suppose that is true, but in that case we still wouldn't be able to
use it as the root fs since it gets removed/re-added during a suspend.
Would the quirk I submitted not have this compromise?

> Thanks,
>
> Lukas

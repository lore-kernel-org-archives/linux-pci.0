Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9927C3033D6
	for <linux-pci@vger.kernel.org>; Sun,  9 Aug 2026 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786246492; cv=pass; b=RkE6vYpwq+EExvNaizxJpqc6ARxLp+faQEP3lk7tXafTFZc/ihRS/aD2NNh2pKNb+YfLH3tbIrVxrzUpxHGIWPlpb4cWnL6GpiUBKX/Mo0DocRTtBtsW0d6gie9VyLBXg3UA+9iaXvgWuFHudyDDQw5u07obEuxbD9Xon+QAnjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786246492; c=relaxed/simple;
	bh=Bf/vujSfVqMLMaDqbzEpJ3OJOm+OAXyoCa73VkkDcCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPPHJPqryJ50LyAeZrhTZTvB6CQioVdpE+pYWoLDADWGF6sCZoJL3Z0jQ4nhe46duSh55i8XNI7zKEswAge7EHoucFZh+t1VIuRPCiTyZVhk4tgd6q4ZKaUVd3W2lcAdETjh9WpoXOBCB0OTvUlI5dup3eefPmgArweCZEFwPCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVjuPi0q; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVjuPi0q"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c05dcdf49so8760311cf.0
        for <linux-pci@vger.kernel.org>; Sat, 08 Aug 2026 20:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786246489; cv=none;
        d=google.com; s=arc-20260327;
        b=Iuxp+KNFHpjok2NV+Cn/rQM8CYiJOHUf2ordP6tVe+qHHXBBq8QrjzFvMSpmrTj/Vl
         fECgBYMRBx2jR/4utchyYQQCgW3vQERbnQgtLWvlCYKyHCcH+IOu6HGaLIVCyhJkBmWm
         MOUD2zQN46Bm5nArPgEBufQWf8HGPPDchG++Pu5/rQoExRnBcxm66WJNpnjH4tVp3AAm
         2lcypTjDuEbVxBxmvFUmN0CRfI1oop/ONZcs4ORQjFH6fqcIU9ArAl/P+m1503vs4xUB
         hsIJufKhSj4EuFDAKuqrbq9g3w3quMe15Vqc1JO1fJfGQ2rSIY41UDasMD1KAu3QkhCj
         RGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9IO4AifK8fBY15try5faT6rvnEHQf7Lfuh0u8UNGjhA=;
        fh=CRf9rTm497KkSv3V6FWQE3Gss6S2jRUA16yDkeWYb8Q=;
        b=lTJINwyRfJ5iR8/3Hk0lQ4hRFdsQDqlTASnL++/Dectf6z4/TfD/pPbEOIF5e3Rkct
         4gigkH/jd89XkcqLPHCza1sNBlO2LWtKy4o6vMuPXcLO2MD/03EXU9+yetGz2YID9a5L
         Ou2rpi85r8MRz2EpahxUBEAb6OkVA9yaO/63ikJAljF38Y79xzAvBt/x5iqvsK+QxD02
         y38gdeOFCJCtIUWGlzjw8Y5Voa9cARCuJo9GpeTRPpg7GsXyENZenJSI409e+9+lyran
         Pt7E6FZqfjkL7/9gVO+bgKh5RTwUj63yNzM+kixrKZgS9nw2kUiDEv7O/baH/3OJoK3v
         uVGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786246489; x=1786851289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9IO4AifK8fBY15try5faT6rvnEHQf7Lfuh0u8UNGjhA=;
        b=eVjuPi0qMMHdVTlb+P/7kQue7pSpt6uStedzwkfr0gMwbYVMKqh67RACnOGImW+nOi
         R7o7xS+P3dyZrE2khkErtC5gUvEjlk8IW1sCFbamHPaWxwtY9WjSseZPEcxCv9Nh6czt
         FWoFTATBVnSi9kHO5wozx+K2jkv92UAS6Fo2EM0JbQAaZ6gwTQlX4uUKASUXWBAZgFQD
         YpELJ//0Nard/dmMsxrFsqj4q8OTwF0TmIqIlTNJ2KL0N2cT3dnYQqVRX165yjvHdGRm
         TYpqk6Wngm8UR8sWsjFYLUv+utyO5sAw4DVwdRVKktTRHEVsdn5cPf2TF2Kazti8SkZ4
         GSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786246489; x=1786851289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9IO4AifK8fBY15try5faT6rvnEHQf7Lfuh0u8UNGjhA=;
        b=It2vT6K83W0GOE6pnog4D1yPoJYo4h9TSCNcWPlwoo2QXxGw6/AQsGHPxPVpoUcWNZ
         iG2ZlbROAbhA91Np4xgq1YYHaxCJo3fwMXKao4vjz/UG7RQmmsZnp4ahcnPbrkUSZh3D
         hTDCduh95kjq7o3KeKmPme1o0AL3W8PFI1KS/sw5Z1QCUiy3zkZoTi8mx6G25C2UpXZB
         TUkQ5BndI1CCHZrpeBXTNL55NADzY7fEbWBR6XFzbQ6rX41OAYwpEzv7NTP9lwEahjIN
         lsMs/Ij9oyVbjXP3dUdVb3h4E/NUBi4vgUoc5cT0Z2yKNHmdzs7aEezo70PIdvjwZvZH
         twYQ==
X-Forwarded-Encrypted: i=1; AHgh+RpcCUqWxNJVETqGt2NOKTYTRSq6O0KH7RHm4VHeH4/mTacGpqt1It1N+0B2xWogf41kuhyKrOy0Cqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlP4qSl25o8aG8x8GhDZvAwKXfsP1Edb2S2VP2oXzrf7Fm4t/
	vtqdudQmZYmpXcQ8GIO75z2hrySP8mCkBT0J62CG2BmSLPzRNwFCCBxkOlEdhk6ElH+ZWdYsL5d
	RumN2t4dikBdRNuCzHxf+VwPxdm/F604VOzpI
X-Gm-Gg: AR+sD13kc4M5BVg7ICYiouMFel7MCChWPyuD098QlEq12lrO7ZDWQviwW8dmqa1CdOL
	ccS4EldqTSnLcTPedV6TJmwiaxEs0lZ9Hfj9cpZ307Jm24p21YOnRKwzzhKfB1wCUtfk0ynYnp1
	Ir+usOR85dqnX++y4f40k07+FSFjRxx6wZTSCJ8vbwy8+tBOHtky2tglaKhwdykIc+uXe/X8nV0
	Vch35r3LUH8Bdd27+JbgjioG/HEAoriHGUel/nzt4B/+yJm2tOZbhGWwP/iwRegBgctMv1iePHI
	fFXrKnSDZx421y6iVT5XDk1bZ+y+jBqTWuKUo8hOoFFutAjenuijtaNyxf0H6swVW3R4VHySo0/
	PC1LwBf5bDG/YDQ==
X-Received: by 2002:ac8:5d4b:0:b0:51c:849b:86b with SMTP id
 d75a77b69052e-52ce620024cmr339604871cf.43.1786246489424; Sat, 08 Aug 2026
 20:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
 <anWdGzfD7HxglsOB@wunner.de> <CAFqHKTm_dHnSP-ceJhbsm3Zsiif+vxM-xqK27b4eXQGQo1Y7Eg@mail.gmail.com>
 <anbl6j9DWiyVQLqS@wunner.de>
In-Reply-To: <anbl6j9DWiyVQLqS@wunner.de>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sat, 8 Aug 2026 20:34:38 -0700
X-Gm-Features: AUfX_mweyjkX-F38sOyUWrypLnlW8oBVW_ltzBHFvQ_K6j2MYCQhsWjJcW5n_4Y
Message-ID: <CAFqHKT=ZzWRdnNCixY5BeLsVE2JUhfmPSNnpw5TFjzu76AocrA@mail.gmail.com>
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 1:16=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> On Fri, Aug 07, 2026 at 05:31:04PM -0700, Derek John Clark wrote:
> > [   25.686128] rtsx_pci 0000:c2:00.0: pciehp: pdev subsystem vendor ID =
mismatch
> [...]
> > reg=3D0x525a10ec expected=3D0x14af1462
>
> The subsystem vendor ID was 0x1462 (MSI) when the card reader was
> enumerated on boot and it is 0x10ec (Realtek) on resume.
>
> Likewise the subystem device ID was 0x14af on boot, 0x525a on resume.
>
> It's another bug in the MSI BIOS (in addition to marking the Root Port
> hotplug-capable):  The BIOS neglected to re-initialize the subsystem
> vendor/device ID registers in config space on resume to the same
> values that it set on boot.  The card reader was likely reset while
> going through the system sleep transition and its config space
> thus needs to be re-initialized.
>
> What happens is that pciehp marks the card reader disconnected
> because it assumes that it was replaced during system sleep.
> It then synthesizes a Presence Detect Changed event:
>
> https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/pci/hotplug/pcie=
hp_core.c#L300
>
> So the pciehp interrupt thread pciehp_ist() will remove the
> rtsx_pci driver and de-enumerate the device.
>
> Replacing or removing PCIe devices during system sleep happens
> all the time (e.g. with Thunderbolt) and we haven't seen issues
> with regards to that.  The likelihood is higher that the lockup
> is caused by rtsx_pci.
>
> Maybe rtsx_pci_remove() blocks somewhere and prevents forward
> progress of the resume transition.  In particular, it calls
> pm_runtime_get_sync() and cancel_delayed_work_sync(), which are
> blocking calls, i.e. they wait for something else to happen.
> You could try commenting those calls out and see if it avoids
> the lockup:
>
> https://elixir.bootlin.com/linux/v7.2-rc6/source/drivers/misc/cardreader/=
rtsx_pcr.c#L1608

This was good instinct. I was able to drill down and find
approximately where it is hanging.

rtsx_pci_remove() ->mfd_remove_devices() -> mfd_remove_devices_fn() ->
platform_device_unregister() -> platform_device_del() -> device_del()
-> bus_remove_device() -> device_release_driver() ->
device_release_driver_internal() -> __device_release_driver() ->
device_remove()

In device_remove() (drivers/base/dd.c) it gets past
device_remove_groups() and hangs before completing this if block:

if (dev->bus && dev->bus->remove)
    dev->bus->remove(dev);
else if (dev->driver->remove)
    dev->driver->remove(dev);

After this logging stops.

- Derek


> Another possibility is a crash due to a NULL pointer deref or
> GPF somewhere in that driver.  This is pretty difficult to debug
> if there's no possibility to see any dmesg output.

> Even if we manage to find the root cause of the lockup, as long as
> the BIOS isn't fixed, the card reader will always be de-enumerated
> and re-enumerated on resume and consequently the card will briefly
> disappear.  This will make it impossible to use the card as root
> filesystem.

I agree. Even if we were to convince them to fix it, there are plenty
of devices in the wild that will likely never get the BIOS update
since MSI isn't using LFVS for this device. (I'm not sure if they do
that for any device)
> > I've been using a SanDisk Ultra 32GB microSDHC UHS-I Card. And yes, it
> > only happens when the card is present.
>
> If you go to sleep and resume without SD card, do you then see in dmesg
> that the card reader was de-enumerated and re-enumerated?  Normally
> there should be at least a "Card not present" / "Card present" message
> from pciehp, if it sensed a replaced device.  ("Card" refers to PCIe card=
,
> not SD card.)

i get card not present, then card present, then link up.
>
> Also, what's the subsystem vendor/device ID as seen with lspci after
> a successful system sleep transition (successful =3D without SD card)?

it reflects the Realtek device VID/PID. I also tested resume after the
1 cycle with it re-inserted and it works fine after the first cycle,
presumably because the device id matches on the second run and beyond

Thanks,
Derek.

> Thanks,
>
> Lukas

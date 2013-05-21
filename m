Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.messageme.de ([85.93.18.63]:32801 "EHLO mail.mueller.mn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265Ab3EUTAU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 May 2013 15:00:20 -0400
Message-ID: <519BC20F.2000800@mueller.mn>
Date: Tue, 21 May 2013 20:50:55 +0200
From: Sebastian <ML-kernel.org@mueller.mn>
MIME-Version: 1.0
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC: Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: enabling aspm on ati radeon
References: <519443A1.8050905@ubuntu.com> <5196D765.9020600@ubuntu.com> <CAErSpo6MGwHLJvis+4=vdQEJN=Qb9aC5e9=3Q6MdTB-HH84YBw@mail.gmail.com> <11045555.dLhhFPGoSV@vostro.rjw.lan> <519B7739.1040909@ubuntu.com>
In-Reply-To: <519B7739.1040909@ubuntu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I read this thread lately and added the force option to my linux-3.9.2.

While most devices enabled ASPM, onboard Ethernet doesnt.
Board is an ASRock 760GM-GS3 and Ethernet chip seems to be RTL8111E.
According to google it looks like this chip isnt able to ASPM, also 
LnkCap shows support, if I interpret LnkCap right.
Back to topic, my Radeon 5450 Evergreen got ASPM enabled.

01:00.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI 
Manhattan [Mobility Radeon HD 5430 Series] (prog-if 00 [VGA controller])
                 LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, 
Latency L0 <64ns, L1 <1us
                         ClockPM- Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- 
Retrain- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         Kernel driver in use: radeon

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 06)
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <512ns, L1 <64us
                         ClockPM+ Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
         Kernel driver in use: r8169



Am 21.05.2013 15:31, schrieb Phillip Susi:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 5/20/2013 4:01 PM, Rafael J. Wysocki wrote:
>> I'm pretty sure it's measurable, at least in some cases.  Phoronix
>> did quite some fuss about a commit that caused ASPM to not work any
>> more on some systems some time ago, so he had to be able to measure
>> it (and it was called a "major power regression").
> That is why I was trying to get it enabled, but the "major regression"
> seems to be caused by Radeons using the ASPM as a cue to enter low
> power mode.  The energy saved by the bus itself going into the lower
> power state I can't imagine is more than a few mW.
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.17 (MingW32)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iQEcBAEBAgAGBQJRm3c5AAoJEJrBOlT6nu75MkUH/3qGUjM3BmDFjCJ5kJUaMOCg
> Ps3YFcr37JPumLZNLAwAHeL+eZH1v8G1SkDKPFMfPjIMCY4II4xxthFutV6bslQv
> PR5w5jjAg/qk0YXEq8CddhdZkVkJw8nKBZiN6jFFcn/c1UgFN39FHCzUTa3sMG2X
> +rEM4RHzrtcIJm46KXkI162Dzcnj7UaGTFYUzwMCxzy3XHn8xKMS1tfsM1TW3sqS
> ptcqbsy1rObJewAhdnQZ0pzRgLC7zKWkGlLo00JdFW7wChjsVbM2db++FlpkCT0W
> sHSSEEYLFqef+fU9FHptJklMx31nF8QHDGh3S277YqTuIaanMufo+gx4vHJC3tM=
> =tcAW
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


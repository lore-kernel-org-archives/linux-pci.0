Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792840367;
	b=WqAhASfpEk0qLCImDyI498Dk3vyHHjL6RMx1PdzZO6SeSUXr8psgtorJr8IwDab7cWTH
	 UtkogLTH92G0ydwvvobmGGhXWvUmY7gCnf9aMbL/sgK3f0jqjrBO1fwUZXqTmlf4vqlK8
	 X/nma5b7gThY4NjAd1Z9cZxf2o89Qhgp+vxIrkK+gyWYGCxsE07BG/eAHwJ1Fqq7vkoZu
	 ZP7bItmpPDDufxn0LkNlh8TCe7J5v1oqTuD+bG94P+WQgZcjvZTqFPs3u9bfZn/540zZq
	 oAkta5JgSgniABMG/ar+zkz8UuZ2TsGNXX0C+Li6nw1LsohfLpS+giEMmFgIuZERHTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840367;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Transfer-Encoding;
	bh=JTzqcbEp89olsHJDj6fg5IXDHBS7+wh/qofgIArVY/I=;
	b=bG2uLq/cigokqjFfBh4ejGEMQoIfV2+orMmWA1P/Vlar6WTjLXNVrUN0cirXP4Xxpt45
	 M0Av7ag6v025umgMp9gTiabZCy18uzDfalvul4HyZ/XPV06JQ9970+uZekIbFejdVxQnV
	 92L0Y5fPF5ThjAh+4/o/ql2P0yzpsiUAblCcpqxtK+ax4+IuHw9162/Jm8fz7yuXcJB0B
	 p0OsTmFbMovOKDYqPL7jDcb3CHRS9pyUBqo+kaVyeG77vznTn7bZ5m09er9NG/BSNy4TA
	 N8AMe9KeWbySBokVQvrAbSoYGhYCRWpNbE653yiif1qcelAUAvkYxYb6ee6V2hdJm/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=florianmueller.de;
	spf=none smtp.mailfrom=florianmueller.de;
	dkim=pass header.d=florianmueller.de header.i=@florianmueller.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Btq6+6q3;
	dkim=pass header.d=florianmueller.de header.i=@florianmueller.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=07oPNOYs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EBC606A31A;
	Sat, 24 Oct 2026 11:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75EBC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=florianmueller.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=florianmueller.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=florianmueller.de header.i=@florianmueller.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Btq6+6q3;
	dkim=pass header.d=florianmueller.de header.i=@florianmueller.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=07oPNOYs
ARC-Seal: i=1; a=rsa-sha256; t=1792840315; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rRlAtKYRZh6th0c2CrFQDJvhnd90XRV1lPlZ09q5wsivkkno7ERg5/gQFz+CjydMZk
    9DAMefNnai/12bEYzzH6qYuQkO2T3lcLcJ/EOs5qUV5rtgOL6eZ5yRwDHzdpFwLvFbkY
    Z+xalGmccvhitDBnJZjPnyjLNY2o2xhB7eZBHWb+uyWLGuZwwkJO0W/IcT9nj+94eOBF
    GEL+SiNVYlVKeQXLI2e47/Z8PXRBoWCbdc32cxEVrFL7gfhlH7f2+cv/V7e9MDryTVTW
    hnUOh/wJOfVwHVgTLaLsNdad82QshL47B5DcWLtbQfydsqGbXg5nJ79bIauLhD2dBWkv
    aV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792840315;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JTzqcbEp89olsHJDj6fg5IXDHBS7+wh/qofgIArVY/I=;
    b=r0eBY9jgIe4QQwPAiXpqsP2YR9UIUZi9Idh4yPkK45xk/9a7QQ6UEgjTrnV/DPSuWm
    AcJa0t6OrxOUltJ6GrL5VbcdXGfZMBAqNs8guUcQOdjjntxIZpJQC9I+gUfAPPzSoHTz
    CbkpTR7UdF0oy8JJivwCBjZP4pMVJoPGtth5IS8RNflbKHX3lZ81UYDaFD1xFCDWm6YY
    ki/Mnw0OsOscDWtXlKIABEubBR0OymkXc/zRUmJcV0rf6mdLsQ9QTXskOAedkt8FSnQw
    dJUh9pXQW1p59t7cPz6eI7JexbozBiIcoukdfyfz6HFCNN4F3+WNyAsI5wn+p8qnY4yP
    Ywig==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792840315;
    s=strato-dkim-0002; d=florianmueller.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JTzqcbEp89olsHJDj6fg5IXDHBS7+wh/qofgIArVY/I=;
    b=Btq6+6q3opJzSzmlPcaJt/BXgm5yomc04364nfyPnD5uDo0aIzY9X0GIiIVXrpjT0W
    AY001YkO+7QPGQ27Rn40B7SnYBAbiIVODcpiPv9KzFszLdfeFwA35wy5kP01qKbtiJxR
    0KyKZ+d73PhefvBwaqxIpdv6MRlcbkmBYFdLRH+XCq8jvwh5Zbv0X1en6010Ui23vhcs
    vmvNpP4q6SjSSi+MPpYfNu/1dxI3RAjpJ5OBD2KqZ+MIDANdgcsZQbKi/LDNFG0Aih6u
    B7f+PfIfTu3Du5KieLrnSTyNB4dX22bcufFvHNhN0USUqkr2Hn8Tv/lINACCoOByNVVc
    beUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792840315;
    s=strato-dkim-0003; d=florianmueller.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JTzqcbEp89olsHJDj6fg5IXDHBS7+wh/qofgIArVY/I=;
    b=07oPNOYsoedzAYMSOdJde7Vt6T1XM2z2EES4PkPokSmSrpmKGGkF9UB4WpXeVTYaDD
    FSznocDAa3w175W3VFBQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1Eu1RG26iKt5QjaYWz7MIDgRVqlmh5r0hGPGDqh4P7mFZWs+gmz1C0aCeIKuKmV0nRs="
Received: from [192.168.178.31]
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id tfd1db29OBBtj6Z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 24 Oct 2026 13:11:55 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------ILk42eMcpKolmm5R0tbJzz9L"
Message-ID: <793689a4-0136-4671-a392-3bf0fa5de2c4@florianmueller.de>
Date: Sat, 24 Oct 2026 13:11:53 +0200
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ALSA: hda/intel: "no codecs initialized" (CORB reset
 timeout) on Acer Aspire 4820G since v6.16
To: Takashi Iwai <tiwai@suse.de>, kernel@florianmueller.de
Cc: linux-sound@vger.kernel.org, perex@perex.cz, regressions@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, bhelgaas@google.com,
 rafael@kernel.org
References: <184896de-1e21-4abb-a224-eda0b5bddfc6@florianmueller.de>
 <87pkx4j1m1.wl-tiwai@suse.de>
From: kernel@florianmueller.de
Content-Language: en-US, de-DE
In-Reply-To: <87pkx4j1m1.wl-tiwai@suse.de>
Content-Transfer-Encoding: 8bit

This is a multi-part message in MIME format.
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Takashi,

thanks. Unfortunately, I cannot bisect on this machine (2010 laptop, no 
faster machine available for kernel builds), but I collected more data.

Summary: Acer Aspire 4820G, Intel 5 Series/3400 HDA (8086:3b56) with 
Realtek ALC269VB, switchable graphics (i915 + radeon, dGPU runtime-off). 
Works from 6.9.12 up to 6.15.11, broken since 6.16.0 (also 6.16.12, 
6.18.57 and 7.0.0). 6.8.0 is bad as well, so that looks like an older, 
separate problem that was fixed before 6.9. Kernels are Ubuntu mainline 
builds, kernel command line is only "ro quiet splash".

1. In the failed state all MMIO reads at BAR 0 of 00:1b.0 return all 
ones, also long after the failed probe and after unbind/bind of 
snd_hda_intel: GCAP = 0xffff GCTL = 0xffffffff CORBRP = 0xffff This 
matches the dmesg output: "number of I/O streams is 30" (GCAP = 0xFFFF) 
and "CORB reset timeout#2, CORBRP = 65535".

2. A PCI remove/rescan fixes it (tested on 6.16.0 and 7.0.0): echo 1 > 
/sys/bus/pci/devices/0000:00:1b.0/remove echo 1 > /sys/bus/pci/rescan 
Registers afterwards: GCAP = 0x4401 GCTL = 0x00000101 CORBRP = 0x005a, 
the ALC269VB is detected and the speakers work. Unbind/bind of the 
driver alone does not help. A systemd oneshot doing the remove/rescan at 
boot works as a workaround.

3. The PCI config space looks fine in the failed state. A full "lspci 
-vvnn" diff between failed and fixed state differs only in the MSI 
address/data values of 00:02.0, 00:1b.0, 00:1f.2 and 03:00.0 (vectors 
re-assigned after the re-enumeration). Power state (D0, runtime_status 
active, power/control on), command bits, BARs and bridge windows are 
identical. In the failed state 00:1b.0 shows MSI Enable+ with 
Address/Data 0, which is probably a leftover of the failed probe.

4. Ruled out: - BAR assignment: identical on 6.15.11 and 6.16.0 (same 
e820 map, host bridge windows, BAR 0 = 0xdc500000, /proc/iomem layout). 
- Runtime PM: see 3. - MSI: with snd_hda_intel.enable_msi=0 the device 
shows MSI Enable- and a legacy IRQ, but it still fails.

5. During the rescan the kernel logs pcieport 0000:00:01.0: bridge 
configuration invalid ([bus ff-ff]), reconfiguring although lspci shows 
the same bridge setup (secondary=01) before and after. I do not know 
whether this is related.

6. The same log signature was reported on an Emachines E732 (also 
8086:3b56) with 6.18, where remove/rescan helps as well.

So the controller seems to be unreachable (or stuck internally) when 
snd_hda_intel touches it on 6.16+, while the config space looks normal, 
and only a full re-enumeration recovers it. I cannot tell which change 
in 6.16 causes this, so I added the PCI and PM lists to Cc.

Attached: lspci -vvnn (failed/fixed) with the diff, lspci -vv and 
/proc/iomem for 6.15.11 and 6.16.0, PCI/e820 dmesg lines of both, the 
register dumps, and the dmesg of the working rescan.

Thanks and best regards,
Florian

Am 20.10.26 um 09:02 schrieb Takashi Iwai:
> On Mon, 19 Oct 2026 21:18:02 +0200,
> kernel@florianmueller.de wrote:
>> Hello,
>>
>> the internal HDA codec (Realtek ALC269VB) of my Acer Aspire 4820G is no
>> longer detected since v6.16. Only the HDMI audio of the Radeon remains,
>> so the built-in speakers are silent. Everything up to v6.15.11 works
>> (actually between 6.9 and 6.15.11 - 6.8 also does not work).
> Since HDMI audio is tied to both HD-audio and graphics drivers, it's
> hard to tell, unfortunately.  Could you try git-bisect to find out the
> culprit commit?
>
>
> Takashi
>
>> Hardware
>>    - Acer Aspire 4820G (2010), BIOS V1.25
>>    - Intel PCH HDA controller 0000:00:1b.0, codec Realtek ALC269VB
>>    - Switchable graphics: Intel (i915) + ATI Radeon (radeon), vga_switcheroo
>>    - ATI HDMI audio at 0000:01:00.1
>>
>> Setup
>>    Xubuntu 26.04.1; kernels are the Ubuntu mainline builds from
>>    kernel.ubuntu.com/mainline (6.16.0-061600-generic etc.), except
>>    6.8.0-147-generic (Ubuntu). Kernel command line: quiet splash.
>>    Every test was a full reboot, a subset of them cold boots (power off).
>>    The pattern is fully consistent and reproducible.
>>
>> Results
>>    good: 6.9.12, 6.11.11, 6.12.113, 6.14.11, 6.15.11
>>    bad:  6.16.0, 6.16.12, 6.18.57, 7.0.0-38
>>    also bad: 6.8.0-147 (Ubuntu), but 6.9.12 is good, so that could be an
>>    older, separate or related problem that was fixed for 6.9.
>>    No 6.16-rc builds were available in the archive, so I could not narrow
>>    it down further than v6.15.11 (good) -> v6.16.0 (bad).
>>
>> Log on bad kernels (6.16.0)
>>    snd_hda_intel 0000:00:1b.0: number of I/O streams is 30, forcing
>> separate stream tags
>>    snd_hda_intel 0000:00:1b.0: CORB reset timeout#2, CORBRP = 65535
>>    hdaudio hdaudioC1D0: no AFG or MFG node found
>>    (same for hdaudioC1D1, C1D2, C1D3)
>>    snd_hda_intel 0000:00:1b.0: no codecs initialized
>>
>> Log on good kernels (6.15.11)
>>    The "number of I/O streams is 30" line is not printed, and
>>    snd_hda_codec_realtek binds:
>>    snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC269VB:
>> line_outs=1 ...
>>
>> Observation
>>    "30 streams" is what one would get from a GCAP value of 0xFFFF
>>    (ISS = OSS = 15), and CORBRP = 65535 is also all ones. This looks like
>>    the controller is not accessible (or still in reset/low power) when the
>>    driver probes it on 6.16 and later. This is only my interpretation of
>>    the numbers - please ignore, if it does not make sense.
>>
>> Attached: dmesg (hda|codec|CORB), uname -r and aplay -l for 6.8.0,
>> 6.9.12, 6.15.11,
>> 6.16.0, 6.18.57 and 7.0.0, plus alsa-info and lspci -nnk.
>>
>> I am happy to test patches or answer questions.
>>
>> One thing that we get to say to rarely:
>> Thank you very much to you and all the kernel developers for the great
>> work and great dedication to FOSS software!
>>
>> Thanks,
>> Florian
>> ~$ uname -r
>> 6.8.0-147-generic
>> ~$ sudo dmesg | grep -i -E "hda|codec|CORB"
>> [sudo: authenticate] Passwort:
>> [   18.091190] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
>> [   18.091570] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
>> [   18.092098] snd_hda_intel 0000:00:1b.0: number of I/O streams is 30, forcing separate stream tags
>> [   18.196646] snd_hda_intel 0000:00:1b.0: CORB reset timeout#2, CORBRP = 65535
>> [   18.208215] hdaudio hdaudioC0D0: no AFG or MFG node found
>> [   18.208240] hdaudio hdaudioC0D1: no AFG or MFG node found
>> [   18.208254] hdaudio hdaudioC0D2: no AFG or MFG node found
>> [   18.208266] hdaudio hdaudioC0D3: no AFG or MFG node found
>> [   18.208270] snd_hda_intel 0000:00:1b.0: no codecs initialized
>> [   19.914898] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
>> [   19.985798] snd_hda_intel 0000:01:00.1: bound 0000:01:00.0 (ops radeon_audio_component_bind_ops [radeon])
>> [   20.018723] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input16
>> ~$ aplay -l
>> **** Liste der Hardware-Geräte (PLAYBACK) ****
>> Karte 0: HDMI [HDA ATI HDMI], Gerät 3: HDMI 0 [HDMI 0]
>>    Sub-Geräte: 1/1
>>    Sub-Gerät #0: subdevice #0
>> ~$ uname -r
>> 6.9.12-060912-generic
>> ~$ sudo dmesg | grep -i -E "hda|codec|CORB"
>> [sudo: authenticate] Passwort:
>> [    8.489918] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
>> [    8.509215] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
>> [    8.532525] snd_hda_intel 0000:01:00.1: bound 0000:01:00.0 (ops radeon_audio_component_bind_ops [radeon])
>> [    8.533963] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input14
>> [    8.700320] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
>> [    8.752819] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC269VB: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
>> [    8.752834] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>> [    8.752839] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
>> [    8.752843] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
>> [    8.752846] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
>> [    8.752848] snd_hda_codec_realtek hdaudioC1D0:    inputs:
>> [    8.752852] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x18
>> [    8.752855] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
>> [    8.776195] input: HDA Intel MID Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input17
>> [    8.776827] input: HDA Intel MID Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input18
>> ~$ aplay -l
>> **** Liste der Hardware-Geräte (PLAYBACK) ****
>> Karte 0: HDMI [HDA ATI HDMI], Gerät 3: HDMI 0 [HDMI 0]
>>    Sub-Geräte: 1/1
>>    Sub-Gerät #0: subdevice #0
>> Karte 1: MID [HDA Intel MID], Gerät 0: ALC269VB Analog [ALC269VB Analog]
>>    Sub-Geräte: 1/1
>>    Sub-Gerät #0: subdevice #0
>> Karte 1: MID [HDA Intel MID], Gerät 1: ALC269VB Digital [ALC269VB Digital]
>>    Sub-Geräte: 1/1
>>    Sub-Gerät #0: subdevice #0
>> ~$ uname -r
>> 6.15.11-061511-generic
>> ~$ sudo dmesg | grep -i -E "hda|codec|CORB"
>> [sudo: authenticate] Passwort:
>> [   10.356203] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
>> [   10.356988] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
>> [   10.375145] snd_hda_intel 0000:01:00.1: bound 0000:01:00.0 (ops radeon_audio_component_bind_ops [radeon])
>> [   10.375865] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
>> [   10.376734] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input16
>> [   10.539973] snd_hda_codec_realtek hdaudioC1D0: ALC269VB: picked fixup  for PCI SSID 1025:0000
>> [   10.541278] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC269VB: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
>> [   10.541291] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>> [   10.541296] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
>> [   10.541300] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
>> [   10.541303] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
>> [   10.541306] snd_hda_codec_realtek hdaudioC1D0:    inputs:
>> [   10.541309] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
>> [   10.541313] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x18
>> [   10.853762] input: HDA Intel MID Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input17
>> [   10.853978] input: HDA Intel MID Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input18
>> ~$ aplay -l
>> **** Liste der Hardware-Geräte (PLAYBACK) ****
>> Karte 0: HDMI [HDA ATI HDMI], Gerät 3: HDMI 0 [HDMI 0]
>>    Sub-Geräte: 1/1
>>    Sub-Gerät #0: subdevice #0
>> Karte 1: MID [HDA Intel MID], Gerät 0: ALC269VB Analog [ALC269VB Analog]
>>    Sub-Geräte: 1/1
>>    Sub-Gerät #0: subdevice #0
>> Karte 1: MID [HDA Intel MID], Gerät 1: ALC269VB Digital [ALC269VB Digital]
>>    Sub-Geräte: 1/1
>>    Sub-Gerät #0: subdevice #0
>> ~$ uname -r
>> 6.16.0-061600-generic
>> ~$ sudo dmesg | grep -i -E "hda|codec|CORB"
>> [sudo: authenticate] Passwort:
>> [    8.587748] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
>> [    8.590394] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
>> [    8.614173] snd_hda_intel 0000:01:00.1: bound 0000:01:00.0 (ops radeon_audio_component_bind_ops [radeon])
>> [    8.615630] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card0/input14
>> [    9.641195] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
>> [    9.642145] snd_hda_intel 0000:00:1b.0: number of I/O streams is 30, forcing separate stream tags
>> [    9.746677] snd_hda_intel 0000:00:1b.0: CORB reset timeout#2, CORBRP = 65535
>> [    9.748114] hdaudio hdaudioC1D0: no AFG or MFG node found
>> [    9.748140] hdaudio hdaudioC1D1: no AFG or MFG node found
>> [    9.748154] hdaudio hdaudioC1D2: no AFG or MFG node found
>> [    9.748167] hdaudio hdaudioC1D3: no AFG or MFG node found
>> [    9.748172] snd_hda_intel 0000:00:1b.0: no codecs initialized
>> ~$ aplay -l
>> **** Liste der Hardware-Geräte (PLAYBACK) ****
>> Karte 0: HDMI [HDA ATI HDMI], Gerät 3: HDMI 0 [HDMI 0]
>>    Sub-Geräte: 1/1
>>    Sub-Gerät #0: subdevice #0
>> ~$ uname -r
>> 6.18.57-061857-generic
>> ~$ sudo dmesg | grep -i -E "hda|codec|CORB"
>> [sudo: authenticate] Passwort:
>> [    9.361118] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
>> [    9.392794] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
>> [    9.393187] snd_hda_intel 0000:00:1b.0: number of I/O streams is 30, forcing separate stream tags
>> [    9.402281] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
>> [    9.431922] snd_hda_intel 0000:01:00.1: bound 0000:01:00.0 (ops radeon_audio_component_bind_ops [radeon])
>> [    9.497770] snd_hda_intel 0000:00:1b.0: CORB reset timeout#2, CORBRP = 65535
>> [    9.502431] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input15
>> [    9.502617] hdaudio hdaudioC0D0: no AFG or MFG node found
>> [    9.502636] hdaudio hdaudioC0D1: no AFG or MFG node found
>> [    9.502647] hdaudio hdaudioC0D2: no AFG or MFG node found
>> [    9.502657] hdaudio hdaudioC0D3: no AFG or MFG node found
>> [    9.502661] snd_hda_intel 0000:00:1b.0: no codecs initialized
>> ~$ aplay -l
>> **** Liste der Hardware-Geräte (PLAYBACK) ****
>> Karte 1: HDMI [HDA ATI HDMI], Gerät 3: HDMI 0 [HDMI 0]
>>    Sub-Geräte: 1/1
>>    Sub-Gerät #0: subdevice #0
>> ~$ uname -r
>> 7.0.0-38-generic
>> ~$ sudo dmesg | grep -i -E "hda|codec|CORB"
>> [sudo: authenticate] Passwort:
>> [    8.881157] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
>> [    8.881582] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [i915])
>> [    8.884669] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
>> [    8.886046] snd_hda_intel 0000:00:1b.0: number of I/O streams is 30, forcing separate stream tags
>> [    8.984401] snd_hda_intel 0000:01:00.1: bound 0000:01:00.0 (ops radeon_audio_component_bind_ops [radeon])
>> [    8.991482] snd_hda_intel 0000:00:1b.0: CORB reset timeout#2, CORBRP = 65535
>> [    8.995216] hdaudio hdaudioC0D0: no AFG or MFG node found
>> [    8.995246] hdaudio hdaudioC0D1: no AFG or MFG node found
>> [    8.995261] hdaudio hdaudioC0D2: no AFG or MFG node found
>> [    8.995273] hdaudio hdaudioC0D3: no AFG or MFG node found
>> [    8.995279] snd_hda_intel 0000:00:1b.0: no codecs initialized
>> [    9.036115] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input16
>> ~$ aplay -l
>> **** Liste der Hardware-Geräte (PLAYBACK) ****
>> Karte 1: HDMI [HDA ATI HDMI], Gerät 3: HDMI 0 [HDMI 0]
>>    Sub-Geräte: 1/1
>>    Sub-Gerät #0: subdevice #0
>> ~$ lspci -nnk
>> 00:00.0 Host bridge [0600]: Intel Corporation Core Processor DRAM Controller [8086:0044] (rev 18)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 00:01.0 PCI bridge [0604]: Intel Corporation Core Processor PCI Express x16 Root Port [8086:0045] (rev 18)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: pcieport
>> 00:02.0 VGA compatible controller [0300]: Intel Corporation Core Processor Integrated Graphics Controller [8086:0046] (rev 18)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: i915
>> 	Kernel modules: i915
>> 00:16.0 Communication controller [0780]: Intel Corporation 5 Series/3400 Series Chipset HECI Controller [8086:3b64] (rev 06)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: mei_me
>> 	Kernel modules: mei_me
>> 00:1a.0 USB controller [0c03]: Intel Corporation 5 Series/3400 Series Chipset USB2 Enhanced Host Controller [8086:3b3c] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: ehci-pci
>> 00:1b.0 Audio device [0403]: Intel Corporation 5 Series/3400 Series Chipset High Definition Audio [8086:3b56] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: snd_hda_intel
>> 	Kernel modules: snd_hda_intel
>> 00:1c.0 PCI bridge [0604]: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 1 [8086:3b42] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: pcieport
>> 00:1c.5 PCI bridge [0604]: Intel Corporation 5 Series/3400 Series Chipset PCI Express Root Port 6 [8086:3b4c] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: pcieport
>> 00:1d.0 USB controller [0c03]: Intel Corporation 5 Series/3400 Series Chipset USB2 Enhanced Host Controller [8086:3b34] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: ehci-pci
>> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge [8086:2448] (rev a5)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 00:1f.0 ISA bridge [0601]: Intel Corporation HM55 Chipset LPC Interface Controller [8086:3b09] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: lpc_ich
>> 	Kernel modules: lpc_ich
>> 00:1f.2 SATA controller [0106]: Intel Corporation 5 Series/3400 Series Chipset 4 port SATA AHCI Controller [8086:3b29] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: ahci
>> 	Kernel modules: ahci
>> 00:1f.3 SMBus [0c05]: Intel Corporation 5 Series/3400 Series Chipset SMBus Controller [8086:3b30] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: i801_smbus
>> 	Kernel modules: i2c_i801
>> 00:1f.6 Signal processing controller [1180]: Intel Corporation 5 Series/3400 Series Chipset Thermal Subsystem [8086:3b32] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: intel ips
>> 	Kernel modules: intel_ips
>> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Madison [Mobility Radeon HD 5650/5750 / 6530M/6550M] [1002:68c1]
>> 	Subsystem: Acer Incorporated [ALI] Mobility Radeon HD 5650 [1025:0359]
>> 	Kernel driver in use: radeon
>> 	Kernel modules: radeon, amdgpu
>> 01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Redwood HDMI Audio [Radeon HD 5000 Series] [1002:aa60]
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: snd_hda_intel
>> 	Kernel modules: snd_hda_intel
>> 02:00.0 Ethernet controller [0200]: Qualcomm Atheros AR8151 v1.0 Gigabit Ethernet [1969:1073] (rev c0)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 	Kernel driver in use: atl1c
>> 	Kernel modules: atl1c
>> 03:00.0 Network controller [0280]: Intel Corporation Wireless 7260 [8086:08b1] (rev bb)
>> 	Subsystem: Intel Corporation Dual Band Wireless-AC 7260 [Wilkins Peak 2] [8086:4470]
>> 	Kernel driver in use: iwlwifi
>> 	Kernel modules: iwlwifi
>> 7f:00.0 Host bridge [0600]: Intel Corporation Core Processor QuickPath Architecture Generic Non-core Registers [8086:2c62] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 7f:00.1 Host bridge [0600]: Intel Corporation Core Processor QuickPath Architecture System Address Decoder [8086:2d01] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 7f:02.0 Host bridge [0600]: Intel Corporation Core Processor QPI Link 0 [8086:2d10] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 7f:02.1 Host bridge [0600]: Intel Corporation 1st Generation Core i3/5/7 Processor QPI Physical 0 [8086:2d11] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 7f:02.2 Host bridge [0600]: Intel Corporation 1st Generation Core i3/5/7 Processor Reserved [8086:2d12] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 7f:02.3 Host bridge [0600]: Intel Corporation 1st Generation Core i3/5/7 Processor Reserved [8086:2d13] (rev 05)
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> upload=true&script=true&cardinfo=
>> !!################################
>> !!ALSA Information Script v 0.5.3
>> !!################################
>>
>> !!Script ran on: Mon Oct 19 19:03:24 UTC 2026
>>
>>
>> !!Linux Distribution
>> !!------------------
>>
>> Ubuntu 26.04.1 LTS \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 26.04.1 LTS" PRETTY_NAME="Ubuntu 26.04.1 LTS" NAME="Ubuntu" ID=ubuntu ID_LIKE=debian HOME_URL="https://www.ubuntu.com/" SUPPORT_URL="https://help.ubuntu.com/" BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/" PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy" UBUNTU_CODENAME=resolute LOGO=ubuntu-logo
>>
>>
>> !!DMI Information
>> !!---------------
>>
>> Manufacturer:      Acer
>> Product Name:      Aspire 4820G
>> Product Version:   V1.25
>> Firmware Version:  V1.25
>> System SKU:        Calpella_CRB
>> Board Vendor:      Acer
>> Board Name:        JM41_CP
>>
>>
>> !!ACPI Device Status Information
>> !!---------------
>>
>> /sys/bus/acpi/devices/LNXVIDEO:02/status 	 15
>> /sys/bus/acpi/devices/PNP0103:00/status 	 15
>> /sys/bus/acpi/devices/PNP0C0A:00/status 	 31
>> /sys/bus/acpi/devices/PNP0C0F:00/status 	 9
>> /sys/bus/acpi/devices/PNP0C0F:01/status 	 9
>> /sys/bus/acpi/devices/PNP0C0F:02/status 	 9
>> /sys/bus/acpi/devices/PNP0C0F:03/status 	 9
>> /sys/bus/acpi/devices/PNP0C0F:04/status 	 9
>> /sys/bus/acpi/devices/PNP0C0F:05/status 	 9
>> /sys/bus/acpi/devices/PNP0C0F:06/status 	 9
>> /sys/bus/acpi/devices/PNP0C0F:07/status 	 9
>>
>>
>> !!ACPI SoundWire Device Status Information
>> !!---------------
>>
>>
>>
>> !!Kernel Information
>> !!------------------
>>
>> Kernel release:    #202507272138 SMP PREEMPT_DYNAMIC Sun Jul 27 22:00:36 UTC 2025
>> Operating System:  GNU/Linux
>> Architecture:      x86_64
>> Processor:         unknown
>> SMP Enabled:       Yes
>>
>>
>> !!ALSA Version
>> !!------------
>>
>> Driver version:     k6.16.0-061600-generic
>> Library version:
>> Utilities version:  1.2.15.2
>>
>>
>> !!Loaded ALSA modules
>> !!-------------------
>>
>> snd_hda_intel (card 0)
>>
>>
>> !!Sound Servers on this system
>> !!----------------------------
>>
>> PipeWire:
>>        Installed - Yes (/usr/bin/pipewire)
>>        Running - Yes
>>
>> Pulseaudio:
>>        Installed - Yes (/usr/bin/pulseaudio)
>>        Running - No
>>
>>
>> !!Soundcards recognised by ALSA
>> !!-----------------------------
>>
>>   0 [HDMI           ]: HDA-Intel - HDA ATI HDMI
>>                        HDA ATI HDMI at 0xdc420000 irq 29
>>
>>
>> !!PCI Soundcards installed in the system
>> !!--------------------------------------
>>
>> 00:1b.0 Audio device [0403]: Intel Corporation 5 Series/3400 Series Chipset High Definition Audio [8086:3b56] (rev 05) (prog-if 00 [HDA compatible])
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>> 01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Redwood HDMI Audio [Radeon HD 5000 Series] [1002:aa60] (prog-if 00 [HDA compatible])
>> 	Subsystem: Acer Incorporated [ALI] Device [1025:0359]
>>
>>
>> !!Modprobe options (Sound related)
>> !!--------------------------------
>>
>> snd_pcsp: index=-2
>> snd_atiixp_modem: index=-2
>> snd_intel8x0m: index=-2
>> snd_via82xx_modem: index=-2
>> snd_atiixp_modem: index=-2
>> snd_intel8x0m: index=-2
>> snd_via82xx_modem: index=-2
>> snd_usb_audio: index=-2
>> snd_usb_caiaq: index=-2
>> snd_usb_ua101: index=-2
>> snd_usb_us122l: index=-2
>> snd_usb_usx2y: index=-2
>> snd_cmipci: mpu_port=0x330 fm_port=0x388
>> snd_pcsp: index=-2
>> snd_usb_audio: index=-2
>>
>>
>> !!Loaded sound module options
>> !!---------------------------
>>
>> !!Module: snd_hda_intel
>> 	align_buffer_size : -1
>> 	bdl_pos_adj : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>> 	beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
>> 	ctl_dev_id : N
>> 	dmic_detect : Y
>> 	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
>> 	enable_msi : -1
>> 	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
>> 	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>> 	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
>> 	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
>> 	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
>> 	pm_blacklist : -1
>> 	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>> 	power_save : 1
>> 	power_save_controller : Y
>> 	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
>> 	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
>> 	single_cmd : -1
>> 	snoop : -1
>>
>>
>> !!Sysfs card info
>> !!---------------
>>
>> !!Card: /sys/class/sound/card0
>> Driver: /sys/bus/pci/drivers/snd_hda_intel
>> Tree:
>> 	/sys/class/sound/card0
>> 	|-- controlC0
>> 	|   |-- dev
>> 	|   |-- device -> ../../card0
>> 	|   |-- power
>> 	|   |-- subsystem -> ../../../../../../../class/sound
>> 	|   `-- uevent
>> 	|-- device -> ../../../0000:01:00.1
>> 	|-- hwC0D0
>> 	|   |-- afg
>> 	|   |-- chip_name
>> 	|   |-- clear
>> 	|   |-- dev
>> 	|   |-- device -> ../../card0
>> 	|   |-- driver_pin_configs
>> 	|   |-- hints
>> 	|   |-- init_pin_configs
>> 	|   |-- init_verbs
>> 	|   |-- mfg
>> 	|   |-- modelname
>> 	|   |-- power
>> 	|   |-- power_off_acct
>> 	|   |-- power_on_acct
>> 	|   |-- reconfig
>> 	|   |-- revision_id
>> 	|   |-- subsystem -> ../../../../../../../class/sound
>> 	|   |-- subsystem_id
>> 	|   |-- uevent
>> 	|   |-- user_pin_configs
>> 	|   |-- vendor_id
>> 	|   `-- vendor_name
>> 	|-- id
>> 	|-- input14
>> 	|   |-- capabilities
>> 	|   |-- device -> ../../card0
>> 	|   |-- event7
>> 	|   |-- id
>> 	|   |-- inhibited
>> 	|   |-- modalias
>> 	|   |-- name
>> 	|   |-- phys
>> 	|   |-- power
>> 	|   |-- properties
>> 	|   |-- subsystem -> ../../../../../../../class/input
>> 	|   |-- uevent
>> 	|   `-- uniq
>> 	|-- number
>> 	|-- pcmC0D3p
>> 	|   |-- dev
>> 	|   |-- device -> ../../card0
>> 	|   |-- pcm_class
>> 	|   |-- power
>> 	|   |-- subsystem -> ../../../../../../../class/sound
>> 	|   `-- uevent
>> 	|-- power
>> 	|   |-- async
>> 	|   |-- autosuspend_delay_ms
>> 	|   |-- control
>> 	|   |-- runtime_active_kids
>> 	|   |-- runtime_active_time
>> 	|   |-- runtime_enabled
>> 	|   |-- runtime_status
>> 	|   |-- runtime_suspended_time
>> 	|   `-- runtime_usage
>> 	|-- subsystem -> ../../../../../../class/sound
>> 	`-- uevent
>>
>>
>> !!HDA-Intel Codec information
>> !!---------------------------
>> --startcollapse--
>>
>> Codec: ATI R6xx HDMI
>> Address: 0
>> AFG Function Id: 0x1 (unsol 0)
>> Vendor Id: 0x1002aa01
>> Subsystem Id: 0x00aa0100
>> Revision Id: 0x100200
>> No Modem Function Group found
>> Default PCM:
>>      rates [0x70]: 32000 44100 48000
>>      bits [0x2]: 16
>>      formats [0x1]: PCM
>> Default Amp-In caps: N/A
>> Default Amp-Out caps: N/A
>> State of AFG node 0x01:
>>    Power states:  D0 D3
>>    Power: setting=D0, actual=D0
>> GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
>> Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
>>    Converter: stream=0, channel=0
>>    Digital: Enabled GenLevel
>>    Digital category: 0x2
>>    IEC Coding Type: 0x0
>> Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
>>    Pincap 0x00000094: OUT Detect HDMI
>>    Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>>      Conn = Digital, Color = Unknown
>>      DefAssociation = 0x1, Sequence = 0x0
>>    Pin-ctls: 0x40: OUT
>>    Unsolicited: tag=00, enabled=0
>>    Connection: 1
>>       0x02
>> --endcollapse--
>>
>>
>> !!ALSA Device nodes
>> !!-----------------
>>
>> crw-rw----+ 1 root audio 116,  4 Oct 19 20:23 /dev/snd/controlC0
>> crw-rw----+ 1 root audio 116,  3 Oct 19 20:23 /dev/snd/hwC0D0
>> crw-rw----+ 1 root audio 116,  2 Oct 19 20:23 /dev/snd/pcmC0D3p
>> crw-rw----+ 1 root audio 116,  1 Oct 19 20:23 /dev/snd/seq
>> crw-rw----+ 1 root audio 116, 33 Oct 19 20:23 /dev/snd/timer
>>
>> /dev/snd/by-path:
>> total 0
>> drwxr-xr-x  2 root root  60 Oct 19 20:23 .
>> drwxr-xr-x  3 root root 160 Oct 19 20:23 ..
>> lrwxrwxrwx+ 1 root root  12 Oct 19 20:23 pci-0000:01:00.1 -> ../controlC0
>>
>>
>> !!Aplay/Arecord output
>> !!--------------------
>>
>> APLAY
>>
>> **** List of PLAYBACK Hardware Devices ****
>> card 0: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
>>    Subdevices: 1/1
>>    Subdevice #0: subdevice #0
>>
>> ARECORD
>>
>> **** List of CAPTURE Hardware Devices ****
>>
>> !!Amixer output
>> !!-------------
>>
>> !!-------Mixer controls for card HDMI
>>
>> Card sysdefault:0 'HDMI'/'HDA ATI HDMI at 0xdc420000 irq 29'
>>    Mixer name	: 'ATI R6xx HDMI'
>>    Components	: 'HDA:1002aa01,00aa0100,00100200'
>>    Controls      : 7
>>    Simple ctrls  : 1
>> Simple mixer control 'IEC958',0
>>    Capabilities: pswitch pswitch-joined
>>    Playback channels: Mono
>>    Mono: Playback [on]
>>
>>
>> !!Alsactl output
>> !!--------------
>>
>> --startcollapse--
>> state.HDMI {
>> 	control.1 {
>> 		iface CARD
>> 		name 'HDMI/DP,pcm=3 Jack'
>> 		value false
>> 		comment {
>> 			access read
>> 			type BOOLEAN
>> 			count 1
>> 		}
>> 	}
>> 	control.2 {
>> 		iface MIXER
>> 		name 'IEC958 Playback Con Mask'
>> 		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
>> 		comment {
>> 			access read
>> 			type IEC958
>> 			count 1
>> 		}
>> 	}
>> 	control.3 {
>> 		iface MIXER
>> 		name 'IEC958 Playback Pro Mask'
>> 		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
>> 		comment {
>> 			access read
>> 			type IEC958
>> 			count 1
>> 		}
>> 	}
>> 	control.4 {
>> 		iface MIXER
>> 		name 'IEC958 Playback Default'
>> 		value '0482000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
>> 		comment {
>> 			access 'read write'
>> 			type IEC958
>> 			count 1
>> 		}
>> 	}
>> 	control.5 {
>> 		iface MIXER
>> 		name 'IEC958 Playback Switch'
>> 		value true
>> 		comment {
>> 			access 'read write'
>> 			type BOOLEAN
>> 			count 1
>> 		}
>> 	}
>> 	control.6 {
>> 		iface PCM
>> 		device 3
>> 		name ELD
>> 		value ''
>> 		comment {
>> 			access 'read volatile'
>> 			type BYTES
>> 			count 0
>> 		}
>> 	}
>> 	control.7 {
>> 		iface PCM
>> 		device 3
>> 		name 'Playback Channel Map'
>> 		value.0 0
>> 		value.1 0
>> 		value.2 0
>> 		value.3 0
>> 		value.4 0
>> 		value.5 0
>> 		value.6 0
>> 		value.7 0
>> 		comment {
>> 			access 'read write volatile'
>> 			type INTEGER
>> 			count 8
>> 			range '0 - 36'
>> 		}
>> 	}
>> }
>> --endcollapse--
>>
>>
>> !!All Loaded Modules
>> !!------------------
>>
>> acer_wmi
>> ahci
>> amdgpu
>> amdxcp
>> at24
>> atl1c
>> autofs4
>> binfmt_misc
>> bluetooth
>> bnep
>> btbcm
>> btintel
>> btmtk
>> btrtl
>> btusb
>> ccm
>> cec
>> cfg80211
>> coretemp
>> dmi_sysfs
>> drm_buddy
>> drm_display_helper
>> drm_exec
>> drm_panel_backlight_quirks
>> drm_suballoc_helper
>> drm_ttm_helper
>> efi_pstore
>> gpu_sched
>> i2c_algo_bit
>> i2c_i801
>> i2c_mux
>> i2c_smbus
>> i915
>> input_leds
>> intel_cstate
>> intel_ips
>> intel_powerclamp
>> irqbypass
>> iwlmvm
>> iwlwifi
>> joydev
>> kvm
>> kvm_intel
>> libahci
>> libarc4
>> lp
>> lpc_ich
>> mac80211
>> mac_hid
>> mc
>> mei
>> mei_me
>> mei_pxp
>> msr
>> option
>> parport
>> platform_profile
>> ppdev
>> psmouse
>> qrtr
>> radeon
>> rc_core
>> rfcomm
>> sch_fq_codel
>> serio_raw
>> sha1_ssse3
>> snd
>> snd_hda_codec
>> snd_hda_codec_hdmi
>> snd_hda_core
>> snd_hda_intel
>> snd_hrtimer
>> snd_hwdep
>> snd_intel_dspcfg
>> snd_intel_sdw_acpi
>> snd_pcm
>> snd_rawmidi
>> snd_seq
>> snd_seq_device
>> snd_seq_dummy
>> snd_seq_midi
>> snd_seq_midi_event
>> snd_timer
>> soundcore
>> sparse_keymap
>> ttm
>> usb_storage
>> usb_wwan
>> usbserial
>> uvc
>> uvcvideo
>> video
>> videobuf2_common
>> videobuf2_memops
>> videobuf2_v4l2
>> videobuf2_vmalloc
>> videodev
>> wmi
>> wmi_bmof
>>
>>
>> !!Sysfs Files
>> !!-----------
>>
>> /sys/class/sound/hwC0D0/init_pin_configs:
>> 0x03 0x18560010
>>
>> /sys/class/sound/hwC0D0/driver_pin_configs:
>>
>> /sys/class/sound/hwC0D0/user_pin_configs:
>>
>> /sys/class/sound/hwC0D0/init_verbs:
>>
>> /sys/class/sound/hwC0D0/hints:
>>
>>
>> !!ALSA/HDA dmesg
>> !!--------------
>>
>>
>>
>> !!Packages installed
>> !!--------------------
>>
>> ii  alsa-topology-conf                            1.2.5.1-3build1                              all          ALSA topology configuration files
>> ii  alsa-ucm-conf                                 1.2.15.3-1ubuntu1.7                          all          ALSA Use Case Manager configuration files
>> ii  alsa-utils                                    1.2.15.2-1ubuntu1                            amd64        Utilities for configuring and using ALSA
>>
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8; name="diff lspci failed lspci
 fixed.txt"
Content-Disposition: attachment; filename="diff lspci failed lspci fixed.txt"
Content-Transfer-Encoding: base64

ZGlmZiBsc3BjaV9mYWlsZWQudHh0IGxzcGNpX2ZpeGVkLnR4dAo5NmM5Ngo8IAkJQWRkcmVz
czogZmVlMDQwMDAgIERhdGE6IDAwMjAKLS0tCj4gCQlBZGRyZXNzOiBmZWUwMTAwMCAgRGF0
YTogMDAyMwoxNTFjMTUxCjwgCQlBZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAwICBEYXRhOiAw
MDAwCi0tLQo+IAkJQWRkcmVzczogMDAwMDAwMDBmZWUwMTAwMCAgRGF0YTogMDAyMgozNTFj
MzUxCjwgCQlBZGRyZXNzOiBmZWUwMDAwMCAgRGF0YTogMDAyNAotLS0KPiAJCUFkZHJlc3M6
IGZlZTA0MDAwICBEYXRhOiAwMDIyCjUzNGM1MzQKPCAJCUFkZHJlc3M6IDAwMDAwMDAwZmVl
MDUwMDAgIERhdGE6IDAwMjUKLS0tCj4gCQlBZGRyZXNzOiAwMDAwMDAwMGZlZTA1MDAwICBE
YXRhOiAwMDIzCg==
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8; name="lspci_fixed.txt"
Content-Disposition: attachment; filename="lspci_fixed.txt"
Content-Transfer-Encoding: base64

MDA6MDAuMCBIb3N0IGJyaWRnZSBbMDYwMF06IEludGVsIENvcnBvcmF0aW9uIENvcmUgUHJv
Y2Vzc29yIERSQU0gQ29udHJvbGxlciBbODA4NjowMDQ0XSAocmV2IDE4KQoJU3Vic3lzdGVt
OiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6
IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBh
ckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsg
NjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFi
b3J0LSA8TUFib3J0KyA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglDYXBhYmls
aXRpZXM6IFtlMF0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBJbnRlbCBDYXBhYmls
aXRpZXMgdjEKCQlDYXBBOiBQZWc2MERpcy0gUGVnMTJEaXMtIFBlZzExRGlzLSBQZWcxMERp
cy0gUGVMV1VEaXMtIERtaVdpZHRoPXg0CgkJICAgICAgRWNjRGlzLSBGb3JjZUVjY0VuLSBW
VGREaXMrIERtaUcyRGlzLSBQZWdHMkRpcysgRERSTWF4U2l6ZT0yR0IvY2hhbgoJCSAgICAg
IDFORGlzLSBDRERpcy0gRERQQ0RpcysgWDJBUElDRW4rIFBEQ0Rpcy0gSUdEaXMtIENESUQ9
MSBDUklEPTIKCQkgICAgICBERFJPQ0NBUC0gT0NFbisgRERSV3J0VnJlZkVuKyBERFIzTEVu
LQoJCUNhcEI6IEltZ3VEaXMtIE9DYnlTU0tVQ2FwLSBPQ2J5U1NLVUVuLSBTTVRDYXAtIENh
Y2hlU3pDYXAgMHgwCgkJICAgICAgU29mdEJpbkNhcC0gRERSM01heEZyZXFXaXRoUmVmMTAw
PTE2MDBNSHogUGVnRzNEaXMtCgkJICAgICAgUGtnVHlwLSBBZGRHZnhFbi0gQWRkR2Z4Q2Fw
LSBQZWdYMTZEaXMtIERtaUczRGlzLSBHbW1EaXMtCgkJICAgICAgRERSM01heEZyZXE9Mjkz
Mk1IeiBMUEREUjNFbi0KCUtlcm5lbCBtb2R1bGVzOiBpbnRlbF9hZ3AKCjAwOjAxLjAgUENJ
IGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0aW9uIENvcmUgUHJvY2Vzc29yIFBDSSBF
eHByZXNzIHgxNiBSb290IFBvcnQgWzgwODY6MDA0NV0gKHJldiAxOCkgKHByb2ctaWYgMDAg
W05vcm1hbCBkZWNvZGVdKQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBE
ZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWND
eWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RC
MkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJy
LSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlIt
IElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1
cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTYKCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5
PTAxLCBzdWJvcmRpbmF0ZT0wMSwgc2VjLWxhdGVuY3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6
IDMwMDAtM2ZmZiBbc2l6ZT00S10gWzE2LWJpdF0KCU1lbW9yeSBiZWhpbmQgYnJpZGdlOiBk
YzQwMDAwMC1kYzRmZmZmZiBbc2l6ZT0xTV0gWzMyLWJpdF0KCVByZWZldGNoYWJsZSBtZW1v
cnkgYmVoaW5kIGJyaWRnZTogZDAwMDAwMDAtZDdmZmZmZmYgW3NpemU9MTI4TV0gWzMyLWJp
dF0KCVNlY29uZGFyeSBzdGF0dXM6IDY2TUh6LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1m
YXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtIDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0
bDogUGFyaXR5LSBTRVJSKyBOb0lTQS0gVkdBLSBWR0ExNi0gTUFib3J0LSA+UmVzZXQtIEZh
c3RCMkItCgkJUHJpRGlzY1Rtci0gU2VjRGlzY1Rtci0gRGlzY1RtclN0YXQtIERpc2NUbXJT
RVJSRW4tCglDYXBhYmlsaXRpZXM6IFs4OF0gU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRl
ZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNhcGFiaWxpdGllczogWzgwXSBQb3dlciBN
YW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhD
dXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBE
MCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmls
aXRpZXM6IFs5MF0gTVNJOiBFbmFibGUtIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQtCgkJ
QWRkcmVzczogMDAwMDAwMDAgIERhdGE6IDAwMDAKCUNhcGFiaWxpdGllczogW2EwXSBFeHBy
ZXNzICh2MikgUm9vdCBQb3J0IChTbG90KyksIEludE1zZ051bSAwCgkJRGV2Q2FwOglNYXhQ
YXlsb2FkIDEyOCBieXRlcywgUGhhbnRGdW5jIDAKCQkJRXh0VGFnLSBSQkUrIFRFRS1JTy0K
CQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJ
CVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3AtCgkJCU1heFBh
eWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBieXRlcwoJCURldlN0YToJQ29yckVy
ci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyLSBUcmFuc1BlbmQt
CgkJTG5rQ2FwOglQb3J0ICMyLCBTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MTYsIEFTUE0gTDBz
IEwxLCBFeGl0IExhdGVuY3kgTDBzIDwyNTZucywgTDEgPDR1cwoJCQlDbG9ja1BNLSBTdXJw
cmlzZS0gTExBY3RSZXAtIEJ3Tm90KyBBU1BNT3B0Q29tcC0KCQlMbmtDdGw6CUFTUE0gTDBz
IEwxIEVuYWJsZWQ7IFJDQiA2NCBieXRlcywgTG5rRGlzYWJsZS0gQ29tbUNsaysKCQkJRXh0
U3luY2gtIENsb2NrUE0tIEF1dFdpZERpcy0gQldJbnQtIEF1dEJXSW50LSBGbHRNb2RlRGlz
LQoJCUxua1N0YToJU3BlZWQgMi41R1QvcywgV2lkdGggeDE2CgkJCVRyRXJyLSBUcmFpbi0g
U2xvdENsaysgRExBY3RpdmUtIEJXTWdtdC0gQUJXTWdtdC0KCQlTbHRDYXA6CUF0dG5CdG4t
IFB3ckN0cmwtIE1STC0gQXR0bkluZC0gUHdySW5kLSBIb3RQbHVnLSBTdXJwcmlzZS0KCQkJ
U2xvdCAjMTcsIFBvd2VyTGltaXQgNzVXOyBJbnRlcmxvY2stIE5vQ29tcGwrCgkJU2x0Q3Rs
OglFbmFibGU6IEF0dG5CdG4tIFB3ckZsdC0gTVJMLSBQcmVzRGV0LSBDbWRDcGx0LSBIUEly
cS0gTGlua0NoZy0KCQkJQ29udHJvbDogQXR0bkluZCBVbmtub3duLCBQd3JJbmQgVW5rbm93
biwgUG93ZXItIEludGVybG9jay0KCQlTbHRTdGE6CVN0YXR1czogQXR0bkJ0bi0gUG93ZXJG
bHQtIE1STC0gQ21kQ3BsdC0gUHJlc0RldCsgSW50ZXJsb2NrLQoJCQlDaGFuZ2VkOiBNUkwt
IFByZXNEZXQrIExpbmtTdGF0ZS0KCQlSb290Q2FwOiBDUlNWaXNpYmxlLQoJCVJvb3RDdGw6
IEVyckNvcnJlY3RhYmxlLSBFcnJOb24tRmF0YWwtIEVyckZhdGFsLSBQTUVJbnRFbmEtIENS
U1Zpc2libGUtCgkJUm9vdFN0YTogUE1FIFJlcUlEIDAwMDAsIFBNRVN0YXR1cy0gUE1FUGVu
ZGluZy0KCQlEZXZDYXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IE5vdCBTdXBwb3J0ZWQsIFRp
bWVvdXREaXMtIE5ST1ByUHJQLSBMVFItCgkJCSAxMEJpdFRhZ0NvbXAtIDEwQml0VGFnUmVx
LSBPQkZGIE5vdCBTdXBwb3J0ZWQsIEV4dEZtdC0gRUVUTFBQcmVmaXgtCgkJCSBFbWVyZ2Vu
Y3lQb3dlclJlZHVjdGlvbiBOb3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJlZHVjdGlv
bkluaXQtCgkJCSBGUlMtIExOIFN5c3RlbSBDTFMgTm90IFN1cHBvcnRlZCwgVFBIQ29tcC0g
RXh0VFBIQ29tcC0gQVJJRndkLQoJCQkgQXRvbWljT3BzQ2FwOiBSb3V0aW5nLSAzMmJpdC0g
NjRiaXQtIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMg
dG8gNTBtcywgVGltZW91dERpcy0gQVJJRndkLQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0g
RWdyZXNzQmxjay0KCQkJIElET1JlcS0gSURPQ29tcGwtIExUUi0gRW1lcmdlbmN5UG93ZXJS
ZWR1Y3Rpb25SZXEtCgkJCSAxMEJpdFRhZ1JlcS0gT0JGRiBEaXNhYmxlZCwgRUVUTFBQcmVm
aXhCbGstCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDIuNUdUL3MsIEVudGVyQ29t
cGxpYW5jZS0gU3BlZWREaXMtCgkJCSBUcmFuc21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRp
bmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRDb21wbGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkg
Q29tcGxpYW5jZSBQcmVzZXQvRGUtZW1waGFzaXM6IC02ZEIgZGUtZW1waGFzaXMsIDBkQiBw
cmVzaG9vdAoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC02ZEIsIEVx
dWFsaXphdGlvbkNvbXBsZXRlLSBFcXVhbGl6YXRpb25QaGFzZTEtCgkJCSBFcXVhbGl6YXRp
b25QaGFzZTItIEVxdWFsaXphdGlvblBoYXNlMy0gTGlua0VxdWFsaXphdGlvblJlcXVlc3Qt
CgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENyb3NzbGlua1JlczogdW5zdXBwb3J0ZWQsIEZs
dE1vZGUtCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIFZpcnR1YWwgQ2hhbm5lbAoJCUNhcHM6
CUxQRVZDPTAgUmVmQ2xrPTEwMG5zIFBBVEVudHJ5Qml0cz0xCgkJQXJiOglGaXhlZC0gV1JS
MzItIFdSUjY0LSBXUlIxMjgtCgkJQ3RybDoJQXJiU2VsZWN0PUZpeGVkCgkJU3RhdHVzOglJ
blByb2dyZXNzLQoJCVZDMDoJQ2FwczoJUEFUT2Zmc2V0PTAwIE1heFRpbWVTbG90cz0xIFJl
alNub29wVHJhbnMtCgkJCUFyYjoJRml4ZWQrIFdSUjMyLSBXUlI2NC0gV1JSMTI4LSBUV1JS
MTI4LSBXUlIyNTYtCgkJCUN0cmw6CUVuYWJsZSsgSUQ9MCBBcmJTZWxlY3Q9Rml4ZWQgVEMv
VkM9MDEKCQkJU3RhdHVzOglOZWdvUGVuZGluZy0gSW5Qcm9ncmVzcy0KCUtlcm5lbCBkcml2
ZXIgaW4gdXNlOiBwY2llcG9ydAoJS2VybmVsIG1vZHVsZXM6IHNocGNocAoKMDA6MDIuMCBW
R0EgY29tcGF0aWJsZSBjb250cm9sbGVyIFswMzAwXTogSW50ZWwgQ29ycG9yYXRpb24gQ29y
ZSBQcm9jZXNzb3IgSW50ZWdyYXRlZCBHcmFwaGljcyBDb250cm9sbGVyIFs4MDg2OjAwNDZd
IChyZXYgMTgpIChwcm9nLWlmIDAwIFtWR0EgY29udHJvbGxlcl0pCglTdWJzeXN0ZW06IEFj
ZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDogSS9P
KyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJy
LSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1I
ei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQt
IDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDog
cGluIEEgcm91dGVkIHRvIElSUSAyNwoJUmVnaW9uIDA6IE1lbW9yeSBhdCBkODAwMDAwMCAo
NjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00TV0KCVJlZ2lvbiAyOiBNZW1vcnkg
YXQgYzAwMDAwMDAgKDY0LWJpdCwgcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yNTZNXQoJUmVnaW9u
IDQ6IEkvTyBwb3J0cyBhdCA0MDUwIFtzaXplPThdCglFeHBhbnNpb24gUk9NIGF0IDAwMGMw
MDAwIFt2aXJ0dWFsXSBbZGlzYWJsZWRdIFtzaXplPTEyOEtdCglDYXBhYmlsaXRpZXM6IFs5
MF0gTVNJOiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQtCgkJQWRkcmVzczog
ZmVlMDEwMDAgIERhdGE6IDAwMjMKCUNhcGFiaWxpdGllczogW2QwXSBQb3dlciBNYW5hZ2Vt
ZW50IHZlcnNpb24gMgoJCUZsYWdzOiBQTUVDbGstIERTSSsgRDEtIEQyLSBBdXhDdXJyZW50
PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0pCgkJU3RhdHVzOiBEMCBOb1Nv
ZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6
IFthNF0gUENJIEFkdmFuY2VkIEZlYXR1cmVzCgkJQUZDYXA6IFRQKyBGTFIrCgkJQUZDdHJs
OiBGTFItCgkJQUZTdGF0dXM6IFRQLQoJS2VybmVsIGRyaXZlciBpbiB1c2U6IGk5MTUKCUtl
cm5lbCBtb2R1bGVzOiBpOTE1CgowMDoxNi4wIENvbW11bmljYXRpb24gY29udHJvbGxlciBb
MDc4MF06IEludGVsIENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAgU2VyaWVzIENoaXBzZXQg
SEVDSSBDb250cm9sbGVyIFs4MDg2OjNiNjRdIChyZXYgMDYpCglTdWJzeXN0ZW06IEFjZXIg
SW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDogSS9PLSBN
ZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBT
dGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0g
VURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxN
QWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGlu
IEEgcm91dGVkIHRvIElSUSAyNQoJUmVnaW9uIDA6IE1lbW9yeSBhdCBkYzUwNjEwMCAoNjQt
Yml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xNl0KCUNhcGFiaWxpdGllczogWzUwXSBQ
b3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQy
LSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3Rh
dHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglD
YXBhYmlsaXRpZXM6IFs4Y10gTVNJOiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRi
aXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwMDAwMCAgRGF0YTogMDAyMQoJS2VybmVsIGRy
aXZlciBpbiB1c2U6IG1laV9tZQoJS2VybmVsIG1vZHVsZXM6IG1laV9tZQoKMDA6MWEuMCBV
U0IgY29udHJvbGxlciBbMGMwM106IEludGVsIENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAg
U2VyaWVzIENoaXBzZXQgVVNCMiBFbmhhbmNlZCBIb3N0IENvbnRyb2xsZXIgWzgwODY6M2Iz
Y10gKHJldiAwNSkgKHByb2ctaWYgMjAgW0VIQ0ldKQoJU3Vic3lzdGVtOiBBY2VyIEluY29y
cG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkvTy0gTWVtKyBC
dXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBp
bmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0g
RmFzdEIyQisgUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJv
cnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGluIEEg
cm91dGVkIHRvIElSUSAxNgoJUmVnaW9uIDA6IE1lbW9yeSBhdCBkYzUwNWMwMCAoMzItYml0
LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xS10KCUNhcGFiaWxpdGllczogWzUwXSBQb3dl
ciBNYW5hZ2VtZW50IHZlcnNpb24gMgoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBB
dXhDdXJyZW50PTM3NW1BIFBNRShEMCssRDEtLEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0
dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNh
cGFiaWxpdGllczogWzU4XSBEZWJ1ZyBwb3J0OiBCQVI9MSBvZmZzZXQ9MDBhMAoJQ2FwYWJp
bGl0aWVzOiBbOThdIFBDSSBBZHZhbmNlZCBGZWF0dXJlcwoJCUFGQ2FwOiBUUCsgRkxSKwoJ
CUFGQ3RybDogRkxSLQoJCUFGU3RhdHVzOiBUUC0KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBl
aGNpLXBjaQoJS2VybmVsIG1vZHVsZXM6IGVoY2lfcGNpCgowMDoxYi4wIEF1ZGlvIGRldmlj
ZSBbMDQwM106IEludGVsIENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAgU2VyaWVzIENoaXBz
ZXQgSGlnaCBEZWZpbml0aW9uIEF1ZGlvIFs4MDg2OjNiNTZdIChyZXYgMDUpIChwcm9nLWlm
IDAwIFtIREEgY29tcGF0aWJsZV0pCglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtB
TEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3Rlcisg
U3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0g
RmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQ
YXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8
UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElS
USAzMAoJUmVnaW9uIDA6IE1lbW9yeSBhdCBkYzUwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbc2l6ZT0xNktdCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVu
dCB2ZXJzaW9uIDIKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD01
NW1BIFBNRShEMCssRDEtLEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29m
dFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczog
WzYwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNz
OiAwMDAwMDAwMGZlZTAxMDAwICBEYXRhOiAwMDIyCglDYXBhYmlsaXRpZXM6IFs3MF0gRXhw
cmVzcyAodjEpIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50LCBJbnRNc2dOdW0g
MAoJCURldkNhcDoJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwCgkJCUV4dFRh
Zy0gUkJFLSBGTFJlc2V0KyBURUUtSU8tCgkJRGV2Q3RsOglDb3JyRXJyLSBOb25GYXRhbEVy
ci0gRmF0YWxFcnItIFVuc3VwUmVxLQoJCQlSbHhkT3JkLSBFeHRUYWctIFBoYW50RnVuYy0g
QXV4UHdyLSBOb1Nub29wLSBGTFJlc2V0LQoJCQlNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4
UmVhZFJlcSAxMjggYnl0ZXMKCQlEZXZTdGE6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRh
bEVyci0gVW5zdXBSZXEtIEF1eFB3cisgVHJhbnNQZW5kLQoJQ2FwYWJpbGl0aWVzOiBbMTAw
IHYxXSBWaXJ0dWFsIENoYW5uZWwKCQlDYXBzOglMUEVWQz0wIFJlZkNsaz0xMDBucyBQQVRF
bnRyeUJpdHM9MQoJCUFyYjoJRml4ZWQtIFdSUjMyLSBXUlI2NC0gV1JSMTI4LQoJCUN0cmw6
CUFyYlNlbGVjdD1GaXhlZAoJCVN0YXR1czoJSW5Qcm9ncmVzcy0KCQlWQzA6CUNhcHM6CVBB
VE9mZnNldD0wMCBNYXhUaW1lU2xvdHM9MSBSZWpTbm9vcFRyYW5zLQoJCQlBcmI6CUZpeGVk
LSBXUlIzMi0gV1JSNjQtIFdSUjEyOC0gVFdSUjEyOC0gV1JSMjU2LQoJCQlDdHJsOglFbmFi
bGUrIElEPTAgQXJiU2VsZWN0PUZpeGVkIFRDL1ZDPWZmCgkJCVN0YXR1czoJTmVnb1BlbmRp
bmctIEluUHJvZ3Jlc3MtCgkJVkMxOglDYXBzOglQQVRPZmZzZXQ9MDAgTWF4VGltZVNsb3Rz
PTEgUmVqU25vb3BUcmFucy0KCQkJQXJiOglGaXhlZC0gV1JSMzItIFdSUjY0LSBXUlIxMjgt
IFRXUlIxMjgtIFdSUjI1Ni0KCQkJQ3RybDoJRW5hYmxlKyBJRD0xIEFyYlNlbGVjdD1GaXhl
ZCBUQy9WQz0wMAoJCQlTdGF0dXM6CU5lZ29QZW5kaW5nLSBJblByb2dyZXNzLQoJQ2FwYWJp
bGl0aWVzOiBbMTMwIHYxXSBSb290IENvbXBsZXggTGluawoJCURlc2M6CVBvcnROdW1iZXI9
MGYgQ29tcG9uZW50SUQ9MDAgRWx0VHlwZT1Db25maWcKCQlMaW5rMDoJRGVzYzoJVGFyZ2V0
UG9ydD0wMCBUYXJnZXRDb21wb25lbnQ9MDAgQXNzb2NSQ1JCLSBMaW5rVHlwZT1NZW1NYXBw
ZWQgTGlua1ZhbGlkKwoJCQlBZGRyOgkwMDAwMDAwMGZlZDFjMDAwCglLZXJuZWwgZHJpdmVy
IGluIHVzZTogc25kX2hkYV9pbnRlbAoJS2VybmVsIG1vZHVsZXM6IHNuZF9oZGFfaW50ZWwK
CjAwOjFjLjAgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0aW9uIDUgU2VyaWVz
LzM0MDAgU2VyaWVzIENoaXBzZXQgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDEgWzgwODY6M2I0
Ml0gKHJldiAwNSkgKHByb2ctaWYgMDAgW05vcm1hbCBkZWNvZGVdKQoJU3Vic3lzdGVtOiBB
Y2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkv
TysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVy
ci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZN
SHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0
LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5l
IFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTcKCUJ1
czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTAyLCBzdWJvcmRpbmF0ZT0wMiwgc2VjLWxhdGVu
Y3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6IDIwMDAtMmZmZiBbc2l6ZT00S10gWzE2LWJpdF0K
CU1lbW9yeSBiZWhpbmQgYnJpZGdlOiBkYjQwMDAwMC1kYzNmZmZmZiBbc2l6ZT0xNk1dIFsz
Mi1iaXRdCglQcmVmZXRjaGFibGUgbWVtb3J5IGJlaGluZCBicmlkZ2U6IGQ4NDAwMDAwLWQ5
M2ZmZmZmIFtzaXplPTE2TV0gWzMyLWJpdF0KCVNlY29uZGFyeSBzdGF0dXM6IDY2TUh6LSBG
YXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQt
IDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0bDogUGFyaXR5LSBTRVJSKyBOb0lTQS0gVkdBLSBW
R0ExNi0gTUFib3J0LSA+UmVzZXQtIEZhc3RCMkItCgkJUHJpRGlzY1Rtci0gU2VjRGlzY1Rt
ci0gRGlzY1RtclN0YXQtIERpc2NUbXJTRVJSRW4tCglDYXBhYmlsaXRpZXM6IFs0MF0gRXhw
cmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdCspLCBJbnRNc2dOdW0gMAoJCURldkNhcDoJTWF4
UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwCgkJCUV4dFRhZy0gUkJFKyBURUUtSU8t
CgkJRGV2Q3RsOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLQoJ
CQlSbHhkT3JkLSBFeHRUYWctIFBoYW50RnVuYy0gQXV4UHdyLSBOb1Nub29wLQoJCQlNYXhQ
YXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJlcSAxMjggYnl0ZXMKCQlEZXZTdGE6CUNvcnJF
cnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtIEF1eFB3cisgVHJhbnNQZW5k
LQoJCUxua0NhcDoJUG9ydCAjMSwgU3BlZWQgMi41R1QvcywgV2lkdGggeDEsIEFTUE0gTDBz
IEwxLCBFeGl0IExhdGVuY3kgTDBzIDwyNTZucywgTDEgPDR1cwoJCQlDbG9ja1BNLSBTdXJw
cmlzZS0gTExBY3RSZXArIEJ3Tm90LSBBU1BNT3B0Q29tcC0KCQlMbmtDdGw6CUFTUE0gTDEg
RW5hYmxlZDsgUkNCIDY0IGJ5dGVzLCBMbmtEaXNhYmxlLSBDb21tQ2xrKwoJCQlFeHRTeW5j
aC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0QldJbnQtIEZsdE1vZGVEaXMtCgkJ
TG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MQoJCQlUckVyci0gVHJhaW4tIFNsb3RD
bGsrIERMQWN0aXZlKyBCV01nbXQtIEFCV01nbXQtCgkJU2x0Q2FwOglBdHRuQnRuLSBQd3JD
dHJsLSBNUkwtIEF0dG5JbmQtIFB3ckluZC0gSG90UGx1ZysgU3VycHJpc2UrCgkJCVNsb3Qg
IzAsIFBvd2VyTGltaXQgMTBXOyBJbnRlcmxvY2stIE5vQ29tcGwrCgkJU2x0Q3RsOglFbmFi
bGU6IEF0dG5CdG4tIFB3ckZsdC0gTVJMLSBQcmVzRGV0LSBDbWRDcGx0LSBIUElycS0gTGlu
a0NoZy0KCQkJQ29udHJvbDogQXR0bkluZCBVbmtub3duLCBQd3JJbmQgVW5rbm93biwgUG93
ZXItIEludGVybG9jay0KCQlTbHRTdGE6CVN0YXR1czogQXR0bkJ0bi0gUG93ZXJGbHQtIE1S
TC0gQ21kQ3BsdC0gUHJlc0RldCsgSW50ZXJsb2NrLQoJCQlDaGFuZ2VkOiBNUkwtIFByZXNE
ZXQrIExpbmtTdGF0ZSsKCQlSb290Q2FwOiBDUlNWaXNpYmxlLQoJCVJvb3RDdGw6IEVyckNv
cnJlY3RhYmxlLSBFcnJOb24tRmF0YWwtIEVyckZhdGFsLSBQTUVJbnRFbmEtIENSU1Zpc2li
bGUtCgkJUm9vdFN0YTogUE1FIFJlcUlEIDAwMDAsIFBNRVN0YXR1cy0gUE1FUGVuZGluZy0K
CQlEZXZDYXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IFJhbmdlIEJDLCBUaW1lb3V0RGlzKyBO
Uk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBOb3Qg
U3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1
Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkg
RlJTLSBMTiBTeXN0ZW0gQ0xTIE5vdCBTdXBwb3J0ZWQsIFRQSENvbXAtIEV4dFRQSENvbXAt
IEFSSUZ3ZC0KCQkJIEF0b21pY09wc0NhcDogUm91dGluZy0gMzJiaXQtIDY0Yml0LSAxMjhi
aXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRp
bWVvdXREaXMrIEFSSUZ3ZC0KCQkJIEF0b21pY09wc0N0bDogUmVxRW4tIEVncmVzc0JsY2st
CgkJCSBJRE9SZXEtIElET0NvbXBsLSBMVFItIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uUmVx
LQoJCQkgMTBCaXRUYWdSZXEtIE9CRkYgRGlzYWJsZWQsIEVFVExQUHJlZml4QmxrLQoJCUxu
a0N0bDI6IFRhcmdldCBMaW5rIFNwZWVkOiAyLjVHVC9zLCBFbnRlckNvbXBsaWFuY2UtIFNw
ZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwgT3BlcmF0aW5nIFJhbmdlLCBF
bnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5jZVNPUy0KCQkJIENvbXBsaWFuY2Ug
UHJlc2V0L0RlLWVtcGhhc2lzOiAtNmRCIGRlLWVtcGhhc2lzLCAwZEIgcHJlc2hvb3QKCQlM
bmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtNmRCLCBFcXVhbGl6YXRpb25D
b21wbGV0ZS0gRXF1YWxpemF0aW9uUGhhc2UxLQoJCQkgRXF1YWxpemF0aW9uUGhhc2UyLSBF
cXVhbGl6YXRpb25QaGFzZTMtIExpbmtFcXVhbGl6YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1l
ci0gMlJldGltZXJzLSBDcm9zc2xpbmtSZXM6IHVuc3VwcG9ydGVkLCBGbHRNb2RlLQoJQ2Fw
YWJpbGl0aWVzOiBbODBdIE1TSTogRW5hYmxlLSBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0
LQoJCUFkZHJlc3M6IDAwMDAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFs5MF0g
U3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0K
CUNhcGFiaWxpdGllczogW2EwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMgoJCUZsYWdz
OiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0s
RDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERT
ZWw9MCBEU2NhbGU9MCBQTUUtCglLZXJuZWwgZHJpdmVyIGluIHVzZTogcGNpZXBvcnQKCUtl
cm5lbCBtb2R1bGVzOiBzaHBjaHAKCjAwOjFjLjUgUENJIGJyaWRnZSBbMDYwNF06IEludGVs
IENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAgU2VyaWVzIENoaXBzZXQgUENJIEV4cHJlc3Mg
Um9vdCBQb3J0IDYgWzgwODY6M2I0Y10gKHJldiAwNSkgKHByb2ctaWYgMDAgW05vcm1hbCBk
ZWNvZGVdKQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEw
MjU6MDM1OV0KCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVt
V0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lO
VHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9
ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglM
YXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBC
IHJvdXRlZCB0byBJUlEgMTYKCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTAzLCBzdWJv
cmRpbmF0ZT0wMywgc2VjLWxhdGVuY3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6IDEwMDAtMWZm
ZiBbc2l6ZT00S10gWzE2LWJpdF0KCU1lbW9yeSBiZWhpbmQgYnJpZGdlOiBkYTQwMDAwMC1k
YjNmZmZmZiBbc2l6ZT0xNk1dIFszMi1iaXRdCglQcmVmZXRjaGFibGUgbWVtb3J5IGJlaGlu
ZCBicmlkZ2U6IGQ5NDAwMDAwLWRhM2ZmZmZmIFtzaXplPTE2TV0gWzMyLWJpdF0KCVNlY29u
ZGFyeSBzdGF0dXM6IDY2TUh6LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJv
cnQtIDxUQWJvcnQtIDxNQWJvcnQtIDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0bDogUGFyaXR5
LSBTRVJSKyBOb0lTQS0gVkdBLSBWR0ExNi0gTUFib3J0LSA+UmVzZXQtIEZhc3RCMkItCgkJ
UHJpRGlzY1Rtci0gU2VjRGlzY1Rtci0gRGlzY1RtclN0YXQtIERpc2NUbXJTRVJSRW4tCglD
YXBhYmlsaXRpZXM6IFs0MF0gRXhwcmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdCspLCBJbnRN
c2dOdW0gMAoJCURldkNhcDoJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwCgkJ
CUV4dFRhZy0gUkJFKyBURUUtSU8tCgkJRGV2Q3RsOglDb3JyRXJyLSBOb25GYXRhbEVyci0g
RmF0YWxFcnItIFVuc3VwUmVxLQoJCQlSbHhkT3JkLSBFeHRUYWctIFBoYW50RnVuYy0gQXV4
UHdyLSBOb1Nub29wLQoJCQlNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJlcSAxMjgg
Ynl0ZXMKCQlEZXZTdGE6CUNvcnJFcnIrIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBS
ZXEtIEF1eFB3cisgVHJhbnNQZW5kLQoJCUxua0NhcDoJUG9ydCAjNiwgU3BlZWQgMi41R1Qv
cywgV2lkdGggeDEsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDwyNTZucywgTDEg
PDR1cwoJCQlDbG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXArIEJ3Tm90LSBBU1BNT3B0Q29t
cC0KCQlMbmtDdGw6CUFTUE0gTDEgRW5hYmxlZDsgUkNCIDY0IGJ5dGVzLCBMbmtEaXNhYmxl
LSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0
QldJbnQtIEZsdE1vZGVEaXMtCgkJTG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MQoJ
CQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlKyBCV01nbXQtIEFCV01nbXQtCgkJ
U2x0Q2FwOglBdHRuQnRuLSBQd3JDdHJsLSBNUkwtIEF0dG5JbmQtIFB3ckluZC0gSG90UGx1
ZysgU3VycHJpc2UrCgkJCVNsb3QgIzUsIFBvd2VyTGltaXQgMTBXOyBJbnRlcmxvY2stIE5v
Q29tcGwrCgkJU2x0Q3RsOglFbmFibGU6IEF0dG5CdG4tIFB3ckZsdC0gTVJMLSBQcmVzRGV0
LSBDbWRDcGx0LSBIUElycS0gTGlua0NoZy0KCQkJQ29udHJvbDogQXR0bkluZCBVbmtub3du
LCBQd3JJbmQgVW5rbm93biwgUG93ZXItIEludGVybG9jay0KCQlTbHRTdGE6CVN0YXR1czog
QXR0bkJ0bi0gUG93ZXJGbHQtIE1STC0gQ21kQ3BsdC0gUHJlc0RldCsgSW50ZXJsb2NrLQoJ
CQlDaGFuZ2VkOiBNUkwtIFByZXNEZXQrIExpbmtTdGF0ZSsKCQlSb290Q2FwOiBDUlNWaXNp
YmxlLQoJCVJvb3RDdGw6IEVyckNvcnJlY3RhYmxlLSBFcnJOb24tRmF0YWwtIEVyckZhdGFs
LSBQTUVJbnRFbmEtIENSU1Zpc2libGUtCgkJUm9vdFN0YTogUE1FIFJlcUlEIDAwMDAsIFBN
RVN0YXR1cy0gUE1FUGVuZGluZy0KCQlEZXZDYXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IFJh
bmdlIEJDLCBUaW1lb3V0RGlzKyBOUk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wLSAx
MEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJ
CQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93
ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBMTiBTeXN0ZW0gQ0xTIE5vdCBTdXBwb3J0ZWQs
IFRQSENvbXAtIEV4dFRQSENvbXAtIEFSSUZ3ZC0KCQkJIEF0b21pY09wc0NhcDogUm91dGlu
Zy0gMzJiaXQtIDY0Yml0LSAxMjhiaXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1l
b3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMrIEFSSUZ3ZC0KCQkJIEF0b21pY09wc0N0
bDogUmVxRW4tIEVncmVzc0JsY2stCgkJCSBJRE9SZXEtIElET0NvbXBsLSBMVFItIEVtZXJn
ZW5jeVBvd2VyUmVkdWN0aW9uUmVxLQoJCQkgMTBCaXRUYWdSZXEtIE9CRkYgRGlzYWJsZWQs
IEVFVExQUHJlZml4QmxrLQoJCUxua0N0bDI6IFRhcmdldCBMaW5rIFNwZWVkOiAyLjVHVC9z
LCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3Jt
YWwgT3BlcmF0aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5j
ZVNPUy0KCQkJIENvbXBsaWFuY2UgUHJlc2V0L0RlLWVtcGhhc2lzOiAtNmRCIGRlLWVtcGhh
c2lzLCAwZEIgcHJlc2hvb3QKCQlMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVs
OiAtNmRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZS0gRXF1YWxpemF0aW9uUGhhc2UxLQoJCQkg
RXF1YWxpemF0aW9uUGhhc2UyLSBFcXVhbGl6YXRpb25QaGFzZTMtIExpbmtFcXVhbGl6YXRp
b25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9zc2xpbmtSZXM6IHVuc3Vw
cG9ydGVkLCBGbHRNb2RlLQoJQ2FwYWJpbGl0aWVzOiBbODBdIE1TSTogRW5hYmxlLSBDb3Vu
dD0xLzEgTWFza2FibGUtIDY0Yml0LQoJCUFkZHJlc3M6IDAwMDAwMDAwICBEYXRhOiAwMDAw
CglDYXBhYmlsaXRpZXM6IFs5MF0gU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJ
XSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNhcGFiaWxpdGllczogW2EwXSBQb3dlciBNYW5hZ2Vt
ZW50IHZlcnNpb24gMgoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50
PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1Nv
ZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglLZXJuZWwgZHJpdmVy
IGluIHVzZTogcGNpZXBvcnQKCUtlcm5lbCBtb2R1bGVzOiBzaHBjaHAKCjAwOjFkLjAgVVNC
IGNvbnRyb2xsZXIgWzBjMDNdOiBJbnRlbCBDb3Jwb3JhdGlvbiA1IFNlcmllcy8zNDAwIFNl
cmllcyBDaGlwc2V0IFVTQjIgRW5oYW5jZWQgSG9zdCBDb250cm9sbGVyIFs4MDg2OjNiMzRd
IChyZXYgMDUpIChwcm9nLWlmIDIwIFtFSENJXSkKCVN1YnN5c3RlbTogQWNlciBJbmNvcnBv
cmF0ZWQgW0FMSV0gRGV2aWNlIFsxMDI1OjAzNTldCglDb250cm9sOiBJL08tIE1lbSsgQnVz
TWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5n
LSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZh
c3RCMkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0
LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBBIHJv
dXRlZCB0byBJUlEgMjMKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZGM1MDU4MDAgKDMyLWJpdCwg
bm9uLXByZWZldGNoYWJsZSkgW3NpemU9MUtdCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIg
TWFuYWdlbWVudCB2ZXJzaW9uIDIKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4
Q3VycmVudD0zNzVtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVz
OiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBh
YmlsaXRpZXM6IFs1OF0gRGVidWcgcG9ydDogQkFSPTEgb2Zmc2V0PTAwYTAKCUNhcGFiaWxp
dGllczogWzk4XSBQQ0kgQWR2YW5jZWQgRmVhdHVyZXMKCQlBRkNhcDogVFArIEZMUisKCQlB
RkN0cmw6IEZMUi0KCQlBRlN0YXR1czogVFAtCglLZXJuZWwgZHJpdmVyIGluIHVzZTogZWhj
aS1wY2kKCUtlcm5lbCBtb2R1bGVzOiBlaGNpX3BjaQoKMDA6MWUuMCBQQ0kgYnJpZGdlIFsw
NjA0XTogSW50ZWwgQ29ycG9yYXRpb24gODI4MDEgTW9iaWxlIFBDSSBCcmlkZ2UgWzgwODY6
MjQ0OF0gKHJldiBhNSkgKHByb2ctaWYgMDEgW1N1YnRyYWN0aXZlIGRlY29kZV0pCglTdWJz
eXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29u
dHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9v
cC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czog
Q2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQt
IDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUJ1
czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTA0LCBzdWJvcmRpbmF0ZT0wNCwgc2VjLWxhdGVu
Y3k9MzIKCUkvTyBiZWhpbmQgYnJpZGdlOiA1MDAwLTVmZmYgW3NpemU9NEtdIFsxNi1iaXRd
CglNZW1vcnkgYmVoaW5kIGJyaWRnZTogZGM3MDAwMDAtZGM4ZmZmZmYgW3NpemU9Mk1dIFsz
Mi1iaXRdCglQcmVmZXRjaGFibGUgbWVtb3J5IGJlaGluZCBicmlkZ2U6IGRjOTAwMDAwLWRj
YWZmZmZmIFtzaXplPTJNXSBbMzItYml0XQoJU2Vjb25kYXJ5IHN0YXR1czogNjZNSHotIEZh
c3RCMkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0
KyA8U0VSUi0gPFBFUlItCglCcmlkZ2VDdGw6IFBhcml0eS0gU0VSUisgTm9JU0EtIFZHQS0g
VkdBMTYtIE1BYm9ydC0gPlJlc2V0LSBGYXN0QjJCLQoJCVByaURpc2NUbXItIFNlY0Rpc2NU
bXItIERpc2NUbXJTdGF0LSBEaXNjVG1yU0VSUkVuLQoJQ2FwYWJpbGl0aWVzOiBbNTBdIFN1
YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FMSV0gRGV2aWNlIFsxMDI1OjAzNTldCgow
MDoxZi4wIElTQSBicmlkZ2UgWzA2MDFdOiBJbnRlbCBDb3Jwb3JhdGlvbiBITTU1IENoaXBz
ZXQgTFBDIEludGVyZmFjZSBDb250cm9sbGVyIFs4MDg2OjNiMDldIChyZXYgMDUpCglTdWJz
eXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29u
dHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9v
cC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czog
Q2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9y
dC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoJ
Q2FwYWJpbGl0aWVzOiBbZTBdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogSW50ZWwg
RmVhdHVyZSBEZXRlY3Rpb24KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBscGNfaWNoCglLZXJu
ZWwgbW9kdWxlczogbHBjX2ljaAoKMDA6MWYuMiBTQVRBIGNvbnRyb2xsZXIgWzAxMDZdOiBJ
bnRlbCBDb3Jwb3JhdGlvbiA1IFNlcmllcy8zNDAwIFNlcmllcyBDaGlwc2V0IDQgcG9ydCBT
QVRBIEFIQ0kgQ29udHJvbGxlciBbODA4NjozYjI5XSAocmV2IDA1KSAocHJvZy1pZiAwMSBb
QUhDSSAxLjBdKQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2Ug
WzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0g
TWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERp
c0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHorIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZT
RUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5U
eC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGluIEIgcm91dGVkIHRvIElSUSAyNAoJUmVn
aW9uIDA6IEkvTyBwb3J0cyBhdCA0MDQ4IFtzaXplPThdCglSZWdpb24gMTogSS9PIHBvcnRz
IGF0IDQwNWMgW3NpemU9NF0KCVJlZ2lvbiAyOiBJL08gcG9ydHMgYXQgNDA0MCBbc2l6ZT04
XQoJUmVnaW9uIDM6IEkvTyBwb3J0cyBhdCA0MDU4IFtzaXplPTRdCglSZWdpb24gNDogSS9P
IHBvcnRzIGF0IDQwMjAgW3NpemU9MzJdCglSZWdpb24gNTogTWVtb3J5IGF0IGRjNTA1MDAw
ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJLXQoJQ2FwYWJpbGl0aWVzOiBb
ODBdIE1TSTogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0LQoJCUFkZHJlc3M6
IGZlZTA0MDAwICBEYXRhOiAwMDIyCglDYXBhYmlsaXRpZXM6IFs3MF0gUG93ZXIgTWFuYWdl
bWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVu
dD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90KyxEM2NvbGQtKQoJCVN0YXR1czogRDAgTm9T
b2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVz
OiBbYThdIFNBVEEgSEJBIHYxLjAgQkFSNCBPZmZzZXQ9MDAwMDAwMDQKCUNhcGFiaWxpdGll
czogW2IwXSBQQ0kgQWR2YW5jZWQgRmVhdHVyZXMKCQlBRkNhcDogVFArIEZMUisKCQlBRkN0
cmw6IEZMUi0KCQlBRlN0YXR1czogVFAtCglLZXJuZWwgZHJpdmVyIGluIHVzZTogYWhjaQoJ
S2VybmVsIG1vZHVsZXM6IGFoY2kKCjAwOjFmLjMgU01CdXMgWzBjMDVdOiBJbnRlbCBDb3Jw
b3JhdGlvbiA1IFNlcmllcy8zNDAwIFNlcmllcyBDaGlwc2V0IFNNQnVzIENvbnRyb2xsZXIg
WzgwODY6M2IzMF0gKHJldiAwNSkKCVN1YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FM
SV0gRGV2aWNlIFsxMDI1OjAzNTldCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyLSBT
cGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBG
YXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBh
ckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0g
PFBFUlItIElOVHgtCglJbnRlcnJ1cHQ6IHBpbiBDIHJvdXRlZCB0byBJUlEgMTkKCVJlZ2lv
biAwOiBNZW1vcnkgYXQgZGM1MDYwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3Np
emU9MjU2XQoJUmVnaW9uIDQ6IEkvTyBwb3J0cyBhdCA0MDAwIFtzaXplPTMyXQoJS2VybmVs
IGRyaXZlciBpbiB1c2U6IGk4MDFfc21idXMKCUtlcm5lbCBtb2R1bGVzOiBpMmNfaTgwMQoK
MDA6MWYuNiBTaWduYWwgcHJvY2Vzc2luZyBjb250cm9sbGVyIFsxMTgwXTogSW50ZWwgQ29y
cG9yYXRpb24gNSBTZXJpZXMvMzQwMCBTZXJpZXMgQ2hpcHNldCBUaGVybWFsIFN1YnN5c3Rl
bSBbODA4NjozYjMyXSAocmV2IDA1KQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBb
QUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIr
IFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlIt
IEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0g
UGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0g
PFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJ
UlEgMjEKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZGM1MDQwMDAgKDY0LWJpdCwgbm9uLXByZWZl
dGNoYWJsZSkgW3NpemU9NEtdCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVu
dCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0krIEQxLSBEMi0gQXV4Q3VycmVudD0w
bUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQoJCVN0YXR1czogRDAgTm9Tb2Z0
UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVzOiBb
ODBdIE1TSTogRW5hYmxlLSBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0LQoJCUFkZHJlc3M6
IDAwMDAwMDAwICBEYXRhOiAwMDAwCglLZXJuZWwgZHJpdmVyIGluIHVzZTogaW50ZWwgaXBz
CglLZXJuZWwgbW9kdWxlczogaW50ZWxfaXBzCgowMTowMC4wIFZHQSBjb21wYXRpYmxlIGNv
bnRyb2xsZXIgWzAzMDBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTUQvQVRJ
XSBNYWRpc29uIFtNb2JpbGl0eSBSYWRlb24gSEQgNTY1MC81NzUwIC8gNjUzME0vNjU1ME1d
IFsxMDAyOjY4YzFdIChwcm9nLWlmIDAwIFtWR0EgY29udHJvbGxlcl0pCglTdWJzeXN0ZW06
IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIE1vYmlsaXR5IFJhZGVvbiBIRCA1NjUwIFsxMDI1
OjAzNTldCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJ
TlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4
KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZh
c3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0
ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRlcwoJSW50ZXJydXB0OiBwaW4gQSBy
b3V0ZWQgdG8gSVJRIDI2CglSZWdpb24gMDogTWVtb3J5IGF0IGQwMDAwMDAwICg2NC1iaXQs
IHByZWZldGNoYWJsZSkgW3NpemU9MTI4TV0KCVJlZ2lvbiAyOiBNZW1vcnkgYXQgZGM0MDAw
MDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTI4S10KCVJlZ2lvbiA0OiBJ
L08gcG9ydHMgYXQgMzAwMCBbc2l6ZT0yNTZdCglFeHBhbnNpb24gUk9NIGF0IGRjNDQwMDAw
IFtkaXNhYmxlZF0gW3NpemU9MTI4S10KCUNhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5h
Z2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDErIEQyKyBBdXhDdXJy
ZW50PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0pCgkJU3RhdHVzOiBEMCBO
b1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRp
ZXM6IFs1OF0gRXhwcmVzcyAodjIpIExlZ2FjeSBFbmRwb2ludCwgSW50TXNnTnVtIDAKCQlE
ZXZDYXA6CU1heFBheWxvYWQgMjU2IGJ5dGVzLCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMg
PDR1cywgTDEgdW5saW1pdGVkCgkJCUV4dFRhZysgQXR0bkJ0bi0gQXR0bkluZC0gUHdySW5k
LSBSQkUrIEZMUmVzZXQtIFRFRS1JTy0KCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJy
LSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQrIEV4dFRhZysgUGhhbnRGdW5jLSBB
dXhQd3ItIE5vU25vb3ArCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDUx
MiBieXRlcwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1
cFJlcS0gQXV4UHdyLSBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICMwLCBTcGVlZCAyLjVH
VC9zLCBXaWR0aCB4MTYsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDw2NG5zLCBM
MSA8MXVzCgkJCUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJlcC0gQndOb3QtIEFTUE1PcHRD
b21wLQoJCUxua0N0bDoJQVNQTSBMMHMgTDEgRW5hYmxlZDsgUkNCIDY0IGJ5dGVzLCBMbmtE
aXNhYmxlLSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0lu
dC0gQXV0QldJbnQtIEZsdE1vZGVEaXMtCgkJTG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0
aCB4MTYKCQkJVHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBBQldN
Z210LQoJCURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogTm90IFN1cHBvcnRlZCwgVGlt
ZW91dERpcy0gTlJPUHJQclAtIExUUi0KCQkJIDEwQml0VGFnQ29tcC0gMTBCaXRUYWdSZXEt
IE9CRkYgTm90IFN1cHBvcnRlZCwgRXh0Rm10LSBFRVRMUFByZWZpeC0KCQkJIEVtZXJnZW5j
eVBvd2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0ZWQsIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9u
SW5pdC0KCQkJIEZSUy0KCQkJIEF0b21pY09wc0NhcDogMzJiaXQtIDY0Yml0LSAxMjhiaXRD
QVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVv
dXREaXMtCgkJCSBBdG9taWNPcHNDdGw6IFJlcUVuLQoJCQkgSURPUmVxLSBJRE9Db21wbC0g
TFRSLSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvblJlcS0KCQkJIDEwQml0VGFnUmVxLSBPQkZG
IERpc2FibGVkLCBFRVRMUFByZWZpeEJsay0KCQlMbmtDdGwyOiBUYXJnZXQgTGluayBTcGVl
ZDogMi41R1QvcywgRW50ZXJDb21wbGlhbmNlLSBTcGVlZERpcy0KCQkJIFRyYW5zbWl0IE1h
cmdpbjogTm9ybWFsIE9wZXJhdGluZyBSYW5nZSwgRW50ZXJNb2RpZmllZENvbXBsaWFuY2Ut
IENvbXBsaWFuY2VTT1MtCgkJCSBDb21wbGlhbmNlIFByZXNldC9EZS1lbXBoYXNpczogLTZk
QiBkZS1lbXBoYXNpcywgMGRCIHByZXNob290CgkJTG5rU3RhMjogQ3VycmVudCBEZS1lbXBo
YXNpcyBMZXZlbDogLTZkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUtIEVxdWFsaXphdGlvblBo
YXNlMS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0gRXF1YWxpemF0aW9uUGhhc2UzLSBMaW5r
RXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5r
UmVzOiB1bnN1cHBvcnRlZCwgRmx0TW9kZS0KCUNhcGFiaWxpdGllczogW2EwXSBNU0k6IEVu
YWJsZSsgQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAwMDAwMGZl
ZTAwMDAwICBEYXRhOiAwMDIwCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIFZlbmRvciBTcGVj
aWZpYyBJbmZvcm1hdGlvbjogSUQ9MDAwMSBSZXY9MSBMZW49MDEwIDw/PgoJS2VybmVsIGRy
aXZlciBpbiB1c2U6IHJhZGVvbgoJS2VybmVsIG1vZHVsZXM6IHJhZGVvbiwgYW1kZ3B1Cgow
MTowMC4xIEF1ZGlvIGRldmljZSBbMDQwM106IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIElu
Yy4gW0FNRC9BVEldIFJlZHdvb2QgSERNSSBBdWRpbyBbUmFkZW9uIEhEIDUwMDAgU2VyaWVz
XSBbMTAwMjphYTYwXSAocHJvZy1pZiAwMCBbSERBIGNvbXBhdGlibGVdKQoJU3Vic3lzdGVt
OiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6
IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBh
ckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsg
NjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFi
b3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBM
aW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBCIHJvdXRlZCB0byBJUlEgMjkK
CVJlZ2lvbiAwOiBNZW1vcnkgYXQgZGM0MjAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJs
ZSkgW3NpemU9MTZLXQoJQ2FwYWJpbGl0aWVzOiBbNTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVy
c2lvbiAzCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBEMSsgRDIrIEF1eEN1cnJlbnQ9MG1BIFBN
RShEMC0sRDEtLEQyLSxEM2hvdC0sRDNjb2xkLSkKCQlTdGF0dXM6IEQzIE5vU29mdFJzdC0g
UE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzU4XSBF
eHByZXNzICh2MikgTGVnYWN5IEVuZHBvaW50LCBJbnRNc2dOdW0gMAoJCURldkNhcDoJTWF4
UGF5bG9hZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5IEwwcyA8NHVzLCBMMSB1
bmxpbWl0ZWQKCQkJRXh0VGFnKyBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFJCRSsgRkxS
ZXNldC0gVEVFLUlPLQoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJy
LSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9T
bm9vcCsKCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJ
RGV2U3RhOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQ
d3ItIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDIuNUdUL3MsIFdpZHRo
IHgxNiwgQVNQTSBMMHMgTDEsIEV4aXQgTGF0ZW5jeSBMMHMgPDY0bnMsIEwxIDwxdXMKCQkJ
Q2xvY2tQTS0gU3VycHJpc2UtIExMQWN0UmVwLSBCd05vdC0gQVNQTU9wdENvbXAtCgkJTG5r
Q3RsOglBU1BNIEwwcyBMMSBFbmFibGVkOyBSQ0IgNjQgYnl0ZXMsIExua0Rpc2FibGUtIENv
bW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0lu
dC0gRmx0TW9kZURpcy0KCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MsIFdpZHRoIHgxNgoJCQlU
ckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01nbXQtCgkJRGV2
Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBOb3QgU3VwcG9ydGVkLCBUaW1lb3V0RGlzLSBO
Uk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBOb3Qg
U3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1
Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkg
RlJTLQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQtIDEyOGJpdENBUy0KCQlEZXZD
dGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywgVGltZW91dERpcy0KCQkJ
IEF0b21pY09wc0N0bDogUmVxRW4tCgkJCSBJRE9SZXEtIElET0NvbXBsLSBMVFItIEVtZXJn
ZW5jeVBvd2VyUmVkdWN0aW9uUmVxLQoJCQkgMTBCaXRUYWdSZXEtIE9CRkYgRGlzYWJsZWQs
IEVFVExQUHJlZml4QmxrLQoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6
IC02ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlLSBFcXVhbGl6YXRpb25QaGFzZTEtCgkJCSBF
cXVhbGl6YXRpb25QaGFzZTItIEVxdWFsaXphdGlvblBoYXNlMy0gTGlua0VxdWFsaXphdGlv
blJlcXVlc3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENyb3NzbGlua1JlczogdW5zdXBw
b3J0ZWQsIEZsdE1vZGUtCglDYXBhYmlsaXRpZXM6IFthMF0gTVNJOiBFbmFibGUrIENvdW50
PTEvMSBNYXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwNDAwMCAgRGF0
YTogMDAyMwoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYxXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3Jt
YXRpb246IElEPTAwMDEgUmV2PTEgTGVuPTAxMCA8Pz4KCUtlcm5lbCBkcml2ZXIgaW4gdXNl
OiBzbmRfaGRhX2ludGVsCglLZXJuZWwgbW9kdWxlczogc25kX2hkYV9pbnRlbAoKMDI6MDAu
MCBFdGhlcm5ldCBjb250cm9sbGVyIFswMjAwXTogUXVhbGNvbW0gQXRoZXJvcyBBUjgxNTEg
djEuMCBHaWdhYml0IEV0aGVybmV0IFsxOTY5OjEwNzNdIChyZXYgYzApCglTdWJzeXN0ZW06
IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDog
SS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFy
RXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwKyA2
Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJv
cnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAsIENhY2hlIExp
bmUgU2l6ZTogNjQgYnl0ZXMKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAzMQoJ
UmVnaW9uIDA6IE1lbW9yeSBhdCBkYjQwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT0yNTZLXQoJUmVnaW9uIDI6IEkvTyBwb3J0cyBhdCAyMDAwIFtzaXplPTEyOF0K
CUNhcGFiaWxpdGllczogWzQwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdz
OiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTM3NW1BIFBNRShEMCssRDErLEQy
KyxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29mdFJzdCsgUE1FLUVuYWJsZS0g
RFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzQ4XSBNU0k6IEVuYWJsZSsg
Q291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAwMDAwMGZlZTAwMDAw
ICBEYXRhOiAwMDIzCglDYXBhYmlsaXRpZXM6IFs1OF0gRXhwcmVzcyAodjEpIEVuZHBvaW50
LCBJbnRNc2dOdW0gMAoJCURldkNhcDoJTWF4UGF5bG9hZCA0MDk2IGJ5dGVzLCBQaGFudEZ1
bmMgMCwgTGF0ZW5jeSBMMHMgdW5saW1pdGVkLCBMMSB1bmxpbWl0ZWQKCQkJRXh0VGFnLSBB
dHRuQnRuKyBBdHRuSW5kKyBQd3JJbmQrIFJCRSsgRkxSZXNldC0gU2xvdFBvd2VyTGltaXQg
MTBXIFRFRS1JTy0KCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0g
VW5zdXBSZXEtCgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25v
b3AtCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDUxMiBieXRlcwoJCURl
dlN0YToJQ29yckVycisgTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdy
KyBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICMwLCBTcGVlZCAyLjVHVC9zLCBXaWR0aCB4
MSwgQVNQTSBMMHMgTDEsIEV4aXQgTGF0ZW5jeSBMMHMgdW5saW1pdGVkLCBMMSB1bmxpbWl0
ZWQKCQkJQ2xvY2tQTSsgU3VycHJpc2UtIExMQWN0UmVwLSBCd05vdC0gQVNQTU9wdENvbXAt
CgkJTG5rQ3RsOglBU1BNIEwxIEVuYWJsZWQ7IFJDQiA2NCBieXRlcywgTG5rRGlzYWJsZS0g
Q29tbUNsaysKCQkJRXh0U3luY2gtIENsb2NrUE0rIEF1dFdpZERpcy0gQldJbnQtIEF1dEJX
SW50LSBGbHRNb2RlRGlzLQoJCUxua1N0YToJU3BlZWQgMi41R1QvcywgV2lkdGggeDEKCQkJ
VHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBBQldNZ210LQoJQ2Fw
YWJpbGl0aWVzOiBbNmNdIFZpdGFsIFByb2R1Y3QgRGF0YQoJCU5vdCByZWFkYWJsZQoJQ2Fw
YWJpbGl0aWVzOiBbMTAwIHYxXSBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcKCQlVRVN0YToJ
RExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhP
Ri0gTWFsZlRMUC0KCQkJRUNSQy0gVW5zdXBSZXErIEFDU1Zpb2wtIFVuY29yckludEVyci0g
QmxvY2tlZFRMUC0gQXRvbWljT3BCbG9ja2VkLSBUTFBCbG9ja2VkRXJyLQoJCQlQb2lzb25U
TFBCbG9ja2VkLSBETVdyUmVxQmxvY2tlZC0gSURFQ2hlY2stIE1pc0lERVRMUC0gUENSQ19D
SEVDSy0gVExQWGxhdEJsb2NrZWQtCgkJVUVNc2s6CURMUC0gU0RFUy0gVExQLSBGQ1AtIENt
cGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtCgkJCUVDUkMtIFVu
c3VwUmVxLSBBQ1NWaW9sLSBVbmNvcnJJbnRFcnItIEJsb2NrZWRUTFAtIEF0b21pY09wQmxv
Y2tlZC0gVExQQmxvY2tlZEVyci0KCQkJUG9pc29uVExQQmxvY2tlZC0gRE1XclJlcUJsb2Nr
ZWQtIElERUNoZWNrLSBNaXNJREVUTFAtIFBDUkNfQ0hFQ0stIFRMUFhsYXRCbG9ja2VkLQoJ
CVVFU3ZydDoJRExQLSBTREVTKyBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhD
bXBsdC0gUnhPRisgTWFsZlRMUCsKCQkJRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtIFVuY29y
ckludEVyci0gQmxvY2tlZFRMUC0gQXRvbWljT3BCbG9ja2VkLSBUTFBCbG9ja2VkRXJyLQoJ
CQlQb2lzb25UTFBCbG9ja2VkLSBETVdyUmVxQmxvY2tlZC0gSURFQ2hlY2stIE1pc0lERVRM
UC0gUENSQ19DSEVDSy0gVExQWGxhdEJsb2NrZWQtCgkJQ0VTdGE6CVJ4RXJyLSBCYWRUTFAr
IEJhZERMTFArIFJvbGxvdmVyLSBUaW1lb3V0LSBBZHZOb25GYXRhbEVyci0gQ29yckludEVy
ci0gSGVhZGVyT0YtCgkJQ0VNc2s6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVy
LSBUaW1lb3V0LSBBZHZOb25GYXRhbEVycisgQ29yckludEVyci0gSGVhZGVyT0YtCgkJQUVS
Q2FwOglGaXJzdCBFcnJvciBQb2ludGVyOiAxNCwgRUNSQ0dlbkNhcCsgRUNSQ0dlbkVuLSBF
Q1JDQ2hrQ2FwKyBFQ1JDQ2hrRW4tCgkJCU11bHRIZHJSZWNDYXAtIE11bHRIZHJSZWNFbi0g
VExQUGZ4UHJlcy0gSGRyTG9nQ2FwLQoJCUhlYWRlckxvZzogMDQwMDAwMDEgMDAwMDA4MGYg
MDIwMjAwMDAgMDAwMDAwMDAKCUNhcGFiaWxpdGllczogWzE4MCB2MV0gRGV2aWNlIFNlcmlh
bCBOdW1iZXIgZmYtZTEtMDMtN2UtYzgtMGEtYTktZmYKCUtlcm5lbCBkcml2ZXIgaW4gdXNl
OiBhdGwxYwoJS2VybmVsIG1vZHVsZXM6IGF0bDFjCgowMzowMC4wIE5ldHdvcmsgY29udHJv
bGxlciBbMDI4MF06IEludGVsIENvcnBvcmF0aW9uIFdpcmVsZXNzIDcyNjAgWzgwODY6MDhi
MV0gKHJldiBiYikKCVN1YnN5c3RlbTogSW50ZWwgQ29ycG9yYXRpb24gRHVhbCBCYW5kIFdp
cmVsZXNzLUFDIDcyNjAgW1dpbGtpbnMgUGVhayAyXSBbODA4Njo0NDcwXQoJQ29udHJvbDog
SS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFy
RXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2
Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJv
cnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAsIENhY2hlIExp
bmUgU2l6ZTogNjQgYnl0ZXMKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAyOAoJ
UmVnaW9uIDA6IE1lbW9yeSBhdCBkYTQwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT04S10KCUNhcGFiaWxpdGllczogW2M4XSBQb3dlciBNYW5hZ2VtZW50IHZlcnNp
b24gMwoJCUZsYWdzOiBQTUVDbGstIERTSSsgRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUo
RDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBN
RS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFtkMF0gTVNJ
OiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAw
MDBmZWUwNTAwMCAgRGF0YTogMDAyMwoJQ2FwYWJpbGl0aWVzOiBbNDBdIEV4cHJlc3MgKHYy
KSBFbmRwb2ludCwgSW50TXNnTnVtIDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMTI4IGJ5dGVz
LCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMgPDUxMm5zLCBMMSB1bmxpbWl0ZWQKCQkJRXh0
VGFnLSBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFJCRSsgRkxSZXNldCsgU2xvdFBvd2Vy
TGltaXQgMFcgVEVFLUlPLQoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFs
RXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnLSBQaGFudEZ1bmMtIEF1eFB3cisg
Tm9Tbm9vcCsgRkxSZXNldC0KCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEg
MTI4IGJ5dGVzCgkJRGV2U3RhOglDb3JyRXJyKyBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVu
c3VwUmVxLSBBdXhQd3IrIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDIu
NUdUL3MsIFdpZHRoIHgxLCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8NHVzLCBM
MSA8MzJ1cwoJCQlDbG9ja1BNKyBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0
Q29tcC0KCQlMbmtDdGw6CUFTUE0gTDEgRW5hYmxlZDsgUkNCIDY0IGJ5dGVzLCBMbmtEaXNh
YmxlLSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTSsgQXV0V2lkRGlzLSBCV0ludC0g
QXV0QldJbnQtIEZsdE1vZGVEaXMtCgkJTG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0aCB4
MQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01nbXQt
CgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBSYW5nZSBCLCBUaW1lb3V0RGlzKyBO
Uk9QclByUC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBWaWEg
V0FLRSMsIEV4dEZtdC0gRUVUTFBQcmVmaXgtCgkJCSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlv
biBOb3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbkluaXQtCgkJCSBGUlMt
IFRQSENvbXAtIEV4dFRQSENvbXAtCgkJCSBBdG9taWNPcHNDYXA6IDMyYml0LSA2NGJpdC0g
MTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91dDogMTZtcyB0byA1NW1z
LCBUaW1lb3V0RGlzLQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0KCQkJIElET1JlcS0gSURP
Q29tcGwtIExUUi0gRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25SZXEtCgkJCSAxMEJpdFRhZ1Jl
cS0gT0JGRiBEaXNhYmxlZCwgRUVUTFBQcmVmaXhCbGstCgkJTG5rQ3RsMjogVGFyZ2V0IExp
bmsgU3BlZWQ6IDIuNUdUL3MsIEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtCgkJCSBUcmFu
c21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRDb21w
bGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkgQ29tcGxpYW5jZSBQcmVzZXQvRGUtZW1waGFz
aXM6IC02ZEIgZGUtZW1waGFzaXMsIDBkQiBwcmVzaG9vdAoJCUxua1N0YTI6IEN1cnJlbnQg
RGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUtIEVxdWFs
aXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0gRXF1YWxpemF0aW9uUGhh
c2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0g
Q3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZCwgRmx0TW9kZS0KCUNhcGFiaWxpdGllczogWzEw
MCB2MV0gQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nCgkJVUVTdGE6CURMUC0gU0RFUy0gVExQ
LSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtCgkJ
CUVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLSBVbmNvcnJJbnRFcnItIEJsb2NrZWRUTFAtIEF0
b21pY09wQmxvY2tlZC0gVExQQmxvY2tlZEVyci0KCQkJUG9pc29uVExQQmxvY2tlZC0gRE1X
clJlcUJsb2NrZWQtIElERUNoZWNrLSBNaXNJREVUTFAtIFBDUkNfQ0hFQ0stIFRMUFhsYXRC
bG9ja2VkLQoJCVVFTXNrOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFi
cnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLQoJCQlFQ1JDLSBVbnN1cFJlcS0gQUNTVmlv
bC0gVW5jb3JySW50RXJyLSBCbG9ja2VkVExQLSBBdG9taWNPcEJsb2NrZWQtIFRMUEJsb2Nr
ZWRFcnItCgkJCVBvaXNvblRMUEJsb2NrZWQtIERNV3JSZXFCbG9ja2VkLSBJREVDaGVjay0g
TWlzSURFVExQLSBQQ1JDX0NIRUNLLSBUTFBYbGF0QmxvY2tlZC0KCQlVRVN2cnQ6CURMUCsg
U0RFUysgVExQLSBGQ1ArIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YrIE1h
bGZUTFArCgkJCUVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLSBVbmNvcnJJbnRFcnIrIEJsb2Nr
ZWRUTFAtIEF0b21pY09wQmxvY2tlZC0gVExQQmxvY2tlZEVyci0KCQkJUG9pc29uVExQQmxv
Y2tlZC0gRE1XclJlcUJsb2NrZWQtIElERUNoZWNrLSBNaXNJREVUTFAtIFBDUkNfQ0hFQ0st
IFRMUFhsYXRCbG9ja2VkLQoJCUNFU3RhOglSeEVyci0gQmFkVExQKyBCYWRETExQLSBSb2xs
b3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrIENvcnJJbnRFcnItIEhlYWRlck9GLQoJ
CUNFTXNrOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2
Tm9uRmF0YWxFcnIrIENvcnJJbnRFcnItIEhlYWRlck9GLQoJCUFFUkNhcDoJRmlyc3QgRXJy
b3IgUG9pbnRlcjogMDAsIEVDUkNHZW5DYXAtIEVDUkNHZW5Fbi0gRUNSQ0Noa0NhcC0gRUNS
Q0Noa0VuLQoJCQlNdWx0SGRyUmVjQ2FwLSBNdWx0SGRyUmVjRW4tIFRMUFBmeFByZXMtIEhk
ckxvZ0NhcC0KCQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAw
MDAwCglDYXBhYmlsaXRpZXM6IFsxNDAgdjFdIERldmljZSBTZXJpYWwgTnVtYmVyIDAwLTE2
LTZmLWZmLWZmLWE2LTEyLTUxCglDYXBhYmlsaXRpZXM6IFsxNGMgdjFdIExhdGVuY3kgVG9s
ZXJhbmNlIFJlcG9ydGluZwoJCU1heCBzbm9vcCBsYXRlbmN5OiAwbnMKCQlNYXggbm8gc25v
b3AgbGF0ZW5jeTogMG5zCglDYXBhYmlsaXRpZXM6IFsxNTQgdjFdIFZlbmRvciBTcGVjaWZp
YyBJbmZvcm1hdGlvbjogSUQ9Y2FmZSBSZXY9MSBMZW49MDE0IDw/PgoJS2VybmVsIGRyaXZl
ciBpbiB1c2U6IGl3bHdpZmkKCUtlcm5lbCBtb2R1bGVzOiBpd2x3aWZpCgo3ZjowMC4wIEhv
c3QgYnJpZGdlIFswNjAwXTogSW50ZWwgQ29ycG9yYXRpb24gQ29yZSBQcm9jZXNzb3IgUXVp
Y2tQYXRoIEFyY2hpdGVjdHVyZSBHZW5lcmljIE5vbi1jb3JlIFJlZ2lzdGVycyBbODA4Njoy
YzYyXSAocmV2IDA1KQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZp
Y2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNs
ZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkIt
IERpc0lOVHgtCglTdGF0dXM6IENhcC0gNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBE
RVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElO
VHgtCglMYXRlbmN5OiAwCgo3ZjowMC4xIEhvc3QgYnJpZGdlIFswNjAwXTogSW50ZWwgQ29y
cG9yYXRpb24gQ29yZSBQcm9jZXNzb3IgUXVpY2tQYXRoIEFyY2hpdGVjdHVyZSBTeXN0ZW0g
QWRkcmVzcyBEZWNvZGVyIFs4MDg2OjJkMDFdIChyZXYgMDUpCglTdWJzeXN0ZW06IEFjZXIg
SW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDogSS9PLSBN
ZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBT
dGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwLSA2Nk1Iei0g
VURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxN
QWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCjdmOjAyLjAgSG9zdCBi
cmlkZ2UgWzA2MDBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBDb3JlIFByb2Nlc3NvciBRUEkgTGlu
ayAwIFs4MDg2OjJkMTBdIChyZXYgMDUpCglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVk
IFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3Rl
cisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VS
Ui0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJC
LSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJS
LSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCjdmOjAyLjEgSG9zdCBicmlkZ2UgWzA2MDBd
OiBJbnRlbCBDb3Jwb3JhdGlvbiAxc3QgR2VuZXJhdGlvbiBDb3JlIGkzLzUvNyBQcm9jZXNz
b3IgUVBJIFBoeXNpY2FsIDAgWzgwODY6MmQxMV0gKHJldiAwNSkKCVN1YnN5c3RlbTogQWNl
ciBJbmNvcnBvcmF0ZWQgW0FMSV0gRGV2aWNlIFsxMDI1OjAzNTldCglDb250cm9sOiBJL08t
IE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnIt
IFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6
LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0g
PE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoKN2Y6MDIuMiBIb3N0
IGJyaWRnZSBbMDYwMF06IEludGVsIENvcnBvcmF0aW9uIDFzdCBHZW5lcmF0aW9uIENvcmUg
aTMvNS83IFByb2Nlc3NvciBSZXNlcnZlZCBbODA4NjoyZDEyXSAocmV2IDA1KQoJU3Vic3lz
dGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRy
b2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3At
IFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENh
cC0gNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8
VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCgo3Zjow
Mi4zIEhvc3QgYnJpZGdlIFswNjAwXTogSW50ZWwgQ29ycG9yYXRpb24gMXN0IEdlbmVyYXRp
b24gQ29yZSBpMy81LzcgUHJvY2Vzc29yIFJlc2VydmVkIFs4MDg2OjJkMTNdIChyZXYgMDUp
CglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5
XQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBW
R0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0
YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5U
QWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6
IDAKCg==
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8; name="lspci_failed.txt"
Content-Disposition: attachment; filename="lspci_failed.txt"
Content-Transfer-Encoding: base64

MDA6MDAuMCBIb3N0IGJyaWRnZSBbMDYwMF06IEludGVsIENvcnBvcmF0aW9uIENvcmUgUHJv
Y2Vzc29yIERSQU0gQ29udHJvbGxlciBbODA4NjowMDQ0XSAocmV2IDE4KQoJU3Vic3lzdGVt
OiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6
IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBh
ckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsg
NjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFi
b3J0LSA8TUFib3J0KyA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglDYXBhYmls
aXRpZXM6IFtlMF0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBJbnRlbCBDYXBhYmls
aXRpZXMgdjEKCQlDYXBBOiBQZWc2MERpcy0gUGVnMTJEaXMtIFBlZzExRGlzLSBQZWcxMERp
cy0gUGVMV1VEaXMtIERtaVdpZHRoPXg0CgkJICAgICAgRWNjRGlzLSBGb3JjZUVjY0VuLSBW
VGREaXMrIERtaUcyRGlzLSBQZWdHMkRpcysgRERSTWF4U2l6ZT0yR0IvY2hhbgoJCSAgICAg
IDFORGlzLSBDRERpcy0gRERQQ0RpcysgWDJBUElDRW4rIFBEQ0Rpcy0gSUdEaXMtIENESUQ9
MSBDUklEPTIKCQkgICAgICBERFJPQ0NBUC0gT0NFbisgRERSV3J0VnJlZkVuKyBERFIzTEVu
LQoJCUNhcEI6IEltZ3VEaXMtIE9DYnlTU0tVQ2FwLSBPQ2J5U1NLVUVuLSBTTVRDYXAtIENh
Y2hlU3pDYXAgMHgwCgkJICAgICAgU29mdEJpbkNhcC0gRERSM01heEZyZXFXaXRoUmVmMTAw
PTE2MDBNSHogUGVnRzNEaXMtCgkJICAgICAgUGtnVHlwLSBBZGRHZnhFbi0gQWRkR2Z4Q2Fw
LSBQZWdYMTZEaXMtIERtaUczRGlzLSBHbW1EaXMtCgkJICAgICAgRERSM01heEZyZXE9Mjkz
Mk1IeiBMUEREUjNFbi0KCUtlcm5lbCBtb2R1bGVzOiBpbnRlbF9hZ3AKCjAwOjAxLjAgUENJ
IGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0aW9uIENvcmUgUHJvY2Vzc29yIFBDSSBF
eHByZXNzIHgxNiBSb290IFBvcnQgWzgwODY6MDA0NV0gKHJldiAxOCkgKHByb2ctaWYgMDAg
W05vcm1hbCBkZWNvZGVdKQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBE
ZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWND
eWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RC
MkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJy
LSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlIt
IElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1
cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTYKCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5
PTAxLCBzdWJvcmRpbmF0ZT0wMSwgc2VjLWxhdGVuY3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6
IDMwMDAtM2ZmZiBbc2l6ZT00S10gWzE2LWJpdF0KCU1lbW9yeSBiZWhpbmQgYnJpZGdlOiBk
YzQwMDAwMC1kYzRmZmZmZiBbc2l6ZT0xTV0gWzMyLWJpdF0KCVByZWZldGNoYWJsZSBtZW1v
cnkgYmVoaW5kIGJyaWRnZTogZDAwMDAwMDAtZDdmZmZmZmYgW3NpemU9MTI4TV0gWzMyLWJp
dF0KCVNlY29uZGFyeSBzdGF0dXM6IDY2TUh6LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1m
YXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtIDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0
bDogUGFyaXR5LSBTRVJSKyBOb0lTQS0gVkdBLSBWR0ExNi0gTUFib3J0LSA+UmVzZXQtIEZh
c3RCMkItCgkJUHJpRGlzY1Rtci0gU2VjRGlzY1Rtci0gRGlzY1RtclN0YXQtIERpc2NUbXJT
RVJSRW4tCglDYXBhYmlsaXRpZXM6IFs4OF0gU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRl
ZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNhcGFiaWxpdGllczogWzgwXSBQb3dlciBN
YW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhD
dXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBE
MCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmls
aXRpZXM6IFs5MF0gTVNJOiBFbmFibGUtIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQtCgkJ
QWRkcmVzczogMDAwMDAwMDAgIERhdGE6IDAwMDAKCUNhcGFiaWxpdGllczogW2EwXSBFeHBy
ZXNzICh2MikgUm9vdCBQb3J0IChTbG90KyksIEludE1zZ051bSAwCgkJRGV2Q2FwOglNYXhQ
YXlsb2FkIDEyOCBieXRlcywgUGhhbnRGdW5jIDAKCQkJRXh0VGFnLSBSQkUrIFRFRS1JTy0K
CQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJ
CVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3AtCgkJCU1heFBh
eWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBieXRlcwoJCURldlN0YToJQ29yckVy
ci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyLSBUcmFuc1BlbmQt
CgkJTG5rQ2FwOglQb3J0ICMyLCBTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MTYsIEFTUE0gTDBz
IEwxLCBFeGl0IExhdGVuY3kgTDBzIDwyNTZucywgTDEgPDR1cwoJCQlDbG9ja1BNLSBTdXJw
cmlzZS0gTExBY3RSZXAtIEJ3Tm90KyBBU1BNT3B0Q29tcC0KCQlMbmtDdGw6CUFTUE0gTDBz
IEwxIEVuYWJsZWQ7IFJDQiA2NCBieXRlcywgTG5rRGlzYWJsZS0gQ29tbUNsaysKCQkJRXh0
U3luY2gtIENsb2NrUE0tIEF1dFdpZERpcy0gQldJbnQtIEF1dEJXSW50LSBGbHRNb2RlRGlz
LQoJCUxua1N0YToJU3BlZWQgMi41R1QvcywgV2lkdGggeDE2CgkJCVRyRXJyLSBUcmFpbi0g
U2xvdENsaysgRExBY3RpdmUtIEJXTWdtdC0gQUJXTWdtdC0KCQlTbHRDYXA6CUF0dG5CdG4t
IFB3ckN0cmwtIE1STC0gQXR0bkluZC0gUHdySW5kLSBIb3RQbHVnLSBTdXJwcmlzZS0KCQkJ
U2xvdCAjMTcsIFBvd2VyTGltaXQgNzVXOyBJbnRlcmxvY2stIE5vQ29tcGwrCgkJU2x0Q3Rs
OglFbmFibGU6IEF0dG5CdG4tIFB3ckZsdC0gTVJMLSBQcmVzRGV0LSBDbWRDcGx0LSBIUEly
cS0gTGlua0NoZy0KCQkJQ29udHJvbDogQXR0bkluZCBVbmtub3duLCBQd3JJbmQgVW5rbm93
biwgUG93ZXItIEludGVybG9jay0KCQlTbHRTdGE6CVN0YXR1czogQXR0bkJ0bi0gUG93ZXJG
bHQtIE1STC0gQ21kQ3BsdC0gUHJlc0RldCsgSW50ZXJsb2NrLQoJCQlDaGFuZ2VkOiBNUkwt
IFByZXNEZXQrIExpbmtTdGF0ZS0KCQlSb290Q2FwOiBDUlNWaXNpYmxlLQoJCVJvb3RDdGw6
IEVyckNvcnJlY3RhYmxlLSBFcnJOb24tRmF0YWwtIEVyckZhdGFsLSBQTUVJbnRFbmEtIENS
U1Zpc2libGUtCgkJUm9vdFN0YTogUE1FIFJlcUlEIDAwMDAsIFBNRVN0YXR1cy0gUE1FUGVu
ZGluZy0KCQlEZXZDYXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IE5vdCBTdXBwb3J0ZWQsIFRp
bWVvdXREaXMtIE5ST1ByUHJQLSBMVFItCgkJCSAxMEJpdFRhZ0NvbXAtIDEwQml0VGFnUmVx
LSBPQkZGIE5vdCBTdXBwb3J0ZWQsIEV4dEZtdC0gRUVUTFBQcmVmaXgtCgkJCSBFbWVyZ2Vu
Y3lQb3dlclJlZHVjdGlvbiBOb3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJlZHVjdGlv
bkluaXQtCgkJCSBGUlMtIExOIFN5c3RlbSBDTFMgTm90IFN1cHBvcnRlZCwgVFBIQ29tcC0g
RXh0VFBIQ29tcC0gQVJJRndkLQoJCQkgQXRvbWljT3BzQ2FwOiBSb3V0aW5nLSAzMmJpdC0g
NjRiaXQtIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMg
dG8gNTBtcywgVGltZW91dERpcy0gQVJJRndkLQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0g
RWdyZXNzQmxjay0KCQkJIElET1JlcS0gSURPQ29tcGwtIExUUi0gRW1lcmdlbmN5UG93ZXJS
ZWR1Y3Rpb25SZXEtCgkJCSAxMEJpdFRhZ1JlcS0gT0JGRiBEaXNhYmxlZCwgRUVUTFBQcmVm
aXhCbGstCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDIuNUdUL3MsIEVudGVyQ29t
cGxpYW5jZS0gU3BlZWREaXMtCgkJCSBUcmFuc21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRp
bmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRDb21wbGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkg
Q29tcGxpYW5jZSBQcmVzZXQvRGUtZW1waGFzaXM6IC02ZEIgZGUtZW1waGFzaXMsIDBkQiBw
cmVzaG9vdAoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC02ZEIsIEVx
dWFsaXphdGlvbkNvbXBsZXRlLSBFcXVhbGl6YXRpb25QaGFzZTEtCgkJCSBFcXVhbGl6YXRp
b25QaGFzZTItIEVxdWFsaXphdGlvblBoYXNlMy0gTGlua0VxdWFsaXphdGlvblJlcXVlc3Qt
CgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENyb3NzbGlua1JlczogdW5zdXBwb3J0ZWQsIEZs
dE1vZGUtCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIFZpcnR1YWwgQ2hhbm5lbAoJCUNhcHM6
CUxQRVZDPTAgUmVmQ2xrPTEwMG5zIFBBVEVudHJ5Qml0cz0xCgkJQXJiOglGaXhlZC0gV1JS
MzItIFdSUjY0LSBXUlIxMjgtCgkJQ3RybDoJQXJiU2VsZWN0PUZpeGVkCgkJU3RhdHVzOglJ
blByb2dyZXNzLQoJCVZDMDoJQ2FwczoJUEFUT2Zmc2V0PTAwIE1heFRpbWVTbG90cz0xIFJl
alNub29wVHJhbnMtCgkJCUFyYjoJRml4ZWQrIFdSUjMyLSBXUlI2NC0gV1JSMTI4LSBUV1JS
MTI4LSBXUlIyNTYtCgkJCUN0cmw6CUVuYWJsZSsgSUQ9MCBBcmJTZWxlY3Q9Rml4ZWQgVEMv
VkM9MDEKCQkJU3RhdHVzOglOZWdvUGVuZGluZy0gSW5Qcm9ncmVzcy0KCUtlcm5lbCBkcml2
ZXIgaW4gdXNlOiBwY2llcG9ydAoJS2VybmVsIG1vZHVsZXM6IHNocGNocAoKMDA6MDIuMCBW
R0EgY29tcGF0aWJsZSBjb250cm9sbGVyIFswMzAwXTogSW50ZWwgQ29ycG9yYXRpb24gQ29y
ZSBQcm9jZXNzb3IgSW50ZWdyYXRlZCBHcmFwaGljcyBDb250cm9sbGVyIFs4MDg2OjAwNDZd
IChyZXYgMTgpIChwcm9nLWlmIDAwIFtWR0EgY29udHJvbGxlcl0pCglTdWJzeXN0ZW06IEFj
ZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDogSS9P
KyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJy
LSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1I
ei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQt
IDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDog
cGluIEEgcm91dGVkIHRvIElSUSAyNwoJUmVnaW9uIDA6IE1lbW9yeSBhdCBkODAwMDAwMCAo
NjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00TV0KCVJlZ2lvbiAyOiBNZW1vcnkg
YXQgYzAwMDAwMDAgKDY0LWJpdCwgcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yNTZNXQoJUmVnaW9u
IDQ6IEkvTyBwb3J0cyBhdCA0MDUwIFtzaXplPThdCglFeHBhbnNpb24gUk9NIGF0IDAwMGMw
MDAwIFt2aXJ0dWFsXSBbZGlzYWJsZWRdIFtzaXplPTEyOEtdCglDYXBhYmlsaXRpZXM6IFs5
MF0gTVNJOiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQtCgkJQWRkcmVzczog
ZmVlMDQwMDAgIERhdGE6IDAwMjAKCUNhcGFiaWxpdGllczogW2QwXSBQb3dlciBNYW5hZ2Vt
ZW50IHZlcnNpb24gMgoJCUZsYWdzOiBQTUVDbGstIERTSSsgRDEtIEQyLSBBdXhDdXJyZW50
PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0pCgkJU3RhdHVzOiBEMCBOb1Nv
ZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6
IFthNF0gUENJIEFkdmFuY2VkIEZlYXR1cmVzCgkJQUZDYXA6IFRQKyBGTFIrCgkJQUZDdHJs
OiBGTFItCgkJQUZTdGF0dXM6IFRQLQoJS2VybmVsIGRyaXZlciBpbiB1c2U6IGk5MTUKCUtl
cm5lbCBtb2R1bGVzOiBpOTE1CgowMDoxNi4wIENvbW11bmljYXRpb24gY29udHJvbGxlciBb
MDc4MF06IEludGVsIENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAgU2VyaWVzIENoaXBzZXQg
SEVDSSBDb250cm9sbGVyIFs4MDg2OjNiNjRdIChyZXYgMDYpCglTdWJzeXN0ZW06IEFjZXIg
SW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDogSS9PLSBN
ZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBT
dGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0g
VURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxN
QWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGlu
IEEgcm91dGVkIHRvIElSUSAyNQoJUmVnaW9uIDA6IE1lbW9yeSBhdCBkYzUwNjEwMCAoNjQt
Yml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xNl0KCUNhcGFiaWxpdGllczogWzUwXSBQ
b3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQy
LSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3Rh
dHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglD
YXBhYmlsaXRpZXM6IFs4Y10gTVNJOiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRi
aXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwMDAwMCAgRGF0YTogMDAyMQoJS2VybmVsIGRy
aXZlciBpbiB1c2U6IG1laV9tZQoJS2VybmVsIG1vZHVsZXM6IG1laV9tZQoKMDA6MWEuMCBV
U0IgY29udHJvbGxlciBbMGMwM106IEludGVsIENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAg
U2VyaWVzIENoaXBzZXQgVVNCMiBFbmhhbmNlZCBIb3N0IENvbnRyb2xsZXIgWzgwODY6M2Iz
Y10gKHJldiAwNSkgKHByb2ctaWYgMjAgW0VIQ0ldKQoJU3Vic3lzdGVtOiBBY2VyIEluY29y
cG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkvTy0gTWVtKyBC
dXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBp
bmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0g
RmFzdEIyQisgUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJv
cnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGluIEEg
cm91dGVkIHRvIElSUSAxNgoJUmVnaW9uIDA6IE1lbW9yeSBhdCBkYzUwNWMwMCAoMzItYml0
LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xS10KCUNhcGFiaWxpdGllczogWzUwXSBQb3dl
ciBNYW5hZ2VtZW50IHZlcnNpb24gMgoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBB
dXhDdXJyZW50PTM3NW1BIFBNRShEMCssRDEtLEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0
dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNh
cGFiaWxpdGllczogWzU4XSBEZWJ1ZyBwb3J0OiBCQVI9MSBvZmZzZXQ9MDBhMAoJQ2FwYWJp
bGl0aWVzOiBbOThdIFBDSSBBZHZhbmNlZCBGZWF0dXJlcwoJCUFGQ2FwOiBUUCsgRkxSKwoJ
CUFGQ3RybDogRkxSLQoJCUFGU3RhdHVzOiBUUC0KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBl
aGNpLXBjaQoJS2VybmVsIG1vZHVsZXM6IGVoY2lfcGNpCgowMDoxYi4wIEF1ZGlvIGRldmlj
ZSBbMDQwM106IEludGVsIENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAgU2VyaWVzIENoaXBz
ZXQgSGlnaCBEZWZpbml0aW9uIEF1ZGlvIFs4MDg2OjNiNTZdIChyZXYgMDUpIChwcm9nLWlm
IDAwIFtIREEgY29tcGF0aWJsZV0pCglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtB
TEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3Rlcisg
U3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0g
RmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQ
YXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8
UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElS
USAzMAoJUmVnaW9uIDA6IE1lbW9yeSBhdCBkYzUwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbc2l6ZT0xNktdCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVu
dCB2ZXJzaW9uIDIKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD01
NW1BIFBNRShEMCssRDEtLEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29m
dFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczog
WzYwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNz
OiAwMDAwMDAwMDAwMDAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFs3MF0gRXhw
cmVzcyAodjEpIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50LCBJbnRNc2dOdW0g
MAoJCURldkNhcDoJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwCgkJCUV4dFRh
Zy0gUkJFLSBGTFJlc2V0KyBURUUtSU8tCgkJRGV2Q3RsOglDb3JyRXJyLSBOb25GYXRhbEVy
ci0gRmF0YWxFcnItIFVuc3VwUmVxLQoJCQlSbHhkT3JkLSBFeHRUYWctIFBoYW50RnVuYy0g
QXV4UHdyLSBOb1Nub29wLSBGTFJlc2V0LQoJCQlNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4
UmVhZFJlcSAxMjggYnl0ZXMKCQlEZXZTdGE6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRh
bEVyci0gVW5zdXBSZXEtIEF1eFB3cisgVHJhbnNQZW5kLQoJQ2FwYWJpbGl0aWVzOiBbMTAw
IHYxXSBWaXJ0dWFsIENoYW5uZWwKCQlDYXBzOglMUEVWQz0wIFJlZkNsaz0xMDBucyBQQVRF
bnRyeUJpdHM9MQoJCUFyYjoJRml4ZWQtIFdSUjMyLSBXUlI2NC0gV1JSMTI4LQoJCUN0cmw6
CUFyYlNlbGVjdD1GaXhlZAoJCVN0YXR1czoJSW5Qcm9ncmVzcy0KCQlWQzA6CUNhcHM6CVBB
VE9mZnNldD0wMCBNYXhUaW1lU2xvdHM9MSBSZWpTbm9vcFRyYW5zLQoJCQlBcmI6CUZpeGVk
LSBXUlIzMi0gV1JSNjQtIFdSUjEyOC0gVFdSUjEyOC0gV1JSMjU2LQoJCQlDdHJsOglFbmFi
bGUrIElEPTAgQXJiU2VsZWN0PUZpeGVkIFRDL1ZDPWZmCgkJCVN0YXR1czoJTmVnb1BlbmRp
bmctIEluUHJvZ3Jlc3MtCgkJVkMxOglDYXBzOglQQVRPZmZzZXQ9MDAgTWF4VGltZVNsb3Rz
PTEgUmVqU25vb3BUcmFucy0KCQkJQXJiOglGaXhlZC0gV1JSMzItIFdSUjY0LSBXUlIxMjgt
IFRXUlIxMjgtIFdSUjI1Ni0KCQkJQ3RybDoJRW5hYmxlKyBJRD0xIEFyYlNlbGVjdD1GaXhl
ZCBUQy9WQz0wMAoJCQlTdGF0dXM6CU5lZ29QZW5kaW5nLSBJblByb2dyZXNzLQoJQ2FwYWJp
bGl0aWVzOiBbMTMwIHYxXSBSb290IENvbXBsZXggTGluawoJCURlc2M6CVBvcnROdW1iZXI9
MGYgQ29tcG9uZW50SUQ9MDAgRWx0VHlwZT1Db25maWcKCQlMaW5rMDoJRGVzYzoJVGFyZ2V0
UG9ydD0wMCBUYXJnZXRDb21wb25lbnQ9MDAgQXNzb2NSQ1JCLSBMaW5rVHlwZT1NZW1NYXBw
ZWQgTGlua1ZhbGlkKwoJCQlBZGRyOgkwMDAwMDAwMGZlZDFjMDAwCglLZXJuZWwgZHJpdmVy
IGluIHVzZTogc25kX2hkYV9pbnRlbAoJS2VybmVsIG1vZHVsZXM6IHNuZF9oZGFfaW50ZWwK
CjAwOjFjLjAgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0aW9uIDUgU2VyaWVz
LzM0MDAgU2VyaWVzIENoaXBzZXQgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDEgWzgwODY6M2I0
Ml0gKHJldiAwNSkgKHByb2ctaWYgMDAgW05vcm1hbCBkZWNvZGVdKQoJU3Vic3lzdGVtOiBB
Y2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkv
TysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVy
ci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZN
SHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0
LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5l
IFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTcKCUJ1
czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTAyLCBzdWJvcmRpbmF0ZT0wMiwgc2VjLWxhdGVu
Y3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6IDIwMDAtMmZmZiBbc2l6ZT00S10gWzE2LWJpdF0K
CU1lbW9yeSBiZWhpbmQgYnJpZGdlOiBkYjQwMDAwMC1kYzNmZmZmZiBbc2l6ZT0xNk1dIFsz
Mi1iaXRdCglQcmVmZXRjaGFibGUgbWVtb3J5IGJlaGluZCBicmlkZ2U6IGQ4NDAwMDAwLWQ5
M2ZmZmZmIFtzaXplPTE2TV0gWzMyLWJpdF0KCVNlY29uZGFyeSBzdGF0dXM6IDY2TUh6LSBG
YXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQt
IDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0bDogUGFyaXR5LSBTRVJSKyBOb0lTQS0gVkdBLSBW
R0ExNi0gTUFib3J0LSA+UmVzZXQtIEZhc3RCMkItCgkJUHJpRGlzY1Rtci0gU2VjRGlzY1Rt
ci0gRGlzY1RtclN0YXQtIERpc2NUbXJTRVJSRW4tCglDYXBhYmlsaXRpZXM6IFs0MF0gRXhw
cmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdCspLCBJbnRNc2dOdW0gMAoJCURldkNhcDoJTWF4
UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwCgkJCUV4dFRhZy0gUkJFKyBURUUtSU8t
CgkJRGV2Q3RsOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLQoJ
CQlSbHhkT3JkLSBFeHRUYWctIFBoYW50RnVuYy0gQXV4UHdyLSBOb1Nub29wLQoJCQlNYXhQ
YXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJlcSAxMjggYnl0ZXMKCQlEZXZTdGE6CUNvcnJF
cnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtIEF1eFB3cisgVHJhbnNQZW5k
LQoJCUxua0NhcDoJUG9ydCAjMSwgU3BlZWQgMi41R1QvcywgV2lkdGggeDEsIEFTUE0gTDBz
IEwxLCBFeGl0IExhdGVuY3kgTDBzIDwyNTZucywgTDEgPDR1cwoJCQlDbG9ja1BNLSBTdXJw
cmlzZS0gTExBY3RSZXArIEJ3Tm90LSBBU1BNT3B0Q29tcC0KCQlMbmtDdGw6CUFTUE0gTDEg
RW5hYmxlZDsgUkNCIDY0IGJ5dGVzLCBMbmtEaXNhYmxlLSBDb21tQ2xrKwoJCQlFeHRTeW5j
aC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0QldJbnQtIEZsdE1vZGVEaXMtCgkJ
TG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MQoJCQlUckVyci0gVHJhaW4tIFNsb3RD
bGsrIERMQWN0aXZlKyBCV01nbXQtIEFCV01nbXQtCgkJU2x0Q2FwOglBdHRuQnRuLSBQd3JD
dHJsLSBNUkwtIEF0dG5JbmQtIFB3ckluZC0gSG90UGx1ZysgU3VycHJpc2UrCgkJCVNsb3Qg
IzAsIFBvd2VyTGltaXQgMTBXOyBJbnRlcmxvY2stIE5vQ29tcGwrCgkJU2x0Q3RsOglFbmFi
bGU6IEF0dG5CdG4tIFB3ckZsdC0gTVJMLSBQcmVzRGV0LSBDbWRDcGx0LSBIUElycS0gTGlu
a0NoZy0KCQkJQ29udHJvbDogQXR0bkluZCBVbmtub3duLCBQd3JJbmQgVW5rbm93biwgUG93
ZXItIEludGVybG9jay0KCQlTbHRTdGE6CVN0YXR1czogQXR0bkJ0bi0gUG93ZXJGbHQtIE1S
TC0gQ21kQ3BsdC0gUHJlc0RldCsgSW50ZXJsb2NrLQoJCQlDaGFuZ2VkOiBNUkwtIFByZXNE
ZXQrIExpbmtTdGF0ZSsKCQlSb290Q2FwOiBDUlNWaXNpYmxlLQoJCVJvb3RDdGw6IEVyckNv
cnJlY3RhYmxlLSBFcnJOb24tRmF0YWwtIEVyckZhdGFsLSBQTUVJbnRFbmEtIENSU1Zpc2li
bGUtCgkJUm9vdFN0YTogUE1FIFJlcUlEIDAwMDAsIFBNRVN0YXR1cy0gUE1FUGVuZGluZy0K
CQlEZXZDYXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IFJhbmdlIEJDLCBUaW1lb3V0RGlzKyBO
Uk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBOb3Qg
U3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1
Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkg
RlJTLSBMTiBTeXN0ZW0gQ0xTIE5vdCBTdXBwb3J0ZWQsIFRQSENvbXAtIEV4dFRQSENvbXAt
IEFSSUZ3ZC0KCQkJIEF0b21pY09wc0NhcDogUm91dGluZy0gMzJiaXQtIDY0Yml0LSAxMjhi
aXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRp
bWVvdXREaXMrIEFSSUZ3ZC0KCQkJIEF0b21pY09wc0N0bDogUmVxRW4tIEVncmVzc0JsY2st
CgkJCSBJRE9SZXEtIElET0NvbXBsLSBMVFItIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uUmVx
LQoJCQkgMTBCaXRUYWdSZXEtIE9CRkYgRGlzYWJsZWQsIEVFVExQUHJlZml4QmxrLQoJCUxu
a0N0bDI6IFRhcmdldCBMaW5rIFNwZWVkOiAyLjVHVC9zLCBFbnRlckNvbXBsaWFuY2UtIFNw
ZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwgT3BlcmF0aW5nIFJhbmdlLCBF
bnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5jZVNPUy0KCQkJIENvbXBsaWFuY2Ug
UHJlc2V0L0RlLWVtcGhhc2lzOiAtNmRCIGRlLWVtcGhhc2lzLCAwZEIgcHJlc2hvb3QKCQlM
bmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtNmRCLCBFcXVhbGl6YXRpb25D
b21wbGV0ZS0gRXF1YWxpemF0aW9uUGhhc2UxLQoJCQkgRXF1YWxpemF0aW9uUGhhc2UyLSBF
cXVhbGl6YXRpb25QaGFzZTMtIExpbmtFcXVhbGl6YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1l
ci0gMlJldGltZXJzLSBDcm9zc2xpbmtSZXM6IHVuc3VwcG9ydGVkLCBGbHRNb2RlLQoJQ2Fw
YWJpbGl0aWVzOiBbODBdIE1TSTogRW5hYmxlLSBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0
LQoJCUFkZHJlc3M6IDAwMDAwMDAwICBEYXRhOiAwMDAwCglDYXBhYmlsaXRpZXM6IFs5MF0g
U3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0K
CUNhcGFiaWxpdGllczogW2EwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMgoJCUZsYWdz
OiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQxLSxEMi0s
RDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERT
ZWw9MCBEU2NhbGU9MCBQTUUtCglLZXJuZWwgZHJpdmVyIGluIHVzZTogcGNpZXBvcnQKCUtl
cm5lbCBtb2R1bGVzOiBzaHBjaHAKCjAwOjFjLjUgUENJIGJyaWRnZSBbMDYwNF06IEludGVs
IENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAgU2VyaWVzIENoaXBzZXQgUENJIEV4cHJlc3Mg
Um9vdCBQb3J0IDYgWzgwODY6M2I0Y10gKHJldiAwNSkgKHByb2ctaWYgMDAgW05vcm1hbCBk
ZWNvZGVdKQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEw
MjU6MDM1OV0KCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVt
V0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lO
VHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9
ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglM
YXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBC
IHJvdXRlZCB0byBJUlEgMTYKCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTAzLCBzdWJv
cmRpbmF0ZT0wMywgc2VjLWxhdGVuY3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6IDEwMDAtMWZm
ZiBbc2l6ZT00S10gWzE2LWJpdF0KCU1lbW9yeSBiZWhpbmQgYnJpZGdlOiBkYTQwMDAwMC1k
YjNmZmZmZiBbc2l6ZT0xNk1dIFszMi1iaXRdCglQcmVmZXRjaGFibGUgbWVtb3J5IGJlaGlu
ZCBicmlkZ2U6IGQ5NDAwMDAwLWRhM2ZmZmZmIFtzaXplPTE2TV0gWzMyLWJpdF0KCVNlY29u
ZGFyeSBzdGF0dXM6IDY2TUh6LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJv
cnQtIDxUQWJvcnQtIDxNQWJvcnQtIDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0bDogUGFyaXR5
LSBTRVJSKyBOb0lTQS0gVkdBLSBWR0ExNi0gTUFib3J0LSA+UmVzZXQtIEZhc3RCMkItCgkJ
UHJpRGlzY1Rtci0gU2VjRGlzY1Rtci0gRGlzY1RtclN0YXQtIERpc2NUbXJTRVJSRW4tCglD
YXBhYmlsaXRpZXM6IFs0MF0gRXhwcmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdCspLCBJbnRN
c2dOdW0gMAoJCURldkNhcDoJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIFBoYW50RnVuYyAwCgkJ
CUV4dFRhZy0gUkJFKyBURUUtSU8tCgkJRGV2Q3RsOglDb3JyRXJyLSBOb25GYXRhbEVyci0g
RmF0YWxFcnItIFVuc3VwUmVxLQoJCQlSbHhkT3JkLSBFeHRUYWctIFBoYW50RnVuYy0gQXV4
UHdyLSBOb1Nub29wLQoJCQlNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJlcSAxMjgg
Ynl0ZXMKCQlEZXZTdGE6CUNvcnJFcnIrIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBS
ZXEtIEF1eFB3cisgVHJhbnNQZW5kLQoJCUxua0NhcDoJUG9ydCAjNiwgU3BlZWQgMi41R1Qv
cywgV2lkdGggeDEsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDwyNTZucywgTDEg
PDR1cwoJCQlDbG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXArIEJ3Tm90LSBBU1BNT3B0Q29t
cC0KCQlMbmtDdGw6CUFTUE0gTDEgRW5hYmxlZDsgUkNCIDY0IGJ5dGVzLCBMbmtEaXNhYmxl
LSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0gQXV0
QldJbnQtIEZsdE1vZGVEaXMtCgkJTG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0aCB4MQoJ
CQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlKyBCV01nbXQtIEFCV01nbXQtCgkJ
U2x0Q2FwOglBdHRuQnRuLSBQd3JDdHJsLSBNUkwtIEF0dG5JbmQtIFB3ckluZC0gSG90UGx1
ZysgU3VycHJpc2UrCgkJCVNsb3QgIzUsIFBvd2VyTGltaXQgMTBXOyBJbnRlcmxvY2stIE5v
Q29tcGwrCgkJU2x0Q3RsOglFbmFibGU6IEF0dG5CdG4tIFB3ckZsdC0gTVJMLSBQcmVzRGV0
LSBDbWRDcGx0LSBIUElycS0gTGlua0NoZy0KCQkJQ29udHJvbDogQXR0bkluZCBVbmtub3du
LCBQd3JJbmQgVW5rbm93biwgUG93ZXItIEludGVybG9jay0KCQlTbHRTdGE6CVN0YXR1czog
QXR0bkJ0bi0gUG93ZXJGbHQtIE1STC0gQ21kQ3BsdC0gUHJlc0RldCsgSW50ZXJsb2NrLQoJ
CQlDaGFuZ2VkOiBNUkwtIFByZXNEZXQrIExpbmtTdGF0ZSsKCQlSb290Q2FwOiBDUlNWaXNp
YmxlLQoJCVJvb3RDdGw6IEVyckNvcnJlY3RhYmxlLSBFcnJOb24tRmF0YWwtIEVyckZhdGFs
LSBQTUVJbnRFbmEtIENSU1Zpc2libGUtCgkJUm9vdFN0YTogUE1FIFJlcUlEIDAwMDAsIFBN
RVN0YXR1cy0gUE1FUGVuZGluZy0KCQlEZXZDYXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IFJh
bmdlIEJDLCBUaW1lb3V0RGlzKyBOUk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wLSAx
MEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJ
CQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93
ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBMTiBTeXN0ZW0gQ0xTIE5vdCBTdXBwb3J0ZWQs
IFRQSENvbXAtIEV4dFRQSENvbXAtIEFSSUZ3ZC0KCQkJIEF0b21pY09wc0NhcDogUm91dGlu
Zy0gMzJiaXQtIDY0Yml0LSAxMjhiaXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1l
b3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMrIEFSSUZ3ZC0KCQkJIEF0b21pY09wc0N0
bDogUmVxRW4tIEVncmVzc0JsY2stCgkJCSBJRE9SZXEtIElET0NvbXBsLSBMVFItIEVtZXJn
ZW5jeVBvd2VyUmVkdWN0aW9uUmVxLQoJCQkgMTBCaXRUYWdSZXEtIE9CRkYgRGlzYWJsZWQs
IEVFVExQUHJlZml4QmxrLQoJCUxua0N0bDI6IFRhcmdldCBMaW5rIFNwZWVkOiAyLjVHVC9z
LCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3Jt
YWwgT3BlcmF0aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5j
ZVNPUy0KCQkJIENvbXBsaWFuY2UgUHJlc2V0L0RlLWVtcGhhc2lzOiAtNmRCIGRlLWVtcGhh
c2lzLCAwZEIgcHJlc2hvb3QKCQlMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVs
OiAtNmRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZS0gRXF1YWxpemF0aW9uUGhhc2UxLQoJCQkg
RXF1YWxpemF0aW9uUGhhc2UyLSBFcXVhbGl6YXRpb25QaGFzZTMtIExpbmtFcXVhbGl6YXRp
b25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9zc2xpbmtSZXM6IHVuc3Vw
cG9ydGVkLCBGbHRNb2RlLQoJQ2FwYWJpbGl0aWVzOiBbODBdIE1TSTogRW5hYmxlLSBDb3Vu
dD0xLzEgTWFza2FibGUtIDY0Yml0LQoJCUFkZHJlc3M6IDAwMDAwMDAwICBEYXRhOiAwMDAw
CglDYXBhYmlsaXRpZXM6IFs5MF0gU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJ
XSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNhcGFiaWxpdGllczogW2EwXSBQb3dlciBNYW5hZ2Vt
ZW50IHZlcnNpb24gMgoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50
PTBtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1Nv
ZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglLZXJuZWwgZHJpdmVy
IGluIHVzZTogcGNpZXBvcnQKCUtlcm5lbCBtb2R1bGVzOiBzaHBjaHAKCjAwOjFkLjAgVVNC
IGNvbnRyb2xsZXIgWzBjMDNdOiBJbnRlbCBDb3Jwb3JhdGlvbiA1IFNlcmllcy8zNDAwIFNl
cmllcyBDaGlwc2V0IFVTQjIgRW5oYW5jZWQgSG9zdCBDb250cm9sbGVyIFs4MDg2OjNiMzRd
IChyZXYgMDUpIChwcm9nLWlmIDIwIFtFSENJXSkKCVN1YnN5c3RlbTogQWNlciBJbmNvcnBv
cmF0ZWQgW0FMSV0gRGV2aWNlIFsxMDI1OjAzNTldCglDb250cm9sOiBJL08tIE1lbSsgQnVz
TWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5n
LSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZh
c3RCMkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0
LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBBIHJv
dXRlZCB0byBJUlEgMjMKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZGM1MDU4MDAgKDMyLWJpdCwg
bm9uLXByZWZldGNoYWJsZSkgW3NpemU9MUtdCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIg
TWFuYWdlbWVudCB2ZXJzaW9uIDIKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4
Q3VycmVudD0zNzVtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVz
OiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBh
YmlsaXRpZXM6IFs1OF0gRGVidWcgcG9ydDogQkFSPTEgb2Zmc2V0PTAwYTAKCUNhcGFiaWxp
dGllczogWzk4XSBQQ0kgQWR2YW5jZWQgRmVhdHVyZXMKCQlBRkNhcDogVFArIEZMUisKCQlB
RkN0cmw6IEZMUi0KCQlBRlN0YXR1czogVFAtCglLZXJuZWwgZHJpdmVyIGluIHVzZTogZWhj
aS1wY2kKCUtlcm5lbCBtb2R1bGVzOiBlaGNpX3BjaQoKMDA6MWUuMCBQQ0kgYnJpZGdlIFsw
NjA0XTogSW50ZWwgQ29ycG9yYXRpb24gODI4MDEgTW9iaWxlIFBDSSBCcmlkZ2UgWzgwODY6
MjQ0OF0gKHJldiBhNSkgKHByb2ctaWYgMDEgW1N1YnRyYWN0aXZlIGRlY29kZV0pCglTdWJz
eXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29u
dHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9v
cC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czog
Q2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQt
IDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUJ1
czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTA0LCBzdWJvcmRpbmF0ZT0wNCwgc2VjLWxhdGVu
Y3k9MzIKCUkvTyBiZWhpbmQgYnJpZGdlOiA1MDAwLTVmZmYgW3NpemU9NEtdIFsxNi1iaXRd
CglNZW1vcnkgYmVoaW5kIGJyaWRnZTogZGM3MDAwMDAtZGM4ZmZmZmYgW3NpemU9Mk1dIFsz
Mi1iaXRdCglQcmVmZXRjaGFibGUgbWVtb3J5IGJlaGluZCBicmlkZ2U6IGRjOTAwMDAwLWRj
YWZmZmZmIFtzaXplPTJNXSBbMzItYml0XQoJU2Vjb25kYXJ5IHN0YXR1czogNjZNSHotIEZh
c3RCMkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0
KyA8U0VSUi0gPFBFUlItCglCcmlkZ2VDdGw6IFBhcml0eS0gU0VSUisgTm9JU0EtIFZHQS0g
VkdBMTYtIE1BYm9ydC0gPlJlc2V0LSBGYXN0QjJCLQoJCVByaURpc2NUbXItIFNlY0Rpc2NU
bXItIERpc2NUbXJTdGF0LSBEaXNjVG1yU0VSUkVuLQoJQ2FwYWJpbGl0aWVzOiBbNTBdIFN1
YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FMSV0gRGV2aWNlIFsxMDI1OjAzNTldCgow
MDoxZi4wIElTQSBicmlkZ2UgWzA2MDFdOiBJbnRlbCBDb3Jwb3JhdGlvbiBITTU1IENoaXBz
ZXQgTFBDIEludGVyZmFjZSBDb250cm9sbGVyIFs4MDg2OjNiMDldIChyZXYgMDUpCglTdWJz
eXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29u
dHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9v
cC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czog
Q2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9y
dC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoJ
Q2FwYWJpbGl0aWVzOiBbZTBdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogSW50ZWwg
RmVhdHVyZSBEZXRlY3Rpb24KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBscGNfaWNoCglLZXJu
ZWwgbW9kdWxlczogbHBjX2ljaAoKMDA6MWYuMiBTQVRBIGNvbnRyb2xsZXIgWzAxMDZdOiBJ
bnRlbCBDb3Jwb3JhdGlvbiA1IFNlcmllcy8zNDAwIFNlcmllcyBDaGlwc2V0IDQgcG9ydCBT
QVRBIEFIQ0kgQ29udHJvbGxlciBbODA4NjozYjI5XSAocmV2IDA1KSAocHJvZy1pZiAwMSBb
QUhDSSAxLjBdKQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2Ug
WzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0g
TWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERp
c0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHorIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZT
RUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5U
eC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGluIEIgcm91dGVkIHRvIElSUSAyNAoJUmVn
aW9uIDA6IEkvTyBwb3J0cyBhdCA0MDQ4IFtzaXplPThdCglSZWdpb24gMTogSS9PIHBvcnRz
IGF0IDQwNWMgW3NpemU9NF0KCVJlZ2lvbiAyOiBJL08gcG9ydHMgYXQgNDA0MCBbc2l6ZT04
XQoJUmVnaW9uIDM6IEkvTyBwb3J0cyBhdCA0MDU4IFtzaXplPTRdCglSZWdpb24gNDogSS9P
IHBvcnRzIGF0IDQwMjAgW3NpemU9MzJdCglSZWdpb24gNTogTWVtb3J5IGF0IGRjNTA1MDAw
ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJLXQoJQ2FwYWJpbGl0aWVzOiBb
ODBdIE1TSTogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0LQoJCUFkZHJlc3M6
IGZlZTAwMDAwICBEYXRhOiAwMDI0CglDYXBhYmlsaXRpZXM6IFs3MF0gUG93ZXIgTWFuYWdl
bWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVu
dD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90KyxEM2NvbGQtKQoJCVN0YXR1czogRDAgTm9T
b2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVz
OiBbYThdIFNBVEEgSEJBIHYxLjAgQkFSNCBPZmZzZXQ9MDAwMDAwMDQKCUNhcGFiaWxpdGll
czogW2IwXSBQQ0kgQWR2YW5jZWQgRmVhdHVyZXMKCQlBRkNhcDogVFArIEZMUisKCQlBRkN0
cmw6IEZMUi0KCQlBRlN0YXR1czogVFAtCglLZXJuZWwgZHJpdmVyIGluIHVzZTogYWhjaQoJ
S2VybmVsIG1vZHVsZXM6IGFoY2kKCjAwOjFmLjMgU01CdXMgWzBjMDVdOiBJbnRlbCBDb3Jw
b3JhdGlvbiA1IFNlcmllcy8zNDAwIFNlcmllcyBDaGlwc2V0IFNNQnVzIENvbnRyb2xsZXIg
WzgwODY6M2IzMF0gKHJldiAwNSkKCVN1YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FM
SV0gRGV2aWNlIFsxMDI1OjAzNTldCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyLSBT
cGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBG
YXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBh
ckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0g
PFBFUlItIElOVHgtCglJbnRlcnJ1cHQ6IHBpbiBDIHJvdXRlZCB0byBJUlEgMTkKCVJlZ2lv
biAwOiBNZW1vcnkgYXQgZGM1MDYwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3Np
emU9MjU2XQoJUmVnaW9uIDQ6IEkvTyBwb3J0cyBhdCA0MDAwIFtzaXplPTMyXQoJS2VybmVs
IGRyaXZlciBpbiB1c2U6IGk4MDFfc21idXMKCUtlcm5lbCBtb2R1bGVzOiBpMmNfaTgwMQoK
MDA6MWYuNiBTaWduYWwgcHJvY2Vzc2luZyBjb250cm9sbGVyIFsxMTgwXTogSW50ZWwgQ29y
cG9yYXRpb24gNSBTZXJpZXMvMzQwMCBTZXJpZXMgQ2hpcHNldCBUaGVybWFsIFN1YnN5c3Rl
bSBbODA4NjozYjMyXSAocmV2IDA1KQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBb
QUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIr
IFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlIt
IEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0g
UGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0g
PFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJ
UlEgMjEKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZGM1MDQwMDAgKDY0LWJpdCwgbm9uLXByZWZl
dGNoYWJsZSkgW3NpemU9NEtdCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVu
dCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0krIEQxLSBEMi0gQXV4Q3VycmVudD0w
bUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQoJCVN0YXR1czogRDAgTm9Tb2Z0
UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVzOiBb
ODBdIE1TSTogRW5hYmxlLSBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0LQoJCUFkZHJlc3M6
IDAwMDAwMDAwICBEYXRhOiAwMDAwCglLZXJuZWwgZHJpdmVyIGluIHVzZTogaW50ZWwgaXBz
CglLZXJuZWwgbW9kdWxlczogaW50ZWxfaXBzCgowMTowMC4wIFZHQSBjb21wYXRpYmxlIGNv
bnRyb2xsZXIgWzAzMDBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTUQvQVRJ
XSBNYWRpc29uIFtNb2JpbGl0eSBSYWRlb24gSEQgNTY1MC81NzUwIC8gNjUzME0vNjU1ME1d
IFsxMDAyOjY4YzFdIChwcm9nLWlmIDAwIFtWR0EgY29udHJvbGxlcl0pCglTdWJzeXN0ZW06
IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIE1vYmlsaXR5IFJhZGVvbiBIRCA1NjUwIFsxMDI1
OjAzNTldCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJ
TlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4
KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZh
c3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0
ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRlcwoJSW50ZXJydXB0OiBwaW4gQSBy
b3V0ZWQgdG8gSVJRIDI2CglSZWdpb24gMDogTWVtb3J5IGF0IGQwMDAwMDAwICg2NC1iaXQs
IHByZWZldGNoYWJsZSkgW3NpemU9MTI4TV0KCVJlZ2lvbiAyOiBNZW1vcnkgYXQgZGM0MDAw
MDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTI4S10KCVJlZ2lvbiA0OiBJ
L08gcG9ydHMgYXQgMzAwMCBbc2l6ZT0yNTZdCglFeHBhbnNpb24gUk9NIGF0IGRjNDQwMDAw
IFtkaXNhYmxlZF0gW3NpemU9MTI4S10KCUNhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5h
Z2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDErIEQyKyBBdXhDdXJy
ZW50PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0pCgkJU3RhdHVzOiBEMCBO
b1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRp
ZXM6IFs1OF0gRXhwcmVzcyAodjIpIExlZ2FjeSBFbmRwb2ludCwgSW50TXNnTnVtIDAKCQlE
ZXZDYXA6CU1heFBheWxvYWQgMjU2IGJ5dGVzLCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMg
PDR1cywgTDEgdW5saW1pdGVkCgkJCUV4dFRhZysgQXR0bkJ0bi0gQXR0bkluZC0gUHdySW5k
LSBSQkUrIEZMUmVzZXQtIFRFRS1JTy0KCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJy
LSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQrIEV4dFRhZysgUGhhbnRGdW5jLSBB
dXhQd3ItIE5vU25vb3ArCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDUx
MiBieXRlcwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1
cFJlcS0gQXV4UHdyLSBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICMwLCBTcGVlZCAyLjVH
VC9zLCBXaWR0aCB4MTYsIEFTUE0gTDBzIEwxLCBFeGl0IExhdGVuY3kgTDBzIDw2NG5zLCBM
MSA8MXVzCgkJCUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJlcC0gQndOb3QtIEFTUE1PcHRD
b21wLQoJCUxua0N0bDoJQVNQTSBMMHMgTDEgRW5hYmxlZDsgUkNCIDY0IGJ5dGVzLCBMbmtE
aXNhYmxlLSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0lu
dC0gQXV0QldJbnQtIEZsdE1vZGVEaXMtCgkJTG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0
aCB4MTYKCQkJVHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBBQldN
Z210LQoJCURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogTm90IFN1cHBvcnRlZCwgVGlt
ZW91dERpcy0gTlJPUHJQclAtIExUUi0KCQkJIDEwQml0VGFnQ29tcC0gMTBCaXRUYWdSZXEt
IE9CRkYgTm90IFN1cHBvcnRlZCwgRXh0Rm10LSBFRVRMUFByZWZpeC0KCQkJIEVtZXJnZW5j
eVBvd2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0ZWQsIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9u
SW5pdC0KCQkJIEZSUy0KCQkJIEF0b21pY09wc0NhcDogMzJiaXQtIDY0Yml0LSAxMjhiaXRD
QVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVv
dXREaXMtCgkJCSBBdG9taWNPcHNDdGw6IFJlcUVuLQoJCQkgSURPUmVxLSBJRE9Db21wbC0g
TFRSLSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvblJlcS0KCQkJIDEwQml0VGFnUmVxLSBPQkZG
IERpc2FibGVkLCBFRVRMUFByZWZpeEJsay0KCQlMbmtDdGwyOiBUYXJnZXQgTGluayBTcGVl
ZDogMi41R1QvcywgRW50ZXJDb21wbGlhbmNlLSBTcGVlZERpcy0KCQkJIFRyYW5zbWl0IE1h
cmdpbjogTm9ybWFsIE9wZXJhdGluZyBSYW5nZSwgRW50ZXJNb2RpZmllZENvbXBsaWFuY2Ut
IENvbXBsaWFuY2VTT1MtCgkJCSBDb21wbGlhbmNlIFByZXNldC9EZS1lbXBoYXNpczogLTZk
QiBkZS1lbXBoYXNpcywgMGRCIHByZXNob290CgkJTG5rU3RhMjogQ3VycmVudCBEZS1lbXBo
YXNpcyBMZXZlbDogLTZkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUtIEVxdWFsaXphdGlvblBo
YXNlMS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0gRXF1YWxpemF0aW9uUGhhc2UzLSBMaW5r
RXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5r
UmVzOiB1bnN1cHBvcnRlZCwgRmx0TW9kZS0KCUNhcGFiaWxpdGllczogW2EwXSBNU0k6IEVu
YWJsZSsgQ291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAwMDAwMGZl
ZTAwMDAwICBEYXRhOiAwMDIwCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIFZlbmRvciBTcGVj
aWZpYyBJbmZvcm1hdGlvbjogSUQ9MDAwMSBSZXY9MSBMZW49MDEwIDw/PgoJS2VybmVsIGRy
aXZlciBpbiB1c2U6IHJhZGVvbgoJS2VybmVsIG1vZHVsZXM6IHJhZGVvbiwgYW1kZ3B1Cgow
MTowMC4xIEF1ZGlvIGRldmljZSBbMDQwM106IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIElu
Yy4gW0FNRC9BVEldIFJlZHdvb2QgSERNSSBBdWRpbyBbUmFkZW9uIEhEIDUwMDAgU2VyaWVz
XSBbMTAwMjphYTYwXSAocHJvZy1pZiAwMCBbSERBIGNvbXBhdGlibGVdKQoJU3Vic3lzdGVt
OiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6
IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBh
ckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsg
NjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFi
b3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBM
aW5lIFNpemU6IDY0IGJ5dGVzCglJbnRlcnJ1cHQ6IHBpbiBCIHJvdXRlZCB0byBJUlEgMjkK
CVJlZ2lvbiAwOiBNZW1vcnkgYXQgZGM0MjAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJs
ZSkgW3NpemU9MTZLXQoJQ2FwYWJpbGl0aWVzOiBbNTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVy
c2lvbiAzCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBEMSsgRDIrIEF1eEN1cnJlbnQ9MG1BIFBN
RShEMC0sRDEtLEQyLSxEM2hvdC0sRDNjb2xkLSkKCQlTdGF0dXM6IEQzIE5vU29mdFJzdC0g
UE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzU4XSBF
eHByZXNzICh2MikgTGVnYWN5IEVuZHBvaW50LCBJbnRNc2dOdW0gMAoJCURldkNhcDoJTWF4
UGF5bG9hZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5IEwwcyA8NHVzLCBMMSB1
bmxpbWl0ZWQKCQkJRXh0VGFnKyBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFJCRSsgRkxS
ZXNldC0gVEVFLUlPLQoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJy
LSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnKyBQaGFudEZ1bmMtIEF1eFB3ci0gTm9T
bm9vcCsKCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzCgkJ
RGV2U3RhOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQ
d3ItIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDIuNUdUL3MsIFdpZHRo
IHgxNiwgQVNQTSBMMHMgTDEsIEV4aXQgTGF0ZW5jeSBMMHMgPDY0bnMsIEwxIDwxdXMKCQkJ
Q2xvY2tQTS0gU3VycHJpc2UtIExMQWN0UmVwLSBCd05vdC0gQVNQTU9wdENvbXAtCgkJTG5r
Q3RsOglBU1BNIEwwcyBMMSBFbmFibGVkOyBSQ0IgNjQgYnl0ZXMsIExua0Rpc2FibGUtIENv
bW1DbGsrCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0lu
dC0gRmx0TW9kZURpcy0KCQlMbmtTdGE6CVNwZWVkIDIuNUdUL3MsIFdpZHRoIHgxNgoJCQlU
ckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01nbXQtCgkJRGV2
Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBOb3QgU3VwcG9ydGVkLCBUaW1lb3V0RGlzLSBO
Uk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBOb3Qg
U3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1
Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkg
RlJTLQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQtIDEyOGJpdENBUy0KCQlEZXZD
dGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywgVGltZW91dERpcy0KCQkJ
IEF0b21pY09wc0N0bDogUmVxRW4tCgkJCSBJRE9SZXEtIElET0NvbXBsLSBMVFItIEVtZXJn
ZW5jeVBvd2VyUmVkdWN0aW9uUmVxLQoJCQkgMTBCaXRUYWdSZXEtIE9CRkYgRGlzYWJsZWQs
IEVFVExQUHJlZml4QmxrLQoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6
IC02ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlLSBFcXVhbGl6YXRpb25QaGFzZTEtCgkJCSBF
cXVhbGl6YXRpb25QaGFzZTItIEVxdWFsaXphdGlvblBoYXNlMy0gTGlua0VxdWFsaXphdGlv
blJlcXVlc3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENyb3NzbGlua1JlczogdW5zdXBw
b3J0ZWQsIEZsdE1vZGUtCglDYXBhYmlsaXRpZXM6IFthMF0gTVNJOiBFbmFibGUrIENvdW50
PTEvMSBNYXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwNDAwMCAgRGF0
YTogMDAyMwoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYxXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3Jt
YXRpb246IElEPTAwMDEgUmV2PTEgTGVuPTAxMCA8Pz4KCUtlcm5lbCBkcml2ZXIgaW4gdXNl
OiBzbmRfaGRhX2ludGVsCglLZXJuZWwgbW9kdWxlczogc25kX2hkYV9pbnRlbAoKMDI6MDAu
MCBFdGhlcm5ldCBjb250cm9sbGVyIFswMjAwXTogUXVhbGNvbW0gQXRoZXJvcyBBUjgxNTEg
djEuMCBHaWdhYml0IEV0aGVybmV0IFsxOTY5OjEwNzNdIChyZXYgYzApCglTdWJzeXN0ZW06
IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDog
SS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFy
RXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwKyA2
Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJv
cnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAsIENhY2hlIExp
bmUgU2l6ZTogNjQgYnl0ZXMKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAzMQoJ
UmVnaW9uIDA6IE1lbW9yeSBhdCBkYjQwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT0yNTZLXQoJUmVnaW9uIDI6IEkvTyBwb3J0cyBhdCAyMDAwIFtzaXplPTEyOF0K
CUNhcGFiaWxpdGllczogWzQwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdz
OiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTM3NW1BIFBNRShEMCssRDErLEQy
KyxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6IEQwIE5vU29mdFJzdCsgUE1FLUVuYWJsZS0g
RFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzQ4XSBNU0k6IEVuYWJsZSsg
Q291bnQ9MS8xIE1hc2thYmxlLSA2NGJpdCsKCQlBZGRyZXNzOiAwMDAwMDAwMGZlZTAwMDAw
ICBEYXRhOiAwMDIzCglDYXBhYmlsaXRpZXM6IFs1OF0gRXhwcmVzcyAodjEpIEVuZHBvaW50
LCBJbnRNc2dOdW0gMAoJCURldkNhcDoJTWF4UGF5bG9hZCA0MDk2IGJ5dGVzLCBQaGFudEZ1
bmMgMCwgTGF0ZW5jeSBMMHMgdW5saW1pdGVkLCBMMSB1bmxpbWl0ZWQKCQkJRXh0VGFnLSBB
dHRuQnRuKyBBdHRuSW5kKyBQd3JJbmQrIFJCRSsgRkxSZXNldC0gU2xvdFBvd2VyTGltaXQg
MTBXIFRFRS1JTy0KCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0g
VW5zdXBSZXEtCgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25v
b3AtCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDUxMiBieXRlcwoJCURl
dlN0YToJQ29yckVycisgTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdy
KyBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICMwLCBTcGVlZCAyLjVHVC9zLCBXaWR0aCB4
MSwgQVNQTSBMMHMgTDEsIEV4aXQgTGF0ZW5jeSBMMHMgdW5saW1pdGVkLCBMMSB1bmxpbWl0
ZWQKCQkJQ2xvY2tQTSsgU3VycHJpc2UtIExMQWN0UmVwLSBCd05vdC0gQVNQTU9wdENvbXAt
CgkJTG5rQ3RsOglBU1BNIEwxIEVuYWJsZWQ7IFJDQiA2NCBieXRlcywgTG5rRGlzYWJsZS0g
Q29tbUNsaysKCQkJRXh0U3luY2gtIENsb2NrUE0rIEF1dFdpZERpcy0gQldJbnQtIEF1dEJX
SW50LSBGbHRNb2RlRGlzLQoJCUxua1N0YToJU3BlZWQgMi41R1QvcywgV2lkdGggeDEKCQkJ
VHJFcnItIFRyYWluLSBTbG90Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBBQldNZ210LQoJQ2Fw
YWJpbGl0aWVzOiBbNmNdIFZpdGFsIFByb2R1Y3QgRGF0YQoJCU5vdCByZWFkYWJsZQoJQ2Fw
YWJpbGl0aWVzOiBbMTAwIHYxXSBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcKCQlVRVN0YToJ
RExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhP
Ri0gTWFsZlRMUC0KCQkJRUNSQy0gVW5zdXBSZXErIEFDU1Zpb2wtIFVuY29yckludEVyci0g
QmxvY2tlZFRMUC0gQXRvbWljT3BCbG9ja2VkLSBUTFBCbG9ja2VkRXJyLQoJCQlQb2lzb25U
TFBCbG9ja2VkLSBETVdyUmVxQmxvY2tlZC0gSURFQ2hlY2stIE1pc0lERVRMUC0gUENSQ19D
SEVDSy0gVExQWGxhdEJsb2NrZWQtCgkJVUVNc2s6CURMUC0gU0RFUy0gVExQLSBGQ1AtIENt
cGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtCgkJCUVDUkMtIFVu
c3VwUmVxLSBBQ1NWaW9sLSBVbmNvcnJJbnRFcnItIEJsb2NrZWRUTFAtIEF0b21pY09wQmxv
Y2tlZC0gVExQQmxvY2tlZEVyci0KCQkJUG9pc29uVExQQmxvY2tlZC0gRE1XclJlcUJsb2Nr
ZWQtIElERUNoZWNrLSBNaXNJREVUTFAtIFBDUkNfQ0hFQ0stIFRMUFhsYXRCbG9ja2VkLQoJ
CVVFU3ZydDoJRExQLSBTREVTKyBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhD
bXBsdC0gUnhPRisgTWFsZlRMUCsKCQkJRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtIFVuY29y
ckludEVyci0gQmxvY2tlZFRMUC0gQXRvbWljT3BCbG9ja2VkLSBUTFBCbG9ja2VkRXJyLQoJ
CQlQb2lzb25UTFBCbG9ja2VkLSBETVdyUmVxQmxvY2tlZC0gSURFQ2hlY2stIE1pc0lERVRM
UC0gUENSQ19DSEVDSy0gVExQWGxhdEJsb2NrZWQtCgkJQ0VTdGE6CVJ4RXJyLSBCYWRUTFAr
IEJhZERMTFArIFJvbGxvdmVyLSBUaW1lb3V0LSBBZHZOb25GYXRhbEVyci0gQ29yckludEVy
ci0gSGVhZGVyT0YtCgkJQ0VNc2s6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVy
LSBUaW1lb3V0LSBBZHZOb25GYXRhbEVycisgQ29yckludEVyci0gSGVhZGVyT0YtCgkJQUVS
Q2FwOglGaXJzdCBFcnJvciBQb2ludGVyOiAxNCwgRUNSQ0dlbkNhcCsgRUNSQ0dlbkVuLSBF
Q1JDQ2hrQ2FwKyBFQ1JDQ2hrRW4tCgkJCU11bHRIZHJSZWNDYXAtIE11bHRIZHJSZWNFbi0g
VExQUGZ4UHJlcy0gSGRyTG9nQ2FwLQoJCUhlYWRlckxvZzogMDQwMDAwMDEgMDAwMDA4MGYg
MDIwMjAwMDAgMDAwMDAwMDAKCUNhcGFiaWxpdGllczogWzE4MCB2MV0gRGV2aWNlIFNlcmlh
bCBOdW1iZXIgZmYtZTEtMDMtN2UtYzgtMGEtYTktZmYKCUtlcm5lbCBkcml2ZXIgaW4gdXNl
OiBhdGwxYwoJS2VybmVsIG1vZHVsZXM6IGF0bDFjCgowMzowMC4wIE5ldHdvcmsgY29udHJv
bGxlciBbMDI4MF06IEludGVsIENvcnBvcmF0aW9uIFdpcmVsZXNzIDcyNjAgWzgwODY6MDhi
MV0gKHJldiBiYikKCVN1YnN5c3RlbTogSW50ZWwgQ29ycG9yYXRpb24gRHVhbCBCYW5kIFdp
cmVsZXNzLUFDIDcyNjAgW1dpbGtpbnMgUGVhayAyXSBbODA4Njo0NDcwXQoJQ29udHJvbDog
SS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFy
RXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2
Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJv
cnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAsIENhY2hlIExp
bmUgU2l6ZTogNjQgYnl0ZXMKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAyOAoJ
UmVnaW9uIDA6IE1lbW9yeSBhdCBkYTQwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT04S10KCUNhcGFiaWxpdGllczogW2M4XSBQb3dlciBNYW5hZ2VtZW50IHZlcnNp
b24gMwoJCUZsYWdzOiBQTUVDbGstIERTSSsgRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUo
RDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBN
RS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFtkMF0gTVNJ
OiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAw
MDBmZWUwNTAwMCAgRGF0YTogMDAyNQoJQ2FwYWJpbGl0aWVzOiBbNDBdIEV4cHJlc3MgKHYy
KSBFbmRwb2ludCwgSW50TXNnTnVtIDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMTI4IGJ5dGVz
LCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMgPDUxMm5zLCBMMSB1bmxpbWl0ZWQKCQkJRXh0
VGFnLSBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFJCRSsgRkxSZXNldCsgU2xvdFBvd2Vy
TGltaXQgMFcgVEVFLUlPLQoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFs
RXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZCsgRXh0VGFnLSBQaGFudEZ1bmMtIEF1eFB3cisg
Tm9Tbm9vcCsgRkxSZXNldC0KCQkJTWF4UGF5bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEg
MTI4IGJ5dGVzCgkJRGV2U3RhOglDb3JyRXJyKyBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVu
c3VwUmVxLSBBdXhQd3IrIFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzAsIFNwZWVkIDIu
NUdUL3MsIFdpZHRoIHgxLCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8NHVzLCBM
MSA8MzJ1cwoJCQlDbG9ja1BNKyBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0
Q29tcC0KCQlMbmtDdGw6CUFTUE0gTDEgRW5hYmxlZDsgUkNCIDY0IGJ5dGVzLCBMbmtEaXNh
YmxlLSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTSsgQXV0V2lkRGlzLSBCV0ludC0g
QXV0QldJbnQtIEZsdE1vZGVEaXMtCgkJTG5rU3RhOglTcGVlZCAyLjVHVC9zLCBXaWR0aCB4
MQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01nbXQt
CgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBSYW5nZSBCLCBUaW1lb3V0RGlzKyBO
Uk9QclByUC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBWaWEg
V0FLRSMsIEV4dEZtdC0gRUVUTFBQcmVmaXgtCgkJCSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlv
biBOb3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbkluaXQtCgkJCSBGUlMt
IFRQSENvbXAtIEV4dFRQSENvbXAtCgkJCSBBdG9taWNPcHNDYXA6IDMyYml0LSA2NGJpdC0g
MTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91dDogMTZtcyB0byA1NW1z
LCBUaW1lb3V0RGlzLQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0KCQkJIElET1JlcS0gSURP
Q29tcGwtIExUUi0gRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25SZXEtCgkJCSAxMEJpdFRhZ1Jl
cS0gT0JGRiBEaXNhYmxlZCwgRUVUTFBQcmVmaXhCbGstCgkJTG5rQ3RsMjogVGFyZ2V0IExp
bmsgU3BlZWQ6IDIuNUdUL3MsIEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtCgkJCSBUcmFu
c21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRDb21w
bGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkgQ29tcGxpYW5jZSBQcmVzZXQvRGUtZW1waGFz
aXM6IC02ZEIgZGUtZW1waGFzaXMsIDBkQiBwcmVzaG9vdAoJCUxua1N0YTI6IEN1cnJlbnQg
RGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVkQiwgRXF1YWxpemF0aW9uQ29tcGxldGUtIEVxdWFs
aXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0gRXF1YWxpemF0aW9uUGhh
c2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0g
Q3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZCwgRmx0TW9kZS0KCUNhcGFiaWxpdGllczogWzEw
MCB2MV0gQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nCgkJVUVTdGE6CURMUC0gU0RFUy0gVExQ
LSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtCgkJ
CUVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLSBVbmNvcnJJbnRFcnItIEJsb2NrZWRUTFAtIEF0
b21pY09wQmxvY2tlZC0gVExQQmxvY2tlZEVyci0KCQkJUG9pc29uVExQQmxvY2tlZC0gRE1X
clJlcUJsb2NrZWQtIElERUNoZWNrLSBNaXNJREVUTFAtIFBDUkNfQ0hFQ0stIFRMUFhsYXRC
bG9ja2VkLQoJCVVFTXNrOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFi
cnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLQoJCQlFQ1JDLSBVbnN1cFJlcS0gQUNTVmlv
bC0gVW5jb3JySW50RXJyLSBCbG9ja2VkVExQLSBBdG9taWNPcEJsb2NrZWQtIFRMUEJsb2Nr
ZWRFcnItCgkJCVBvaXNvblRMUEJsb2NrZWQtIERNV3JSZXFCbG9ja2VkLSBJREVDaGVjay0g
TWlzSURFVExQLSBQQ1JDX0NIRUNLLSBUTFBYbGF0QmxvY2tlZC0KCQlVRVN2cnQ6CURMUCsg
U0RFUysgVExQLSBGQ1ArIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YrIE1h
bGZUTFArCgkJCUVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLSBVbmNvcnJJbnRFcnIrIEJsb2Nr
ZWRUTFAtIEF0b21pY09wQmxvY2tlZC0gVExQQmxvY2tlZEVyci0KCQkJUG9pc29uVExQQmxv
Y2tlZC0gRE1XclJlcUJsb2NrZWQtIElERUNoZWNrLSBNaXNJREVUTFAtIFBDUkNfQ0hFQ0st
IFRMUFhsYXRCbG9ja2VkLQoJCUNFU3RhOglSeEVyci0gQmFkVExQKyBCYWRETExQLSBSb2xs
b3Zlci0gVGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrIENvcnJJbnRFcnItIEhlYWRlck9GLQoJ
CUNFTXNrOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gQWR2
Tm9uRmF0YWxFcnIrIENvcnJJbnRFcnItIEhlYWRlck9GLQoJCUFFUkNhcDoJRmlyc3QgRXJy
b3IgUG9pbnRlcjogMDAsIEVDUkNHZW5DYXAtIEVDUkNHZW5Fbi0gRUNSQ0Noa0NhcC0gRUNS
Q0Noa0VuLQoJCQlNdWx0SGRyUmVjQ2FwLSBNdWx0SGRyUmVjRW4tIFRMUFBmeFByZXMtIEhk
ckxvZ0NhcC0KCQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAw
MDAwCglDYXBhYmlsaXRpZXM6IFsxNDAgdjFdIERldmljZSBTZXJpYWwgTnVtYmVyIDAwLTE2
LTZmLWZmLWZmLWE2LTEyLTUxCglDYXBhYmlsaXRpZXM6IFsxNGMgdjFdIExhdGVuY3kgVG9s
ZXJhbmNlIFJlcG9ydGluZwoJCU1heCBzbm9vcCBsYXRlbmN5OiAwbnMKCQlNYXggbm8gc25v
b3AgbGF0ZW5jeTogMG5zCglDYXBhYmlsaXRpZXM6IFsxNTQgdjFdIFZlbmRvciBTcGVjaWZp
YyBJbmZvcm1hdGlvbjogSUQ9Y2FmZSBSZXY9MSBMZW49MDE0IDw/PgoJS2VybmVsIGRyaXZl
ciBpbiB1c2U6IGl3bHdpZmkKCUtlcm5lbCBtb2R1bGVzOiBpd2x3aWZpCgo3ZjowMC4wIEhv
c3QgYnJpZGdlIFswNjAwXTogSW50ZWwgQ29ycG9yYXRpb24gQ29yZSBQcm9jZXNzb3IgUXVp
Y2tQYXRoIEFyY2hpdGVjdHVyZSBHZW5lcmljIE5vbi1jb3JlIFJlZ2lzdGVycyBbODA4Njoy
YzYyXSAocmV2IDA1KQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZp
Y2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNs
ZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkIt
IERpc0lOVHgtCglTdGF0dXM6IENhcC0gNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBE
RVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElO
VHgtCglMYXRlbmN5OiAwCgo3ZjowMC4xIEhvc3QgYnJpZGdlIFswNjAwXTogSW50ZWwgQ29y
cG9yYXRpb24gQ29yZSBQcm9jZXNzb3IgUXVpY2tQYXRoIEFyY2hpdGVjdHVyZSBTeXN0ZW0g
QWRkcmVzcyBEZWNvZGVyIFs4MDg2OjJkMDFdIChyZXYgMDUpCglTdWJzeXN0ZW06IEFjZXIg
SW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDogSS9PLSBN
ZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBT
dGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwLSA2Nk1Iei0g
VURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxN
QWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCjdmOjAyLjAgSG9zdCBi
cmlkZ2UgWzA2MDBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBDb3JlIFByb2Nlc3NvciBRUEkgTGlu
ayAwIFs4MDg2OjJkMTBdIChyZXYgMDUpCglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVk
IFtBTEldIERldmljZSBbMTAyNTowMzU5XQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3Rl
cisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VS
Ui0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJC
LSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJS
LSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCjdmOjAyLjEgSG9zdCBicmlkZ2UgWzA2MDBd
OiBJbnRlbCBDb3Jwb3JhdGlvbiAxc3QgR2VuZXJhdGlvbiBDb3JlIGkzLzUvNyBQcm9jZXNz
b3IgUVBJIFBoeXNpY2FsIDAgWzgwODY6MmQxMV0gKHJldiAwNSkKCVN1YnN5c3RlbTogQWNl
ciBJbmNvcnBvcmF0ZWQgW0FMSV0gRGV2aWNlIFsxMDI1OjAzNTldCglDb250cm9sOiBJL08t
IE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnIt
IFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXAtIDY2TUh6
LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0g
PE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoKN2Y6MDIuMiBIb3N0
IGJyaWRnZSBbMDYwMF06IEludGVsIENvcnBvcmF0aW9uIDFzdCBHZW5lcmF0aW9uIENvcmUg
aTMvNS83IFByb2Nlc3NvciBSZXNlcnZlZCBbODA4NjoyZDEyXSAocmV2IDA1KQoJU3Vic3lz
dGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRy
b2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3At
IFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENh
cC0gNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8
VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCgo3Zjow
Mi4zIEhvc3QgYnJpZGdlIFswNjAwXTogSW50ZWwgQ29ycG9yYXRpb24gMXN0IEdlbmVyYXRp
b24gQ29yZSBpMy81LzcgUHJvY2Vzc29yIFJlc2VydmVkIFs4MDg2OjJkMTNdIChyZXYgMDUp
CglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIERldmljZSBbMTAyNTowMzU5
XQoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBW
R0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0
YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5U
QWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6
IDAKCg==
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8;
 name="audio_register_after_workaround_on7.0.0.txt"
Content-Disposition: attachment;
 filename="audio_register_after_workaround_on7.0.0.txt"
Content-Transfer-Encoding: base64

fiQgc3VkbyBweXRob24zIC0gPDwnRU9GJwppbXBvcnQgbW1hcCwgb3MsIHN0cnVjdApmZCA9
IG9zLm9wZW4oIi9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6MDA6MWIuMC9yZXNvdXJjZTAi
LCBvcy5PX1JET05MWSkKbSA9IG1tYXAubW1hcChmZCwgMHg0MDAwLCBtbWFwLk1BUF9TSEFS
RUQsIG1tYXAuUFJPVF9SRUFEKQpwcmludCgiR0NBUCAgID0gMHglMDR4IiAlIHN0cnVjdC51
bnBhY2tfZnJvbSgiPEgiLCBtLCAweDAwKVswXSkKcHJpbnQoIkdDVEwgICA9IDB4JTA4eCIg
JSBzdHJ1Y3QudW5wYWNrX2Zyb20oIjxJIiwgbSwgMHgwOClbMF0pCnByaW50KCJDT1JCUlAg
PSAweCUwNHgiICUgc3RydWN0LnVucGFja19mcm9tKCI8SCIsIG0sIDB4NEEpWzBdKQpFT0YK
R0NBUCAgID0gMHg0NDAxCkdDVEwgICA9IDB4MDAwMDAxMDEKQ09SQlJQID0gMHgwMDVhCg==

--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8; name="enabling_workaround_7.0.0.txt"
Content-Disposition: attachment; filename="enabling_workaround_7.0.0.txt"
Content-Transfer-Encoding: base64

KioqKiBMaXN0ZSBkZXIgSGFyZHdhcmUtR2Vyw6R0ZSAoUExBWUJBQ0spICoqKioKS2FydGUg
MTogSERNSSBbSERBIEFUSSBIRE1JXSwgR2Vyw6R0IDM6IEhETUkgMCBbSERNSSAwXQogIFN1
Yi1HZXLDpHRlOiAxLzEKICBTdWItR2Vyw6R0ICMwOiBzdWJkZXZpY2UgIzAKCn4kIGVjaG8g
MSB8IHN1ZG8gdGVlIC9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6MDA6MWIuMC9yZW1vdmUK
MQoKfiQgZWNobyAxIHwgc3VkbyB0ZWUgL3N5cy9idXMvcGNpL3Jlc2NhbgoxCgp+JCBhcGxh
eSAtbAoqKioqIExpc3RlIGRlciBIYXJkd2FyZS1HZXLDpHRlIChQTEFZQkFDSykgKioqKgpL
YXJ0ZSAwOiBNSUQgW0hEQSBJbnRlbCBNSURdLCBHZXLDpHQgMDogQUxDMjY5VkIgQW5hbG9n
IFtBTEMyNjlWQiBBbmFsb2ddCiAgU3ViLUdlcsOkdGU6IDEvMQogIFN1Yi1HZXLDpHQgIzA6
IHN1YmRldmljZSAjMApLYXJ0ZSAwOiBNSUQgW0hEQSBJbnRlbCBNSURdLCBHZXLDpHQgMTog
QUxDMjY5VkIgRGlnaXRhbCBbQUxDMjY5VkIgRGlnaXRhbF0KICBTdWItR2Vyw6R0ZTogMS8x
CiAgU3ViLUdlcsOkdCAjMDogc3ViZGV2aWNlICMwCkthcnRlIDE6IEhETUkgW0hEQSBBVEkg
SERNSV0sIEdlcsOkdCAzOiBIRE1JIDAgW0hETUkgMF0KICBTdWItR2Vyw6R0ZTogMS8xCiAg
U3ViLUdlcsOkdCAjMDogc3ViZGV2aWNlICMwCgp+JCBzdWRvIGRtZXNnIHwgdGFpbCAtMzAK
WyAzMzEyLjE1MDk0MF0gc25kX2hkYV9jb2RlY19hbGMyNjkgaGRhdWRpb0MwRDA6ICAgIHNw
ZWFrZXJfb3V0cz0wICgweDAvMHgwLzB4MC8weDAvMHgwKQpbIDMzMTIuMTUwOTQ0XSBzbmRf
aGRhX2NvZGVjX2FsYzI2OSBoZGF1ZGlvQzBEMDogICAgaHBfb3V0cz0xICgweDIxLzB4MC8w
eDAvMHgwLzB4MCkKWyAzMzEyLjE1MDk0N10gc25kX2hkYV9jb2RlY19hbGMyNjkgaGRhdWRp
b0MwRDA6ICAgIG1vbm86IG1vbm9fb3V0PTB4MApbIDMzMTIuMTUwOTQ5XSBzbmRfaGRhX2Nv
ZGVjX2FsYzI2OSBoZGF1ZGlvQzBEMDogICAgZGlnLW91dD0weDFlLzB4MApbIDMzMTIuMTUw
OTUyXSBzbmRfaGRhX2NvZGVjX2FsYzI2OSBoZGF1ZGlvQzBEMDogICAgaW5wdXRzOgpbIDMz
MTIuMTUwOTU2XSBzbmRfaGRhX2NvZGVjX2FsYzI2OSBoZGF1ZGlvQzBEMDogICAgICBJbnRl
cm5hbCBNaWM9MHgxMgpbIDMzMTIuMTUwOTU4XSBzbmRfaGRhX2NvZGVjX2FsYzI2OSBoZGF1
ZGlvQzBEMDogICAgICBNaWM9MHgxOApbIDMzMTIuMTYzOTMzXSBpbnB1dDogSERBIEludGVs
IE1JRCBNaWMgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFiLjAvc291bmQvY2Fy
ZDAvaW5wdXQxNwpbIDMzMTIuMTY0MDk0XSBpbnB1dDogSERBIEludGVsIE1JRCBIZWFkcGhv
bmUgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFiLjAvc291bmQvY2FyZDAvaW5w
dXQxOApbIDMzMzQuMDg4NTMzXSBwY2kgMDAwMDowMDoxYi4wOiBbODA4NjozYjU2XSB0eXBl
IDAwIGNsYXNzIDB4MDQwMzAwIFBDSWUgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5kcG9p
bnQKWyAzMzM0LjA4ODYyOF0gcGNpIDAwMDA6MDA6MWIuMDogQkFSIDAgW21lbSAweGRjNTAw
MDAwLTB4ZGM1MDNmZmYgNjRiaXRdClsgMzMzNC4wODg3ODBdIHBjaSAwMDAwOjAwOjFiLjA6
IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsgMzMzNC4wODkxNzBdIHBj
aWVwb3J0IDAwMDA6MDA6MDEuMDogYnJpZGdlIGNvbmZpZ3VyYXRpb24gaW52YWxpZCAoW2J1
cyBmZi1mZl0pLCByZWNvbmZpZ3VyaW5nClsgMzMzNC4wODkyOTJdIHBjaSAwMDAwOjAwOjFi
LjA6IEJBUiAwIFttZW0gMHhkYzUwMDAwMC0weGRjNTAzZmZmIDY0Yml0XTogYXNzaWduZWQK
WyAzMzM0LjA4OTMzNl0gcGNpIDAwMDA6MDA6MWUuMDogUENJIGJyaWRnZSB0byBbYnVzIDA0
XQpbIDMzMzQuMDg5MzQ0XSBwY2kgMDAwMDowMDoxZS4wOiAgIGJyaWRnZSB3aW5kb3cgW2lv
ICAweDUwMDAtMHg1ZmZmXQpbIDMzMzQuMDg5MzUzXSBwY2kgMDAwMDowMDoxZS4wOiAgIGJy
aWRnZSB3aW5kb3cgW21lbSAweGRjNzAwMDAwLTB4ZGM4ZmZmZmZdClsgMzMzNC4wODkzNTld
IHBjaSAwMDAwOjAwOjFlLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZGM5MDAwMDAtMHhk
Y2FmZmZmZiA2NGJpdCBwcmVmXQpbIDMzMzQuMDg5ODc4XSBzbmRfaGRhX2ludGVsIDAwMDA6
MDA6MWIuMDogYm91bmQgMDAwMDowMDowMi4wIChvcHMgaW50ZWxfYXVkaW9fY29tcG9uZW50
X2JpbmRfb3BzIFtpOTE1XSkKWyAzMzM0LjEwMjU1MF0gc25kX2hkYV9jb2RlY19hbGMyNjkg
aGRhdWRpb0MwRDA6IEFMQzI2OVZCOiBwaWNrZWQgZml4dXAgIGZvciBQQ0kgU1NJRCAxMDI1
OjAwMDAKWyAzMzM0LjEwMzA2Ml0gc25kX2hkYV9jb2RlY19hbGMyNjkgaGRhdWRpb0MwRDA6
IGF1dG9jb25maWcgZm9yIEFMQzI2OVZCOiBsaW5lX291dHM9MSAoMHgxNC8weDAvMHgwLzB4
MC8weDApIHR5cGU6c3BlYWtlcgpbIDMzMzQuMTAzMDY3XSBzbmRfaGRhX2NvZGVjX2FsYzI2
OSBoZGF1ZGlvQzBEMDogICAgc3BlYWtlcl9vdXRzPTAgKDB4MC8weDAvMHgwLzB4MC8weDAp
ClsgMzMzNC4xMDMwNzFdIHNuZF9oZGFfY29kZWNfYWxjMjY5IGhkYXVkaW9DMEQwOiAgICBo
cF9vdXRzPTEgKDB4MjEvMHgwLzB4MC8weDAvMHgwKQpbIDMzMzQuMTAzMDc0XSBzbmRfaGRh
X2NvZGVjX2FsYzI2OSBoZGF1ZGlvQzBEMDogICAgbW9ubzogbW9ub19vdXQ9MHgwClsgMzMz
NC4xMDMwNzZdIHNuZF9oZGFfY29kZWNfYWxjMjY5IGhkYXVkaW9DMEQwOiAgICBkaWctb3V0
PTB4MWUvMHgwClsgMzMzNC4xMDMwNzhdIHNuZF9oZGFfY29kZWNfYWxjMjY5IGhkYXVkaW9D
MEQwOiAgICBpbnB1dHM6ClsgMzMzNC4xMDMwODFdIHNuZF9oZGFfY29kZWNfYWxjMjY5IGhk
YXVkaW9DMEQwOiAgICAgIEludGVybmFsIE1pYz0weDEyClsgMzMzNC4xMDMwODNdIHNuZF9o
ZGFfY29kZWNfYWxjMjY5IGhkYXVkaW9DMEQwOiAgICAgIE1pYz0weDE4ClsgMzMzNC4xMTcy
MTddIGlucHV0OiBIREEgSW50ZWwgTUlEIE1pYyBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAw
MDA6MDA6MWIuMC9zb3VuZC9jYXJkMC9pbnB1dDE5ClsgMzMzNC4xMTczNDRdIGlucHV0OiBI
REEgSW50ZWwgTUlEIEhlYWRwaG9uZSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6
MWIuMC9zb3VuZC9jYXJkMC9pbnB1dDIwCg==
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8; name="audioregistertest.txt"
Content-Disposition: attachment; filename="audioregistertest.txt"
Content-Transfer-Encoding: base64

dWRvIHB5dGhvbjMgLSA8PCdFT0YnCmltcG9ydCBtbWFwLCBvcywgc3RydWN0CmZkID0gb3Mu
b3BlbigiL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMDowMDoxYi4wL3Jlc291cmNlMCIsIG9z
Lk9fUkRPTkxZKQptID0gbW1hcC5tbWFwKGZkLCAweDQwMDAsIG1tYXAuTUFQX1NIQVJFRCwg
bW1hcC5QUk9UX1JFQUQpCnByaW50KCJHQ0FQICAgPSAweCUwNHgiICUgc3RydWN0LnVucGFj
a19mcm9tKCI8SCIsIG0sIDB4MDApWzBdKQpwcmludCgiR0NUTCAgID0gMHglMDh4IiAlIHN0
cnVjdC51bnBhY2tfZnJvbSgiPEkiLCBtLCAweDA4KVswXSkKcHJpbnQoIkNPUkJSUCA9IDB4
JTA0eCIgJSBzdHJ1Y3QudW5wYWNrX2Zyb20oIjxIIiwgbSwgMHg0QSlbMF0pCkVPRgpbc3Vk
bzogYXV0aGVudGljYXRlXSBQYXNzd29ydDogICAgICAgIApHQ0FQICAgPSAweGZmZmYKR0NU
TCAgID0gMHhmZmZmZmZmZgpDT1JCUlAgPSAweGZmZmYK
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8; name="test_7.0.0_without_MSI.txt"
Content-Disposition: attachment; filename="test_7.0.0_without_MSI.txt"
Content-Transfer-Encoding: base64

MDA6MWIuMCBBdWRpbyBkZXZpY2U6IEludGVsIENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAg
U2VyaWVzIENoaXBzZXQgSGlnaCBEZWZpbml0aW9uIEF1ZGlvIChyZXYgMDUpIChwcm9nLWlm
IDAwIFtIREEgY29tcGF0aWJsZV0pCglTdWJzeXN0ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtB
TEldIERldmljZSAwMzU5CglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3lj
bGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJC
LSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0g
REVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJ
TlR4LQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDIyCglS
ZWdpb24gMDogTWVtb3J5IGF0IGRjNTAwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUp
IFtzaXplPTE2S10KCUNhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNp
b24gMgoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTU1bUEgUE1F
KEQwKyxEMS0sRDItLEQzaG90KyxEM2NvbGQrKQoJCVN0YXR1czogRDAgTm9Tb2Z0UnN0LSBQ
TUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVzOiBbNjBdIE1T
STogRW5hYmxlLSBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0KwoJCUFkZHJlc3M6IDAwMDAw
MDAwMDAwMDAwMDAgIERhdGE6IDAwMDAKCUNhcGFiaWxpdGllczogWzcwXSBFeHByZXNzICh2
MSkgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5kcG9pbnQsIEludE1zZ051bSAwCgkJRGV2
Q2FwOglNYXhQYXlsb2FkIDEyOCBieXRlcywgUGhhbnRGdW5jIDAKCQkJRXh0VGFnLSBSQkUt
IEZMUmVzZXQrIFRFRS1JTy0KCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRh
bEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3It
IE5vU25vb3AtIEZMUmVzZXQtCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVx
IDEyOCBieXRlcwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBV
bnN1cFJlcS0gQXV4UHdyKyBUcmFuc1BlbmQtCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIFZp
cnR1YWwgQ2hhbm5lbAoJCUNhcHM6CUxQRVZDPTAgUmVmQ2xrPTEwMG5zIFBBVEVudHJ5Qml0
cz0xCgkJQXJiOglGaXhlZC0gV1JSMzItIFdSUjY0LSBXUlIxMjgtCgkJQ3RybDoJQXJiU2Vs
ZWN0PUZpeGVkCgkJU3RhdHVzOglJblByb2dyZXNzLQoJCVZDMDoJQ2FwczoJUEFUT2Zmc2V0
PTAwIE1heFRpbWVTbG90cz0xIFJlalNub29wVHJhbnMtCgkJCUFyYjoJRml4ZWQtIFdSUjMy
LSBXUlI2NC0gV1JSMTI4LSBUV1JSMTI4LSBXUlIyNTYtCgkJCUN0cmw6CUVuYWJsZSsgSUQ9
MCBBcmJTZWxlY3Q9Rml4ZWQgVEMvVkM9ZmYKCQkJU3RhdHVzOglOZWdvUGVuZGluZy0gSW5Q
cm9ncmVzcy0KCQlWQzE6CUNhcHM6CVBBVE9mZnNldD0wMCBNYXhUaW1lU2xvdHM9MSBSZWpT
bm9vcFRyYW5zLQoJCQlBcmI6CUZpeGVkLSBXUlIzMi0gV1JSNjQtIFdSUjEyOC0gVFdSUjEy
OC0gV1JSMjU2LQoJCQlDdHJsOglFbmFibGUrIElEPTEgQXJiU2VsZWN0PUZpeGVkIFRDL1ZD
PTAwCgkJCVN0YXR1czoJTmVnb1BlbmRpbmctIEluUHJvZ3Jlc3MtCglDYXBhYmlsaXRpZXM6
IFsxMzAgdjFdIFJvb3QgQ29tcGxleCBMaW5rCgkJRGVzYzoJUG9ydE51bWJlcj0wZiBDb21w
b25lbnRJRD0wMCBFbHRUeXBlPUNvbmZpZwoJCUxpbmswOglEZXNjOglUYXJnZXRQb3J0PTAw
IFRhcmdldENvbXBvbmVudD0wMCBBc3NvY1JDUkItIExpbmtUeXBlPU1lbU1hcHBlZCBMaW5r
VmFsaWQrCgkJCUFkZHI6CTAwMDAwMDAwZmVkMWMwMDAKCUtlcm5lbCBkcml2ZXIgaW4gdXNl
OiBzbmRfaGRhX2ludGVsCglLZXJuZWwgbW9kdWxlczogc25kX2hkYV9pbnRlbAoK
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8; name="dmesg_good.txt"
Content-Disposition: attachment; filename="dmesg_good.txt"
Content-Transfer-Encoding: base64

WyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDAwMDAwMC0weDAw
MDAwMDAwMDAwOWNmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0g
MHgwMDAwMDAwMDAwMDlkMDAwLTB4MDAwMDAwMDAwMDA5ZmZmZl0gcmVzZXJ2ZWQKWyAgICAw
LjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDBlMDAwMC0weDAwMDAwMDAw
MDAwZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAw
MDAwMDAwMDAxMDAwMDAtMHgwMDAwMDAwMGIzNjc0ZmZmXSB1c2FibGUKWyAgICAwLjAwMDAw
MF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBiMzY3NTAwMC0weDAwMDAwMDAwYjM2YmVm
ZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAw
YjM2YmYwMDAtMHgwMDAwMDAwMGIzNzNhZmZmXSB1c2FibGUKWyAgICAwLjAwMDAwMF0gQklP
Uy1lODIwOiBbbWVtIDB4MDAwMDAwMDBiMzczYjAwMC0weDAwMDAwMDAwYjM3YmVmZmZdIEFD
UEkgTlZTClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwYjM3YmYw
MDAtMHgwMDAwMDAwMGIzN2UwZmZmXSB1c2FibGUKWyAgICAwLjAwMDAwMF0gQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDBiMzdlMTAwMC0weDAwMDAwMDAwYjM3ZmVmZmZdIEFDUEkgZGF0
YQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGIzN2ZmMDAwLTB4
MDAwMDAwMDBiMzdmZmZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21l
bSAweDAwMDAwMDAwYjM4MDAwMDAtMHgwMDAwMDAwMGJmZmZmZmZmXSByZXNlcnZlZApbICAg
IDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGYwMDAwMDAwLTB4MDAwMDAw
MDBmN2ZmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4
MDAwMDAwMDBmZWIwMDAwMC0weDAwMDAwMDAwZmViMDNmZmZdIHJlc2VydmVkClsgICAgMC4w
MDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmVjMDAwMDAtMHgwMDAwMDAwMGZl
YzAwZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAw
MDAwMGZlZDEwMDAwLTB4MDAwMDAwMDBmZWQxM2ZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAw
MF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZWQxODAwMC0weDAwMDAwMDAwZmVkMTlm
ZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAw
ZmVkMWIwMDAtMHgwMDAwMDAwMGZlZDFmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBC
SU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZlZTAwMDAwLTB4MDAwMDAwMDBmZWUwMGZmZl0g
cmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZmUw
MDAwMC0weDAwMDAwMDAwZmZmZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1Mt
ZTgyMDogW21lbSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwMWZiZmZmZmZmXSB1c2Fi
bGUKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDFmYzAwMDAwMC0w
eDAwMDAwMDAxZmZmZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDog
W21lbSAweDAwMDAwMDAyMDAwMDAwMDAtMHgwMDAwMDAwMjNiZmZmZmZmXSB1c2FibGUKWyAg
ICAwLjAwMjEzMV0gZTgyMDogdXBkYXRlIFttZW0gMHgwMDAwMDAwMC0weDAwMDAwZmZmXSB1
c2FibGUgPT0+IHJlc2VydmVkClsgICAgMC4wMDIxMzVdIGU4MjA6IHJlbW92ZSBbbWVtIDB4
MDAwYTAwMDAtMHgwMDBmZmZmZl0gdXNhYmxlClsgICAgMC4wNDM3NjNdIEJvb3RpbmcgcGFy
YXZpcnR1YWxpemVkIGtlcm5lbCBvbiBiYXJlIGhhcmR3YXJlClsgICAgMC4xODg3NTddIFNw
ZWN0cmUgVjEgOiBNaXRpZ2F0aW9uOiB1c2VyY29weS9zd2FwZ3MgYmFycmllcnMgYW5kIF9f
dXNlciBwb2ludGVyIHNhbml0aXphdGlvbgpbICAgIDAuMTg4NzY4XSBTcGVjdHJlIFYyIDog
bWl0aWdhdGlvbjogRW5hYmxpbmcgY29uZGl0aW9uYWwgSW5kaXJlY3QgQnJhbmNoIFByZWRp
Y3Rpb24gQmFycmllcgpbICAgIDAuMzQ4MTIxXSBQQ0k6IEVDQU0gW21lbSAweGYwMDAwMDAw
LTB4ZjdmZmZmZmZdIHJlc2VydmVkIGFzIEU4MjAgZW50cnkKWyAgICAwLjM4Nzg2MF0gUENJ
OiBVc2luZyBFODIwIHJlc2VydmF0aW9ucyBmb3IgaG9zdCBicmlkZ2Ugd2luZG93cwpbICAg
IDAuMzk5OTk1XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtpbyAgMHgw
MDAwLTB4MGNmNyB3aW5kb3ddClsgICAgMC4zOTk5OThdIHBjaV9idXMgMDAwMDowMDogcm9v
dCBidXMgcmVzb3VyY2UgW2lvICAweDBkMDAtMHhmZmZmIHdpbmRvd10KWyAgICAwLjQwMDAw
MF0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4MDAwYTAwMDAt
MHgwMDBiZmZmZiB3aW5kb3ddClsgICAgMC40MDAwMDNdIHBjaV9idXMgMDAwMDowMDogcm9v
dCBidXMgcmVzb3VyY2UgW21lbSAweGMwMDAwMDAwLTB4ZmVhZmZmZmYgd2luZG93XQpbICAg
IDAuNDAwMDA1XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMgMDAt
N2VdClsgICAgMC40MDAzNjFdIHBjaSAwMDAwOjAwOjAyLjA6IEJBUiAwIFttZW0gMHhkODAw
MDAwMC0weGQ4M2ZmZmZmIDY0Yml0XQpbICAgIDAuNDAwMzY1XSBwY2kgMDAwMDowMDowMi4w
OiBCQVIgMiBbbWVtIDB4YzAwMDAwMDAtMHhjZmZmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAu
NDAwMzY4XSBwY2kgMDAwMDowMDowMi4wOiBCQVIgNCBbaW8gIDB4NDA1MC0weDQwNTddClsg
ICAgMC40MDA3NzRdIHBjaSAwMDAwOjAwOjE2LjA6IEJBUiAwIFttZW0gMHhkYzUwNjEwMC0w
eGRjNTA2MTBmIDY0Yml0XQpbICAgIDAuNDAxNjYzXSBwY2kgMDAwMDowMDoxYS4wOiBCQVIg
MCBbbWVtIDB4ZGM1MDVjMDAtMHhkYzUwNWZmZl0KWyAgICAwLjQwMTg2NV0gcGNpIDAwMDA6
MDA6MWIuMDogWzgwODY6M2I1Nl0gdHlwZSAwMCBjbGFzcyAweDA0MDMwMCBQQ0llIFJvb3Qg
Q29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50ClsgICAgMC40MDE5MjBdIHBjaSAwMDAwOjAw
OjFiLjA6IEJBUiAwIFttZW0gMHhkYzUwMDAwMC0weGRjNTAzZmZmIDY0Yml0XQpbICAgIDAu
NDAyMDAyXSBwY2kgMDAwMDowMDoxYi4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90
IEQzY29sZApbICAgIDAuNDAzNjQ4XSBwY2kgMDAwMDowMDoxZC4wOiBCQVIgMCBbbWVtIDB4
ZGM1MDU4MDAtMHhkYzUwNWJmZl0KWyAgICAwLjQwNDMxNl0gcGNpIDAwMDA6MDA6MWYuMjog
QkFSIDAgW2lvICAweDQwNDgtMHg0MDRmXQpbICAgIDAuNDA0MzIxXSBwY2kgMDAwMDowMDox
Zi4yOiBCQVIgMSBbaW8gIDB4NDA1Yy0weDQwNWZdClsgICAgMC40MDQzMjRdIHBjaSAwMDAw
OjAwOjFmLjI6IEJBUiAyIFtpbyAgMHg0MDQwLTB4NDA0N10KWyAgICAwLjQwNDMyOF0gcGNp
IDAwMDA6MDA6MWYuMjogQkFSIDMgW2lvICAweDQwNTgtMHg0MDViXQpbICAgIDAuNDA0MzMy
XSBwY2kgMDAwMDowMDoxZi4yOiBCQVIgNCBbaW8gIDB4NDAyMC0weDQwM2ZdClsgICAgMC40
MDQzMzVdIHBjaSAwMDAwOjAwOjFmLjI6IEJBUiA1IFttZW0gMHhkYzUwNTAwMC0weGRjNTA1
N2ZmXQpbICAgIDAuNDA0NTcwXSBwY2kgMDAwMDowMDoxZi4zOiBCQVIgMCBbbWVtIDB4ZGM1
MDYwMDAtMHhkYzUwNjBmZiA2NGJpdF0KWyAgICAwLjQwNDU3N10gcGNpIDAwMDA6MDA6MWYu
MzogQkFSIDQgW2lvICAweDQwMDAtMHg0MDFmXQpbICAgIDAuNDA0NzU0XSBwY2kgMDAwMDow
MDoxZi42OiBCQVIgMCBbbWVtIDB4ZGM1MDQwMDAtMHhkYzUwNGZmZiA2NGJpdF0KWyAgICAw
LjQwNTAyNF0gcGNpIDAwMDA6MDE6MDAuMDogQkFSIDAgW21lbSAweGQwMDAwMDAwLTB4ZDdm
ZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjQwNTAyOV0gcGNpIDAwMDA6MDE6MDAuMDogQkFS
IDIgW21lbSAweGRjNDAwMDAwLTB4ZGM0MWZmZmYgNjRiaXRdClsgICAgMC40MDUwMzJdIHBj
aSAwMDAwOjAxOjAwLjA6IEJBUiA0IFtpbyAgMHgzMDAwLTB4MzBmZl0KWyAgICAwLjQwNTI1
MV0gcGNpIDAwMDA6MDE6MDAuMTogQkFSIDAgW21lbSAweGRjNDIwMDAwLTB4ZGM0MjNmZmYg
NjRiaXRdClsgICAgMC40MDU2MzJdIHBjaSAwMDAwOjAyOjAwLjA6IEJBUiAwIFttZW0gMHhk
YjQwMDAwMC0weGRiNDNmZmZmIDY0Yml0XQpbICAgIDAuNDA1NjM3XSBwY2kgMDAwMDowMjow
MC4wOiBCQVIgMiBbaW8gIDB4MjAwMC0weDIwN2ZdClsgICAgMC40MDYyMzldIHBjaSAwMDAw
OjAzOjAwLjA6IEJBUiAwIFttZW0gMHhkYTQwMDAwMC0weGRhNDAxZmZmIDY0Yml0XQpbICAg
IDAuNDA2ODYwXSBwY2lfYnVzIDAwMDA6MDQ6IGV4dGVuZGVkIGNvbmZpZyBzcGFjZSBub3Qg
YWNjZXNzaWJsZQpbICAgIDAuNDA4OTkzXSBwY2lfYnVzIDAwMDA6N2Y6IHJvb3QgYnVzIHJl
c291cmNlIFtidXMgN2ZdClsgICAgMC40MTYyMzhdIGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZl
ciBbbWVtIDB4MDAwOWQwMDAtMHgwMDA5ZmZmZl0KWyAgICAwLjQxNjI0MV0gZTgyMDogcmVz
ZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHhiMzY3NTAwMC0weGIzZmZmZmZmXQpbICAgIDAuNDE2
MjQzXSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweGIzNzNiMDAwLTB4YjNmZmZm
ZmZdClsgICAgMC40MTYyNDVdIGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4YjM3
ZTEwMDAtMHhiM2ZmZmZmZl0KWyAgICAwLjQxNjI0Nl0gZTgyMDogcmVzZXJ2ZSBSQU0gYnVm
ZmVyIFttZW0gMHhiMzgwMDAwMC0weGIzZmZmZmZmXQpbICAgIDAuNDIwNTk1XSBwbnAgMDA6
MDA6IGRpc2FibGluZyBbaW8gIDB4MTY0ZS0weDE2NGZdIGJlY2F1c2UgaXQgb3ZlcmxhcHMg
MDAwMDowMDoxYy41IEJBUiAxMyBbaW8gIDB4MTAwMC0weDFmZmZdClsgICAgMC40NTM0NzNd
IHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgNCBbaW8gIDB4MDAwMC0weDBjZjcgd2luZG93
XQpbICAgIDAuNDUzNDc2XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDUgW2lvICAweDBk
MDAtMHhmZmZmIHdpbmRvd10KWyAgICAwLjQ1MzQ3OF0gcGNpX2J1cyAwMDAwOjAwOiByZXNv
dXJjZSA2IFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZmIHdpbmRvd10KWyAgICAwLjQ1MzQ4
MF0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA3IFttZW0gMHhjMDAwMDAwMC0weGZlYWZm
ZmZmIHdpbmRvd10KWyAgICAwLjQ1MzQ4M10gcGNpX2J1cyAwMDAwOjAxOiByZXNvdXJjZSAw
IFtpbyAgMHgzMDAwLTB4M2ZmZl0KWyAgICAwLjQ1MzQ4NV0gcGNpX2J1cyAwMDAwOjAxOiBy
ZXNvdXJjZSAxIFttZW0gMHhkYzQwMDAwMC0weGRjNGZmZmZmXQpbICAgIDAuNDUzNDg3XSBw
Y2lfYnVzIDAwMDA6MDE6IHJlc291cmNlIDIgW21lbSAweGQwMDAwMDAwLTB4ZDdmZmZmZmYg
NjRiaXQgcHJlZl0KWyAgICAwLjQ1MzQ4OV0gcGNpX2J1cyAwMDAwOjAyOiByZXNvdXJjZSAw
IFtpbyAgMHgyMDAwLTB4MmZmZl0KWyAgICAwLjQ1MzQ5MV0gcGNpX2J1cyAwMDAwOjAyOiBy
ZXNvdXJjZSAxIFttZW0gMHhkYjQwMDAwMC0weGRjM2ZmZmZmXQpbICAgIDAuNDUzNDkzXSBw
Y2lfYnVzIDAwMDA6MDI6IHJlc291cmNlIDIgW21lbSAweGQ4NDAwMDAwLTB4ZDkzZmZmZmYg
NjRiaXQgcHJlZl0KWyAgICAwLjQ1MzQ5Nl0gcGNpX2J1cyAwMDAwOjAzOiByZXNvdXJjZSAw
IFtpbyAgMHgxMDAwLTB4MWZmZl0KWyAgICAwLjQ1MzQ5OF0gcGNpX2J1cyAwMDAwOjAzOiBy
ZXNvdXJjZSAxIFttZW0gMHhkYTQwMDAwMC0weGRiM2ZmZmZmXQpbICAgIDAuNDUzNTAwXSBw
Y2lfYnVzIDAwMDA6MDM6IHJlc291cmNlIDIgW21lbSAweGQ5NDAwMDAwLTB4ZGEzZmZmZmYg
NjRiaXQgcHJlZl0KWyAgICAwLjQ1MzUwMl0gcGNpX2J1cyAwMDAwOjA0OiByZXNvdXJjZSA0
IFtpbyAgMHgwMDAwLTB4MGNmNyB3aW5kb3ddClsgICAgMC40NTM1MDVdIHBjaV9idXMgMDAw
MDowNDogcmVzb3VyY2UgNSBbaW8gIDB4MGQwMC0weGZmZmYgd2luZG93XQpbICAgIDAuNDUz
NTA3XSBwY2lfYnVzIDAwMDA6MDQ6IHJlc291cmNlIDYgW21lbSAweDAwMGEwMDAwLTB4MDAw
YmZmZmYgd2luZG93XQpbICAgIDAuNDUzNTA5XSBwY2lfYnVzIDAwMDA6MDQ6IHJlc291cmNl
IDcgW21lbSAweGMwMDAwMDAwLTB4ZmVhZmZmZmYgd2luZG93XQpbICAgIDEuNjg3ODkwXSBh
dGExOiBTQVRBIG1heCBVRE1BLzEzMyBhYmFyIG0yMDQ4QDB4ZGM1MDUwMDAgcG9ydCAweGRj
NTA1MTAwIGlycSAyNCBscG0tcG9sIDMKWyAgICAxLjY4Nzg5NV0gYXRhMjogU0FUQSBtYXgg
VURNQS8xMzMgYWJhciBtMjA0OEAweGRjNTA1MDAwIHBvcnQgMHhkYzUwNTE4MCBpcnEgMjQg
bHBtLXBvbCAzClsgICAgMy45MTYwODJdIHN5c3RlbWRbMV06IHN5c3RlbWQgMjU5LjUtMHVi
dW50dTMuNCBydW5uaW5nIGluIHN5c3RlbSBtb2RlICgrUEFNICtBVURJVCArU0VMSU5VWCAr
QVBQQVJNT1IgK0lNQSArSVBFICtTTUFDSyArU0VDQ09NUCArR0NSWVBUIC1HTlVUTFMgK09Q
RU5TU0wgK0FDTCArQkxLSUQgK0NVUkwgK0VMRlVUSUxTICtGSURPMiArSUROMiAtSUROICtL
TU9EICtMSUJDUllQVFNFVFVQICtMSUJDUllQVFNFVFVQX1BMVUdJTlMgK0xJQkZESVNLICtQ
Q1JFMiArUFdRVUFMSVRZICtQMTFLSVQgK1FSRU5DT0RFICtUUE0yICtCWklQMiArTFo0ICtY
WiArWkxJQiArWlNURCArQlBGX0ZSQU1FV09SSyArQlRGIC1YS0JDT01NT04gLVVUTVAgK1NZ
U1ZJTklUICtMSUJBUkNISVZFKQpbICAgIDguNDU5Mzk1XSBbZHJtXSBEZXRlY3RlZCBWUkFN
IFJBTT0xMDI0TSwgQkFSPTEyOE0KWyAgIDEwLjM4MTk2N10gc25kX2hkYV9pbnRlbCAwMDAw
OjAwOjFiLjA6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAwMDAyKQpbICAgMTAuMzkyNzIw
XSBzbmRfaGRhX2ludGVsIDAwMDA6MDA6MWIuMDogYm91bmQgMDAwMDowMDowMi4wIChvcHMg
aW50ZWxfYXVkaW9fY29tcG9uZW50X2JpbmRfb3BzIFtpOTE1XSkKWyAgIDEwLjc1MTM4NF0g
aW5wdXQ6IEhEQSBJbnRlbCBNSUQgTWljIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDow
MDoxYi4wL3NvdW5kL2NhcmQwL2lucHV0MTcKWyAgIDEwLjc1MTUxNF0gaW5wdXQ6IEhEQSBJ
bnRlbCBNSUQgSGVhZHBob25lIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxYi4w
L3NvdW5kL2NhcmQwL2lucHV0MTgKWyAgIDMzLjk1MTczNF0gcGNpX2J1cyAwMDAwOjA0OiBB
bGxvY2F0aW5nIHJlc291cmNlcwpbICAgMzMuOTU0MDE5XSBwY2lfYnVzIDAwMDA6MDI6IEFs
bG9jYXRpbmcgcmVzb3VyY2VzClsgICAzMy45NTQwNTNdIHBjaV9idXMgMDAwMDowMzogQWxs
b2NhdGluZyByZXNvdXJjZXMKWyAgIDM0Ljk2MzAxMF0gcGNpX2J1cyAwMDAwOjA0OiBBbGxv
Y2F0aW5nIHJlc291cmNlcwpbICAgMzQuOTY0MjM3XSBwY2lfYnVzIDAwMDA6MDI6IEFsbG9j
YXRpbmcgcmVzb3VyY2VzClsgICAzNC45NjQyNjldIHBjaV9idXMgMDAwMDowMzogQWxsb2Nh
dGluZyByZXNvdXJjZXMKWyAgIDU2LjE2MDE2M10gcGNpX2J1cyAwMDAwOjA0OiBBbGxvY2F0
aW5nIHJlc291cmNlcwpbICAgNTYuMTYyNDQwXSBwY2lfYnVzIDAwMDA6MDI6IEFsbG9jYXRp
bmcgcmVzb3VyY2VzClsgICA1Ni4xNjI0ODJdIHBjaV9idXMgMDAwMDowMzogQWxsb2NhdGlu
ZyByZXNvdXJjZXMKWyAgIDc4LjIwODYxMV0gcGNpX2J1cyAwMDAwOjA0OiBBbGxvY2F0aW5n
IHJlc291cmNlcwpbICAgNzguMjA5ODY2XSBwY2lfYnVzIDAwMDA6MDI6IEFsbG9jYXRpbmcg
cmVzb3VyY2VzClsgICA3OC4yMDk5MDFdIHBjaV9idXMgMDAwMDowMzogQWxsb2NhdGluZyBy
ZXNvdXJjZXMKWyAgIDg3LjU1NjgzMl0gcGNpX2J1cyAwMDAwOjA0OiBBbGxvY2F0aW5nIHJl
c291cmNlcwpbICAgODcuNTU4MzA4XSBwY2lfYnVzIDAwMDA6MDI6IEFsbG9jYXRpbmcgcmVz
b3VyY2VzClsgICA4Ny41NTgzNDRdIHBjaV9idXMgMDAwMDowMzogQWxsb2NhdGluZyByZXNv
dXJjZXMK
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8; name="dmesg_bad.txt"
Content-Disposition: attachment; filename="dmesg_bad.txt"
Content-Transfer-Encoding: base64

WyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDAwMDAwMC0weDAw
MDAwMDAwMDAwOWNmZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0g
MHgwMDAwMDAwMDAwMDlkMDAwLTB4MDAwMDAwMDAwMDA5ZmZmZl0gcmVzZXJ2ZWQKWyAgICAw
LjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDBlMDAwMC0weDAwMDAwMDAw
MDAwZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAw
MDAwMDAwMDAxMDAwMDAtMHgwMDAwMDAwMGIzNjc0ZmZmXSB1c2FibGUKWyAgICAwLjAwMDAw
MF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBiMzY3NTAwMC0weDAwMDAwMDAwYjM2YmVm
ZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAw
YjM2YmYwMDAtMHgwMDAwMDAwMGIzNzNhZmZmXSB1c2FibGUKWyAgICAwLjAwMDAwMF0gQklP
Uy1lODIwOiBbbWVtIDB4MDAwMDAwMDBiMzczYjAwMC0weDAwMDAwMDAwYjM3YmVmZmZdIEFD
UEkgTlZTClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwYjM3YmYw
MDAtMHgwMDAwMDAwMGIzN2UwZmZmXSB1c2FibGUKWyAgICAwLjAwMDAwMF0gQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDBiMzdlMTAwMC0weDAwMDAwMDAwYjM3ZmVmZmZdIEFDUEkgZGF0
YQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGIzN2ZmMDAwLTB4
MDAwMDAwMDBiMzdmZmZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21l
bSAweDAwMDAwMDAwYjM4MDAwMDAtMHgwMDAwMDAwMGJmZmZmZmZmXSByZXNlcnZlZApbICAg
IDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGYwMDAwMDAwLTB4MDAwMDAw
MDBmN2ZmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4
MDAwMDAwMDBmZWIwMDAwMC0weDAwMDAwMDAwZmViMDNmZmZdIHJlc2VydmVkClsgICAgMC4w
MDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmVjMDAwMDAtMHgwMDAwMDAwMGZl
YzAwZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAw
MDAwMGZlZDEwMDAwLTB4MDAwMDAwMDBmZWQxM2ZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAw
MF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZWQxODAwMC0weDAwMDAwMDAwZmVkMTlm
ZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAw
ZmVkMWIwMDAtMHgwMDAwMDAwMGZlZDFmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBC
SU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZlZTAwMDAwLTB4MDAwMDAwMDBmZWUwMGZmZl0g
cmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZmUw
MDAwMC0weDAwMDAwMDAwZmZmZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1Mt
ZTgyMDogW21lbSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwMWZiZmZmZmZmXSB1c2Fi
bGUKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDFmYzAwMDAwMC0w
eDAwMDAwMDAxZmZmZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDog
W21lbSAweDAwMDAwMDAyMDAwMDAwMDAtMHgwMDAwMDAwMjNiZmZmZmZmXSB1c2FibGUKWyAg
ICAwLjAwMjIzOV0gZTgyMDogdXBkYXRlIFttZW0gMHgwMDAwMDAwMC0weDAwMDAwZmZmXSB1
c2FibGUgPT0+IHJlc2VydmVkClsgICAgMC4wMDIyNDNdIGU4MjA6IHJlbW92ZSBbbWVtIDB4
MDAwYTAwMDAtMHgwMDBmZmZmZl0gdXNhYmxlClsgICAgMC4wMTYyMDBdIFJBTURJU0s6IFtt
ZW0gMHgyYjFiMzAwMC0weDMxOGQwZmZmXQpbICAgIDAuMDQzMzkwXSBCb290aW5nIHBhcmF2
aXJ0dWFsaXplZCBrZXJuZWwgb24gYmFyZSBoYXJkd2FyZQpbICAgIDAuMTg4Nzg5XSBTcGVj
dHJlIFYxIDogTWl0aWdhdGlvbjogdXNlcmNvcHkvc3dhcGdzIGJhcnJpZXJzIGFuZCBfX3Vz
ZXIgcG9pbnRlciBzYW5pdGl6YXRpb24KWyAgICAwLjE4ODc5NV0gU3BlY3RyZSBWMiA6IG1p
dGlnYXRpb246IEVuYWJsaW5nIGNvbmRpdGlvbmFsIEluZGlyZWN0IEJyYW5jaCBQcmVkaWN0
aW9uIEJhcnJpZXIKWyAgICAwLjM0ODIxMF0gUENJOiBFQ0FNIFttZW0gMHhmMDAwMDAwMC0w
eGY3ZmZmZmZmXSByZXNlcnZlZCBhcyBFODIwIGVudHJ5ClsgICAgMC4zOTk5MTFdIFBDSTog
VXNpbmcgRTgyMCByZXNlcnZhdGlvbnMgZm9yIGhvc3QgYnJpZGdlIHdpbmRvd3MKWyAgICAw
LjQxMTk0OF0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4MDAw
MC0weDBjZjcgd2luZG93XQpbICAgIDAuNDExOTUyXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3Qg
YnVzIHJlc291cmNlIFtpbyAgMHgwZDAwLTB4ZmZmZiB3aW5kb3ddClsgICAgMC40MTE5NTRd
IHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweDAwMGEwMDAwLTB4
MDAwYmZmZmYgd2luZG93XQpbICAgIDAuNDExOTU3XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3Qg
YnVzIHJlc291cmNlIFttZW0gMHhjMDAwMDAwMC0weGZlYWZmZmZmIHdpbmRvd10KWyAgICAw
LjQxMTk2MF0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbYnVzIDAwLTdl
XQpbICAgIDAuNDEyMzA5XSBwY2kgMDAwMDowMDowMi4wOiBCQVIgMCBbbWVtIDB4ZDgwMDAw
MDAtMHhkODNmZmZmZiA2NGJpdF0KWyAgICAwLjQxMjMxMl0gcGNpIDAwMDA6MDA6MDIuMDog
QkFSIDIgW21lbSAweGMwMDAwMDAwLTB4Y2ZmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjQx
MjMxNV0gcGNpIDAwMDA6MDA6MDIuMDogQkFSIDQgW2lvICAweDQwNTAtMHg0MDU3XQpbICAg
IDAuNDEyNzEyXSBwY2kgMDAwMDowMDoxNi4wOiBCQVIgMCBbbWVtIDB4ZGM1MDYxMDAtMHhk
YzUwNjEwZiA2NGJpdF0KWyAgICAwLjQxMzY5NV0gcGNpIDAwMDA6MDA6MWEuMDogQkFSIDAg
W21lbSAweGRjNTA1YzAwLTB4ZGM1MDVmZmZdClsgICAgMC40MTM5MDNdIHBjaSAwMDAwOjAw
OjFiLjA6IFs4MDg2OjNiNTZdIHR5cGUgMDAgY2xhc3MgMHgwNDAzMDAgUENJZSBSb290IENv
bXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludApbICAgIDAuNDEzOTU5XSBwY2kgMDAwMDowMDox
Yi4wOiBCQVIgMCBbbWVtIDB4ZGM1MDAwMDAtMHhkYzUwM2ZmZiA2NGJpdF0KWyAgICAwLjQx
NDA0MF0gcGNpIDAwMDA6MDA6MWIuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBE
M2NvbGQKWyAgICAwLjQyNTExNV0gcGNpIDAwMDA6MDA6MWQuMDogQkFSIDAgW21lbSAweGRj
NTA1ODAwLTB4ZGM1MDViZmZdClsgICAgMC40MjU5NDRdIHBjaSAwMDAwOjAwOjFmLjI6IEJB
UiAwIFtpbyAgMHg0MDQ4LTB4NDA0Zl0KWyAgICAwLjQyNTk0OF0gcGNpIDAwMDA6MDA6MWYu
MjogQkFSIDEgW2lvICAweDQwNWMtMHg0MDVmXQpbICAgIDAuNDI1OTUyXSBwY2kgMDAwMDow
MDoxZi4yOiBCQVIgMiBbaW8gIDB4NDA0MC0weDQwNDddClsgICAgMC40MjU5NTZdIHBjaSAw
MDAwOjAwOjFmLjI6IEJBUiAzIFtpbyAgMHg0MDU4LTB4NDA1Yl0KWyAgICAwLjQyNTk1OV0g
cGNpIDAwMDA6MDA6MWYuMjogQkFSIDQgW2lvICAweDQwMjAtMHg0MDNmXQpbICAgIDAuNDI1
OTYzXSBwY2kgMDAwMDowMDoxZi4yOiBCQVIgNSBbbWVtIDB4ZGM1MDUwMDAtMHhkYzUwNTdm
Zl0KWyAgICAwLjQyNjE5M10gcGNpIDAwMDA6MDA6MWYuMzogQkFSIDAgW21lbSAweGRjNTA2
MDAwLTB4ZGM1MDYwZmYgNjRiaXRdClsgICAgMC40MjYyMDBdIHBjaSAwMDAwOjAwOjFmLjM6
IEJBUiA0IFtpbyAgMHg0MDAwLTB4NDAxZl0KWyAgICAwLjQyNjM4MF0gcGNpIDAwMDA6MDA6
MWYuNjogQkFSIDAgW21lbSAweGRjNTA0MDAwLTB4ZGM1MDRmZmYgNjRiaXRdClsgICAgMC40
MjY2NDVdIHBjaSAwMDAwOjAxOjAwLjA6IEJBUiAwIFttZW0gMHhkMDAwMDAwMC0weGQ3ZmZm
ZmZmIDY0Yml0IHByZWZdClsgICAgMC40MjY2NTBdIHBjaSAwMDAwOjAxOjAwLjA6IEJBUiAy
IFttZW0gMHhkYzQwMDAwMC0weGRjNDFmZmZmIDY0Yml0XQpbICAgIDAuNDI2NjUzXSBwY2kg
MDAwMDowMTowMC4wOiBCQVIgNCBbaW8gIDB4MzAwMC0weDMwZmZdClsgICAgMC40MjY4ODNd
IHBjaSAwMDAwOjAxOjAwLjE6IEJBUiAwIFttZW0gMHhkYzQyMDAwMC0weGRjNDIzZmZmIDY0
Yml0XQpbICAgIDAuNDI3MjY5XSBwY2kgMDAwMDowMjowMC4wOiBCQVIgMCBbbWVtIDB4ZGI0
MDAwMDAtMHhkYjQzZmZmZiA2NGJpdF0KWyAgICAwLjQyNzI3M10gcGNpIDAwMDA6MDI6MDAu
MDogQkFSIDIgW2lvICAweDIwMDAtMHgyMDdmXQpbICAgIDAuNDI3ODY5XSBwY2kgMDAwMDow
MzowMC4wOiBCQVIgMCBbbWVtIDB4ZGE0MDAwMDAtMHhkYTQwMWZmZiA2NGJpdF0KWyAgICAw
LjQyODQ4N10gcGNpX2J1cyAwMDAwOjA0OiBleHRlbmRlZCBjb25maWcgc3BhY2Ugbm90IGFj
Y2Vzc2libGUKWyAgICAwLjQzMDY0M10gcGNpX2J1cyAwMDAwOjdmOiByb290IGJ1cyByZXNv
dXJjZSBbYnVzIDdmXQpbICAgIDAuNDM4MDM0XSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIg
W21lbSAweDAwMDlkMDAwLTB4MDAwOWZmZmZdClsgICAgMC40MzgwMzddIGU4MjA6IHJlc2Vy
dmUgUkFNIGJ1ZmZlciBbbWVtIDB4YjM2NzUwMDAtMHhiM2ZmZmZmZl0KWyAgICAwLjQzODAz
OV0gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHhiMzczYjAwMC0weGIzZmZmZmZm
XQpbICAgIDAuNDM4MDQxXSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweGIzN2Ux
MDAwLTB4YjNmZmZmZmZdClsgICAgMC40MzgwNDNdIGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZl
ciBbbWVtIDB4YjM4MDAwMDAtMHhiM2ZmZmZmZl0KWyAgICAwLjQ0NDY0M10gcG5wIDAwOjAw
OiBkaXNhYmxpbmcgW2lvICAweDE2NGUtMHgxNjRmXSBiZWNhdXNlIGl0IG92ZXJsYXBzIDAw
MDA6MDA6MWMuNSBCQVIgMTMgW2lvICAweDEwMDAtMHgxZmZmXQpbICAgIDAuNTA2MTExXSBw
Y2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDQgW2lvICAweDAwMDAtMHgwY2Y3IHdpbmRvd10K
WyAgICAwLjUwNjExN10gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA1IFtpbyAgMHgwZDAw
LTB4ZmZmZiB3aW5kb3ddClsgICAgMC41MDYxMjJdIHBjaV9idXMgMDAwMDowMDogcmVzb3Vy
Y2UgNiBbbWVtIDB4MDAwYTAwMDAtMHgwMDBiZmZmZiB3aW5kb3ddClsgICAgMC41MDYxMjdd
IHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgNyBbbWVtIDB4YzAwMDAwMDAtMHhmZWFmZmZm
ZiB3aW5kb3ddClsgICAgMC41MDYxMzJdIHBjaV9idXMgMDAwMDowMTogcmVzb3VyY2UgMCBb
aW8gIDB4MzAwMC0weDNmZmZdClsgICAgMC41MDYxMzddIHBjaV9idXMgMDAwMDowMTogcmVz
b3VyY2UgMSBbbWVtIDB4ZGM0MDAwMDAtMHhkYzRmZmZmZl0KWyAgICAwLjUwNjE0MV0gcGNp
X2J1cyAwMDAwOjAxOiByZXNvdXJjZSAyIFttZW0gMHhkMDAwMDAwMC0weGQ3ZmZmZmZmIDY0
Yml0IHByZWZdClsgICAgMC41MDYxNDddIHBjaV9idXMgMDAwMDowMjogcmVzb3VyY2UgMCBb
aW8gIDB4MjAwMC0weDJmZmZdClsgICAgMC41MDYxNTFdIHBjaV9idXMgMDAwMDowMjogcmVz
b3VyY2UgMSBbbWVtIDB4ZGI0MDAwMDAtMHhkYzNmZmZmZl0KWyAgICAwLjUwNjE1Nl0gcGNp
X2J1cyAwMDAwOjAyOiByZXNvdXJjZSAyIFttZW0gMHhkODQwMDAwMC0weGQ5M2ZmZmZmIDY0
Yml0IHByZWZdClsgICAgMC41MDYxNjFdIHBjaV9idXMgMDAwMDowMzogcmVzb3VyY2UgMCBb
aW8gIDB4MTAwMC0weDFmZmZdClsgICAgMC41MDYxNjZdIHBjaV9idXMgMDAwMDowMzogcmVz
b3VyY2UgMSBbbWVtIDB4ZGE0MDAwMDAtMHhkYjNmZmZmZl0KWyAgICAwLjUwNjE3MV0gcGNp
X2J1cyAwMDAwOjAzOiByZXNvdXJjZSAyIFttZW0gMHhkOTQwMDAwMC0weGRhM2ZmZmZmIDY0
Yml0IHByZWZdClsgICAgMC41MDYxNzZdIHBjaV9idXMgMDAwMDowNDogcmVzb3VyY2UgNCBb
aW8gIDB4MDAwMC0weDBjZjcgd2luZG93XQpbICAgIDAuNTA2MTgxXSBwY2lfYnVzIDAwMDA6
MDQ6IHJlc291cmNlIDUgW2lvICAweDBkMDAtMHhmZmZmIHdpbmRvd10KWyAgICAwLjUwNjE4
Nl0gcGNpX2J1cyAwMDAwOjA0OiByZXNvdXJjZSA2IFttZW0gMHgwMDBhMDAwMC0weDAwMGJm
ZmZmIHdpbmRvd10KWyAgICAwLjUwNjE5MV0gcGNpX2J1cyAwMDAwOjA0OiByZXNvdXJjZSA3
IFttZW0gMHhjMDAwMDAwMC0weGZlYWZmZmZmIHdpbmRvd10KWyAgICAxLjc4Njk5MF0gYXRh
MTogU0FUQSBtYXggVURNQS8xMzMgYWJhciBtMjA0OEAweGRjNTA1MDAwIHBvcnQgMHhkYzUw
NTEwMCBpcnEgMjQgbHBtLXBvbCAzClsgICAgMS43ODY5OTddIGF0YTI6IFNBVEEgbWF4IFVE
TUEvMTMzIGFiYXIgbTIwNDhAMHhkYzUwNTAwMCBwb3J0IDB4ZGM1MDUxODAgaXJxIDI0IGxw
bS1wb2wgMwpbICAgIDQuMjQyNTY1XSBzeXN0ZW1kWzFdOiBzeXN0ZW1kIDI1OS41LTB1YnVu
dHUzLjQgcnVubmluZyBpbiBzeXN0ZW0gbW9kZSAoK1BBTSArQVVESVQgK1NFTElOVVggK0FQ
UEFSTU9SICtJTUEgK0lQRSArU01BQ0sgK1NFQ0NPTVAgK0dDUllQVCAtR05VVExTICtPUEVO
U1NMICtBQ0wgK0JMS0lEICtDVVJMICtFTEZVVElMUyArRklETzIgK0lETjIgLUlETiArS01P
RCArTElCQ1JZUFRTRVRVUCArTElCQ1JZUFRTRVRVUF9QTFVHSU5TICtMSUJGRElTSyArUENS
RTIgK1BXUVVBTElUWSArUDExS0lUICtRUkVOQ09ERSArVFBNMiArQlpJUDIgK0xaNCArWFog
K1pMSUIgK1pTVEQgK0JQRl9GUkFNRVdPUksgK0JURiAtWEtCQ09NTU9OIC1VVE1QICtTWVNW
SU5JVCArTElCQVJDSElWRSkKWyAgIDIwLjc3MTQ5MV0gW2RybV0gRGV0ZWN0ZWQgVlJBTSBS
QU09MTAyNE0sIEJBUj0xMjhNClsgICAyMS43MTY4ODZdIHNuZF9oZGFfaW50ZWwgMDAwMDow
MDoxYi4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikKWyAgIDIyLjczNjQ3OV0g
c25kX2hkYV9pbnRlbCAwMDAwOjAwOjFiLjA6IGJvdW5kIDAwMDA6MDA6MDIuMCAob3BzIGlu
dGVsX2F1ZGlvX2NvbXBvbmVudF9iaW5kX29wcyBbaTkxNV0pClsgICAyMi43MzY5OTldIHNu
ZF9oZGFfaW50ZWwgMDAwMDowMDoxYi4wOiBudW1iZXIgb2YgSS9PIHN0cmVhbXMgaXMgMzAs
IGZvcmNpbmcgc2VwYXJhdGUgc3RyZWFtIHRhZ3MKWyAgIDIyLjg0MTY2MV0gc25kX2hkYV9p
bnRlbCAwMDAwOjAwOjFiLjA6IENPUkIgcmVzZXQgdGltZW91dCMyLCBDT1JCUlAgPSA2NTUz
NQpbICAgMjIuODQyMDA3XSBzbmRfaGRhX2ludGVsIDAwMDA6MDA6MWIuMDogbm8gY29kZWNz
IGluaXRpYWxpemVkClsgICA0Ni42OTc4NDldIHBjaV9idXMgMDAwMDowNDogQWxsb2NhdGlu
ZyByZXNvdXJjZXMKWyAgIDQ2LjY5OTIwOV0gcGNpX2J1cyAwMDAwOjAyOiBBbGxvY2F0aW5n
IHJlc291cmNlcwpbICAgNDYuNjk5MjQ0XSBwY2lfYnVzIDAwMDA6MDM6IEFsbG9jYXRpbmcg
cmVzb3VyY2VzClsgICA0Ny43MDYzNjldIHBjaV9idXMgMDAwMDowNDogQWxsb2NhdGluZyBy
ZXNvdXJjZXMKWyAgIDQ3LjcwNzUyMF0gcGNpX2J1cyAwMDAwOjAyOiBBbGxvY2F0aW5nIHJl
c291cmNlcwpbICAgNDcuNzA3NTU0XSBwY2lfYnVzIDAwMDA6MDM6IEFsbG9jYXRpbmcgcmVz
b3VyY2VzClsgICA2MC41NjQyNDVdIHBjaV9idXMgMDAwMDowNDogQWxsb2NhdGluZyByZXNv
dXJjZXMKWyAgIDYwLjU2NjI1OV0gcGNpX2J1cyAwMDAwOjAyOiBBbGxvY2F0aW5nIHJlc291
cmNlcwpbICAgNjAuNTY2MzAzXSBwY2lfYnVzIDAwMDA6MDM6IEFsbG9jYXRpbmcgcmVzb3Vy
Y2VzCg==
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8;
 name="iomem-6.16.0-061600-generic.txt"
Content-Disposition: attachment; filename="iomem-6.16.0-061600-generic.txt"
Content-Transfer-Encoding: base64

MDAwMDAwMDAtMDAwMDBmZmYgOiBSZXNlcnZlZAowMDAwMTAwMC0wMDA5Y2ZmZiA6IFN5c3Rl
bSBSQU0KMDAwOWQwMDAtMDAwOWZmZmYgOiBSZXNlcnZlZAowMDBhMDAwMC0wMDBiZmZmZiA6
IFBDSSBCdXMgMDAwMDowMAowMDBjMDAwMC0wMDBjZWRmZiA6IFZpZGVvIFJPTQowMDBlMDAw
MC0wMDBmZmZmZiA6IFJlc2VydmVkCiAgMDAwZjAwMDAtMDAwZmZmZmYgOiBTeXN0ZW0gUk9N
CjAwMTAwMDAwLWIzNjc0ZmZmIDogU3lzdGVtIFJBTQpiMzY3NTAwMC1iMzZiZWZmZiA6IFJl
c2VydmVkCmIzNmJmMDAwLWIzNzNhZmZmIDogU3lzdGVtIFJBTQpiMzczYjAwMC1iMzdiZWZm
ZiA6IEFDUEkgTm9uLXZvbGF0aWxlIFN0b3JhZ2UKYjM3YmYwMDAtYjM3ZTBmZmYgOiBTeXN0
ZW0gUkFNCmIzN2UxMDAwLWIzN2ZlZmZmIDogQUNQSSBUYWJsZXMKYjM3ZmYwMDAtYjM3ZmZm
ZmYgOiBTeXN0ZW0gUkFNCmIzODAwMDAwLWJmZmZmZmZmIDogUmVzZXJ2ZWQKICBiODAwMDAw
MC1iZmZmZmZmZiA6IEdyYXBoaWNzIFN0b2xlbiBNZW1vcnkKYzAwMDAwMDAtZmVhZmZmZmYg
OiBQQ0kgQnVzIDAwMDA6MDAKICBjMDAwMDAwMC1jZmZmZmZmZiA6IDAwMDA6MDA6MDIuMAog
IGQwMDAwMDAwLWQ3ZmZmZmZmIDogUENJIEJ1cyAwMDAwOjAxCiAgICBkMDAwMDAwMC1kN2Zm
ZmZmZiA6IDAwMDA6MDE6MDAuMAogIGQ4MDAwMDAwLWQ4M2ZmZmZmIDogMDAwMDowMDowMi4w
CiAgZDg0MDAwMDAtZDkzZmZmZmYgOiBQQ0kgQnVzIDAwMDA6MDIKICBkOTQwMDAwMC1kYTNm
ZmZmZiA6IFBDSSBCdXMgMDAwMDowMwogIGRhNDAwMDAwLWRiM2ZmZmZmIDogUENJIEJ1cyAw
MDAwOjAzCiAgICBkYTQwMDAwMC1kYTQwMWZmZiA6IDAwMDA6MDM6MDAuMAogICAgICBkYTQw
MDAwMC1kYTQwMWZmZiA6IGl3bHdpZmkKICBkYjQwMDAwMC1kYzNmZmZmZiA6IFBDSSBCdXMg
MDAwMDowMgogICAgZGI0MDAwMDAtZGI0M2ZmZmYgOiAwMDAwOjAyOjAwLjAKICAgICAgZGI0
MDAwMDAtZGI0M2ZmZmYgOiBhdGwxYwogIGRjNDAwMDAwLWRjNGZmZmZmIDogUENJIEJ1cyAw
MDAwOjAxCiAgICBkYzQwMDAwMC1kYzQxZmZmZiA6IDAwMDA6MDE6MDAuMAogICAgZGM0MjAw
MDAtZGM0MjNmZmYgOiAwMDAwOjAxOjAwLjEKICAgICAgZGM0MjAwMDAtZGM0MjNmZmYgOiBJ
Q0ggSEQgYXVkaW8KICAgIGRjNDQwMDAwLWRjNDVmZmZmIDogMDAwMDowMTowMC4wCiAgZGM1
MDAwMDAtZGM1MDNmZmYgOiAwMDAwOjAwOjFiLjAKICAgIGRjNTAwMDAwLWRjNTAzZmZmIDog
SUNIIEhEIGF1ZGlvCiAgZGM1MDQwMDAtZGM1MDRmZmYgOiAwMDAwOjAwOjFmLjYKICAgIGRj
NTA0MDAwLWRjNTA0ZmZmIDogMDAwMDowMDoxZi42CiAgZGM1MDUwMDAtZGM1MDU3ZmYgOiAw
MDAwOjAwOjFmLjIKICAgIGRjNTA1MDAwLWRjNTA1N2ZmIDogYWhjaQogIGRjNTA1ODAwLWRj
NTA1YmZmIDogMDAwMDowMDoxZC4wCiAgICBkYzUwNTgwMC1kYzUwNWJmZiA6IGVoY2lfaGNk
CiAgZGM1MDVjMDAtZGM1MDVmZmYgOiAwMDAwOjAwOjFhLjAKICAgIGRjNTA1YzAwLWRjNTA1
ZmZmIDogZWhjaV9oY2QKICBkYzUwNjAwMC1kYzUwNjBmZiA6IDAwMDA6MDA6MWYuMwogICAg
ZGM1MDYwMDAtZGM1MDYwZmYgOiBpODAxX3NtYnVzCiAgZGM1MDYxMDAtZGM1MDYxMGYgOiAw
MDAwOjAwOjE2LjAKICAgIGRjNTA2MTAwLWRjNTA2MTBmIDogbWVpX21lCiAgZGM1MDcwMDAt
ZGM1MDdmZmYgOiBJbnRlbCBGbHVzaCBQYWdlCiAgZGM2MDAwMDAtZGM2MDBmZmYgOiBwbnAg
MDA6MDQKICBkYzcwMDAwMC1kYzhmZmZmZiA6IFBDSSBCdXMgMDAwMDowNAogIGRjOTAwMDAw
LWRjYWZmZmZmIDogUENJIEJ1cyAwMDAwOjA0CiAgZjAwMDAwMDAtZjdmZmZmZmYgOiBQQ0kg
RUNBTSAwMDAwIFtidXMgMDAtN2ZdCiAgICBmMDAwMDAwMC1mN2ZmZmZmZiA6IFJlc2VydmVk
CiAgICAgIGYwMDAwMDAwLWYxZmZmZmZmIDogcG5wIDAwOjA0CmZlYjAwMDAwLWZlYjAzZmZm
IDogUmVzZXJ2ZWQKZmVjMDAwMDAtZmVjMDBmZmYgOiBSZXNlcnZlZAogIGZlYzAwMDAwLWZl
YzAwM2ZmIDogSU9BUElDIDAKZmVkMDAwMDAtZmVkMDAzZmYgOiBIUEVUIDAKICBmZWQwMDAw
MC1mZWQwMDNmZiA6IFBOUDAxMDM6MDAKZmVkMTAwMDAtZmVkMTNmZmYgOiBSZXNlcnZlZAog
IGZlZDEwMDAwLWZlZDEzZmZmIDogcG5wIDAwOjA0CmZlZDE4MDAwLWZlZDE5ZmZmIDogUmVz
ZXJ2ZWQKICBmZWQxODAwMC1mZWQxOGZmZiA6IHBucCAwMDowNAogIGZlZDE5MDAwLWZlZDE5
ZmZmIDogcG5wIDAwOjA0CmZlZDFiMDAwLWZlZDFmZmZmIDogUmVzZXJ2ZWQKICBmZWQxYzAw
MC1mZWQxZmZmZiA6IHBucCAwMDowNAogICAgZmVkMWY0MTAtZmVkMWY0MTQgOiBpVENPX3dk
dC4xLmF1dG8KZmVkMjAwMDAtZmVkM2ZmZmYgOiBwbnAgMDA6MDQKZmVkNDUwMDAtZmVkOGZm
ZmYgOiBwbnAgMDA6MDQKZmVlMDAwMDAtZmVlMDBmZmYgOiBSZXNlcnZlZApmZjAwMDAwMC1m
ZmZmZmZmZiA6IElOVDA4MDA6MDAKICBmZmUwMDAwMC1mZmZmZmZmZiA6IFJlc2VydmVkCjEw
MDAwMDAwMC0xZmJmZmZmZmYgOiBTeXN0ZW0gUkFNCiAgMTIyMjAwMDAwLTEyMzc5YTlhNSA6
IEtlcm5lbCBjb2RlCiAgMTIzODAwMDAwLTEyNDcwZmZmZiA6IEtlcm5lbCByb2RhdGEKICAx
MjQ4MDAwMDAtMTI0YzkyYjdmIDogS2VybmVsIGRhdGEKICAxMjUxYmQwMDAtMTI1NWZmZmZm
IDogS2VybmVsIGJzcwoxZmMwMDAwMDAtMWZmZmZmZmZmIDogUmVzZXJ2ZWQKMjAwMDAwMDAw
LTIzYmZmZmZmZiA6IFN5c3RlbSBSQU0K
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8;
 name="lspci-6.16.0-061600-generic.txt"
Content-Disposition: attachment; filename="lspci-6.16.0-061600-generic.txt"
Content-Transfer-Encoding: base64

MDA6MWIuMCBBdWRpbyBkZXZpY2UgWzA0MDNdOiBJbnRlbCBDb3Jwb3JhdGlvbiA1IFNlcmll
cy8zNDAwIFNlcmllcyBDaGlwc2V0IEhpZ2ggRGVmaW5pdGlvbiBBdWRpbyBbODA4NjozYjU2
XSAocmV2IDA1KSAocHJvZy1pZiAwMCBbSERBIGNvbXBhdGlibGVdKQoJU3Vic3lzdGVtOiBB
Y2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkv
Ty0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVy
ci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZN
SHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0
LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6
IHBpbiBBIHJvdXRlZCB0byBJUlEgMzAKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZGM1MDAwMDAg
KDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQoJQ2FwYWJpbGl0aWVzOiBb
NTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBE
MS0gRDItIEF1eEN1cnJlbnQ9NTVtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCsp
CgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQ
TUUtCglDYXBhYmlsaXRpZXM6IFs2MF0gTVNJOiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJs
ZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDAwMDAwMDAwMCAgRGF0YTogMDAwMAoJQ2Fw
YWJpbGl0aWVzOiBbNzBdIEV4cHJlc3MgKHYxKSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBF
bmRwb2ludCwgSW50TXNnTnVtIDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMTI4IGJ5dGVzLCBQ
aGFudEZ1bmMgMAoJCQlFeHRUYWctIFJCRS0gRkxSZXNldCsgVEVFLUlPLQoJCURldkN0bDoJ
Q29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZC0g
RXh0VGFnLSBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcC0gRkxSZXNldC0KCQkJTWF4UGF5
bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgMTI4IGJ5dGVzCgkJRGV2U3RhOglDb3JyRXJy
LSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3IrIFRyYW5zUGVuZC0K
CUNhcGFiaWxpdGllczogWzEwMCB2MV0gVmlydHVhbCBDaGFubmVsCgkJQ2FwczoJTFBFVkM9
MCBSZWZDbGs9MTAwbnMgUEFURW50cnlCaXRzPTEKCQlBcmI6CUZpeGVkLSBXUlIzMi0gV1JS
NjQtIFdSUjEyOC0KCQlDdHJsOglBcmJTZWxlY3Q9Rml4ZWQKCQlTdGF0dXM6CUluUHJvZ3Jl
c3MtCgkJVkMwOglDYXBzOglQQVRPZmZzZXQ9MDAgTWF4VGltZVNsb3RzPTEgUmVqU25vb3BU
cmFucy0KCQkJQXJiOglGaXhlZC0gV1JSMzItIFdSUjY0LSBXUlIxMjgtIFRXUlIxMjgtIFdS
UjI1Ni0KCQkJQ3RybDoJRW5hYmxlKyBJRD0wIEFyYlNlbGVjdD1GaXhlZCBUQy9WQz1mZgoJ
CQlTdGF0dXM6CU5lZ29QZW5kaW5nLSBJblByb2dyZXNzLQoJCVZDMToJQ2FwczoJUEFUT2Zm
c2V0PTAwIE1heFRpbWVTbG90cz0xIFJlalNub29wVHJhbnMtCgkJCUFyYjoJRml4ZWQtIFdS
UjMyLSBXUlI2NC0gV1JSMTI4LSBUV1JSMTI4LSBXUlIyNTYtCgkJCUN0cmw6CUVuYWJsZSsg
SUQ9MSBBcmJTZWxlY3Q9Rml4ZWQgVEMvVkM9MDAKCQkJU3RhdHVzOglOZWdvUGVuZGluZy0g
SW5Qcm9ncmVzcy0KCUNhcGFiaWxpdGllczogWzEzMCB2MV0gUm9vdCBDb21wbGV4IExpbmsK
CQlEZXNjOglQb3J0TnVtYmVyPTBmIENvbXBvbmVudElEPTAwIEVsdFR5cGU9Q29uZmlnCgkJ
TGluazA6CURlc2M6CVRhcmdldFBvcnQ9MDAgVGFyZ2V0Q29tcG9uZW50PTAwIEFzc29jUkNS
Qi0gTGlua1R5cGU9TWVtTWFwcGVkIExpbmtWYWxpZCsKCQkJQWRkcjoJMDAwMDAwMDBmZWQx
YzAwMAoJS2VybmVsIGRyaXZlciBpbiB1c2U6IHNuZF9oZGFfaW50ZWwKCUtlcm5lbCBtb2R1
bGVzOiBzbmRfaGRhX2ludGVsCgo=
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8;
 name="lspci-6.15.11-061511-generic.txt"
Content-Disposition: attachment; filename="lspci-6.15.11-061511-generic.txt"
Content-Transfer-Encoding: base64

MDA6MWIuMCBBdWRpbyBkZXZpY2UgWzA0MDNdOiBJbnRlbCBDb3Jwb3JhdGlvbiA1IFNlcmll
cy8zNDAwIFNlcmllcyBDaGlwc2V0IEhpZ2ggRGVmaW5pdGlvbiBBdWRpbyBbODA4NjozYjU2
XSAocmV2IDA1KSAocHJvZy1pZiAwMCBbSERBIGNvbXBhdGlibGVdKQoJU3Vic3lzdGVtOiBB
Y2VyIEluY29ycG9yYXRlZCBbQUxJXSBEZXZpY2UgWzEwMjU6MDM1OV0KCUNvbnRyb2w6IEkv
Ty0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVy
ci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZN
SHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0
LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6
IHBpbiBBIHJvdXRlZCB0byBJUlEgMjkKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgZGM1MDAwMDAg
KDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQoJQ2FwYWJpbGl0aWVzOiBb
NTBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBE
MS0gRDItIEF1eEN1cnJlbnQ9NTVtQSBQTUUoRDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCsp
CgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QtIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQ
TUUtCglDYXBhYmlsaXRpZXM6IFs2MF0gTVNJOiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJs
ZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwNDAwMCAgRGF0YTogMDAyMwoJQ2Fw
YWJpbGl0aWVzOiBbNzBdIEV4cHJlc3MgKHYxKSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBF
bmRwb2ludCwgSW50TXNnTnVtIDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMTI4IGJ5dGVzLCBQ
aGFudEZ1bmMgMAoJCQlFeHRUYWctIFJCRS0gRkxSZXNldCsgVEVFLUlPLQoJCURldkN0bDoJ
Q29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZC0g
RXh0VGFnLSBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcC0gRkxSZXNldC0KCQkJTWF4UGF5
bG9hZCAxMjggYnl0ZXMsIE1heFJlYWRSZXEgMTI4IGJ5dGVzCgkJRGV2U3RhOglDb3JyRXJy
LSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3IrIFRyYW5zUGVuZC0K
CUNhcGFiaWxpdGllczogWzEwMCB2MV0gVmlydHVhbCBDaGFubmVsCgkJQ2FwczoJTFBFVkM9
MCBSZWZDbGs9MTAwbnMgUEFURW50cnlCaXRzPTEKCQlBcmI6CUZpeGVkLSBXUlIzMi0gV1JS
NjQtIFdSUjEyOC0KCQlDdHJsOglBcmJTZWxlY3Q9Rml4ZWQKCQlTdGF0dXM6CUluUHJvZ3Jl
c3MtCgkJVkMwOglDYXBzOglQQVRPZmZzZXQ9MDAgTWF4VGltZVNsb3RzPTEgUmVqU25vb3BU
cmFucy0KCQkJQXJiOglGaXhlZC0gV1JSMzItIFdSUjY0LSBXUlIxMjgtIFRXUlIxMjgtIFdS
UjI1Ni0KCQkJQ3RybDoJRW5hYmxlKyBJRD0wIEFyYlNlbGVjdD1GaXhlZCBUQy9WQz1mZgoJ
CQlTdGF0dXM6CU5lZ29QZW5kaW5nLSBJblByb2dyZXNzLQoJCVZDMToJQ2FwczoJUEFUT2Zm
c2V0PTAwIE1heFRpbWVTbG90cz0xIFJlalNub29wVHJhbnMtCgkJCUFyYjoJRml4ZWQtIFdS
UjMyLSBXUlI2NC0gV1JSMTI4LSBUV1JSMTI4LSBXUlIyNTYtCgkJCUN0cmw6CUVuYWJsZSsg
SUQ9MSBBcmJTZWxlY3Q9Rml4ZWQgVEMvVkM9MDAKCQkJU3RhdHVzOglOZWdvUGVuZGluZy0g
SW5Qcm9ncmVzcy0KCUNhcGFiaWxpdGllczogWzEzMCB2MV0gUm9vdCBDb21wbGV4IExpbmsK
CQlEZXNjOglQb3J0TnVtYmVyPTBmIENvbXBvbmVudElEPTAwIEVsdFR5cGU9Q29uZmlnCgkJ
TGluazA6CURlc2M6CVRhcmdldFBvcnQ9MDAgVGFyZ2V0Q29tcG9uZW50PTAwIEFzc29jUkNS
Qi0gTGlua1R5cGU9TWVtTWFwcGVkIExpbmtWYWxpZCsKCQkJQWRkcjoJMDAwMDAwMDBmZWQx
YzAwMAoJS2VybmVsIGRyaXZlciBpbiB1c2U6IHNuZF9oZGFfaW50ZWwKCUtlcm5lbCBtb2R1
bGVzOiBzbmRfaGRhX2ludGVsCgo=
--------------ILk42eMcpKolmm5R0tbJzz9L
Content-Type: text/plain; charset=UTF-8;
 name="iomem-6.15.11-061511-generic.txt"
Content-Disposition: attachment; filename="iomem-6.15.11-061511-generic.txt"
Content-Transfer-Encoding: base64

MDAwMDAwMDAtMDAwMDBmZmYgOiBSZXNlcnZlZAowMDAwMTAwMC0wMDA5Y2ZmZiA6IFN5c3Rl
bSBSQU0KMDAwOWQwMDAtMDAwOWZmZmYgOiBSZXNlcnZlZAowMDBhMDAwMC0wMDBiZmZmZiA6
IFBDSSBCdXMgMDAwMDowMAowMDBjMDAwMC0wMDBjZWRmZiA6IFZpZGVvIFJPTQowMDBlMDAw
MC0wMDBmZmZmZiA6IFJlc2VydmVkCiAgMDAwZjAwMDAtMDAwZmZmZmYgOiBTeXN0ZW0gUk9N
CjAwMTAwMDAwLWIzNjc0ZmZmIDogU3lzdGVtIFJBTQpiMzY3NTAwMC1iMzZiZWZmZiA6IFJl
c2VydmVkCmIzNmJmMDAwLWIzNzNhZmZmIDogU3lzdGVtIFJBTQpiMzczYjAwMC1iMzdiZWZm
ZiA6IEFDUEkgTm9uLXZvbGF0aWxlIFN0b3JhZ2UKYjM3YmYwMDAtYjM3ZTBmZmYgOiBTeXN0
ZW0gUkFNCmIzN2UxMDAwLWIzN2ZlZmZmIDogQUNQSSBUYWJsZXMKYjM3ZmYwMDAtYjM3ZmZm
ZmYgOiBTeXN0ZW0gUkFNCmIzODAwMDAwLWJmZmZmZmZmIDogUmVzZXJ2ZWQKICBiODAwMDAw
MC1iZmZmZmZmZiA6IEdyYXBoaWNzIFN0b2xlbiBNZW1vcnkKYzAwMDAwMDAtZmVhZmZmZmYg
OiBQQ0kgQnVzIDAwMDA6MDAKICBjMDAwMDAwMC1jZmZmZmZmZiA6IDAwMDA6MDA6MDIuMAog
IGQwMDAwMDAwLWQ3ZmZmZmZmIDogUENJIEJ1cyAwMDAwOjAxCiAgICBkMDAwMDAwMC1kN2Zm
ZmZmZiA6IDAwMDA6MDE6MDAuMAogIGQ4MDAwMDAwLWQ4M2ZmZmZmIDogMDAwMDowMDowMi4w
CiAgZDg0MDAwMDAtZDkzZmZmZmYgOiBQQ0kgQnVzIDAwMDA6MDIKICBkOTQwMDAwMC1kYTNm
ZmZmZiA6IFBDSSBCdXMgMDAwMDowMwogIGRhNDAwMDAwLWRiM2ZmZmZmIDogUENJIEJ1cyAw
MDAwOjAzCiAgICBkYTQwMDAwMC1kYTQwMWZmZiA6IDAwMDA6MDM6MDAuMAogICAgICBkYTQw
MDAwMC1kYTQwMWZmZiA6IGl3bHdpZmkKICBkYjQwMDAwMC1kYzNmZmZmZiA6IFBDSSBCdXMg
MDAwMDowMgogICAgZGI0MDAwMDAtZGI0M2ZmZmYgOiAwMDAwOjAyOjAwLjAKICAgICAgZGI0
MDAwMDAtZGI0M2ZmZmYgOiBhdGwxYwogIGRjNDAwMDAwLWRjNGZmZmZmIDogUENJIEJ1cyAw
MDAwOjAxCiAgICBkYzQwMDAwMC1kYzQxZmZmZiA6IDAwMDA6MDE6MDAuMAogICAgZGM0MjAw
MDAtZGM0MjNmZmYgOiAwMDAwOjAxOjAwLjEKICAgICAgZGM0MjAwMDAtZGM0MjNmZmYgOiBJ
Q0ggSEQgYXVkaW8KICAgIGRjNDQwMDAwLWRjNDVmZmZmIDogMDAwMDowMTowMC4wCiAgZGM1
MDAwMDAtZGM1MDNmZmYgOiAwMDAwOjAwOjFiLjAKICAgIGRjNTAwMDAwLWRjNTAzZmZmIDog
SUNIIEhEIGF1ZGlvCiAgZGM1MDQwMDAtZGM1MDRmZmYgOiAwMDAwOjAwOjFmLjYKICAgIGRj
NTA0MDAwLWRjNTA0ZmZmIDogMDAwMDowMDoxZi42CiAgZGM1MDUwMDAtZGM1MDU3ZmYgOiAw
MDAwOjAwOjFmLjIKICAgIGRjNTA1MDAwLWRjNTA1N2ZmIDogYWhjaQogIGRjNTA1ODAwLWRj
NTA1YmZmIDogMDAwMDowMDoxZC4wCiAgICBkYzUwNTgwMC1kYzUwNWJmZiA6IGVoY2lfaGNk
CiAgZGM1MDVjMDAtZGM1MDVmZmYgOiAwMDAwOjAwOjFhLjAKICAgIGRjNTA1YzAwLWRjNTA1
ZmZmIDogZWhjaV9oY2QKICBkYzUwNjAwMC1kYzUwNjBmZiA6IDAwMDA6MDA6MWYuMwogICAg
ZGM1MDYwMDAtZGM1MDYwZmYgOiBpODAxX3NtYnVzCiAgZGM1MDYxMDAtZGM1MDYxMGYgOiAw
MDAwOjAwOjE2LjAKICAgIGRjNTA2MTAwLWRjNTA2MTBmIDogbWVpX21lCiAgZGM1MDcwMDAt
ZGM1MDdmZmYgOiBJbnRlbCBGbHVzaCBQYWdlCiAgZGM2MDAwMDAtZGM2MDBmZmYgOiBwbnAg
MDA6MDQKICBkYzcwMDAwMC1kYzhmZmZmZiA6IFBDSSBCdXMgMDAwMDowNAogIGRjOTAwMDAw
LWRjYWZmZmZmIDogUENJIEJ1cyAwMDAwOjA0CiAgZjAwMDAwMDAtZjdmZmZmZmYgOiBQQ0kg
RUNBTSAwMDAwIFtidXMgMDAtN2ZdCiAgICBmMDAwMDAwMC1mN2ZmZmZmZiA6IFJlc2VydmVk
CiAgICAgIGYwMDAwMDAwLWYxZmZmZmZmIDogcG5wIDAwOjA0CmZlYjAwMDAwLWZlYjAzZmZm
IDogUmVzZXJ2ZWQKZmVjMDAwMDAtZmVjMDBmZmYgOiBSZXNlcnZlZAogIGZlYzAwMDAwLWZl
YzAwM2ZmIDogSU9BUElDIDAKZmVkMDAwMDAtZmVkMDAzZmYgOiBIUEVUIDAKICBmZWQwMDAw
MC1mZWQwMDNmZiA6IFBOUDAxMDM6MDAKZmVkMTAwMDAtZmVkMTNmZmYgOiBSZXNlcnZlZAog
IGZlZDEwMDAwLWZlZDEzZmZmIDogcG5wIDAwOjA0CmZlZDE4MDAwLWZlZDE5ZmZmIDogUmVz
ZXJ2ZWQKICBmZWQxODAwMC1mZWQxOGZmZiA6IHBucCAwMDowNAogIGZlZDE5MDAwLWZlZDE5
ZmZmIDogcG5wIDAwOjA0CmZlZDFiMDAwLWZlZDFmZmZmIDogUmVzZXJ2ZWQKICBmZWQxYzAw
MC1mZWQxZmZmZiA6IHBucCAwMDowNAogICAgZmVkMWY0MTAtZmVkMWY0MTQgOiBpVENPX3dk
dC4xLmF1dG8KZmVkMjAwMDAtZmVkM2ZmZmYgOiBwbnAgMDA6MDQKZmVkNDUwMDAtZmVkOGZm
ZmYgOiBwbnAgMDA6MDQKZmVlMDAwMDAtZmVlMDBmZmYgOiBSZXNlcnZlZApmZjAwMDAwMC1m
ZmZmZmZmZiA6IElOVDA4MDA6MDAKICBmZmUwMDAwMC1mZmZmZmZmZiA6IFJlc2VydmVkCjEw
MDAwMDAwMC0xZmJmZmZmZmYgOiBTeXN0ZW0gUkFNCjFmYzAwMDAwMC0xZmZmZmZmZmYgOiBS
ZXNlcnZlZAoyMDAwMDAwMDAtMjNiZmZmZmZmIDogU3lzdGVtIFJBTQogIDIwMmUwMDAwMC0y
MDQzNzVkYmEgOiBLZXJuZWwgY29kZQogIDIwNDQwMDAwMC0yMDUyZjNmZmYgOiBLZXJuZWwg
cm9kYXRhCiAgMjA1NDAwMDAwLTIwNTg4Y2YzZiA6IEtlcm5lbCBkYXRhCiAgMjA1ZGFhMDAw
LTIwNjFmZmZmZiA6IEtlcm5lbCBic3MK

--------------ILk42eMcpKolmm5R0tbJzz9L--

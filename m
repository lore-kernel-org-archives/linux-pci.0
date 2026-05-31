Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB054763;
	Sun, 31 May 2026 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780233678; cv=none; b=ccY+B7BLQTAwxSCZ8vpy8uqemk+Iskg/nKH3fdNGK7PKYG/gHDM6gGxdzTAe2xjrZ2fqE1ZWAvCleY03xpms/p5eBdrXNgRZCINrsBiitTH6ms6+xkR/NOQb3QZwj7XIezfPJcLAruhWIZRQrKFiQqy8SN3gFneqFvArj+JzLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780233678; c=relaxed/simple;
	bh=D2b96bpT//bRq15xL4d2iEh1wwnmcO9QOqblE0YyH98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NERFRGBfIkwAntonRko3bKrEu78IoE7OXxuw+W8eQmiZyqzF70PN5GwnN4eeA2jx7uX7pvP62LJGlNeAaCp/PEzdx0vEvBDdiYmeygwcoGH3iXwnc/fCenAAJ9eUJzP7z/BdhV2SOAD+o4SmjNxOYsuds9A5ErRNSfyoi4FDqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2Ghbqlb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2Ghbqlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5CC1F00893;
	Sun, 31 May 2026 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780233676;
	bh=ucei/Km5pTxeBW0GqGAGxBN/tmGyfgYst8kZ8KmZjaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H2GhbqlbA4jVp+/XBpaAJWcxUhFfRoJi9+gKEit8tscC/y1lF2Vt1DVIa8avsg9yi
	 ZV3i3WfprvWXekEeWWWvofPCJngCFGRHbNTrZKmvsQYNVG6trArcYERMREnzK+IOWg
	 KsJNJfLeMfjap/QwcEcBtFbEPrV4ltGGP+RGV3b89QkqqQ5lILu6Wh/j0EO24q3x1t
	 RrQBzDMXPHee5/A9BXxOgIwiqZv+OdHF9SoHgl5bvcL7sm/iF6qeJN3cajL5rxkI2U
	 CRuVqXQMLjKeAsV7fjLCP2G5Fyaen336T4FmjVjJCGVEfEasGxfhPeHSBgvpFNkodf
	 UxfQ9w5u3JzZw==
Message-ID: <cf379972-6b2d-42e5-9660-32d031516862@kernel.org>
Date: Sun, 31 May 2026 15:21:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] HDA controller MMIO unreadable on Intel
 5-series PCH (Ibex Peak) since v6.16
Content-Language: en-US
To: Filippe Duke <fduke@greennet.ua>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.com" <tiwai@suse.com>
References: <5e54aea4a97f1cbbe866d9d8f3f25f9f2958e1c9.camel@greennet.ua>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5e54aea4a97f1cbbe866d9d8f3f25f9f2958e1c9.camel@greennet.ua>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/29/26 20:26, Filippe Duke wrote:
> #regzbot introduced: 4d4c10f763d7
> 
> Hi,
> 
> The HDA controller on old Intel 5-series PCH (Ibex  Peak) becomes non- 
> functional since 6.16.
> PCI configuration space is ok;
> PCI function power state appears to be D0;
> However MMIO always reads 0xFFFF, causing CORB timeouts;
> ALC269VB codec enumeration fails (no AFG/MFG node found).
> HW works on v6.15.x and earlier and works under WinPE on the same machine.
> 
> Bisected to first bad commit:
> 4d4c10f763d7 PCI: Explicitly put devices into D0 when initializing
> 
> On top of v6.16, commenting out the single call to
> |pci_pm_power_up_and_verify_state(dev)| in |pci_pm_init()| (drivers/pci/ 
> pci.c:3273)
> is sufficient to restore working audio. The one-line diff is attached.
> 
> HW:
> ---
> DMI:  Acer Aspire 4745G / JV41_CP, BIOS V1.25 03/16/2011 (Insyde)
> CPU: Intel Core i7 M 640
> PCH: Intel 5-series (Ibex Peak)
> HDA: 0000:00:1b.0 [8086:3b56] rev 05, SSID [1025:0357]
> Codec: Realtek ALC269VB
> GPU: Switchable:  Intel HD (Ironlake, 8086:0046) +
> AMD Radeon HD Cedar (1002:68e0, 01:00.0)
> 
> Symptom (dmesg):
> ---
> snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
> snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops 
> intel_audio_component_bind_ops [i915])
> snd_hda_intel 0000:00:1b.0: number of I/O streams is 30, forcing 
> separate stream tags
> snd_hda_intel 0000:00:1b.0: CORB reset timeout#2, CORBRP = 65535
> hdaudio hdaudioC0D0: no AFG or MFG node found
> hdaudio hdaudioC0D1: no AFG or MFG node found
> hdaudio hdaudioC0D2: no AFG or MFG node found
> hdaudio hdaudioC0D3: no AFG or MFG node found
> snd_hda_intel 0000:00:1b.0: no codecs initialized
> 
> Hence the sound device is missing from ALSA.
> HDMI audio on AMD (01:00.1) is not affected by the issue.
> Attaching you lshw, lspci, DSDT, dmesg and diff.
> 
> Best regards
> 
> -- 
> 
> Filippe Duke
> System Engineer
> 
> GREENNET
> Kyiv, 7B Lesi Ukrainky St.,
> Cell.: +380672772879
> Email: fduke@greennet.ua
> Web: https://greennet.ua
> 

There have been a few commits that have adjusted the behavior due to the 
commit you identified.  So I believe it's potentially the tip of the 
iceberg.

Can you please see if this issue still exists on 7.1-rc5?

This is the most recent commit (from 7.1-rc3) that I know of changing it.

https://git.kernel.org/torvalds/c/909f7bf9b080c

Thanks!

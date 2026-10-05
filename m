Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C2481FCF;
	Mon,  5 Oct 2026 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207056; cv=none; b=VdNlSadnqGTb61zbp3zuyLLx2qekS+7Q7H7lujhrDN5a9HFq3Oivul8lThtZ3WcxlsG3KmGbP0HkKOYmThrshKJ5rGtIYHt8e3msdoSEcQ+9YR9IWPPPPgwGF+bBxZldtCzqNarhq+MxDKZSxPEbQJYkN+UNCQg6ePeH0L61u6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207056; c=relaxed/simple;
	bh=xdk3IJP0B2Z1cq9xFbg30OL4Ry1PTEv/f+Dvk1r8uck=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W10W1vAflOnLOT5mxcn0Huorydu2zHI7mOMHK0dHRWR2eBJgCg/ib7tLLjX44l70fSfG08qhEFpSnm5eLWk3wGf07ZAXKPfjWw+D1UV6vg+uQYMTwiUYJQBOpPwIqsMvwOXVGmtpfd048C+vO6r3aUI/GGnFSUJKOL/kYqcmPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ttOpbLGU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RuL07ps1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LZaiahBW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fM3uheps; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ttOpbLGU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RuL07ps1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LZaiahBW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fM3uheps"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A6731F79B;
	Mon,  5 Oct 2026 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6ZpEWw0gF54VUQwnNcqXYOamKTPfoqBKXHD2NOup/0=;
	b=ttOpbLGU1ZvsoFN1TiqUCJbSrkbjo9QI82VcK0YJvgTiU+tx2K+9wTYS6a1mim3PzvzGy0
	e7ZeMzpR1iIyBW5p4OPmLN07mXQeiwYScAeihs9Dujuzg0LSj6uPOj5/egEcVvl//6JU8O
	BVXnEeOCKfGlsO5rSpEbkevtIoSB+Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6ZpEWw0gF54VUQwnNcqXYOamKTPfoqBKXHD2NOup/0=;
	b=RuL07ps1oY3avvMauHAd0+3enFZ5trlmC6e+H4M+LZWhsX/DOxOaiAmcI3GvfytrgxJrso
	3IuaQiucyNu3PvDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LZaiahBW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fM3uheps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6ZpEWw0gF54VUQwnNcqXYOamKTPfoqBKXHD2NOup/0=;
	b=LZaiahBWM6nvO7EqHhW/rZxxY27ZIhd/WNDXiv29LR14Otdl8VLoVIca4i1mvIJ1OPXAOO
	9P+R3FlQriYXQBRqQClnTgAI6FAPPGn1mIi9oY3Sgx4KL8A6QQhTNPXiJXqMH28zFu2rR7
	E9DpQ4fVlY1HjNLo9/0QPIc6t5bxO4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6ZpEWw0gF54VUQwnNcqXYOamKTPfoqBKXHD2NOup/0=;
	b=fM3uhepsdLZtpp7G+L/RjyW9+5jK6yOuhM8hbwpOZ1WrOsuGgEuh9BldRrt5z38OX4CLTZ
	HuZAEM8dGNpkwrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32F0F132D3;
	Mon,  5 Oct 2026 13:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EMpsAoSmw2r9cgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 05 Oct 2026 13:30:44 +0000
Date: Mon, 05 Oct 2026 15:30:35 +0200
Message-ID: <878q4cs29w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Munteanu Vlad <m.vlad.stefan@gmail.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	conmanx360@gmail.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [BUG] ALSA: hda: AE-7 behind ASM1083 rev 03 bridge: fatal MCE at probe
In-Reply-To: <CAMx+sF_kr_WW4LENM2K-7XxDHN4vER+5qz07NAOhKC3A07Gvaw@mail.gmail.com>
References: <CAMx+sF_kr_WW4LENM2K-7XxDHN4vER+5qz07NAOhKC3A07Gvaw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6A6731F79B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,perex.cz,gmail.com,google.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,osmocom.org:url,suse.de:mid,suse.de:dkim,endeavouros.com:url]
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 

On Mon, 05 Oct 2026 14:47:15 +0200,
Munteanu Vlad wrote:
> 
> Hi,
> 
> Newer Sound Blaster AE-7 cards (CA0132, PCI 1102:0010, SSID 1102:0081)
> put the CA0132 behind an ASMedia ASM1083/1085 rev 03 PCIe-to-PCI bridge.
> On my machine, binding snd_hda_intel to the card takes the whole system
> down every time: a fatal machine check (or a silent hard hang) within
> about a second of probe. This looks like the problem other AE-7 owners
> report, where the card "never worked" on Linux [1].
> 
> I tracked it down to MMIO reads to the CA0132 that never complete. I
> have a workaround (attached, not meant for merging as-is) with which the
> card now works fully: probe, DSP firmware download, playback. I'd like
> your advice on the proper fix, and I'm happy to test patches.
> 
> 
> Hardware / software
> -------------------
> 
> - Dell Precision 7920 Tower, 2x Xeon Gold 6152 (Skylake-SP),
> BIOS 2.53.1, APEI firmware-first error handling.
> - 44:00.0 Intel Sky Lake-E PCIe Root Port A [8086:2030]
> -> 45:00.0 ASMedia ASM1083/1085 PCIe-to-PCI bridge [1b21:1080] rev 03
> -> 46:00.0 Creative CA0132 [1102:0010] rev 01, subsystem [1102:0081]
> - Ubuntu kernel 7.0.0-38-generic (based on 7.0.14). The code paths
> involved (sound/hda/core/controller.c, core/stream.c,
> codecs/ca0132.c) are the same in current mainline as far as I can
> see. I haven't built mainline yet, but can if that helps. The same
> hang happened with Ubuntu's 6.17 kernel at install time.
> 
> 
> 1. The failure
> --------------
> 
> Identical in every run (CPU PPIN removed):
> 
> mce: [Hardware Error]: CPU 0: Machine Check Exception: 5 Bank 6:
> bb80000000000e0b
> mce: [Hardware Error]: RIP !INEXACT! 10:<ffffffffc1fdbf1b>
> {snd_hdac_bus_init_cmd_io+0x1db/0x260 [snd_hda_core]}
> mce: [Hardware Error]: TSC 2e59a247c66 MISC 44000000
> mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1791056639 SOCKET 0 APIC
> 0 microcode 2007006
> mce: [Hardware Error]: Machine check: Processor context corrupt
> Kernel panic - not syncing: Fatal machine check
> 
> Bank 6 is the IIO, and MCACOD 0x0e0b is a generic I/O bus error. The MCE
> comes about 1.18 s after the last driver message ("codec_mask = 0x2"),
> which matches the root port's completion timeout (260-900 ms). So a CPU
> read to the CA0132 never got a completion.
> 
> In this build, +0x1db is the instruction right after
> "mov 0x4a(%rax),%ax", i.e. the readw(CORBRP) in the first poll loop of
> azx_clear_corbrp(), immediately after writew(CORBRP, AZX_CORBRP_RST).
> CORB DMA isn't running yet at that point.
> 
> 
> 2. What the experiments showed
> ------------------------------
> 
> - Done from userspace with the card unbound (setpci / devmem), each
> register access is fine on its own. That includes the controller reset
> at driver timing, and the whole CORB/RIRB setup sequence done slowly
> with a read after each step. Note that the CORB/RIRB base addresses
> were 0 in that test, so no real DMA happened, and the IOMMU logged no
> faults.
> 
> - In the driver, with the CORBRP readback avoided (write RST, wait
> 10 ms, write 0, wait 10 ms, no reads in between), the MCE moved to
> snd_hdac_bus_init_cmd_io+0x186. That's readl(GCTL) in the final
> updatel(GCTL, UNSOL): the first read after CORBCTL=RUN, the RIRB
> base/size writes, RIRBWP=RST, RINTCNT and RIRBCTL. Adding 10 ms delays
> between those writes did NOT help. Adding a GCTL read after each
> group of writes did.
> 
> - With that in place, the probe got through codec enumeration and then
> hung (no MCE record that time). The last trace point was
> ca0132_mmio_init() returning. The next code is ae5_register_set() (the
> AE-7 path): 19 BAR2 writes, then the first BAR2 read, in
> ca0113_mmio_command_set_type2(). So presumably it was that read.
> 
> - Turning off AER/SERR/parity reporting on the card, the bridge and the
> root port did not help either. The machine hung at the same point, but
> left no MCE record and had to be power-cycled.
> 
> So the pattern seems to be: on this bridge, a read that follows a run
> of posted writes to the CA0132 never completes. One data point doesn't
> fit a simple count, though. azx_int_clear() does 13 writes to
> registers 32 bytes apart, and the read after it was fine. So it may be
> about writes to neighbouring registers being merged by the bridge. I
> couldn't pin that down. ASM1083 rev 03 is reported as broken with other
> PCI cards as well [2].
> 
> 
> 3. Workaround that works (attached, against the Ubuntu 7.0.0-38 tree)
> --------------------------------------------------------------------
> 
> All of it applies only to Creative HDA controllers (PCI vendor check):
> 
> a) snd_hdac_reg_write{b,w,l}(): read GCTL after every register write.
> b) snd_hdac_bus_init_cmd_io(): do the CORB read pointer reset without
> polling CORBRP while RST is set (set, 10 ms, clear, 10 ms), and
> settle + read GCTL after each group of CORB/RIRB writes.
> c) snd_hdac_stream_reset(): keep the SRST handshake, but wait 5 ms
> before each read-back.
> d) ca0132.c: follow every write to spec->mem_base (45 sites) with the
> same flush read.
> 
> With this everything works over several boots and hours of playback:
> controller and codec probe, "ca0132 DSP downloaded and running", the
> AE-7 post-DSP setup, and playback in 2.0 and 2.1 (6 channels). There
> have been no MCEs since. NVIDIA HDMI audio, driven by the same
> snd_hda_intel, is unaffected (the flushes are gated on the vendor).
> 
> (c) may not be needed. My first version did the stream reset blind (no
> SRST read-back) because I suspected reads during reset. The DMAR faults
> I then saw turned out to be the separate issue in section 4.
> 
> 
> 4. Second issue: the CA0132 reads past the end of the cyclic buffer
> -------------------------------------------------------------------
> 
> With IOMMU translation (default DMA-FQ domain), every buffer wrap during
> playback produces:
> 
> DMAR: [DMA Read NO_PASID] Request device [46:00.0] fault addr
> 0xffec0000 [fault reason 0x06] PTE Read access is not set
> 
> The fault repeats at the buffer-wrap period (0.683 s for 32768 frames
> at 48 kHz). The address changes with the buffer, and it's consistent
> with the address just past the end of a size-aligned IOVA allocation of
> the current PCM buffer: 0xffec0000 for a 768 KiB buffer (6 ch, which
> would sit at 0xffe00000), and 0xfff40000 / 0xfff80000 for 256 KiB
> buffers. I haven't read the buffer's IOVA directly. If that's right,
> the controller prefetches past the last BDL entry before wrapping. The
> audio itself is fine. As a workaround I switch the card's IOMMU group
> to identity before binding it.
> 
> 
> 5. Minor
> --------
> 
> PipeWire first asks for buffer=1572864, period=49152, which gives
> "Too many BDL entries" (because of AZX_DCAPS_4K_BDLE_BOUNDARY). It then
> falls back to a smaller buffer and works.
> 
> 
> Questions
> ---------
> 
> - Would a quirk keyed on an ASMedia 1b21:1080 (rev 03) bridge directly
> upstream of the controller be acceptable? It would set something like
> bus->flush_writes (read back after every write), plus a CORB reset
> that doesn't poll while RST is set. Or would you rather this live in
> the PCI layer?
> - Are there any known ASM1083/1085 errata about posted writes or write
> merging?
> - For the buffer overread, what's the preferred fix: padding the
> allocation, an extra BDL entry, or something else?
> 
> I can test patches on this machine. Failures leave crash dumps in
> pstore/ERST, so each failed test is quick to diagnose.
> 
> [1] https://forum.endeavouros.com/t/unable-to-boot-after-installing-new-sound-card-ae-7/40457
> [2] https://projects.osmocom.org/projects/retronetworking/wiki/PCIe-%3EPCI_bridges
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=208667 (ASM1083/1085 ASPM quirk)
> [4] https://bugzilla.kernel.org/show_bug.cgi?id=217510 (AE-7, possibly related)
> 
> Regards,
> gigiou_88

Thanks for the report and the fix attempt.

My gut feeling is, though, it should be rather addressed in the PCI
core side or similar lower layer than tweaking too much on the
HD-audio driver side.


Takashi

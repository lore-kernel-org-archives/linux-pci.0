Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF63374E55
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204453; cv=pass; b=AheJizNjWqYpLO4l+aPZsIDdfSkLkr9t4ZZyhoij6TMdGMgzSdJuF5iE3PyyDwIPOhRubdh9YwOU7FDOpIIfu58MD4IlEGkl5BnbIi1xiCsm3UEOtcj7J5nlRCDWzJawSZtvcsofTTvGVkan+jBGvdfaXzGiT3/tqM0T0ztiX8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204453; c=relaxed/simple;
	bh=5KFe4kBoaL5GWabpuC2SBfUpKBdLrth+DhJmOphNURo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k7BmaJ/V4wHQJ7W004J4MSSbg0fpV5rSya4fYKTmeKr0UkLveL2sOGXCpA4kJKYb5GEAmEDRHurzPO2/5FH2a2g/RSd1W4LqusJWkQv9FS+dsIw7NMw2xo0y/L1Etkejckw5a2VNRxgRYQKElFEdy6yk9ebEvN0Qu2LuJ7lATDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz9mYFkx; arc=pass smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz9mYFkx"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-883a16b758dso273020b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 05:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791204449; cv=none;
        d=google.com; s=arc-20260327;
        b=OfYKQ6gJPhUxwiFLbguysQvbShfKIEW8a5Yd7VKgnjIlw4F52PlFXdrwCJ/imupE8u
         ViVuCdINOOgd/Al9NPESzwFg/SSE/ui1UUf/VQ+N9YYRZiFg7yUSw5hT9taz9/Uy2fEM
         Y0kq8VdMtV3pcI+LscFH9mWzjDY3ewNcoe+p0PDErwByqg9cWu+5ZMa2PRgRmGeyLbXs
         gcxgLj1gYBvHVBsKnrJ0Xe6zJhk6/qq64YGRrupFfWlVV8/oENmPnXB5pMalGTiw+EWe
         aoCfEhuJ7RhXSZXO5Rz3VgDT7q2Xo9qHumdHZV+6xktZIyGihXx940Qs2CZq4EwixUs+
         Sr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=T5vnsPZCS1zRPYLf/2AM5tG4fyXhDrsj8GWi1pO4DHU=;
        fh=NlSBOG7jHmtWyBXGCnKgNtkKqObZ5XPXSPR0s8z0+DI=;
        b=HViXv96bJGNsNz63hXaXgCCi8scYrd1flL2z4TkOH5ZzvGr13QcLNhA5wm5WuNrtg1
         Ggjntlx/gavFLBPQLVy2os8rb7Reaw2GSpRanMfWs8QrqWYVFk8Cr7IN0Lt2KAsgmP0b
         nCdIWuS5Ptb08xIFBiolesF4wkKszFvNWb/n6cwpKRiW6tvF4Gv7I1r3KkKPt9Z7yacT
         O4cMlH5p/rQhtNheobmND17eR2EfBHLWkggUXg5pYcpvCpohEB5ZHlxzqc3ygOi0SSWC
         v5cjZC+FmPNEfev3Smq8g6+zZ1bMZKGbOzMmaMvt+O6JBU5eBktQJH2vn8J1QsZegEVk
         MJdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791204449; x=1791809249; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5vnsPZCS1zRPYLf/2AM5tG4fyXhDrsj8GWi1pO4DHU=;
        b=Yz9mYFkxnb72AjG8mX60RFLUOb8Gzj/4MfAFzPet3kmBJY4h9IGVkAjsoedlkkrT/J
         V5ghY/XfVTHnm7ABDw/KtI6pEjFpiVqDhmpXud7NY1M8BQiY4WH3LS7Fjthxm+AWkdEg
         pgnZ4xVgsnPHTvUqpT+7uQY1+loORWljqyeoQgKNuFr6WX2bCtWjPsndSGzDi/9NCRf6
         pcTvsIGm5ppez+YOt97r0yQhO61r7XMNKgFSecg8ci+rAdOCmxfGon+TB9OYQiTY+V4k
         egCA9sjRLRKkCScasgC2t1aHtMoft5vks54GKhQ3iDXEuqs7nrj84w5R3UOEXguBJcHs
         ZxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791204449; x=1791809249;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T5vnsPZCS1zRPYLf/2AM5tG4fyXhDrsj8GWi1pO4DHU=;
        b=Qg5h3J4lnSEefBWAmVRkb5v8VIwQe4tVvLAOqchGcCWIl0fXRzMMjO7UTwc5JI3SO9
         NNaAo3F5FBjAYH6ATSdtpvIbKw3zZKvsHhm07qfaM4n5pH9qLgN5ME3nz1Gw7XxLg0jX
         2TLrCW0OTlTTRZM0REZXK5XshXdVUrZkjlpFnPfApz1nrAdIBfIrf0SgpieDi8rHp5Iy
         MITn4lZa3xHOU9kPDsBs92KzGO0PyCESiwX7z6+3BrKjlAGGFkZnPQ3yDK9yhbCeja1M
         3mXKKyci+UBR4bNIhZUZmbzITVIMZ9vBqepwuENYZnqcrVispJyZFmuge0IVeBKw3oIz
         z41A==
X-Forwarded-Encrypted: i=1; AKwUvBzdEnulRDyjvnAVNDNMUnCgGjk0xS6pvhlqCSj1cNWJquBNK5+HxfYVFD+275zfKPBzKrPz0yHaMAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYcuEgQB1LRAzQasfaKkKPEC5EUya72CBgK+2CirDIMLoYNOTK
	Sclx4W/vZKGpEQZJFSnupX2DmQ7XWPKn8U7gkLvK5wr7qlVD/opqyr3nbG/1/lzu+Pj1oDozs4p
	gc8OZQUDTmu399EEDW9TF739oHNqTNwA=
X-Gm-Gg: AYBFou1wmGdTwi3Wx5nktnqfqWplKjngdsaBm3KZ3Kd6YdkOcN84iJP9oGze4myKgIi
	Xlqcla0T2oGSsaLsaF5Bz2rTSHOHDkqPoryocGIQyjKllIJMrBM1DMsEOBE6rehlLQd3X9W7E8a
	YtMPXxVRCgFKqzr0KComVi7p3zckAIPwu2OWdbyFimqBtFfO7SOfD2ahQ+4Mb5A5oPIwmznmt0K
	Sd2YOeUXZO/v+zV8n8R9s2xi1pK+HaM337NQTvwaGhKkPlnrtb6IgB6KQ6HI2BEbBye3KSXTAzH
	CqdGyay2gDGMdp4EqCFVFgBr8sxo6H2fFJS7sZVmnywqJ73TEJ1fhgs=
X-Received: by 2002:a05:6a00:2d1a:b0:886:4ca4:a3e8 with SMTP id
 d2e1a72fcca58-88af476b06fmr7575782b3a.5.1791204448792; Mon, 05 Oct 2026
 05:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Munteanu Vlad <m.vlad.stefan@gmail.com>
Date: Mon, 5 Oct 2026 15:47:15 +0300
X-Gm-Features: AclHuK8SCLGkSNj0w-cI65UxPBSs3UtRNvufkPzXZSYyjuQgSEtHUZyBsdMNO9k
Message-ID: <CAMx+sF_kr_WW4LENM2K-7XxDHN4vER+5qz07NAOhKC3A07Gvaw@mail.gmail.com>
Subject: [BUG] ALSA: hda: AE-7 behind ASM1083 rev 03 bridge: fatal MCE at probe
To: tiwai@suse.com, linux-sound@vger.kernel.org
Cc: perex@perex.cz, conmanx360@gmail.com, bhelgaas@google.com, 
	linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e40bf6065d17487a"

--000000000000e40bf6065d17487a
Content-Type: text/plain; charset="UTF-8"

Hi,

Newer Sound Blaster AE-7 cards (CA0132, PCI 1102:0010, SSID 1102:0081)
put the CA0132 behind an ASMedia ASM1083/1085 rev 03 PCIe-to-PCI bridge.
On my machine, binding snd_hda_intel to the card takes the whole system
down every time: a fatal machine check (or a silent hard hang) within
about a second of probe. This looks like the problem other AE-7 owners
report, where the card "never worked" on Linux [1].

I tracked it down to MMIO reads to the CA0132 that never complete. I
have a workaround (attached, not meant for merging as-is) with which the
card now works fully: probe, DSP firmware download, playback. I'd like
your advice on the proper fix, and I'm happy to test patches.


Hardware / software
-------------------

- Dell Precision 7920 Tower, 2x Xeon Gold 6152 (Skylake-SP),
BIOS 2.53.1, APEI firmware-first error handling.
- 44:00.0 Intel Sky Lake-E PCIe Root Port A [8086:2030]
-> 45:00.0 ASMedia ASM1083/1085 PCIe-to-PCI bridge [1b21:1080] rev 03
-> 46:00.0 Creative CA0132 [1102:0010] rev 01, subsystem [1102:0081]
- Ubuntu kernel 7.0.0-38-generic (based on 7.0.14). The code paths
involved (sound/hda/core/controller.c, core/stream.c,
codecs/ca0132.c) are the same in current mainline as far as I can
see. I haven't built mainline yet, but can if that helps. The same
hang happened with Ubuntu's 6.17 kernel at install time.


1. The failure
--------------

Identical in every run (CPU PPIN removed):

mce: [Hardware Error]: CPU 0: Machine Check Exception: 5 Bank 6:
bb80000000000e0b
mce: [Hardware Error]: RIP !INEXACT! 10:<ffffffffc1fdbf1b>
{snd_hdac_bus_init_cmd_io+0x1db/0x260 [snd_hda_core]}
mce: [Hardware Error]: TSC 2e59a247c66 MISC 44000000
mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1791056639 SOCKET 0 APIC
0 microcode 2007006
mce: [Hardware Error]: Machine check: Processor context corrupt
Kernel panic - not syncing: Fatal machine check

Bank 6 is the IIO, and MCACOD 0x0e0b is a generic I/O bus error. The MCE
comes about 1.18 s after the last driver message ("codec_mask = 0x2"),
which matches the root port's completion timeout (260-900 ms). So a CPU
read to the CA0132 never got a completion.

In this build, +0x1db is the instruction right after
"mov 0x4a(%rax),%ax", i.e. the readw(CORBRP) in the first poll loop of
azx_clear_corbrp(), immediately after writew(CORBRP, AZX_CORBRP_RST).
CORB DMA isn't running yet at that point.


2. What the experiments showed
------------------------------

- Done from userspace with the card unbound (setpci / devmem), each
register access is fine on its own. That includes the controller reset
at driver timing, and the whole CORB/RIRB setup sequence done slowly
with a read after each step. Note that the CORB/RIRB base addresses
were 0 in that test, so no real DMA happened, and the IOMMU logged no
faults.

- In the driver, with the CORBRP readback avoided (write RST, wait
10 ms, write 0, wait 10 ms, no reads in between), the MCE moved to
snd_hdac_bus_init_cmd_io+0x186. That's readl(GCTL) in the final
updatel(GCTL, UNSOL): the first read after CORBCTL=RUN, the RIRB
base/size writes, RIRBWP=RST, RINTCNT and RIRBCTL. Adding 10 ms delays
between those writes did NOT help. Adding a GCTL read after each
group of writes did.

- With that in place, the probe got through codec enumeration and then
hung (no MCE record that time). The last trace point was
ca0132_mmio_init() returning. The next code is ae5_register_set() (the
AE-7 path): 19 BAR2 writes, then the first BAR2 read, in
ca0113_mmio_command_set_type2(). So presumably it was that read.

- Turning off AER/SERR/parity reporting on the card, the bridge and the
root port did not help either. The machine hung at the same point, but
left no MCE record and had to be power-cycled.

So the pattern seems to be: on this bridge, a read that follows a run
of posted writes to the CA0132 never completes. One data point doesn't
fit a simple count, though. azx_int_clear() does 13 writes to
registers 32 bytes apart, and the read after it was fine. So it may be
about writes to neighbouring registers being merged by the bridge. I
couldn't pin that down. ASM1083 rev 03 is reported as broken with other
PCI cards as well [2].


3. Workaround that works (attached, against the Ubuntu 7.0.0-38 tree)
--------------------------------------------------------------------

All of it applies only to Creative HDA controllers (PCI vendor check):

a) snd_hdac_reg_write{b,w,l}(): read GCTL after every register write.
b) snd_hdac_bus_init_cmd_io(): do the CORB read pointer reset without
polling CORBRP while RST is set (set, 10 ms, clear, 10 ms), and
settle + read GCTL after each group of CORB/RIRB writes.
c) snd_hdac_stream_reset(): keep the SRST handshake, but wait 5 ms
before each read-back.
d) ca0132.c: follow every write to spec->mem_base (45 sites) with the
same flush read.

With this everything works over several boots and hours of playback:
controller and codec probe, "ca0132 DSP downloaded and running", the
AE-7 post-DSP setup, and playback in 2.0 and 2.1 (6 channels). There
have been no MCEs since. NVIDIA HDMI audio, driven by the same
snd_hda_intel, is unaffected (the flushes are gated on the vendor).

(c) may not be needed. My first version did the stream reset blind (no
SRST read-back) because I suspected reads during reset. The DMAR faults
I then saw turned out to be the separate issue in section 4.


4. Second issue: the CA0132 reads past the end of the cyclic buffer
-------------------------------------------------------------------

With IOMMU translation (default DMA-FQ domain), every buffer wrap during
playback produces:

DMAR: [DMA Read NO_PASID] Request device [46:00.0] fault addr
0xffec0000 [fault reason 0x06] PTE Read access is not set

The fault repeats at the buffer-wrap period (0.683 s for 32768 frames
at 48 kHz). The address changes with the buffer, and it's consistent
with the address just past the end of a size-aligned IOVA allocation of
the current PCM buffer: 0xffec0000 for a 768 KiB buffer (6 ch, which
would sit at 0xffe00000), and 0xfff40000 / 0xfff80000 for 256 KiB
buffers. I haven't read the buffer's IOVA directly. If that's right,
the controller prefetches past the last BDL entry before wrapping. The
audio itself is fine. As a workaround I switch the card's IOMMU group
to identity before binding it.


5. Minor
--------

PipeWire first asks for buffer=1572864, period=49152, which gives
"Too many BDL entries" (because of AZX_DCAPS_4K_BDLE_BOUNDARY). It then
falls back to a smaller buffer and works.


Questions
---------

- Would a quirk keyed on an ASMedia 1b21:1080 (rev 03) bridge directly
upstream of the controller be acceptable? It would set something like
bus->flush_writes (read back after every write), plus a CORB reset
that doesn't poll while RST is set. Or would you rather this live in
the PCI layer?
- Are there any known ASM1083/1085 errata about posted writes or write
merging?
- For the buffer overread, what's the preferred fix: padding the
allocation, an extra BDL entry, or something else?

I can test patches on this machine. Failures leave crash dumps in
pstore/ERST, so each failed test is quick to diagnose.

[1] https://forum.endeavouros.com/t/unable-to-boot-after-installing-new-sound-card-ae-7/40457
[2] https://projects.osmocom.org/projects/retronetworking/wiki/PCIe-%3EPCI_bridges
[3] https://bugzilla.kernel.org/show_bug.cgi?id=208667 (ASM1083/1085 ASPM quirk)
[4] https://bugzilla.kernel.org/show_bug.cgi?id=217510 (AE-7, possibly related)

Regards,
gigiou_88

--000000000000e40bf6065d17487a
Content-Type: text/x-patch; charset="US-ASCII"; name="ae7-asm1083-workaround.patch"
Content-Disposition: attachment; filename="ae7-asm1083-workaround.patch"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

LS0tIGEvaW5jbHVkZS9zb3VuZC9oZGF1ZGlvLmgKKysrIGIvaW5jbHVkZS9zb3VuZC9oZGF1ZGlv
LmgKQEAgLTQyNyw2ICs0MjcsMjQgQEAKICNkZWZpbmUgc25kX2hkYWNfYWxpZ25lZF93cml0ZSh2
YWwsIGFkZHIsIG1hc2spIGRvIHt9IHdoaWxlICgwKQogI2VuZGlmCiAKKy8qCisgKiBhZTcgbG9j
YWwgcGF0Y2g6IGEgU291bmQgQmxhc3RlciBBRS03IChDcmVhdGl2ZSBDQTAxMzIpIGJlaGluZCBh
biBBU01lZGlhIEFTTTEwODMvMTA4NSByZXYgMDMgUENJZS10by1QQ0kKKyAqIGJyaWRnZSBsb3Nl
cyBhIHJlZ2lzdGVyIHJlYWQgdGhhdCBmb2xsb3dzIGEgcnVuIG9mIHBvc3RlZCB3cml0ZXM6IHRo
ZSByZWFkIG5ldmVyIGNvbXBsZXRlcywgdGhlIHJvb3QgcG9ydCdzCisgKiBjb21wbGV0aW9uIHRp
bWVvdXQgZmlyZXMgYW5kIHRoZSBDUFUgdGFrZXMgYSBmYXRhbCBtYWNoaW5lIGNoZWNrLiBSZWFk
aW5nIGJhY2sgYWZ0ZXIgZXZlcnkgd3JpdGUgYXZvaWRzIGl0LAorICogc28gb24gQ3JlYXRpdmUg
SERBIGNvbnRyb2xsZXJzIGV2ZXJ5IHJlZ2lzdGVyIHdyaXRlIGlzIGZvbGxvd2VkIGJ5IGEgcmVh
ZCBvZiBHQ1RMIChvZmZzZXQgMHgwOCkuCisgKi8KK3N0YXRpYyBpbmxpbmUgYm9vbCBzbmRfaGRh
Y19idXNfZmx1c2hfd3JpdGVzKHN0cnVjdCBoZGFjX2J1cyAqYnVzKQoreworCXJldHVybiBidXMg
JiYgYnVzLT5kZXYgJiYgZGV2X2lzX3BjaShidXMtPmRldikgJiYKKwkgICAgICAgdG9fcGNpX2Rl
dihidXMtPmRldiktPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0NSRUFUSVZFOworfQorCitzdGF0
aWMgaW5saW5lIHZvaWQgc25kX2hkYWNfcmVnX2ZsdXNoKHN0cnVjdCBoZGFjX2J1cyAqYnVzKQor
eworCWlmIChzbmRfaGRhY19idXNfZmx1c2hfd3JpdGVzKGJ1cykgJiYgYnVzLT5yZW1hcF9hZGRy
KQorCQlyZWFkbChidXMtPnJlbWFwX2FkZHIgKyAweDA4KTsJLyogQVpYX1JFR19HQ1RMICovCit9
CisKIHN0YXRpYyBpbmxpbmUgdm9pZCBzbmRfaGRhY19yZWdfd3JpdGViKHN0cnVjdCBoZGFjX2J1
cyAqYnVzLCB2b2lkIF9faW9tZW0gKmFkZHIsCiAJCQkJICAgICAgIHU4IHZhbCkKIHsKQEAgLTQz
NCw2ICs0NTIsNyBAQAogCQlzbmRfaGRhY19hbGlnbmVkX3dyaXRlKHZhbCwgYWRkciwgMHhmZik7
CiAJZWxzZQogCQl3cml0ZWIodmFsLCBhZGRyKTsKKwlzbmRfaGRhY19yZWdfZmx1c2goYnVzKTsK
IH0KIAogc3RhdGljIGlubGluZSB2b2lkIHNuZF9oZGFjX3JlZ193cml0ZXcoc3RydWN0IGhkYWNf
YnVzICpidXMsIHZvaWQgX19pb21lbSAqYWRkciwKQEAgLTQ0Myw2ICs0NjIsNyBAQAogCQlzbmRf
aGRhY19hbGlnbmVkX3dyaXRlKHZhbCwgYWRkciwgMHhmZmZmKTsKIAllbHNlCiAJCXdyaXRldyh2
YWwsIGFkZHIpOworCXNuZF9oZGFjX3JlZ19mbHVzaChidXMpOwogfQogCiBzdGF0aWMgaW5saW5l
IHU4IHNuZF9oZGFjX3JlZ19yZWFkYihzdHJ1Y3QgaGRhY19idXMgKmJ1cywgdm9pZCBfX2lvbWVt
ICphZGRyKQpAQCAtNDU3LDcgKzQ3NywxMiBAQAogCQlzbmRfaGRhY19hbGlnbmVkX3JlYWQoYWRk
ciwgMHhmZmZmKSA6IHJlYWR3KGFkZHIpOwogfQogCi0jZGVmaW5lIHNuZF9oZGFjX3JlZ193cml0
ZWwoYnVzLCBhZGRyLCB2YWwpCXdyaXRlbCh2YWwsIGFkZHIpCitzdGF0aWMgaW5saW5lIHZvaWQg
c25kX2hkYWNfcmVnX3dyaXRlbChzdHJ1Y3QgaGRhY19idXMgKmJ1cywgdm9pZCBfX2lvbWVtICph
ZGRyLAorCQkJCSAgICAgICB1MzIgdmFsKQoreworCXdyaXRlbCh2YWwsIGFkZHIpOworCXNuZF9o
ZGFjX3JlZ19mbHVzaChidXMpOworfQogI2RlZmluZSBzbmRfaGRhY19yZWdfcmVhZGwoYnVzLCBh
ZGRyKQlyZWFkbChhZGRyKQogI2RlZmluZSBzbmRfaGRhY19yZWdfd3JpdGVxKGJ1cywgYWRkciwg
dmFsKQl3cml0ZXEodmFsLCBhZGRyKQogI2RlZmluZSBzbmRfaGRhY19yZWdfcmVhZHEoYnVzLCBh
ZGRyKQkJcmVhZHEoYWRkcikKLS0tIGEvc291bmQvaGRhL2NvcmUvY29udHJvbGxlci5jCisrKyBi
L3NvdW5kL2hkYS9jb3JlL2NvbnRyb2xsZXIuYwpAQCAtNDAsNiArNDAsNTIgQEAKICAqIHNuZF9o
ZGFjX2J1c19pbml0X2NtZF9pbyAtIHNldCB1cCBDT1JCL1JJUkIgYnVmZmVycwogICogQGJ1czog
SEQtYXVkaW8gY29yZSBidXMKICAqLworLyoKKyAqIGFlNyBsb2NhbCBwYXRjaCwgU291bmQgQmxh
c3RlciBBRS03IGJlaGluZCBhbiBBU01lZGlhIEFTTTEwODMvMTA4NSByZXYgMDMgYnJpZGdlIChz
ZWUgaW5jbHVkZS9zb3VuZC9oZGF1ZGlvLmgpOgorICogdGhlIHN0b2NrIENPUkIvUklSQiBzZXR1
cCBoYW5ncyB0aGUgbWFjaGluZSB0d2ljZSDigJQgcmVhZGluZyBDT1JCUlAgYmFjayB3aGlsZSBD
T1JCUlBfUlNUIGlzIHNldCBuZXZlciBjb21wbGV0ZXMsCisgKiBhbmQgbmVpdGhlciBkb2VzIHRo
ZSBmaXJzdCByZWFkIGFmdGVyIHRoZSBiYWNrLXRvLWJhY2sgQ09SQiBzdGFydCAvIFJJUkIgc2V0
dXAgd3JpdGVzLiBUaGlzIGlzIHRoZSBzZXF1ZW5jZSB0aGF0CisgKiB3YXMgdGVzdGVkIHRvIHdv
cmsgb24gdGhhdCBjYXJkOiBsZXQgdGhlIHdyaXRlcyBzZXR0bGUgYW5kIHJlYWQgR0NUTCBhZnRl
ciBlYWNoIGdyb3VwLCBhbmQgZG8gdGhlIENPUkIgcmVhZAorICogcG9pbnRlciByZXNldCB3aXRo
b3V0IHJlYWRpbmcgaXQgYmFjay4KKyAqLworc3RhdGljIHZvaWQgYWU3X3NldHRsZShzdHJ1Y3Qg
aGRhY19idXMgKmJ1cykKK3sKKwltZGVsYXkoMTApOworCXJlYWRsKGJ1cy0+cmVtYXBfYWRkciAr
IEFaWF9SRUdfR0NUTCk7Cit9CisKK3N0YXRpYyB2b2lkIGFlN19pbml0X2NtZF9pbyhzdHJ1Y3Qg
aGRhY19idXMgKmJ1cykKK3sKKwl2b2lkIF9faW9tZW0gKnJlZ3MgPSBidXMtPnJlbWFwX2FkZHI7
CisKKwlhZTdfc2V0dGxlKGJ1cyk7CisJd3JpdGVsKCh1MzIpKGJ1cy0+Y29yYi5hZGRyICsgYnVz
LT5hZGRyX29mZnNldCksIHJlZ3MgKyBBWlhfUkVHX0NPUkJMQkFTRSk7CisJd3JpdGVsKHVwcGVy
XzMyX2JpdHMoYnVzLT5jb3JiLmFkZHIgKyBidXMtPmFkZHJfb2Zmc2V0KSwgcmVncyArIEFaWF9S
RUdfQ09SQlVCQVNFKTsKKwl3cml0ZWIoMHgwMiwgcmVncyArIEFaWF9SRUdfQ09SQlNJWkUpOwor
CXdyaXRldygwLCByZWdzICsgQVpYX1JFR19DT1JCV1ApOworCWFlN19zZXR0bGUoYnVzKTsKKwkv
KiBDT1JCIHJlYWQgcG9pbnRlciByZXNldDogbmV2ZXIgcmVhZCBhbnl0aGluZyB3aGlsZSBDT1JC
UlBfUlNUIGlzIHNldCAqLworCXdyaXRldyhBWlhfQ09SQlJQX1JTVCwgcmVncyArIEFaWF9SRUdf
Q09SQlJQKTsKKwltZGVsYXkoMTApOworCXdyaXRldygwLCByZWdzICsgQVpYX1JFR19DT1JCUlAp
OworCW1kZWxheSgxMCk7CisJaWYgKCFidXMtPnVzZV9waW9fZm9yX2NvbW1hbmRzKQorCQl3cml0
ZWIoQVpYX0NPUkJDVExfUlVOLCByZWdzICsgQVpYX1JFR19DT1JCQ1RMKTsKKwlhZTdfc2V0dGxl
KGJ1cyk7CisJd3JpdGVsKCh1MzIpKGJ1cy0+cmlyYi5hZGRyICsgYnVzLT5hZGRyX29mZnNldCks
IHJlZ3MgKyBBWlhfUkVHX1JJUkJMQkFTRSk7CisJd3JpdGVsKHVwcGVyXzMyX2JpdHMoYnVzLT5y
aXJiLmFkZHIgKyBidXMtPmFkZHJfb2Zmc2V0KSwgcmVncyArIEFaWF9SRUdfUklSQlVCQVNFKTsK
KwlhZTdfc2V0dGxlKGJ1cyk7CisJd3JpdGViKDB4MDIsIHJlZ3MgKyBBWlhfUkVHX1JJUkJTSVpF
KTsKKwl3cml0ZXcoQVpYX1JJUkJXUF9SU1QsIHJlZ3MgKyBBWlhfUkVHX1JJUkJXUCk7CisJYWU3
X3NldHRsZShidXMpOworCXdyaXRldygxLCByZWdzICsgQVpYX1JFR19SSU5UQ05UKTsKKwlhZTdf
c2V0dGxlKGJ1cyk7CisJd3JpdGViKGJ1cy0+bm90X3VzZV9pbnRlcnJ1cHRzID8gQVpYX1JCQ1RM
X0RNQV9FTiA6IEFaWF9SQkNUTF9ETUFfRU4gfCBBWlhfUkJDVExfSVJRX0VOLAorCSAgICAgICBy
ZWdzICsgQVpYX1JFR19SSVJCQ1RMKTsKKwlhZTdfc2V0dGxlKGJ1cyk7CisJd3JpdGVsKHJlYWRs
KHJlZ3MgKyBBWlhfUkVHX0dDVEwpIHwgQVpYX0dDVExfVU5TT0wsIHJlZ3MgKyBBWlhfUkVHX0dD
VEwpOworCWFlN19zZXR0bGUoYnVzKTsKK30KKwogdm9pZCBzbmRfaGRhY19idXNfaW5pdF9jbWRf
aW8oc3RydWN0IGhkYWNfYnVzICpidXMpCiB7CiAJV0FSTl9PTl9PTkNFKCFidXMtPnJiLmFyZWEp
OwpAQCAtNDgsNiArOTQsMTQgQEAKIAkvKiBDT1JCIHNldCB1cCAqLwogCWJ1cy0+Y29yYi5hZGRy
ID0gYnVzLT5yYi5hZGRyOwogCWJ1cy0+Y29yYi5idWYgPSAoX19sZTMyICopYnVzLT5yYi5hcmVh
OworCWlmIChzbmRfaGRhY19idXNfZmx1c2hfd3JpdGVzKGJ1cykpIHsKKwkJYnVzLT5yaXJiLmFk
ZHIgPSBidXMtPnJiLmFkZHIgKyAyMDQ4OworCQlidXMtPnJpcmIuYnVmID0gKF9fbGUzMiAqKShi
dXMtPnJiLmFyZWEgKyAyMDQ4KTsKKwkJYnVzLT5yaXJiLndwID0gYnVzLT5yaXJiLnJwID0gMDsK
KwkJbWVtc2V0KGJ1cy0+cmlyYi5jbWRzLCAwLCBzaXplb2YoYnVzLT5yaXJiLmNtZHMpKTsKKwkJ
YWU3X2luaXRfY21kX2lvKGJ1cyk7CisJCXJldHVybjsKKwl9CiAJc25kX2hkYWNfY2hpcF93cml0
ZWwoYnVzLCBDT1JCTEJBU0UsICh1MzIpKGJ1cy0+Y29yYi5hZGRyICsgYnVzLT5hZGRyX29mZnNl
dCkpOwogCXNuZF9oZGFjX2NoaXBfd3JpdGVsKGJ1cywgQ09SQlVCQVNFLCB1cHBlcl8zMl9iaXRz
KGJ1cy0+Y29yYi5hZGRyICsgYnVzLT5hZGRyX29mZnNldCkpOwogCi0tLSBhL3NvdW5kL2hkYS9j
b3JlL3N0cmVhbS5jCisrKyBiL3NvdW5kL2hkYS9jb3JlL3N0cmVhbS5jCkBAIC0yMzAsNiArMjMw
LDM3IEBACiAKIAlkbWFfcnVuX3N0YXRlID0gc25kX2hkYWNfc3RyZWFtX3JlYWRiKGF6eF9kZXYs
IFNEX0NUTCkgJiBTRF9DVExfRE1BX1NUQVJUOwogCisJaWYgKHNuZF9oZGFjX2J1c19mbHVzaF93
cml0ZXMoYXp4X2Rldi0+YnVzKSkgeworCQkvKgorCQkgKiBhZTcgbG9jYWwgcGF0Y2ggKHNlZSBp
bmNsdWRlL3NvdW5kL2hkYXVkaW8uaCk6IGtlZXAgdGhlIHNwZWMgaGFuZHNoYWtlIOKAlCBTUlNU
IG11c3QgYmUgcmVhZCBiYWNrCisJCSAqIGFzIDEgYW5kIHRoZW4gYXMgMCwgb3RoZXJ3aXNlIHN0
YWxlIERNQSBzdGF0ZSBzdXJ2aXZlcyB0aGUgcmVzZXQgKGEgcGxheWJhY2sgc3RyZWFtIHJldXNl
ZCBhZnRlcgorCQkgKiB0aGUgRFNQIGZpcm13YXJlIHVwbG9hZCBrZXB0IHJlYWRpbmcgdGhlIGZy
ZWVkIHVwbG9hZCBidWZmZXIpLiBHaXZlIHRoZSBoYXJkd2FyZSB0aW1lIGJlZm9yZSBlYWNoCisJ
CSAqIHJlYWQtYmFjayBpbnN0ZWFkIG9mIHBvbGxpbmcgcmlnaHQgYWZ0ZXIgdGhlIHdyaXRlLgor
CQkgKi8KKwkJc3RhdGljIGF0b21pY190IGFlN19sb2dnZWQgPSBBVE9NSUNfSU5JVCgwKTsKKwkJ
aW50IGluX3BvbGxzID0gMCwgb3V0X3BvbGxzID0gMDsKKworCQl2YWwgPSBzbmRfaGRhY19zdHJl
YW1fcmVhZGIoYXp4X2RldiwgU0RfQ1RMKTsKKwkJd3JpdGViKHZhbCB8IFNEX0NUTF9TVFJFQU1f
UkVTRVQsIGF6eF9kZXYtPnNkX2FkZHIgKyBBWlhfUkVHX1NEX0NUTCk7CisJCW1kZWxheSg1KTsK
KwkJd2hpbGUgKCEoc25kX2hkYWNfc3RyZWFtX3JlYWRiKGF6eF9kZXYsIFNEX0NUTCkgJiBTRF9D
VExfU1RSRUFNX1JFU0VUKSAmJiArK2luX3BvbGxzIDwgMTAwKQorCQkJdWRlbGF5KDEwKTsKKwkJ
aWYgKGF6eF9kZXYtPmJ1cy0+ZG1hX3N0b3BfZGVsYXkgJiYgZG1hX3J1bl9zdGF0ZSkKKwkJCXVk
ZWxheShhenhfZGV2LT5idXMtPmRtYV9zdG9wX2RlbGF5KTsKKwkJd3JpdGViKHZhbCAmIH5TRF9D
VExfU1RSRUFNX1JFU0VULCBhenhfZGV2LT5zZF9hZGRyICsgQVpYX1JFR19TRF9DVEwpOworCQlt
ZGVsYXkoNSk7CisJCXdoaWxlICgoc25kX2hkYWNfc3RyZWFtX3JlYWRiKGF6eF9kZXYsIFNEX0NU
TCkgJiBTRF9DVExfU1RSRUFNX1JFU0VUKSAmJiArK291dF9wb2xscyA8IDEwMCkKKwkJCXVkZWxh
eSgxMCk7CisJCWlmIChhdG9taWNfaW5jX3JldHVybigmYWU3X2xvZ2dlZCkgPD0gMzApCisJCQlk
ZXZfaW5mbyhhenhfZGV2LT5idXMtPmRldiwgImFlNzogc3RyZWFtICVkIHJlc2V0OiBTUlNUIHJl
YWQgMSAlcywgcmVhZCAwICVzXG4iLAorCQkJCSBhenhfZGV2LT5pbmRleCwKKwkJCQkgaW5fcG9s
bHMgPCAxMDAgPyAib2siIDogIk5FVkVSICh0aW1lb3V0KSIsCisJCQkJIG91dF9wb2xscyA8IDEw
MCA/ICJvayIgOiAiTkVWRVIgKHRpbWVvdXQpIik7CisJCWlmIChhenhfZGV2LT5wb3NidWYpCisJ
CQkqYXp4X2Rldi0+cG9zYnVmID0gMDsKKwkJcmV0dXJuOworCX0KKwogCXNuZF9oZGFjX3N0cmVh
bV91cGRhdGViKGF6eF9kZXYsIFNEX0NUTCwgMCwgU0RfQ1RMX1NUUkVBTV9SRVNFVCk7CiAKIAkv
KiB3YWl0IGZvciBoYXJkd2FyZSB0byByZXBvcnQgdGhhdCB0aGUgc3RyZWFtIGVudGVyZWQgcmVz
ZXQgKi8KLS0tIGEvc291bmQvaGRhL2NvZGVjcy9jYTAxMzIuYworKysgYi9zb3VuZC9oZGEvY29k
ZWNzL2NhMDEzMi5jCkBAIC0zNjI3LDYgKzM2MjcsMjkgQEAKICAqIG9mIHRoZSBvbi1jYXJkIExF
RC4gSXQgc2VlbXMgdG8gdXNlIHBpbiAyIGZvciBkYXRhLCB0aGVuIHRvZ2dsZXMgMyB0byBvbiBh
bmQKICAqIHRoZW4gb2ZmIHRvIHNlbmQgdGhhdCBiaXQuCiAgKi8KKy8qCisgKiBhZTcgbG9jYWwg
cGF0Y2g6IGZsdXNoIGV2ZXJ5IHdyaXRlIHRvIHRoZSBjYXJkJ3Mgc2Vjb25kIE1NSU8gcmVnaW9u
IChCQVIgMikgd2l0aCBhIHJlYWQsIGxpa2UgdGhlIEhEQSByZWdpc3RlcgorICogd3JpdGVzIGlu
IGluY2x1ZGUvc291bmQvaGRhdWRpby5oIOKAlCBvbiBhIFNvdW5kIEJsYXN0ZXIgQUUtNyBiZWhp
bmQgYW4gQVNNZWRpYSBBU00xMDgzLzEwODUgcmV2IDAzIGJyaWRnZSBhIHJlYWQKKyAqIHRoYXQg
Zm9sbG93cyBhIHJ1biBvZiBwb3N0ZWQgd3JpdGVzIG5ldmVyIGNvbXBsZXRlcyBhbmQgdGFrZXMg
dGhlIG1hY2hpbmUgZG93bi4KKyAqLworc3RhdGljIHZvaWQgY2EwMTMyX21taW9fd3JpdGVsKHN0
cnVjdCBoZGFfY29kZWMgKmNvZGVjLCB1MzIgdmFsLCB2b2lkIF9faW9tZW0gKmFkZHIpCit7CisJ
d3JpdGVsKHZhbCwgYWRkcik7CisJc25kX2hkYWNfcmVnX2ZsdXNoKCZjb2RlYy0+YnVzLT5jb3Jl
KTsKK30KKworc3RhdGljIHZvaWQgY2EwMTMyX21taW9fd3JpdGV3KHN0cnVjdCBoZGFfY29kZWMg
KmNvZGVjLCB1MTYgdmFsLCB2b2lkIF9faW9tZW0gKmFkZHIpCit7CisJd3JpdGV3KHZhbCwgYWRk
cik7CisJc25kX2hkYWNfcmVnX2ZsdXNoKCZjb2RlYy0+YnVzLT5jb3JlKTsKK30KKworc3RhdGlj
IHZvaWQgY2EwMTMyX21taW9fd3JpdGViKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLCB1OCB2YWws
IHZvaWQgX19pb21lbSAqYWRkcikKK3sKKwl3cml0ZWIodmFsLCBhZGRyKTsKKwlzbmRfaGRhY19y
ZWdfZmx1c2goJmNvZGVjLT5idXMtPmNvcmUpOworfQorCiBzdGF0aWMgdm9pZCBjYTAxMTNfbW1p
b19ncGlvX3NldChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywgdW5zaWduZWQgaW50IGdwaW9fcGlu
LAogCQlib29sIGVuYWJsZSkKIHsKQEAgLTM2MzYsNyArMzY1OSw3IEBACiAJZ3Bpb19kYXRhID0g
Z3Bpb19waW4gJiAweEY7CiAJZ3Bpb19kYXRhIHw9ICgoZW5hYmxlIDw8IDgpICYgMHgxMDApOwog
Ci0Jd3JpdGV3KGdwaW9fZGF0YSwgc3BlYy0+bWVtX2Jhc2UgKyAweDMyMCk7CisJY2EwMTMyX21t
aW9fd3JpdGV3KGNvZGVjLCBncGlvX2RhdGEsIHNwZWMtPm1lbV9iYXNlICsgMHgzMjApOwogfQog
CiAvKgpAQCAtMzY1MywyMSArMzY3NiwyMSBAQAogCXN0cnVjdCBjYTAxMzJfc3BlYyAqc3BlYyA9
IGNvZGVjLT5zcGVjOwogCXVuc2lnbmVkIGludCB3cml0ZV92YWw7CiAKLQl3cml0ZWwoMHgwMDAw
MDA3ZSwgc3BlYy0+bWVtX2Jhc2UgKyAweDIxMCk7CisJY2EwMTMyX21taW9fd3JpdGVsKGNvZGVj
LCAweDAwMDAwMDdlLCBzcGVjLT5tZW1fYmFzZSArIDB4MjEwKTsKIAlyZWFkbChzcGVjLT5tZW1f
YmFzZSArIDB4MjEwKTsKLQl3cml0ZWwoMHgwMDAwMDA1YSwgc3BlYy0+bWVtX2Jhc2UgKyAweDIx
MCk7CisJY2EwMTMyX21taW9fd3JpdGVsKGNvZGVjLCAweDAwMDAwMDVhLCBzcGVjLT5tZW1fYmFz
ZSArIDB4MjEwKTsKIAlyZWFkbChzcGVjLT5tZW1fYmFzZSArIDB4MjEwKTsKIAlyZWFkbChzcGVj
LT5tZW1fYmFzZSArIDB4MjEwKTsKIAotCXdyaXRlbCgweDAwODAwMDA1LCBzcGVjLT5tZW1fYmFz
ZSArIDB4MjBjKTsKLQl3cml0ZWwoZ3JvdXAsIHNwZWMtPm1lbV9iYXNlICsgMHg4MDQpOworCWNh
MDEzMl9tbWlvX3dyaXRlbChjb2RlYywgMHgwMDgwMDAwNSwgc3BlYy0+bWVtX2Jhc2UgKyAweDIw
Yyk7CisJY2EwMTMyX21taW9fd3JpdGVsKGNvZGVjLCBncm91cCwgc3BlYy0+bWVtX2Jhc2UgKyAw
eDgwNCk7CiAKLQl3cml0ZWwoMHgwMDgwMDAwNSwgc3BlYy0+bWVtX2Jhc2UgKyAweDIwYyk7CisJ
Y2EwMTMyX21taW9fd3JpdGVsKGNvZGVjLCAweDAwODAwMDA1LCBzcGVjLT5tZW1fYmFzZSArIDB4
MjBjKTsKIAl3cml0ZV92YWwgPSAodGFyZ2V0ICYgMHhmZik7CiAJd3JpdGVfdmFsIHw9ICh2YWx1
ZSA8PCA4KTsKIAogCi0Jd3JpdGVsKHdyaXRlX3ZhbCwgc3BlYy0+bWVtX2Jhc2UgKyAweDIwNCk7
CisJY2EwMTMyX21taW9fd3JpdGVsKGNvZGVjLCB3cml0ZV92YWwsIHNwZWMtPm1lbV9iYXNlICsg
MHgyMDQpOwogCS8qCiAJICogTmVlZCBkZWxheSBoZXJlIG9yIGVsc2UgaXQgZ29lcyB0b28gZmFz
dCBhbmQgd29ya3MgaW5jb25zaXN0ZW50bHkuCiAJICovCkBAIC0zNjc3LDggKzM3MDAsOCBAQAog
CXJlYWRsKHNwZWMtPm1lbV9iYXNlICsgMHg4NTQpOwogCXJlYWRsKHNwZWMtPm1lbV9iYXNlICsg
MHg4NDApOwogCi0Jd3JpdGVsKDB4MDA4MDAwMDQsIHNwZWMtPm1lbV9iYXNlICsgMHgyMGMpOwot
CXdyaXRlbCgweDAwMDAwMDAwLCBzcGVjLT5tZW1fYmFzZSArIDB4MjEwKTsKKwljYTAxMzJfbW1p
b193cml0ZWwoY29kZWMsIDB4MDA4MDAwMDQsIHNwZWMtPm1lbV9iYXNlICsgMHgyMGMpOworCWNh
MDEzMl9tbWlvX3dyaXRlbChjb2RlYywgMHgwMDAwMDAwMCwgc3BlYy0+bWVtX2Jhc2UgKyAweDIx
MCk7CiAJcmVhZGwoc3BlYy0+bWVtX2Jhc2UgKyAweDIxMCk7CiAJcmVhZGwoc3BlYy0+bWVtX2Jh
c2UgKyAweDIxMCk7CiB9CkBAIC0zNjkyLDI4ICszNzE1LDI4IEBACiAJc3RydWN0IGNhMDEzMl9z
cGVjICpzcGVjID0gY29kZWMtPnNwZWM7CiAJdW5zaWduZWQgaW50IHdyaXRlX3ZhbDsKIAotCXdy
aXRlbCgweDAwMDAwMDdlLCBzcGVjLT5tZW1fYmFzZSArIDB4MjEwKTsKKwljYTAxMzJfbW1pb193
cml0ZWwoY29kZWMsIDB4MDAwMDAwN2UsIHNwZWMtPm1lbV9iYXNlICsgMHgyMTApOwogCXJlYWRs
KHNwZWMtPm1lbV9iYXNlICsgMHgyMTApOwotCXdyaXRlbCgweDAwMDAwMDVhLCBzcGVjLT5tZW1f
YmFzZSArIDB4MjEwKTsKKwljYTAxMzJfbW1pb193cml0ZWwoY29kZWMsIDB4MDAwMDAwNWEsIHNw
ZWMtPm1lbV9iYXNlICsgMHgyMTApOwogCXJlYWRsKHNwZWMtPm1lbV9iYXNlICsgMHgyMTApOwog
CXJlYWRsKHNwZWMtPm1lbV9iYXNlICsgMHgyMTApOwogCi0Jd3JpdGVsKDB4MDA4MDAwMDMsIHNw
ZWMtPm1lbV9iYXNlICsgMHgyMGMpOwotCXdyaXRlbChncm91cCwgc3BlYy0+bWVtX2Jhc2UgKyAw
eDgwNCk7CisJY2EwMTMyX21taW9fd3JpdGVsKGNvZGVjLCAweDAwODAwMDAzLCBzcGVjLT5tZW1f
YmFzZSArIDB4MjBjKTsKKwljYTAxMzJfbW1pb193cml0ZWwoY29kZWMsIGdyb3VwLCBzcGVjLT5t
ZW1fYmFzZSArIDB4ODA0KTsKIAotCXdyaXRlbCgweDAwODAwMDA1LCBzcGVjLT5tZW1fYmFzZSAr
IDB4MjBjKTsKKwljYTAxMzJfbW1pb193cml0ZWwoY29kZWMsIDB4MDA4MDAwMDUsIHNwZWMtPm1l
bV9iYXNlICsgMHgyMGMpOwogCXdyaXRlX3ZhbCA9ICh0YXJnZXQgJiAweGZmKTsKIAl3cml0ZV92
YWwgfD0gKHZhbHVlIDw8IDgpOwogCiAKLQl3cml0ZWwod3JpdGVfdmFsLCBzcGVjLT5tZW1fYmFz
ZSArIDB4MjA0KTsKKwljYTAxMzJfbW1pb193cml0ZWwoY29kZWMsIHdyaXRlX3ZhbCwgc3BlYy0+
bWVtX2Jhc2UgKyAweDIwNCk7CiAJbXNsZWVwKDIwKTsKIAlyZWFkbChzcGVjLT5tZW1fYmFzZSAr
IDB4ODYwKTsKIAlyZWFkbChzcGVjLT5tZW1fYmFzZSArIDB4ODU0KTsKIAlyZWFkbChzcGVjLT5t
ZW1fYmFzZSArIDB4ODQwKTsKIAotCXdyaXRlbCgweDAwODAwMDA0LCBzcGVjLT5tZW1fYmFzZSAr
IDB4MjBjKTsKLQl3cml0ZWwoMHgwMDAwMDAwMCwgc3BlYy0+bWVtX2Jhc2UgKyAweDIxMCk7CisJ
Y2EwMTMyX21taW9fd3JpdGVsKGNvZGVjLCAweDAwODAwMDA0LCBzcGVjLT5tZW1fYmFzZSArIDB4
MjBjKTsKKwljYTAxMzJfbW1pb193cml0ZWwoY29kZWMsIDB4MDAwMDAwMDAsIHNwZWMtPm1lbV9i
YXNlICsgMHgyMTApOwogCXJlYWRsKHNwZWMtPm1lbV9iYXNlICsgMHgyMTApOwogCXJlYWRsKHNw
ZWMtPm1lbV9iYXNlICsgMHgyMTApOwogfQpAQCAtNzg5NCwxOCArNzkxNywxOCBAQAogCWNoaXBp
b184MDUxX3dyaXRlX2RpcmVjdChjb2RlYywgMHg5MywgMHgxMCk7CiAJY2hpcGlvXzgwNTFfd3Jp
dGVfcGxsX3BtdShjb2RlYywgMHg0NCwgMHhjMik7CiAKLQl3cml0ZWIoMHhmZiwgc3BlYy0+bWVt
X2Jhc2UgKyAweDMwNCk7Ci0Jd3JpdGViKDB4ZmYsIHNwZWMtPm1lbV9iYXNlICsgMHgzMDQpOwot
CXdyaXRlYigweGZmLCBzcGVjLT5tZW1fYmFzZSArIDB4MzA0KTsKLQl3cml0ZWIoMHhmZiwgc3Bl
Yy0+bWVtX2Jhc2UgKyAweDMwNCk7Ci0Jd3JpdGViKDB4MDAsIHNwZWMtPm1lbV9iYXNlICsgMHgx
MDApOwotCXdyaXRlYigweGZmLCBzcGVjLT5tZW1fYmFzZSArIDB4MzA0KTsKLQl3cml0ZWIoMHgw
MCwgc3BlYy0+bWVtX2Jhc2UgKyAweDEwMCk7Ci0Jd3JpdGViKDB4ZmYsIHNwZWMtPm1lbV9iYXNl
ICsgMHgzMDQpOwotCXdyaXRlYigweDAwLCBzcGVjLT5tZW1fYmFzZSArIDB4MTAwKTsKLQl3cml0
ZWIoMHhmZiwgc3BlYy0+bWVtX2Jhc2UgKyAweDMwNCk7Ci0Jd3JpdGViKDB4MDAsIHNwZWMtPm1l
bV9iYXNlICsgMHgxMDApOwotCXdyaXRlYigweGZmLCBzcGVjLT5tZW1fYmFzZSArIDB4MzA0KTsK
KwljYTAxMzJfbW1pb193cml0ZWIoY29kZWMsIDB4ZmYsIHNwZWMtPm1lbV9iYXNlICsgMHgzMDQp
OworCWNhMDEzMl9tbWlvX3dyaXRlYihjb2RlYywgMHhmZiwgc3BlYy0+bWVtX2Jhc2UgKyAweDMw
NCk7CisJY2EwMTMyX21taW9fd3JpdGViKGNvZGVjLCAweGZmLCBzcGVjLT5tZW1fYmFzZSArIDB4
MzA0KTsKKwljYTAxMzJfbW1pb193cml0ZWIoY29kZWMsIDB4ZmYsIHNwZWMtPm1lbV9iYXNlICsg
MHgzMDQpOworCWNhMDEzMl9tbWlvX3dyaXRlYihjb2RlYywgMHgwMCwgc3BlYy0+bWVtX2Jhc2Ug
KyAweDEwMCk7CisJY2EwMTMyX21taW9fd3JpdGViKGNvZGVjLCAweGZmLCBzcGVjLT5tZW1fYmFz
ZSArIDB4MzA0KTsKKwljYTAxMzJfbW1pb193cml0ZWIoY29kZWMsIDB4MDAsIHNwZWMtPm1lbV9i
YXNlICsgMHgxMDApOworCWNhMDEzMl9tbWlvX3dyaXRlYihjb2RlYywgMHhmZiwgc3BlYy0+bWVt
X2Jhc2UgKyAweDMwNCk7CisJY2EwMTMyX21taW9fd3JpdGViKGNvZGVjLCAweDAwLCBzcGVjLT5t
ZW1fYmFzZSArIDB4MTAwKTsKKwljYTAxMzJfbW1pb193cml0ZWIoY29kZWMsIDB4ZmYsIHNwZWMt
Pm1lbV9iYXNlICsgMHgzMDQpOworCWNhMDEzMl9tbWlvX3dyaXRlYihjb2RlYywgMHgwMCwgc3Bl
Yy0+bWVtX2Jhc2UgKyAweDEwMCk7CisJY2EwMTMyX21taW9fd3JpdGViKGNvZGVjLCAweGZmLCBz
cGVjLT5tZW1fYmFzZSArIDB4MzA0KTsKIAogCWNhMDExM19tbWlvX2NvbW1hbmRfc2V0KGNvZGVj
LCAweDMwLCAweDJiLCAweDNmKTsKIAljYTAxMTNfbW1pb19jb21tYW5kX3NldChjb2RlYywgMHgz
MCwgMHgyZCwgMHgzZik7CkBAIC04ODI3LDkgKzg4NTAsOSBAQAogCXVuc2lnbmVkIGludCBpOwog
CiAJZm9yIChpID0gMDsgaSA8IDQ7IGkrKykKLQkJd3JpdGViKDB4MCwgc3BlYy0+bWVtX2Jhc2Ug
KyAweDEwMCk7CisJCWNhMDEzMl9tbWlvX3dyaXRlYihjb2RlYywgMHgwLCBzcGVjLT5tZW1fYmFz
ZSArIDB4MTAwKTsKIAlmb3IgKGkgPSAwOyBpIDwgODsgaSsrKQotCQl3cml0ZWIoMHhiMywgc3Bl
Yy0+bWVtX2Jhc2UgKyAweDMwNCk7CisJCWNhMDEzMl9tbWlvX3dyaXRlYihjb2RlYywgMHhiMywg
c3BlYy0+bWVtX2Jhc2UgKyAweDMwNCk7CiAKIAljYTAxMTNfbW1pb19ncGlvX3NldChjb2RlYywg
MCwgZmFsc2UpOwogCWNhMDExM19tbWlvX2dwaW9fc2V0KGNvZGVjLCAxLCBmYWxzZSk7CkBAIC05
MTExLDggKzkxMzQsOCBAQAogewogCXN0cnVjdCBjYTAxMzJfc3BlYyAqc3BlYyA9IGNvZGVjLT5z
cGVjOwogCi0Jd3JpdGVsKDB4MDA4MjA2ODAsIHNwZWMtPm1lbV9iYXNlICsgMHgwMUMpOwotCXdy
aXRlbCgweDAwODIwNjgwLCBzcGVjLT5tZW1fYmFzZSArIDB4MDFDKTsKKwljYTAxMzJfbW1pb193
cml0ZWwoY29kZWMsIDB4MDA4MjA2ODAsIHNwZWMtPm1lbV9iYXNlICsgMHgwMUMpOworCWNhMDEz
Ml9tbWlvX3dyaXRlbChjb2RlYywgMHgwMDgyMDY4MCwgc3BlYy0+bWVtX2Jhc2UgKyAweDAxQyk7
CiAKIAljaGlwaW9fd3JpdGUoY29kZWMsIDB4MThiMGE0LCAweDAwMDAwMGMyKTsKIApAQCAtOTIy
OCw3ICs5MjUxLDcgQEAKIAogCWFkZHIgPSBjYTAxMTNfbW1pb19pbml0X2FkZHJlc3Nfc2J6Owog
CWZvciAoaSA9IDA7IGkgPCAzOyBpKyspCi0JCXdyaXRlbCgweDAwMDAwMDAwLCBzcGVjLT5tZW1f
YmFzZSArIGFkZHJbaV0pOworCQljYTAxMzJfbW1pb193cml0ZWwoY29kZWMsIDB4MDAwMDAwMDAs
IHNwZWMtPm1lbV9iYXNlICsgYWRkcltpXSk7CiAKIAljdXJfYWRkciA9IGk7CiAJc3dpdGNoIChj
YTAxMzJfcXVpcmsoc3BlYykpIHsKQEAgLTkyNTEsNyArOTI3NCw3IEBACiAJfQogCiAJZm9yIChp
ID0gMDsgaSA8IDI7IGkrKykKLQkJd3JpdGVsKHRtcFtpXSwgc3BlYy0+bWVtX2Jhc2UgKyBhZGRy
W2N1cl9hZGRyICsgaV0pOworCQljYTAxMzJfbW1pb193cml0ZWwoY29kZWMsIHRtcFtpXSwgc3Bl
Yy0+bWVtX2Jhc2UgKyBhZGRyW2N1cl9hZGRyICsgaV0pOwogCiAJY3VyX2FkZHIgKz0gaTsKIApA
QCAtOTI2Nyw3ICs5MjkwLDcgQEAKIAl9CiAKIAlmb3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykK
LQkJd3JpdGVsKGRhdGFbaV0sIHNwZWMtPm1lbV9iYXNlICsgYWRkcltjdXJfYWRkciArIGldKTsK
KwkJY2EwMTMyX21taW9fd3JpdGVsKGNvZGVjLCBkYXRhW2ldLCBzcGVjLT5tZW1fYmFzZSArIGFk
ZHJbY3VyX2FkZHIgKyBpXSk7CiB9CiAKIHN0YXRpYyB2b2lkIGNhMDEzMl9tbWlvX2luaXRfYWU1
KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQpAQCAtOTI4MSw4ICs5MzA0LDggQEAKIAljb3VudCA9
IEFSUkFZX1NJWkUoY2EwMTEzX21taW9faW5pdF9kYXRhX2FlNSk7CiAKIAlpZiAoY2EwMTMyX3F1
aXJrKHNwZWMpID09IFFVSVJLX0FFNykgewotCQl3cml0ZWwoMHgwMDAwMDY4MCwgc3BlYy0+bWVt
X2Jhc2UgKyAweDFjKTsKLQkJd3JpdGVsKDB4MDA4ODA2ODAsIHNwZWMtPm1lbV9iYXNlICsgMHgx
Yyk7CisJCWNhMDEzMl9tbWlvX3dyaXRlbChjb2RlYywgMHgwMDAwMDY4MCwgc3BlYy0+bWVtX2Jh
c2UgKyAweDFjKTsKKwkJY2EwMTMyX21taW9fd3JpdGVsKGNvZGVjLCAweDAwODgwNjgwLCBzcGVj
LT5tZW1fYmFzZSArIDB4MWMpOwogCX0KIAogCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7
CkBAIC05MjkxLDE1ICs5MzE0LDE1IEBACiAJCSAqIGEgZGlmZmVyZW50IHZhbHVlIHRvIDB4MjBj
LgogCQkgKi8KIAkJaWYgKGkgPT0gMjEgJiYgY2EwMTMyX3F1aXJrKHNwZWMpID09IFFVSVJLX0FF
NykgewotCQkJd3JpdGVsKDB4MDA4MDAwMDEsIHNwZWMtPm1lbV9iYXNlICsgYWRkcltpXSk7CisJ
CQljYTAxMzJfbW1pb193cml0ZWwoY29kZWMsIDB4MDA4MDAwMDEsIHNwZWMtPm1lbV9iYXNlICsg
YWRkcltpXSk7CiAJCQljb250aW51ZTsKIAkJfQogCi0JCXdyaXRlbChkYXRhW2ldLCBzcGVjLT5t
ZW1fYmFzZSArIGFkZHJbaV0pOworCQljYTAxMzJfbW1pb193cml0ZWwoY29kZWMsIGRhdGFbaV0s
IHNwZWMtPm1lbV9iYXNlICsgYWRkcltpXSk7CiAJfQogCiAJaWYgKGNhMDEzMl9xdWlyayhzcGVj
KSA9PSBRVUlSS19BRTUpCi0JCXdyaXRlbCgweDAwODgwNjgwLCBzcGVjLT5tZW1fYmFzZSArIDB4
MWMpOworCQljYTAxMzJfbW1pb193cml0ZWwoY29kZWMsIDB4MDA4ODA2ODAsIHNwZWMtPm1lbV9i
YXNlICsgMHgxYyk7CiB9CiAKIHN0YXRpYyB2b2lkIGNhMDEzMl9tbWlvX2luaXQoc3RydWN0IGhk
YV9jb2RlYyAqY29kZWMpCkBAIC05MzYxLDE5ICs5Mzg0LDE5IEBACiAJfQogCiAJZm9yIChpID0g
Y3VyX2FkZHIgPSAwOyBpIDwgMzsgaSsrLCBjdXJfYWRkcisrKQotCQl3cml0ZWIodG1wW2ldLCBz
cGVjLT5tZW1fYmFzZSArIGFkZHJbY3VyX2FkZHJdKTsKKwkJY2EwMTMyX21taW9fd3JpdGViKGNv
ZGVjLCB0bXBbaV0sIHNwZWMtPm1lbV9iYXNlICsgYWRkcltjdXJfYWRkcl0pOwogCiAJLyoKIAkg
KiBGaXJzdCB3cml0ZXMgYXJlIGluIHNpbmdsZSBieXRlcywgZmluYWwgYXJlIGluIDQgYnl0ZXMu
IFNvLCB3ZSB1c2UKIAkgKiB3cml0ZWIsIHRoZW4gd3JpdGVsLgogCSAqLwogCWZvciAoaSA9IDA7
IGN1cl9hZGRyIDwgMTI7IGkrKywgY3VyX2FkZHIrKykKLQkJd3JpdGViKGRhdGFbaV0sIHNwZWMt
Pm1lbV9iYXNlICsgYWRkcltjdXJfYWRkcl0pOworCQljYTAxMzJfbW1pb193cml0ZWIoY29kZWMs
IGRhdGFbaV0sIHNwZWMtPm1lbV9iYXNlICsgYWRkcltjdXJfYWRkcl0pOwogCiAJZm9yICg7IGN1
cl9hZGRyIDwgY291bnQ7IGkrKywgY3VyX2FkZHIrKykKLQkJd3JpdGVsKGRhdGFbaV0sIHNwZWMt
Pm1lbV9iYXNlICsgYWRkcltjdXJfYWRkcl0pOworCQljYTAxMzJfbW1pb193cml0ZWwoY29kZWMs
IGRhdGFbaV0sIHNwZWMtPm1lbV9iYXNlICsgYWRkcltjdXJfYWRkcl0pOwogCi0Jd3JpdGVsKDB4
MDA4MDAwMDEsIHNwZWMtPm1lbV9iYXNlICsgMHgyMGMpOworCWNhMDEzMl9tbWlvX3dyaXRlbChj
b2RlYywgMHgwMDgwMDAwMSwgc3BlYy0+bWVtX2Jhc2UgKyAweDIwYyk7CiAKIAlpZiAoY2EwMTMy
X3F1aXJrKHNwZWMpID09IFFVSVJLX0FFNykgewogCQljYTAxMTNfbW1pb19jb21tYW5kX3NldF90
eXBlMihjb2RlYywgMHg0OCwgMHgwNywgMHg4Myk7Cg==
--000000000000e40bf6065d17487a--

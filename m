Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0549C4DE
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304653; cv=pass; b=I3/qXaXi0dS7ULZlvPywKqzt8ED4iZvnDGBM8bdzrOo2SLhKeAMrEUV00qzz8fXPjygL++DnbuyF1jzmV4YaxsvLBGwRceyHUrUBW721gGuXm58wXoxBJfziRv9k5gD/ZwC6N2f71vnEs3uNond5piGWeZhthwaSIC8tx7uGTc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304653; c=relaxed/simple;
	bh=23GE1//HToMw9BjSOTu4Uf9FoVBIUTHZpdiz7HmOaR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V10DMDakJLzdmQVn1FquHAx+SNHb0VFpX2ACnfN+/QfY2pNTvoYFj89HXaQksVXypwHY0fiWLdqIj8p+IW4cavawAXPZv0x4aeulNVMWUjc1Yfe/9iQ+5qBM6masd26nnedd1INQN12tcfa+6tKHFUmC4BPvm5hwunKU40gMlDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgUI3Iw9; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgUI3Iw9"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3511800bbe7so277579eec.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 09:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791304651; cv=none;
        d=google.com; s=arc-20260327;
        b=PRE7dF2IXKmDhjGP3UUPmKxyA1p7dI4B/T6Ph84sTLvYSqra8Qt2v3QDBULirNsCzr
         mxnEJJqEcnQ8dCaVMsjACCisK23UOjtBu/373CPF6s9vfADJRfqNRqcfC0EDfNAWfQxd
         rtd/w397HX4Q9saZkfeIUo9qZLzXGhU7QeD3bxD1/4HZAZbIaN/18yIF7iLnEqKmz9zk
         E1bAU+u0Ok9CpHEhAcah8DAAMZOkSes/aVs5IXLd8ONKOAvyn10/iQQnerau8HnNP482
         zWvDrkLj815FbLs2n5WinzGEIHbpcqINv6tZZbSWBg+IyQNbDfUqU4jZeqbCdVZ5sWm3
         dq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3SsWHI7CKVsQNG4RpYPJ3G/TaNahQqmd6cNGHFfokw=;
        fh=k2dV6L8K2MOD9O8JXSknJWzRsX08IzdJhRJ/muJfS0g=;
        b=S4NRNnlzGPiD4q0U/9JK4LLTR0imzoGFf5ePkR1902/b0Z472nqVkUd9u+1clv0x8X
         bHvukXZRxN8Fg/+uVFKEdq62kKggCmQOhQ+MNNIFiL/e3uFbNguuwq7FsXCH9yBQuUJ0
         ImKjhRmh195sAWDMG8QfYr0hN/4dZzYqGL3Uw+WH/cCpkChcBMFCY3nnG+YLj/aMXy74
         5ijXsBDn1xmghpoSmXUFPPtt5BpXPzpgs/6F+y6EzlU/yWLwOLQ+JpM8qzLXc+6DN+N0
         CW91Y48WIy0ZC20jmTKspI83mKQmH3BuUwrykZJYlTeG/bL3lwJV0Y3A+FLRqvyDwiH1
         WhSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791304651; x=1791909451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3SsWHI7CKVsQNG4RpYPJ3G/TaNahQqmd6cNGHFfokw=;
        b=OgUI3Iw9y2y4mi9TCEzAwj9uft9i2EhVIFYX48Kb/DGGuv4nMMiMmh81F9SU7F/Lbp
         yoPLrPk8IRhyGQd7abmE1wTphgDKq6Pq3YeYmC0iLwq/v2kS5I85ovETGPetUav9AIfD
         WwPwOzIPoadJ8yb7rO0M1B7wCKVY6mVvhoy9ZEqOSlvL2+gxr6nX95M7DpUZnslbPEL5
         tPmnpGgfhTV6CxFB+uEn5NvhJ9I6vcWIoKHCsdcaydMh6SDNjtKArQsXkweEj99rfup6
         Swclr2OchPLvep2xNzvzAHtfOGxxImcJbWYUH7peWjyih/aHbwi8d2fY7Kr/sDcxQZeQ
         9emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791304651; x=1791909451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3SsWHI7CKVsQNG4RpYPJ3G/TaNahQqmd6cNGHFfokw=;
        b=NzeIwKWiRvI1zdAk3313iumuGa5u3NBAYKtAfL1PfXYp//6pF9kfFLovEGr84AV2SO
         yKU6zSL5QLBZ2DgncXl4Br2MelbgAbJ9Y8R6dcfeIDRlYr9UvPDVvbcN3Rw1NA8ZUmQg
         sIkOexgyqJNDNEkv3fW8lS15JksepgN3Lq6jMMh5xpeYcBUiYDCHGYqJkavlKp66DiNx
         UF8M7xuDbZ8pjY8NrFFdm/EHxpymfLz6KQ4PCVseW4Wv7mjq3jd3B53ktoaPHivQkBUq
         UVzNjpT5Arb0rR1MNVTc4FUuR5F9dvfCfX9dhWU4jyJvTD3dOs6hApB/+HtKkdGWBpNJ
         tPrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXK6rkvUgJ7DaDlPZbPDZXMkkUi4DGycztFZCpD7XIyCoIbT2rYVzziIK46oopJbak3hW75c+tvNE=@vger.kernel.org
X-Gm-Message-State: AFuF++lUZmQWWxBYplYsVD3eshdrm+1x8jgGbFomxB+16IG1ZjKYfIY/
	Yw8jqoVOtnih63Fvb8439neXbs6OkTLyB5dtu7QzpKUi3ieDl+6WWbmpBUZ83guKbAOEp1Nwo/e
	GlpAJFg92JUVQOqolUrO5VaBi/I7Grro=
X-Gm-Gg: AYBFou16kehdxCF0T7DKCmN7x0tzpAH9uGKVvlwez8ZM25dpyBF3ANT2fDo5dREfcYj
	jcumVPH8V++CiT7ObwnAq+W+9S7djk1/LAvJqydTr1zfBJAh11SW4GhFZkiaK1P5cAvWAGQBMSO
	1X5Yz3muydEL/ZNMCIdZaYLHfPkr8AMcVEalNON5VhpKBwGoMfkn736BRr+ZRU+L1iV3Zulk41t
	LVyzeS0nafSvd621dF/qdB1wxVTgNfnXQkJrzs5bF2ocC2MjrhG3SA9AjdaIBnOfTk/fEZ1yiMh
	+GnXke48FAUcqeMV3QU4TPvXGTJRc+B9UWxVQJRX5R2LXsROlh7R3GgsCc0zT9bKMKoi50CqWSN
	TV4dSXOFa2W52PCu6bay2hhG8+M25vghv+tyj25XqiA==
X-Received: by 2002:a05:701b:2516:b0:144:ff51:2d73 with SMTP id
 a92af1059eb24-14f5b11e751mr26261761c88.2.1791304650585; Tue, 06 Oct 2026
 09:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
 <20261005231914.GA639967@bhelgaas>
In-Reply-To: <20261005231914.GA639967@bhelgaas>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Oct 2026 12:37:18 -0400
X-Gm-Features: AclHuK-BIaWcWgCEtEbjE0ty4LupnIxIkwW2Z1OGfGkwHjdyvUjnPWl3akWUrI4
Message-ID: <CADnq5_O2TWeWEE1NsuCVvtWLKWyOiJHChPGP9CN4Zu=hvs+jmA@mail.gmail.com>
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Perlow, Jason" <jperlow@gmail.com>, Lukas Wunner <lukas@wunner.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Aditya Garg <aditya.garg@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 7:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Alex]
>
> On Mon, Oct 05, 2026 at 01:53:55PM -0400, Perlow, Jason wrote:
> > Hi Lukas, Bjorn,
> >
> > Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
> > Errors"), first in v7.3-rc1, an Apple MacBookPro16,1 (T2 chip) loses
> > power 17 to 24 s after boot. v7.2.9 is fine; v7.3-rc5 and v7.3-rc6 are
> > not. Bisection lands on that commit, and v7.3-rc6 with only that
> > commit reverted no longer powers off. aer.c has not changed since, as
> > of v7.3-rc6-3, so I expect it is still unfixed; I did not find an
> > existing report.
>
> Alex reported something similar at
> https://bugzilla.kernel.org/show_bug.cgi?id=3D222095.
>
> Can you try the experiment mentioned there?  The patches Lukas
> mentioned don't apply cleanly on v7.3-rc1, but the conflict looks
> trivial?

Lukas' patches fixes some boards, but unfortunately, I'm still seeing
failures on others.  Reverting the patch fixes those failures.  I've
updated the ticket.

Alex

>
> > Hardware
> > --------
> >
> > MacBookPro16,1 with an AMD Navi 14 dGPU and the Apple T2. The bisect
> > machine has a Core i7-9750H; a second unit of the same model, used for
> > cross-checks, has a Core i9-9980HK. I have not tested any other T2
> > model. The internal SSD, the T2 and the audio device are functions of
> > one Apple PCIe device behind root port 00:1b.0:
> >
> >   04:00.0 Apple ANS2 NVMe          [106b:2005]
> >   04:00.1 Apple T2 Bridge          [106b:1801]
> >   04:00.2 Apple T2 Secure Enclave  [106b:1802]
> >   04:00.3 Apple Audio Device       [106b:1803]
> >
> > Symptom
> > -------
> >
> > The machine powers off abruptly 17 to 24 s after boot. There is no
> > shutdown sequence; the previous boot's journal simply ends. Nothing is
> > logged beforehand: no AER message, no oops, no lockup, no thermal
> > event. The T2 controls power on these machines, so I assume (but
> > cannot show) that the T2/SMC removes power.
> >
> > Bisect
> > ------
> >
> > v7.2.9 good, v7.3-rc5 bad. Vanilla mainline trees, no out-of-tree
> > patches in the kernel image, CONFIG_PCIEAER=3Dy,
> > CONFIG_ACPI_APEI_GHES=3Dy, kernel messages captured over the network.
> > 19 steps, 4 skipped because those trees oops early for an unrelated
> > reason (the ones I looked at were in thunderbolt icm_probe at about
> > 5 s). Good boots were watched for 55.8 to 69.7 s; bad boots stopped
> > logging between 17.9 and 24.1 s. The complete history, every commit
> > tested and every result, is in Appendix B, and the exact method in
> > Appendix A. The result:
> >
> >   # first bad commit: [eddba19b8b5f] PCI/AER: Support Advisory
> >   # Non-Fatal Errors
> >
> > Revert test, v7.3-rc6, same config:
> >
> >   v7.3-rc6 unmodified:            powers off at 16.7 s
> >   only eddba19b8b5f reverted:     survives the full 64 s capture
> >
> > With that revert on top of 7.3.0-rc6 plus the out-of-tree t2linux
> > series (one kernel image, built once), a normal desktop runs on both
> > MacBookPro16,1 units: the second one has been up for more than 45
> > minutes, and the bisect machine ran sessions of 32 and 22 minutes.
> > For completeness: the bisect machine once lost power after about 10
> > minutes while I was manually switching the display mux and powering
> > off the AMD GPU, which I do not expect the firmware to support. I
> > have not established the cause and have no evidence either way on
> > whether it is related.
> >
> > Which devices are affected
> > --------------------------
> >
> > On v7.2.9, where the Advisory Non-Fatal Error bit is still masked, the
> > Correctable Error Status register has AdvNonFatalErr latched on
> > exactly these functions, with every Uncorrectable Error Status
> > register clear:
> >
> >   04:00.0 04:00.1 04:00.2 04:00.3  (the Apple device above)
> >   01:00.0 AMD Navi 10 XL PCIe switch upstream port [1002:1478]
> >
> > The pattern is identical on both MacBookPro16,1 units (same model, so
> > this says nothing about other T2 models). The Titan Ridge 4C bridges
> > and NHI on the same machine do not have the bit set.
> > These devices report the advisory bit without any matching
> > Uncorrectable Error status, which looks like the "non-compliant
> > products" case the commit message mentions.
> >
> > Only one of the two machines was used for the bisect and the
> > power-off tests above. I have not yet booted an unreverted 7.3 kernel
> > on the second one, so I cannot yet say that the power-off reproduces
> > there.
> >
> > Control: an ASUS ROG Zephyrus M15 GU502LV (i7-10750H, RTX 2060, no
> > T2) has the same bit latched on its NVIDIA TU106 functions
> > [10de:10f9, 10de:1ada, 10de:1adb] and on Titan Ridge 2C [8086:15e7,
> > 8086:15e8, 8086:15e9]. It ran a 7.3.0-rc6 build with the commit
> > applied (plus the t2linux series) for more than 15 hours without a
> > problem, and the same reverted kernel image as above also runs on it
> > normally. So unmasking the bit is not harmful in general; something
> > specific to the T2 platform is.
> >
> > What I do not know
> > ------------------
> >
> > Which device triggers the power-off, and why. My guess, and it is
> > only a guess: treating a possible Advisory Non-Fatal Error as
> > non-Advisory and recovering through the uncorrectable path resets or
> > disturbs a T2 function, and the T2 then powers the machine down. I
> > intend to build a diagnostic kernel that can leave the bit masked per
> > device to find out which one.
> >
> > Possibly related, different symptom: "PCI/portdev: Disable AER for
> > Titan Ridge 4C 2018" (Atharva Tiwari, January 2026) concerned AER
> > warnings on T2 iMacs.
> >
> > What I am asking
> > ----------------
> >
> > Which direction would you prefer: a revert, or a quirk that keeps
> > Advisory Non-Fatal Errors masked on the affected Apple functions (and
> > possibly the AMD switch port)? The t2linux project carries a revert
> > for now: https://github.com/t2linux/linux-t2-patches/pull/70
> >
> > I can test patches on real hardware and can provide full lspci -vvv
> > output, the complete bisect log and the captured boot logs.
> >
> > #regzbot introduced: eddba19b8b5f76d57424ee328a68fd495c5db857
> >
> > Thanks,
> > Jason Perlow
> >
> >
> > APPENDIX A - METHOD
> >
> > Machine: one MacBookPro16,1 for every boot below, running a Debian
> > trixie userland from its internal SSD. The distribution's 7.2.9 kernel
> > was the default boot entry between tests.
> >
> > Build: git bisect in a clone of torvalds/linux (git.kernel.org). Each
> > candidate was built on a separate x86-64 build host (16 threads, gcc
> > 15.2.0, binutils 2.46) with the same recipe:
> >
> >   cp bisect-trimmed.config .config
> >   make olddefconfig
> >   make -j10 bindeb-pkg LOCALVERSION=3D-bisN-vanilla-rc0 \
> >        KDEB_PKGVERSION=3D<release>-1
> >
> > bisect-trimmed.config is a 7.3.0-rc5 configuration trimmed to build
> > quickly (2068 options built in, 204 modules). It has CONFIG_PCIEAER=3Dy=
,
> > CONFIG_PCIE_DPC=3Dy, CONFIG_PCIEASPM=3Dy, CONFIG_ACPI_APEI=3Dy and
> > CONFIG_ACPI_APEI_GHES=3Dy. The same file was used for all 19 steps and
> > for both v7.3-rc6 tests. No out-of-tree patches were applied to the
> > kernel. The release strings come from each tree's Makefile, so commits
> > on 7.2-based topic branches show as 7.2.0.
> >
> > Boot: the .deb packages were installed on the laptop and booted through
> > a one-shot rEFInd entry; the default entry stayed the stable kernel.
> > Kernel command line for every test boot:
> >
> >   console=3Dtty0 ignore_loglevel keep_bootcon initcall_debug
> >   printk.time=3D1 log_buf_len=3D16M panic=3D0 fbcon=3Dfont:TER16x32
> >   systemd.show_status=3D1 systemd.unit=3Dmulti-user.target
> >   modprobe.blacklist=3Dsbs,sbshc
> >   systemd.mask=3Dncz-usb2-rescan.service
> >   systemd.wants=3Dncz-netlog.service
> >
> > (plus the root=3D options). So there was no graphical session. sbs and
> > sbshc are the ACPI smart battery drivers; ncz-usb2-rescan is an
> > unrelated distribution boot workaround. Steps 13 to 19 and the two
> > v7.3-rc6 tests also had module_blacklist=3Dthunderbolt,t2thunderbolt,
> > added after the early oopses (in thunderbolt icm_probe, at about 5 s)
> > had cost several skipped steps. Steps 1 to 12 ran with Thunderbolt
> > enabled.
> >
> > Capture: a small userspace unit (ncz-netlog.service) streams /dev/kmsg
> > and the journal over TCP to a second machine from early multi-user
> > boot, so captures begin at roughly 10 s of uptime. Each capture file
> > records the uptime of its last line.
> >
> > Verdicts:
> >   good: the machine kept running and logging past the point where bad
> >         kernels die (the cut always came before 25 s).
> >   bad:  the capture stops before 45 s, the machine stays unreachable
> >         for at least 60 s, and the next boot's journal shows the
> >         previous boot ending with no clean shutdown.
> >   skip: a kernel oops or panic in the capture or the previous boot's
> >         journal.
> >
> > After a cut the laptop does not restart by itself, so it was powered
> > on by hand and booted the stable kernel; the verdict was then confirmed
> > from the previous boot's journal.
> >
> > Caveats:
> >   - One machine was used for the bisect and for the power-off tests.
> >   - No desktop session was running.
> >   - sbs/sbshc were blocked on every boot, and Thunderbolt from step 13
> >     on.
> >   - The laptop was powered from, and networked through, a Thunderbolt
> >     dock during the bisect. An earlier test of a T2-patched
> >     7.3.0-rc5 kernel with the dock unplugged also lost power, but I
> >     did not repeat the bisect undocked.
> >   - Out-of-tree DKMS modules for the T2 hardware (t2smc, t2gmux,
> >     t2smp, t2thunderbolt) were installed for these kernels and may
> >     have been loaded, which would taint them. An earlier test with
> >     those modules blocked still lost power.
> >   - Step 12 ran 816 s before an unrelated oops, so it did not show
> >     the cut and was treated as a skip rather than as good; this does
> >     not change the result.
> >   - The device that triggers the cut is not identified.
> >
> > APPENDIX B - FULL BISECT HISTORY
> >
> > Good: v7.2.9 (5fce161649b4). Bad: v7.3-rc5 (72d3fcf802c4). The first
> > commit tested is the merge base, "Linux 7.2". Observed =3D uptime of th=
e
> > last line captured. Results: 8 good, 7 bad, 4 skip.
> >
> >  #  commit        result observed   subject
> >  1  8d3ae59288f1  good   55.8 s     Linux 7.2
> >  2  56ea4e86832d  good   67.7 s     nstree: check listing permission
> >                                     before taking a namespace ref
> >  3  93e4b3076b5f  bad    24.1 s     Merge tag 'char-misc-7.3-rc1'
> >  4  21bd0802cd3f  good   60.1 s     Merge tag 'for-linus' (rdma)
> >  5  0b0e645ed2c8  bad    22.9 s     Merge tag 'auxdisplay-v7.3-1'
> >  6  e5f92606156a  good   69.5 s     Merge tag 'mm-nonmm-stable-2026-08-
> >                                     22-16-57'
> >  7  b6b019a1d9b9  good   69.2 s     Merge tag 'parisc-for-7.3-rc1'
> >  8  b130a2caf5d3  skip   oops 5.3 s Merge branch
> >                                     'pci/controller/tegra264'
> >  9  455b454c87bb  good   69.0 s     i3c: mipi-i3c-hci: Add support for
> >                                     AMD_PT I3C controller
> > 10  9bb52aa1972d  skip   oops 5.5 s Merge branch
> >                                     'pci/controller/dwc-meson'
> > 11  b4b07fb82b9e  skip   oops 5.3 s Merge branch 'pci/wake'
> > 12  651fb94aaf24  skip   oops 816 s alpha/PCI: Fix I/O port accessor
> >                                     argument order in
> >                                     pci_legacy_write()
> > 13  625ae0ff41e5  bad    19.9 s     Merge branch 'pci/dt-binding'
> > 14  9f91b2b716a0  bad    19.1 s     Merge branch 'pci/procfs'
> > 15  ea55835bc538  bad    23.3 s     Merge branch 'pci/dpc'
> > 16  d358e9ad15c2  bad    22.3 s     Merge branch 'pci/aer'
> > 17  8446e1147f65  good   69.7 s     PCI/AER: Deduplicate logging of
> >                                     Error Source Identification
> > 18  f141f74c45c6  good   67.6 s     PCI/AER: Move retrieval of FEP and
> >                                     TLP Log into helper
> > 19  eddba19b8b5f  bad    17.9 s     PCI/AER: Support Advisory
> >                                     Non-Fatal Errors
> >
> > Full hashes of the decisive steps:
> >   eddba19b8b5f76d57424ee328a68fd495c5db857  (first bad)
> >   f141f74c45c6f774eebdb7e45bd609be5122bfa8  (last good before it)
> >   8446e1147f65563d374ffa54dc3ba81adb1342c5
> >
> > The v7.3-rc6 tests (a90ee4305c4a) used the same recipe and command line=
:
> > unmodified, power off at 16.7 s; with only eddba19b8b5f reverted,
> > survived the full 64 s capture.
> >
> > --
> > Jason

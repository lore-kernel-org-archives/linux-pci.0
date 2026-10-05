Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C664DA9A0
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225477; cv=pass; b=RACf2VNtgdagamTVOjP6gPKPEjCH/Ibh4mjrCAcY5piML1HvjcpmFsJGy5fRM/QsPox3jnTEDihs2Pgailqi41Ykf88lbEfWkcdnOxfHlvIlsKnVlbk7Y3Di4ZWE7Me4ZgW0T+O+w55xN3yVKoGzdtkqnKmX1/5G2HtwFjT3Tlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225477; c=relaxed/simple;
	bh=TRxWNGFhdqQpfPO5v46Kexu45qU4McKCASsfdcBOpnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfOw5O+i/+d0L0RxETZOIr5y966X5UaeFU21QQKEPinIp6rKINCp72V6oHE81dbQ0vobmiFLKpoELEl1x/1h/XDKcUYSzOb8/B1NyOz/spKNIuZRZl4XBTdVCTReesdu9vmO58McbVgYUMSWCC0cSvw3kGoiK77rJulnJyK1pYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMIbriL/; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMIbriL/"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-1438cb9b3a3so1870370c88.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 11:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791225473; cv=none;
        d=google.com; s=arc-20260327;
        b=JmdCfBy938oWaRAbp/AzFpi0u9f+dgE+e7yGpCc4IfeUfz0ISLbWrYoxazUqBccJck
         yeM9vJz3bQAxgB91j9rLDr2VtVxxQqOC1fs5oaRjTEKXXwGHOlqI8FzkIdergj5QVIaV
         tplakPz98W2fT+LQgVgSYP155W2iWGQmYdi30khayAu9yK1Dygy28bwPnUU2FhYtuIDA
         Mktxc7rEf7218iik1QS+wz/fzsHYyMAQcxOei305zYzpOFRC7SFpU45V6AH50kuH/8oS
         pyp6tOfTGAkCgK3A1F9IDNMxCKxGMSTEB4aOYbO9roMZxS+u6BGHrL9MWjVBrNZQozQ8
         cCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hQlAwXEHFQ9S4vHabSWS5zY7cMkoUtpZoiB4ZpGvqWA=;
        fh=c6UZfEaxe5FWo2bunruNy2Xqg9hAtjPQfHgmIaXvpj0=;
        b=M2ci+v3yE5FDJPjvfdFm4allyoSS6SLbKwE1Q2UF/4RVuyT9cxfVU0Dnjq9+2jJdhs
         lTPPFonM0Pb+X24hjO6VTVyfO5cpHp+2vLooKjZTnLPZ+nw1+6RT91x36+zAK61DX1ux
         8PJHGJf7atmxTdixj6ft7QoqCb9xDwiS6BHVOnuVrBM+87fleKxEEHZRpdssjFc5rO7K
         +baFBB/pxpN+oPqBmzaLazmlzDg4POfdpfvpVGqAuf9+6eWZACNGGcY47O2NyFnTGKAP
         qfnPck2hq468V28s9bd54odTEqN9MQ02nUyLE+0uQQUFB23Xj0SUffXn9u84FOSgD7VL
         CkQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791225473; x=1791830273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hQlAwXEHFQ9S4vHabSWS5zY7cMkoUtpZoiB4ZpGvqWA=;
        b=OMIbriL/bZy9sa873iuoXrFabWDUuXstkrd/KEQdJA0OZP+mlNBoIVvL7H6cYaKKXY
         3B7/4YCs/7k/JbRCTee6IrjEFMJYv9NxBzOCgntyPvCk5RU45dUX3eUhpRbKyyfduJ9c
         rhN823F/AxzPRBGHQ9NvEoep0X3PQ+RhFp2k7oZdbPzRmMxLaXpVmQCDimcs4dCd7QRp
         Zrstxp8GvX/UM4V4+k0q9sdKpIrsfXXSW2UX23OQqvBMPu4smm4QEq5nOILOdNt6kkHV
         HH+48Tcn4hagvSJn3OSbNNEFFchCtT6iA0linEPKrDLHyjTjjVd4JZ9qiPqH3mXRK+EA
         0Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791225473; x=1791830273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hQlAwXEHFQ9S4vHabSWS5zY7cMkoUtpZoiB4ZpGvqWA=;
        b=X94xwu7HrvbTQUYgWsmXPh9p6bNkhey3jL44IxnSGJnR+DvctmWL1K1LzcwUYgfZ0j
         UdFtOEKZQPbEbmdxiSdgWsfFI2qdqWHasFmWmezI+phonP2qASCFgxMURSe5rb8/7I6L
         fUWUaZmY9aCoE1lW8yobCdaO7ECu/Y89M5NVgDSV5pEw2JnMWyt2BFzT8TqjnhW6jny+
         8LE3wag//49SqP79EJ4M+UbfX3vFUDvtTetRofNmTkNJQztjSzLbqSNaSUYFX4FJFfyh
         ogOkA/2eEKbk06CyA8peNxd4R1vC0J61P6LEVFuLOSjIIAECx8NCLfCdLGU9S6B+vQGI
         l81A==
X-Gm-Message-State: AFuF++mxTbQO9XOTHgCzQ5Fl95+z8yHIESDdB1Bxe9w0IEwYkeLn4HkV
	r7szLeymG3o7/ekilqP2iriPb7tYqZz5lz1HQVdwNg0cHMBBmvsG7QFGJDlWzIIoyauVZzPKw8W
	3replSjhDVNyIojB3UEJl1mr2XrZXEDA=
X-Gm-Gg: AYBFou2sYE2d78Q2DyQBGe8Ey3OzlChXjHEMjxvHpTkUPm7ylaAcOyGyyIMQs1f/ru7
	/pyDUXISt6H7S1sAvwqSWOMqMet5sYhS/jc7Ch98pA6uQQ6RLhJC9qrsMNVpbnrwd0UCE4GMo06
	9BfOBl69esevq/rbpE8atZ2RTCgJAMEZ5SZPJhZalVWipodZWLR2mP43/+QVyhGVt2y1t4fJIA7
	045uoOxr4JEOtY2AtVlFjxKxbSOZ+/LjKixS9KrqcA97fff5MAM4vt4bGD/iFPusP7zrI/tP/sK
	BeosqhxmXd0k7avVpidMf8KaQx0xOpYKbZVvt5jLFsPPNgtvClvp97IPFsfq5HGpjr8FnNieqNT
	aBIZKFEKsGQZ8BoSWOkENHX4f3v/dF8ayfmydrp+3fcr74iSHR8Erjl6uCh9YzDAu0w1JfYVXxW
	7Ci6SycluMxMmTPHUIZRF7mxZYMQyArDE=
X-Received: by 2002:a05:7023:b84:b0:14a:5284:1bf5 with SMTP id
 a92af1059eb24-14f5b9fd404mr18332616c88.13.1791225472710; Mon, 05 Oct 2026
 11:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
In-Reply-To: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Mon, 5 Oct 2026 14:37:38 -0400
X-Gm-Features: AclHuK_CcX3L73EjkzAgLR0Rz_ApNrzl0SBmsWs0SCnQ38SLSykgSI5uaAveYEw
Message-ID: <CABZrw2FEsTL=qkFyrRbyET6-7ZvEu6-p8KS=4fH95vGQ2A0f1A@mail.gmail.com>
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, Aditya Garg <aditya.garg@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Follow-up: the trigger is one device, the T2 Secure Enclave function
(106b:1802, 04:00.2).

To find which device matters I built a diagnostic kernel on v7.3-rc6
(same config and recipe as the bisect, no revert). It adds a boot
parameter, aer_anfe_skip=3D<list>, that leaves the Advisory Non-Fatal
bit masked on the listed devices (a BDF, a vendor:device pair, or
"all") and logs one line per device at unmask time. Without the
parameter it behaves as v7.3-rc6 does.

Each boot ran on the same MacBookPro16,1, with kernel messages
streamed over the network. A cut means the machine powered off with
no clean shutdown; every cut so far has come before 27 s.

 #  masked (skipped)                      result
 1  all five functions that latch it      survived
 2  04:00.0 04:00.1 04:00.2 04:00.3       survived, 343 s
    (the four Apple functions only;
    the AMD switch port 01:00.0 unmasked)
 3  04:00.0 04:00.1 only                  powered off at 14 s
    (NVMe and T2 Bridge; Enclave and
    Audio unmasked)
 4  04:00.2 only (106b:1802)              survived, 120 s

So the AMD switch port is not involved. Test 3 cuts with the Enclave
and Audio unmasked, and test 4 survives with Audio still unmasked, so
unmasking the bit on 04:00.2 alone is what triggers the power-off.
Each case was run once; I can repeat them if that would help.

I still do not know why the T2 reacts. No AER message is logged before
the cut, and the Uncorrectable Error Status of that function is clear,
so this is only about the Correctable path that the commit enables.

Since the bit is only wrong on this one function, a quirk may be
better than a revert: keep Advisory Non-Fatal Errors masked on Apple
106b:1802, for example with a DECLARE_PCI_FIXUP_EARLY entry that makes
pci_aer_init() leave the mask alone. I am happy to write and test
that patch on both of my T2 machines if you tell me which form you
prefer (a quirk flag in the PCI core, or a device-specific fixup).

The diagnostic patch, the lspci -vvv output and the captured boot
logs are available on request.

Thanks,
Jason Perlow

On Mon, Oct 5, 2026 at 1:53=E2=80=AFPM Perlow, Jason <jperlow@gmail.com> wr=
ote:
>
> Hi Lukas, Bjorn,
>
> Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
> Errors"), first in v7.3-rc1, an Apple MacBookPro16,1 (T2 chip) loses
> power 17 to 24 s after boot. v7.2.9 is fine; v7.3-rc5 and v7.3-rc6 are
> not. Bisection lands on that commit, and v7.3-rc6 with only that
> commit reverted no longer powers off. aer.c has not changed since, as
> of v7.3-rc6-3, so I expect it is still unfixed; I did not find an
> existing report.
>
> Hardware
> --------
>
> MacBookPro16,1 with an AMD Navi 14 dGPU and the Apple T2. The bisect
> machine has a Core i7-9750H; a second unit of the same model, used for
> cross-checks, has a Core i9-9980HK. I have not tested any other T2
> model. The internal SSD, the T2 and the audio device are functions of
> one Apple PCIe device behind root port 00:1b.0:
>
>   04:00.0 Apple ANS2 NVMe          [106b:2005]
>   04:00.1 Apple T2 Bridge          [106b:1801]
>   04:00.2 Apple T2 Secure Enclave  [106b:1802]
>   04:00.3 Apple Audio Device       [106b:1803]
>
> Symptom
> -------
>
> The machine powers off abruptly 17 to 24 s after boot. There is no
> shutdown sequence; the previous boot's journal simply ends. Nothing is
> logged beforehand: no AER message, no oops, no lockup, no thermal
> event. The T2 controls power on these machines, so I assume (but
> cannot show) that the T2/SMC removes power.
>
> Bisect
> ------
>
> v7.2.9 good, v7.3-rc5 bad. Vanilla mainline trees, no out-of-tree
> patches in the kernel image, CONFIG_PCIEAER=3Dy,
> CONFIG_ACPI_APEI_GHES=3Dy, kernel messages captured over the network.
> 19 steps, 4 skipped because those trees oops early for an unrelated
> reason (the ones I looked at were in thunderbolt icm_probe at about
> 5 s). Good boots were watched for 55.8 to 69.7 s; bad boots stopped
> logging between 17.9 and 24.1 s. The complete history, every commit
> tested and every result, is in Appendix B, and the exact method in
> Appendix A. The result:
>
>   # first bad commit: [eddba19b8b5f] PCI/AER: Support Advisory
>   # Non-Fatal Errors
>
> Revert test, v7.3-rc6, same config:
>
>   v7.3-rc6 unmodified:            powers off at 16.7 s
>   only eddba19b8b5f reverted:     survives the full 64 s capture
>
> With that revert on top of 7.3.0-rc6 plus the out-of-tree t2linux
> series (one kernel image, built once), a normal desktop runs on both
> MacBookPro16,1 units: the second one has been up for more than 45
> minutes, and the bisect machine ran sessions of 32 and 22 minutes.
> For completeness: the bisect machine once lost power after about 10
> minutes while I was manually switching the display mux and powering
> off the AMD GPU, which I do not expect the firmware to support. I
> have not established the cause and have no evidence either way on
> whether it is related.
>
> Which devices are affected
> --------------------------
>
> On v7.2.9, where the Advisory Non-Fatal Error bit is still masked, the
> Correctable Error Status register has AdvNonFatalErr latched on
> exactly these functions, with every Uncorrectable Error Status
> register clear:
>
>   04:00.0 04:00.1 04:00.2 04:00.3  (the Apple device above)
>   01:00.0 AMD Navi 10 XL PCIe switch upstream port [1002:1478]
>
> The pattern is identical on both MacBookPro16,1 units (same model, so
> this says nothing about other T2 models). The Titan Ridge 4C bridges
> and NHI on the same machine do not have the bit set.
> These devices report the advisory bit without any matching
> Uncorrectable Error status, which looks like the "non-compliant
> products" case the commit message mentions.
>
> Only one of the two machines was used for the bisect and the
> power-off tests above. I have not yet booted an unreverted 7.3 kernel
> on the second one, so I cannot yet say that the power-off reproduces
> there.
>
> Control: an ASUS ROG Zephyrus M15 GU502LV (i7-10750H, RTX 2060, no
> T2) has the same bit latched on its NVIDIA TU106 functions
> [10de:10f9, 10de:1ada, 10de:1adb] and on Titan Ridge 2C [8086:15e7,
> 8086:15e8, 8086:15e9]. It ran a 7.3.0-rc6 build with the commit
> applied (plus the t2linux series) for more than 15 hours without a
> problem, and the same reverted kernel image as above also runs on it
> normally. So unmasking the bit is not harmful in general; something
> specific to the T2 platform is.
>
> What I do not know
> ------------------
>
> Which device triggers the power-off, and why. My guess, and it is
> only a guess: treating a possible Advisory Non-Fatal Error as
> non-Advisory and recovering through the uncorrectable path resets or
> disturbs a T2 function, and the T2 then powers the machine down. I
> intend to build a diagnostic kernel that can leave the bit masked per
> device to find out which one.
>
> Possibly related, different symptom: "PCI/portdev: Disable AER for
> Titan Ridge 4C 2018" (Atharva Tiwari, January 2026) concerned AER
> warnings on T2 iMacs.
>
> What I am asking
> ----------------
>
> Which direction would you prefer: a revert, or a quirk that keeps
> Advisory Non-Fatal Errors masked on the affected Apple functions (and
> possibly the AMD switch port)? The t2linux project carries a revert
> for now: https://github.com/t2linux/linux-t2-patches/pull/70
>
> I can test patches on real hardware and can provide full lspci -vvv
> output, the complete bisect log and the captured boot logs.
>
> #regzbot introduced: eddba19b8b5f76d57424ee328a68fd495c5db857
>
> Thanks,
> Jason Perlow
>
>
> APPENDIX A - METHOD
>
> Machine: one MacBookPro16,1 for every boot below, running a Debian
> trixie userland from its internal SSD. The distribution's 7.2.9 kernel
> was the default boot entry between tests.
>
> Build: git bisect in a clone of torvalds/linux (git.kernel.org). Each
> candidate was built on a separate x86-64 build host (16 threads, gcc
> 15.2.0, binutils 2.46) with the same recipe:
>
>   cp bisect-trimmed.config .config
>   make olddefconfig
>   make -j10 bindeb-pkg LOCALVERSION=3D-bisN-vanilla-rc0 \
>        KDEB_PKGVERSION=3D<release>-1
>
> bisect-trimmed.config is a 7.3.0-rc5 configuration trimmed to build
> quickly (2068 options built in, 204 modules). It has CONFIG_PCIEAER=3Dy,
> CONFIG_PCIE_DPC=3Dy, CONFIG_PCIEASPM=3Dy, CONFIG_ACPI_APEI=3Dy and
> CONFIG_ACPI_APEI_GHES=3Dy. The same file was used for all 19 steps and
> for both v7.3-rc6 tests. No out-of-tree patches were applied to the
> kernel. The release strings come from each tree's Makefile, so commits
> on 7.2-based topic branches show as 7.2.0.
>
> Boot: the .deb packages were installed on the laptop and booted through
> a one-shot rEFInd entry; the default entry stayed the stable kernel.
> Kernel command line for every test boot:
>
>   console=3Dtty0 ignore_loglevel keep_bootcon initcall_debug
>   printk.time=3D1 log_buf_len=3D16M panic=3D0 fbcon=3Dfont:TER16x32
>   systemd.show_status=3D1 systemd.unit=3Dmulti-user.target
>   modprobe.blacklist=3Dsbs,sbshc
>   systemd.mask=3Dncz-usb2-rescan.service
>   systemd.wants=3Dncz-netlog.service
>
> (plus the root=3D options). So there was no graphical session. sbs and
> sbshc are the ACPI smart battery drivers; ncz-usb2-rescan is an
> unrelated distribution boot workaround. Steps 13 to 19 and the two
> v7.3-rc6 tests also had module_blacklist=3Dthunderbolt,t2thunderbolt,
> added after the early oopses (in thunderbolt icm_probe, at about 5 s)
> had cost several skipped steps. Steps 1 to 12 ran with Thunderbolt
> enabled.
>
> Capture: a small userspace unit (ncz-netlog.service) streams /dev/kmsg
> and the journal over TCP to a second machine from early multi-user
> boot, so captures begin at roughly 10 s of uptime. Each capture file
> records the uptime of its last line.
>
> Verdicts:
>   good: the machine kept running and logging past the point where bad
>         kernels die (the cut always came before 25 s).
>   bad:  the capture stops before 45 s, the machine stays unreachable
>         for at least 60 s, and the next boot's journal shows the
>         previous boot ending with no clean shutdown.
>   skip: a kernel oops or panic in the capture or the previous boot's
>         journal.
>
> After a cut the laptop does not restart by itself, so it was powered
> on by hand and booted the stable kernel; the verdict was then confirmed
> from the previous boot's journal.
>
> Caveats:
>   - One machine was used for the bisect and for the power-off tests.
>   - No desktop session was running.
>   - sbs/sbshc were blocked on every boot, and Thunderbolt from step 13
>     on.
>   - The laptop was powered from, and networked through, a Thunderbolt
>     dock during the bisect. An earlier test of a T2-patched
>     7.3.0-rc5 kernel with the dock unplugged also lost power, but I
>     did not repeat the bisect undocked.
>   - Out-of-tree DKMS modules for the T2 hardware (t2smc, t2gmux,
>     t2smp, t2thunderbolt) were installed for these kernels and may
>     have been loaded, which would taint them. An earlier test with
>     those modules blocked still lost power.
>   - Step 12 ran 816 s before an unrelated oops, so it did not show
>     the cut and was treated as a skip rather than as good; this does
>     not change the result.
>   - The device that triggers the cut is not identified.
>
> APPENDIX B - FULL BISECT HISTORY
>
> Good: v7.2.9 (5fce161649b4). Bad: v7.3-rc5 (72d3fcf802c4). The first
> commit tested is the merge base, "Linux 7.2". Observed =3D uptime of the
> last line captured. Results: 8 good, 7 bad, 4 skip.
>
>  #  commit        result observed   subject
>  1  8d3ae59288f1  good   55.8 s     Linux 7.2
>  2  56ea4e86832d  good   67.7 s     nstree: check listing permission
>                                     before taking a namespace ref
>  3  93e4b3076b5f  bad    24.1 s     Merge tag 'char-misc-7.3-rc1'
>  4  21bd0802cd3f  good   60.1 s     Merge tag 'for-linus' (rdma)
>  5  0b0e645ed2c8  bad    22.9 s     Merge tag 'auxdisplay-v7.3-1'
>  6  e5f92606156a  good   69.5 s     Merge tag 'mm-nonmm-stable-2026-08-
>                                     22-16-57'
>  7  b6b019a1d9b9  good   69.2 s     Merge tag 'parisc-for-7.3-rc1'
>  8  b130a2caf5d3  skip   oops 5.3 s Merge branch
>                                     'pci/controller/tegra264'
>  9  455b454c87bb  good   69.0 s     i3c: mipi-i3c-hci: Add support for
>                                     AMD_PT I3C controller
> 10  9bb52aa1972d  skip   oops 5.5 s Merge branch
>                                     'pci/controller/dwc-meson'
> 11  b4b07fb82b9e  skip   oops 5.3 s Merge branch 'pci/wake'
> 12  651fb94aaf24  skip   oops 816 s alpha/PCI: Fix I/O port accessor
>                                     argument order in
>                                     pci_legacy_write()
> 13  625ae0ff41e5  bad    19.9 s     Merge branch 'pci/dt-binding'
> 14  9f91b2b716a0  bad    19.1 s     Merge branch 'pci/procfs'
> 15  ea55835bc538  bad    23.3 s     Merge branch 'pci/dpc'
> 16  d358e9ad15c2  bad    22.3 s     Merge branch 'pci/aer'
> 17  8446e1147f65  good   69.7 s     PCI/AER: Deduplicate logging of
>                                     Error Source Identification
> 18  f141f74c45c6  good   67.6 s     PCI/AER: Move retrieval of FEP and
>                                     TLP Log into helper
> 19  eddba19b8b5f  bad    17.9 s     PCI/AER: Support Advisory
>                                     Non-Fatal Errors
>
> Full hashes of the decisive steps:
>   eddba19b8b5f76d57424ee328a68fd495c5db857  (first bad)
>   f141f74c45c6f774eebdb7e45bd609be5122bfa8  (last good before it)
>   8446e1147f65563d374ffa54dc3ba81adb1342c5
>
> The v7.3-rc6 tests (a90ee4305c4a) used the same recipe and command line:
> unmodified, power off at 16.7 s; with only eddba19b8b5f reverted,
> survived the full 64 s capture.
>
> --
> Jason



--=20
Jason Perlow | Argonaut Media Communications

Voice/Text  (954) 242-3484 | jperlow@gmail.com | Blog: techbroiler.net
Read my Tech and Food Industry articles: https://linktr.ee/jperlow
Bluesky: https://bsky.app/profile/jperlow.bsky.social

Need to schedule a meeting with me? https://bit.ly/3y8P3Gp

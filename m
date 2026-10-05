Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6F4519A2;
	Mon,  5 Oct 2026 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791242360; cv=none; b=PX5nXGqnnsdAv2+f2Z0dXB2yknkRSbF9/j1ahLIDpbFND/km4PpRSLCCWnGlH4SihqlA0CJHsqHsm3XWbotgs0sAJoJfAEeD5kq0+WIuYYYm9MQ0cU7z4webd6d9W5Bw1DuuuHHaT5vlTLwIiBhxfzVbEd6UdYyBS5F5Oy+q0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791242360; c=relaxed/simple;
	bh=1sY8nyUsXMMS7f9cagRPGqla94V1XYuJhI6GbG6cYEo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YXPKSpcp27/jJowPl1oneJwUWtGEjRWT6iRjn6DIwguX70hYIqh1RRkVMdWJC3/8YqZGL9kc54HOFrzMVCjDpe5OQK1nEH/0+NHForsBL2U4gC9yt6aiSyuXhEbNcMzL9fasL6XbFUdMb8cYRkfsVxxNSMzB0nM7A42uoqkUXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiopzaiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiopzaiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED44F1F000FF;
	Mon,  5 Oct 2026 23:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791242356;
	bh=Ih5AdgVWG/WfrdffmE77K1IMWggLbRJUfnhovT4T4AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=HiopzaiSMurG+bExiPGm01IYPLfttLOCpPKxzSaKHQVJXZilpUE8aoinSOp1vJE+u
	 2DFor7MQQh8navhw6UqqWlRpn34t/ZZgjN5DoZ8Xfn1pyeM//B7+X7UabSPn15ZsIT
	 2ye8miSgxsVWXdPl7TJBSQjrUwQzb72S/DXJ6kndCrMzXr6d/zhdtR0cuFm96BaExU
	 KGINN1zxl7I9v1DvARjSspfoULOKwDKELMhBVLOKnJOT69G29uCjmwAo4fPVbIfxMB
	 Sj2ZoFEH799F3fd5pYKjJA3cPeKnwmSvQwl5484CPniZmw49yXmCL+JsMMzWX4nX30
	 ypJwMtLiAdEJg==
Date: Mon, 5 Oct 2026 18:19:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Perlow, Jason" <jperlow@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, Aditya Garg <aditya.garg@linux.dev>,
	Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
Message-ID: <20261005231914.GA639967@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>

[+cc Alex]

On Mon, Oct 05, 2026 at 01:53:55PM -0400, Perlow, Jason wrote:
> Hi Lukas, Bjorn,
> 
> Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
> Errors"), first in v7.3-rc1, an Apple MacBookPro16,1 (T2 chip) loses
> power 17 to 24 s after boot. v7.2.9 is fine; v7.3-rc5 and v7.3-rc6 are
> not. Bisection lands on that commit, and v7.3-rc6 with only that
> commit reverted no longer powers off. aer.c has not changed since, as
> of v7.3-rc6-3, so I expect it is still unfixed; I did not find an
> existing report.

Alex reported something similar at
https://bugzilla.kernel.org/show_bug.cgi?id=222095.

Can you try the experiment mentioned there?  The patches Lukas
mentioned don't apply cleanly on v7.3-rc1, but the conflict looks
trivial?

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
> patches in the kernel image, CONFIG_PCIEAER=y,
> CONFIG_ACPI_APEI_GHES=y, kernel messages captured over the network.
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
>   make -j10 bindeb-pkg LOCALVERSION=-bisN-vanilla-rc0 \
>        KDEB_PKGVERSION=<release>-1
> 
> bisect-trimmed.config is a 7.3.0-rc5 configuration trimmed to build
> quickly (2068 options built in, 204 modules). It has CONFIG_PCIEAER=y,
> CONFIG_PCIE_DPC=y, CONFIG_PCIEASPM=y, CONFIG_ACPI_APEI=y and
> CONFIG_ACPI_APEI_GHES=y. The same file was used for all 19 steps and
> for both v7.3-rc6 tests. No out-of-tree patches were applied to the
> kernel. The release strings come from each tree's Makefile, so commits
> on 7.2-based topic branches show as 7.2.0.
> 
> Boot: the .deb packages were installed on the laptop and booted through
> a one-shot rEFInd entry; the default entry stayed the stable kernel.
> Kernel command line for every test boot:
> 
>   console=tty0 ignore_loglevel keep_bootcon initcall_debug
>   printk.time=1 log_buf_len=16M panic=0 fbcon=font:TER16x32
>   systemd.show_status=1 systemd.unit=multi-user.target
>   modprobe.blacklist=sbs,sbshc
>   systemd.mask=ncz-usb2-rescan.service
>   systemd.wants=ncz-netlog.service
> 
> (plus the root= options). So there was no graphical session. sbs and
> sbshc are the ACPI smart battery drivers; ncz-usb2-rescan is an
> unrelated distribution boot workaround. Steps 13 to 19 and the two
> v7.3-rc6 tests also had module_blacklist=thunderbolt,t2thunderbolt,
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
> commit tested is the merge base, "Linux 7.2". Observed = uptime of the
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

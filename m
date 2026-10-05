Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A931D367
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222851; cv=pass; b=FsOXhAWC4NZ0kt7v4zV3/qE5Eotet2AfnReAuH3FcCD2DfhdYnjSa7XGh+ikPBk4zar6+lsIstPx5jBc3+9lMdzLYRHmdHCMdwYmDRoqOASI0TCHzVoYvvy7SOGBhw513mqbZvpVhzq5WU2nRr3hp/0RznxCGbHspVdAFWzgdvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222851; c=relaxed/simple;
	bh=oeiHp/KTwJO4QacRK6gvRDvsAn2DVttHJkCeINCCYPk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gz/2bxVPx4Ex/JyrXCDlj2cmFeIQne7J4jJ/1kxbYPe/7CVjH40LurhozlT/uDAxzpH1vffK/LvD6Fk9pKiaAkqyTZ2IThG6U3VPwMXQzA7agThNT8/NMbraAZ9lSbL2Dz2yVr5ErRo20DU954PZWlg+FogTeoXz1TBZFpgTXj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skrRp4N1; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skrRp4N1"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so308591566b.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 10:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791222847; cv=none;
        d=google.com; s=arc-20260327;
        b=fX9z1sQbXpkVQfimvYooMcADOM4i+euXZ6ywpQ+p08YXeayGC5+4bqR8PQ1/tZz+Yc
         tWztOtsplH5Xr7HF2HWLM3PTKRjKccsLKDR0f5IpBMo9ORNI4eiigz6qxQNlWYDkFzXj
         52sDJiQwOEMEXMuOedby3b14C4XdL8Ufz5k1JMYkKRdO+UX75+yMFLRRjpk/mjOfYIo/
         AKjkOXF2YdWAVRroZlnEwnNJCvESl1iLWT+8RwQ4/T6CHl1ijuUX5tvWR4e4LWvGncFg
         r69rNURza11O4ihrSF8KOUuQDa1whM7qg2UsC3P9iatggvYQB7uH53TzhSK8MO0HPVS2
         LesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rufYfABK5UKmdjHYuYOKSM2AVE49bISrbMG52hK0RDc=;
        fh=c6UZfEaxe5FWo2bunruNy2Xqg9hAtjPQfHgmIaXvpj0=;
        b=ZFpUK24ABali426/JvqiDPEXloiNjUfAHfcC0IhJXLDSNqwFrTSx+OnRUHzApSZgrh
         +wSIBYCsd7s1GlvwbaM/CzxnxJ1KUoZhOZATIS9lZIJbwPsuDB2Ym+W4aEO4kTZit7qp
         PH3d7momO0efZC8hc9Di+pjRHkiNquRpn6fuNE3ffUhUe5ttV80wCxW+5s/ZNljA8oDI
         4Xy8bAg/2FWRJm1qQpFuqM7I7cM3N4RqpK6737XT41zWnS/LwazJHWw8kdR+5Me5cxtV
         +n9rsq/my4ubko9psP2yilG8GcJwvb1HYt2nRDNiuO+j4zMgXav/sUHIVKQ5PPGbiCYF
         k/3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791222847; x=1791827647; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rufYfABK5UKmdjHYuYOKSM2AVE49bISrbMG52hK0RDc=;
        b=skrRp4N120E2Dx2S+qbAFAHYp62hs8dto01ECdk5dqqusqlJgVm5XIsEof0Plm5+J4
         N37ZOfKWuyBixDBTZRdoZi+pn6ByTMyaS1Sin6iY9ehr3Y+DMkfH4h3bHTJcfyOgp6aK
         UBqSWtDmkWJIC7Ygr877kVJgkoxB1/Lx6aSyyp/tOp5v3D/BzJvlHMJ12GI+vWR3l4A/
         B8+JLoDTgN4lFVjxl8Kq98zgKuSg0cohqXIVCH7zH9fp7j5Dn5b56Nmi0/qJCvRFxwmC
         YPyPiKQXVc6dOS2sTzHwAS7yNt46rLGFWqeQNTsOhH68l7BGNvNMyIaUFRGgxTDiay79
         0k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791222847; x=1791827647;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rufYfABK5UKmdjHYuYOKSM2AVE49bISrbMG52hK0RDc=;
        b=oL16g4gAXxTHTL2uYgCrIO9+9YJXsD6bHYpttVWRDBnkVIwf3odpK1HpXPDsq9SfJD
         84TCyoslY7WYxcfRB1d71xNH4e+JfxFMUn2e6mZ+uuGjW5nuQtja6ZihhW9p60PMKGAV
         VJU5ez2fmp7yxjdTN5GcN/e7Mze++0LMaR7KnYGt/9BUpPwCtl45j6KwvsS5h6uhm8my
         g9GvpIcl170Ec16Vofo5/TgfcJje9yGvwuKnFr43xxA18KXvNVT5w/z8+EQAzALWjoS5
         1WbP7TNPZg50BB5al27Uhr/XV5Jf9gmzpq4LtAt3gAomX+WdP/mIK3j2bSSC6regsl3V
         lYug==
X-Gm-Message-State: AFq9FYKfkcxeNDdm6+2/7VefXpeY0RGLxLCQoGuuGBwbRWhOQvMJgpM8
	BaoCcu2hA5AdARoghjxC/tCYG4ZIjlBpoR5U0KIy+7yYCOpZk24heKpVHRSsldIet3fE7yE19rt
	KZCdl6viYdos0ufidaZPfdMw0GucY9to=
X-Gm-Gg: AYBFou1eTGuw4JLqL4+Dl6w185z2MS28qjmd2MLwHr0YvSoXnnWvXL9J10CAjtf01z/
	YluqgrwKmW//na0/cd4So/a+joSgRVstU5oBNR/CYkFWOtjLX3Fc3ctlC6L3ngpPaCjkTwQN52H
	qJIV/ovfeM5deo23/n2xpzSEJMTegPD6euyLfaX/Gzrp3lFAkmE+5z18JEH6JDTTX2meG1LX853
	8X6ldWhi2WmVe7fjUtfj9XvdSJeEGBUF+dMlzm1jr0TCTUAYbxV7CMdlHgz0h5iuqZp1cN25kt3
	x9IBJPYb87zHHd/9LgVl1y03pXMtnAge4EoUac66zwDJZtRmggnHioE8th0AucJg52w12uLlZfU
	ekDoA3fak86NXBrjK0//7fpoLw2sdxpEdeY+t2kBA7YsJ/qMYP43y84c0GvKhXRz0Ynm8l3vvyn
	aZVB3LGlKrYVbuJWJBE3om
X-Received: by 2002:a17:907:c785:b0:c29:609a:be6 with SMTP id
 a640c23a62f3a-c2e4b00c1a6mr988906466b.40.1791222847227; Mon, 05 Oct 2026
 10:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Mon, 5 Oct 2026 13:53:55 -0400
X-Gm-Features: AclHuK-786zF4ENB_sM-58clbMTGhe-HLv-miexpx8ux--fasyD2B84Tt70Y40A
Message-ID: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
Subject: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, Aditya Garg <aditya.garg@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Lukas, Bjorn,

Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
Errors"), first in v7.3-rc1, an Apple MacBookPro16,1 (T2 chip) loses
power 17 to 24 s after boot. v7.2.9 is fine; v7.3-rc5 and v7.3-rc6 are
not. Bisection lands on that commit, and v7.3-rc6 with only that
commit reverted no longer powers off. aer.c has not changed since, as
of v7.3-rc6-3, so I expect it is still unfixed; I did not find an
existing report.

Hardware
--------

MacBookPro16,1 with an AMD Navi 14 dGPU and the Apple T2. The bisect
machine has a Core i7-9750H; a second unit of the same model, used for
cross-checks, has a Core i9-9980HK. I have not tested any other T2
model. The internal SSD, the T2 and the audio device are functions of
one Apple PCIe device behind root port 00:1b.0:

  04:00.0 Apple ANS2 NVMe          [106b:2005]
  04:00.1 Apple T2 Bridge          [106b:1801]
  04:00.2 Apple T2 Secure Enclave  [106b:1802]
  04:00.3 Apple Audio Device       [106b:1803]

Symptom
-------

The machine powers off abruptly 17 to 24 s after boot. There is no
shutdown sequence; the previous boot's journal simply ends. Nothing is
logged beforehand: no AER message, no oops, no lockup, no thermal
event. The T2 controls power on these machines, so I assume (but
cannot show) that the T2/SMC removes power.

Bisect
------

v7.2.9 good, v7.3-rc5 bad. Vanilla mainline trees, no out-of-tree
patches in the kernel image, CONFIG_PCIEAER=y,
CONFIG_ACPI_APEI_GHES=y, kernel messages captured over the network.
19 steps, 4 skipped because those trees oops early for an unrelated
reason (the ones I looked at were in thunderbolt icm_probe at about
5 s). Good boots were watched for 55.8 to 69.7 s; bad boots stopped
logging between 17.9 and 24.1 s. The complete history, every commit
tested and every result, is in Appendix B, and the exact method in
Appendix A. The result:

  # first bad commit: [eddba19b8b5f] PCI/AER: Support Advisory
  # Non-Fatal Errors

Revert test, v7.3-rc6, same config:

  v7.3-rc6 unmodified:            powers off at 16.7 s
  only eddba19b8b5f reverted:     survives the full 64 s capture

With that revert on top of 7.3.0-rc6 plus the out-of-tree t2linux
series (one kernel image, built once), a normal desktop runs on both
MacBookPro16,1 units: the second one has been up for more than 45
minutes, and the bisect machine ran sessions of 32 and 22 minutes.
For completeness: the bisect machine once lost power after about 10
minutes while I was manually switching the display mux and powering
off the AMD GPU, which I do not expect the firmware to support. I
have not established the cause and have no evidence either way on
whether it is related.

Which devices are affected
--------------------------

On v7.2.9, where the Advisory Non-Fatal Error bit is still masked, the
Correctable Error Status register has AdvNonFatalErr latched on
exactly these functions, with every Uncorrectable Error Status
register clear:

  04:00.0 04:00.1 04:00.2 04:00.3  (the Apple device above)
  01:00.0 AMD Navi 10 XL PCIe switch upstream port [1002:1478]

The pattern is identical on both MacBookPro16,1 units (same model, so
this says nothing about other T2 models). The Titan Ridge 4C bridges
and NHI on the same machine do not have the bit set.
These devices report the advisory bit without any matching
Uncorrectable Error status, which looks like the "non-compliant
products" case the commit message mentions.

Only one of the two machines was used for the bisect and the
power-off tests above. I have not yet booted an unreverted 7.3 kernel
on the second one, so I cannot yet say that the power-off reproduces
there.

Control: an ASUS ROG Zephyrus M15 GU502LV (i7-10750H, RTX 2060, no
T2) has the same bit latched on its NVIDIA TU106 functions
[10de:10f9, 10de:1ada, 10de:1adb] and on Titan Ridge 2C [8086:15e7,
8086:15e8, 8086:15e9]. It ran a 7.3.0-rc6 build with the commit
applied (plus the t2linux series) for more than 15 hours without a
problem, and the same reverted kernel image as above also runs on it
normally. So unmasking the bit is not harmful in general; something
specific to the T2 platform is.

What I do not know
------------------

Which device triggers the power-off, and why. My guess, and it is
only a guess: treating a possible Advisory Non-Fatal Error as
non-Advisory and recovering through the uncorrectable path resets or
disturbs a T2 function, and the T2 then powers the machine down. I
intend to build a diagnostic kernel that can leave the bit masked per
device to find out which one.

Possibly related, different symptom: "PCI/portdev: Disable AER for
Titan Ridge 4C 2018" (Atharva Tiwari, January 2026) concerned AER
warnings on T2 iMacs.

What I am asking
----------------

Which direction would you prefer: a revert, or a quirk that keeps
Advisory Non-Fatal Errors masked on the affected Apple functions (and
possibly the AMD switch port)? The t2linux project carries a revert
for now: https://github.com/t2linux/linux-t2-patches/pull/70

I can test patches on real hardware and can provide full lspci -vvv
output, the complete bisect log and the captured boot logs.

#regzbot introduced: eddba19b8b5f76d57424ee328a68fd495c5db857

Thanks,
Jason Perlow


APPENDIX A - METHOD

Machine: one MacBookPro16,1 for every boot below, running a Debian
trixie userland from its internal SSD. The distribution's 7.2.9 kernel
was the default boot entry between tests.

Build: git bisect in a clone of torvalds/linux (git.kernel.org). Each
candidate was built on a separate x86-64 build host (16 threads, gcc
15.2.0, binutils 2.46) with the same recipe:

  cp bisect-trimmed.config .config
  make olddefconfig
  make -j10 bindeb-pkg LOCALVERSION=-bisN-vanilla-rc0 \
       KDEB_PKGVERSION=<release>-1

bisect-trimmed.config is a 7.3.0-rc5 configuration trimmed to build
quickly (2068 options built in, 204 modules). It has CONFIG_PCIEAER=y,
CONFIG_PCIE_DPC=y, CONFIG_PCIEASPM=y, CONFIG_ACPI_APEI=y and
CONFIG_ACPI_APEI_GHES=y. The same file was used for all 19 steps and
for both v7.3-rc6 tests. No out-of-tree patches were applied to the
kernel. The release strings come from each tree's Makefile, so commits
on 7.2-based topic branches show as 7.2.0.

Boot: the .deb packages were installed on the laptop and booted through
a one-shot rEFInd entry; the default entry stayed the stable kernel.
Kernel command line for every test boot:

  console=tty0 ignore_loglevel keep_bootcon initcall_debug
  printk.time=1 log_buf_len=16M panic=0 fbcon=font:TER16x32
  systemd.show_status=1 systemd.unit=multi-user.target
  modprobe.blacklist=sbs,sbshc
  systemd.mask=ncz-usb2-rescan.service
  systemd.wants=ncz-netlog.service

(plus the root= options). So there was no graphical session. sbs and
sbshc are the ACPI smart battery drivers; ncz-usb2-rescan is an
unrelated distribution boot workaround. Steps 13 to 19 and the two
v7.3-rc6 tests also had module_blacklist=thunderbolt,t2thunderbolt,
added after the early oopses (in thunderbolt icm_probe, at about 5 s)
had cost several skipped steps. Steps 1 to 12 ran with Thunderbolt
enabled.

Capture: a small userspace unit (ncz-netlog.service) streams /dev/kmsg
and the journal over TCP to a second machine from early multi-user
boot, so captures begin at roughly 10 s of uptime. Each capture file
records the uptime of its last line.

Verdicts:
  good: the machine kept running and logging past the point where bad
        kernels die (the cut always came before 25 s).
  bad:  the capture stops before 45 s, the machine stays unreachable
        for at least 60 s, and the next boot's journal shows the
        previous boot ending with no clean shutdown.
  skip: a kernel oops or panic in the capture or the previous boot's
        journal.

After a cut the laptop does not restart by itself, so it was powered
on by hand and booted the stable kernel; the verdict was then confirmed
from the previous boot's journal.

Caveats:
  - One machine was used for the bisect and for the power-off tests.
  - No desktop session was running.
  - sbs/sbshc were blocked on every boot, and Thunderbolt from step 13
    on.
  - The laptop was powered from, and networked through, a Thunderbolt
    dock during the bisect. An earlier test of a T2-patched
    7.3.0-rc5 kernel with the dock unplugged also lost power, but I
    did not repeat the bisect undocked.
  - Out-of-tree DKMS modules for the T2 hardware (t2smc, t2gmux,
    t2smp, t2thunderbolt) were installed for these kernels and may
    have been loaded, which would taint them. An earlier test with
    those modules blocked still lost power.
  - Step 12 ran 816 s before an unrelated oops, so it did not show
    the cut and was treated as a skip rather than as good; this does
    not change the result.
  - The device that triggers the cut is not identified.

APPENDIX B - FULL BISECT HISTORY

Good: v7.2.9 (5fce161649b4). Bad: v7.3-rc5 (72d3fcf802c4). The first
commit tested is the merge base, "Linux 7.2". Observed = uptime of the
last line captured. Results: 8 good, 7 bad, 4 skip.

 #  commit        result observed   subject
 1  8d3ae59288f1  good   55.8 s     Linux 7.2
 2  56ea4e86832d  good   67.7 s     nstree: check listing permission
                                    before taking a namespace ref
 3  93e4b3076b5f  bad    24.1 s     Merge tag 'char-misc-7.3-rc1'
 4  21bd0802cd3f  good   60.1 s     Merge tag 'for-linus' (rdma)
 5  0b0e645ed2c8  bad    22.9 s     Merge tag 'auxdisplay-v7.3-1'
 6  e5f92606156a  good   69.5 s     Merge tag 'mm-nonmm-stable-2026-08-
                                    22-16-57'
 7  b6b019a1d9b9  good   69.2 s     Merge tag 'parisc-for-7.3-rc1'
 8  b130a2caf5d3  skip   oops 5.3 s Merge branch
                                    'pci/controller/tegra264'
 9  455b454c87bb  good   69.0 s     i3c: mipi-i3c-hci: Add support for
                                    AMD_PT I3C controller
10  9bb52aa1972d  skip   oops 5.5 s Merge branch
                                    'pci/controller/dwc-meson'
11  b4b07fb82b9e  skip   oops 5.3 s Merge branch 'pci/wake'
12  651fb94aaf24  skip   oops 816 s alpha/PCI: Fix I/O port accessor
                                    argument order in
                                    pci_legacy_write()
13  625ae0ff41e5  bad    19.9 s     Merge branch 'pci/dt-binding'
14  9f91b2b716a0  bad    19.1 s     Merge branch 'pci/procfs'
15  ea55835bc538  bad    23.3 s     Merge branch 'pci/dpc'
16  d358e9ad15c2  bad    22.3 s     Merge branch 'pci/aer'
17  8446e1147f65  good   69.7 s     PCI/AER: Deduplicate logging of
                                    Error Source Identification
18  f141f74c45c6  good   67.6 s     PCI/AER: Move retrieval of FEP and
                                    TLP Log into helper
19  eddba19b8b5f  bad    17.9 s     PCI/AER: Support Advisory
                                    Non-Fatal Errors

Full hashes of the decisive steps:
  eddba19b8b5f76d57424ee328a68fd495c5db857  (first bad)
  f141f74c45c6f774eebdb7e45bd609be5122bfa8  (last good before it)
  8446e1147f65563d374ffa54dc3ba81adb1342c5

The v7.3-rc6 tests (a90ee4305c4a) used the same recipe and command line:
unmodified, power off at 16.7 s; with only eddba19b8b5f reverted,
survived the full 64 s capture.

-- 
Jason

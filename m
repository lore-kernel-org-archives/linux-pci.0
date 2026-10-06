Received: from mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F14A0EF6
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312363; cv=none; b=Y82NfjUMOZnXScgaXU8Me0TrydSPS0bPnc/Jvp7YFsTJv6utkheBRO2Iqw/LhyiRzbYXaTPYya1SF6OP1v0baLbJdnmfRWwbcxQQYkRd1NqvAC9Cx28sv/FygCG5V60qOa7Ev0PqjPZwc6R3aj+xrrH4qzcmowtKPge480mRQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312363; c=relaxed/simple;
	bh=paP8qoeD8n8ss+o8PUBgpg9BkHu31CSK6uRZ3M1V7jI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HIqiu0PKDMWaeiKa9pBk6gIsqBdU9XxBQMo17kIAZnQG7mIKuA0YBIXsVKi8z+BfD8o7wcv3JywoFJgILB7uXp7D6N6XwkGI+qWS+aVjKK7ieiBDJg6VldCJ6pLGYP8jGPpslyV37KONQvH+5PKOMxc9HIBGaLM2wOKJAPhJFVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FegmaBkR; arc=none smtp.client-ip=91.218.175.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FegmaBkR"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=paP8qoeD8n8ss+o8PUBgpg9BkHu31CSK6uRZ3M1V7jI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791312358; v=1; x=1791917158;
 b=FegmaBkRc6PSgkMuidwhG3avnZPc8AaS3RYIzJv9AN4ZKT9xBP5TnqOPnBmXo69N4hbhwqaB
 ZkXyb1ta0fMK7i9T6FmCog8jjwHsYSvVH5nG/KP5EHCxQWdXNbXWqlL5G7gwrz0q+9/2wx9ZWjz
 T8O2jU5uxKNycYLGw82V+p28=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f5599b8ca2260046;
	Tue, 06 Oct 2026 18:45:48 +0000
X-Mizu-Trace-ID: f5599b8ca2260046
X-Migadu-Flow: FLOW_OUT
Date: Wed, 07 Oct 2026 00:15:44 +0530
From: Aditya Garg <aditya.garg@linux.dev>
To: Alex Deucher <alexdeucher@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: "Perlow, Jason" <jperlow@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
User-Agent: Thunderbird for Android
In-Reply-To: <CADnq5_O2TWeWEE1NsuCVvtWLKWyOiJHChPGP9CN4Zu=hvs+jmA@mail.gmail.com>
References: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com> <20261005231914.GA639967@bhelgaas> <CADnq5_O2TWeWEE1NsuCVvtWLKWyOiJHChPGP9CN4Zu=hvs+jmA@mail.gmail.com>
Message-ID: <02FB87FF-9CFD-4CD6-BC94-1D2F7B9C4C94@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 6 October 2026 10:07:18=E2=80=AFpm IST, Alex Deucher <alexdeucher@gmail=
=2Ecom> wrote:
>On Mon, Oct 5, 2026 at 7:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel=2Eor=
g> wrote:
>>
>> [+cc Alex]
>>
>> On Mon, Oct 05, 2026 at 01:53:55PM -0400, Perlow, Jason wrote:
>> > Hi Lukas, Bjorn,
>> >
>> > Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
>> > Errors"), first in v7=2E3-rc1, an Apple MacBookPro16,1 (T2 chip) lose=
s
>> > power 17 to 24 s after boot=2E v7=2E2=2E9 is fine; v7=2E3-rc5 and v7=
=2E3-rc6 are
>> > not=2E Bisection lands on that commit, and v7=2E3-rc6 with only that
>> > commit reverted no longer powers off=2E aer=2Ec has not changed since=
, as
>> > of v7=2E3-rc6-3, so I expect it is still unfixed; I did not find an
>> > existing report=2E
>>
>> Alex reported something similar at
>> https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D222095=2E
>>
>> Can you try the experiment mentioned there?  The patches Lukas
>> mentioned don't apply cleanly on v7=2E3-rc1, but the conflict looks
>> trivial?
>
>Lukas' patches fixes some boards, but unfortunately, I'm still seeing
>failures on others=2E  Reverting the patch fixes those failures=2E  I've
>updated the ticket=2E

Considering the number of devices breaking has started increasing inspite =
of being just in rc, that commit should be reverted=2E
>
>Alex
>
>>
>> > Hardware
>> > --------
>> >
>> > MacBookPro16,1 with an AMD Navi 14 dGPU and the Apple T2=2E The bisec=
t
>> > machine has a Core i7-9750H; a second unit of the same model, used fo=
r
>> > cross-checks, has a Core i9-9980HK=2E I have not tested any other T2
>> > model=2E The internal SSD, the T2 and the audio device are functions =
of
>> > one Apple PCIe device behind root port 00:1b=2E0:
>> >
>> >   04:00=2E0 Apple ANS2 NVMe          [106b:2005]
>> >   04:00=2E1 Apple T2 Bridge          [106b:1801]
>> >   04:00=2E2 Apple T2 Secure Enclave  [106b:1802]
>> >   04:00=2E3 Apple Audio Device       [106b:1803]
>> >
>> > Symptom
>> > -------
>> >
>> > The machine powers off abruptly 17 to 24 s after boot=2E There is no
>> > shutdown sequence; the previous boot's journal simply ends=2E Nothing=
 is
>> > logged beforehand: no AER message, no oops, no lockup, no thermal
>> > event=2E The T2 controls power on these machines, so I assume (but
>> > cannot show) that the T2/SMC removes power=2E
>> >
>> > Bisect
>> > ------
>> >
>> > v7=2E2=2E9 good, v7=2E3-rc5 bad=2E Vanilla mainline trees, no out-of-=
tree
>> > patches in the kernel image, CONFIG_PCIEAER=3Dy,
>> > CONFIG_ACPI_APEI_GHES=3Dy, kernel messages captured over the network=
=2E
>> > 19 steps, 4 skipped because those trees oops early for an unrelated
>> > reason (the ones I looked at were in thunderbolt icm_probe at about
>> > 5 s)=2E Good boots were watched for 55=2E8 to 69=2E7 s; bad boots sto=
pped
>> > logging between 17=2E9 and 24=2E1 s=2E The complete history, every co=
mmit
>> > tested and every result, is in Appendix B, and the exact method in
>> > Appendix A=2E The result:
>> >
>> >   # first bad commit: [eddba19b8b5f] PCI/AER: Support Advisory
>> >   # Non-Fatal Errors
>> >
>> > Revert test, v7=2E3-rc6, same config:
>> >
>> >   v7=2E3-rc6 unmodified:            powers off at 16=2E7 s
>> >   only eddba19b8b5f reverted:     survives the full 64 s capture
>> >
>> > With that revert on top of 7=2E3=2E0-rc6 plus the out-of-tree t2linux
>> > series (one kernel image, built once), a normal desktop runs on both
>> > MacBookPro16,1 units: the second one has been up for more than 45
>> > minutes, and the bisect machine ran sessions of 32 and 22 minutes=2E
>> > For completeness: the bisect machine once lost power after about 10
>> > minutes while I was manually switching the display mux and powering
>> > off the AMD GPU, which I do not expect the firmware to support=2E I
>> > have not established the cause and have no evidence either way on
>> > whether it is related=2E
>> >
>> > Which devices are affected
>> > --------------------------
>> >
>> > On v7=2E2=2E9, where the Advisory Non-Fatal Error bit is still masked=
, the
>> > Correctable Error Status register has AdvNonFatalErr latched on
>> > exactly these functions, with every Uncorrectable Error Status
>> > register clear:
>> >
>> >   04:00=2E0 04:00=2E1 04:00=2E2 04:00=2E3  (the Apple device above)
>> >   01:00=2E0 AMD Navi 10 XL PCIe switch upstream port [1002:1478]
>> >
>> > The pattern is identical on both MacBookPro16,1 units (same model, so
>> > this says nothing about other T2 models)=2E The Titan Ridge 4C bridge=
s
>> > and NHI on the same machine do not have the bit set=2E
>> > These devices report the advisory bit without any matching
>> > Uncorrectable Error status, which looks like the "non-compliant
>> > products" case the commit message mentions=2E
>> >
>> > Only one of the two machines was used for the bisect and the
>> > power-off tests above=2E I have not yet booted an unreverted 7=2E3 ke=
rnel
>> > on the second one, so I cannot yet say that the power-off reproduces
>> > there=2E
>> >
>> > Control: an ASUS ROG Zephyrus M15 GU502LV (i7-10750H, RTX 2060, no
>> > T2) has the same bit latched on its NVIDIA TU106 functions
>> > [10de:10f9, 10de:1ada, 10de:1adb] and on Titan Ridge 2C [8086:15e7,
>> > 8086:15e8, 8086:15e9]=2E It ran a 7=2E3=2E0-rc6 build with the commit
>> > applied (plus the t2linux series) for more than 15 hours without a
>> > problem, and the same reverted kernel image as above also runs on it
>> > normally=2E So unmasking the bit is not harmful in general; something
>> > specific to the T2 platform is=2E
>> >
>> > What I do not know
>> > ------------------
>> >
>> > Which device triggers the power-off, and why=2E My guess, and it is
>> > only a guess: treating a possible Advisory Non-Fatal Error as
>> > non-Advisory and recovering through the uncorrectable path resets or
>> > disturbs a T2 function, and the T2 then powers the machine down=2E I
>> > intend to build a diagnostic kernel that can leave the bit masked per
>> > device to find out which one=2E
>> >
>> > Possibly related, different symptom: "PCI/portdev: Disable AER for
>> > Titan Ridge 4C 2018" (Atharva Tiwari, January 2026) concerned AER
>> > warnings on T2 iMacs=2E
>> >
>> > What I am asking
>> > ----------------
>> >
>> > Which direction would you prefer: a revert, or a quirk that keeps
>> > Advisory Non-Fatal Errors masked on the affected Apple functions (and
>> > possibly the AMD switch port)? The t2linux project carries a revert
>> > for now: https://github=2Ecom/t2linux/linux-t2-patches/pull/70
>> >
>> > I can test patches on real hardware and can provide full lspci -vvv
>> > output, the complete bisect log and the captured boot logs=2E
>> >
>> > #regzbot introduced: eddba19b8b5f76d57424ee328a68fd495c5db857
>> >
>> > Thanks,
>> > Jason Perlow
>> >
>> >
>> > APPENDIX A - METHOD
>> >
>> > Machine: one MacBookPro16,1 for every boot below, running a Debian
>> > trixie userland from its internal SSD=2E The distribution's 7=2E2=2E9=
 kernel
>> > was the default boot entry between tests=2E
>> >
>> > Build: git bisect in a clone of torvalds/linux (git=2Ekernel=2Eorg)=
=2E Each
>> > candidate was built on a separate x86-64 build host (16 threads, gcc
>> > 15=2E2=2E0, binutils 2=2E46) with the same recipe:
>> >
>> >   cp bisect-trimmed=2Econfig =2Econfig
>> >   make olddefconfig
>> >   make -j10 bindeb-pkg LOCALVERSION=3D-bisN-vanilla-rc0 \
>> >        KDEB_PKGVERSION=3D<release>-1
>> >
>> > bisect-trimmed=2Econfig is a 7=2E3=2E0-rc5 configuration trimmed to b=
uild
>> > quickly (2068 options built in, 204 modules)=2E It has CONFIG_PCIEAER=
=3Dy,
>> > CONFIG_PCIE_DPC=3Dy, CONFIG_PCIEASPM=3Dy, CONFIG_ACPI_APEI=3Dy and
>> > CONFIG_ACPI_APEI_GHES=3Dy=2E The same file was used for all 19 steps =
and
>> > for both v7=2E3-rc6 tests=2E No out-of-tree patches were applied to t=
he
>> > kernel=2E The release strings come from each tree's Makefile, so comm=
its
>> > on 7=2E2-based topic branches show as 7=2E2=2E0=2E
>> >
>> > Boot: the =2Edeb packages were installed on the laptop and booted thr=
ough
>> > a one-shot rEFInd entry; the default entry stayed the stable kernel=
=2E
>> > Kernel command line for every test boot:
>> >
>> >   console=3Dtty0 ignore_loglevel keep_bootcon initcall_debug
>> >   printk=2Etime=3D1 log_buf_len=3D16M panic=3D0 fbcon=3Dfont:TER16x32
>> >   systemd=2Eshow_status=3D1 systemd=2Eunit=3Dmulti-user=2Etarget
>> >   modprobe=2Eblacklist=3Dsbs,sbshc
>> >   systemd=2Emask=3Dncz-usb2-rescan=2Eservice
>> >   systemd=2Ewants=3Dncz-netlog=2Eservice
>> >
>> > (plus the root=3D options)=2E So there was no graphical session=2E sb=
s and
>> > sbshc are the ACPI smart battery drivers; ncz-usb2-rescan is an
>> > unrelated distribution boot workaround=2E Steps 13 to 19 and the two
>> > v7=2E3-rc6 tests also had module_blacklist=3Dthunderbolt,t2thunderbol=
t,
>> > added after the early oopses (in thunderbolt icm_probe, at about 5 s)
>> > had cost several skipped steps=2E Steps 1 to 12 ran with Thunderbolt
>> > enabled=2E
>> >
>> > Capture: a small userspace unit (ncz-netlog=2Eservice) streams /dev/k=
msg
>> > and the journal over TCP to a second machine from early multi-user
>> > boot, so captures begin at roughly 10 s of uptime=2E Each capture fil=
e
>> > records the uptime of its last line=2E
>> >
>> > Verdicts:
>> >   good: the machine kept running and logging past the point where bad
>> >         kernels die (the cut always came before 25 s)=2E
>> >   bad:  the capture stops before 45 s, the machine stays unreachable
>> >         for at least 60 s, and the next boot's journal shows the
>> >         previous boot ending with no clean shutdown=2E
>> >   skip: a kernel oops or panic in the capture or the previous boot's
>> >         journal=2E
>> >
>> > After a cut the laptop does not restart by itself, so it was powered
>> > on by hand and booted the stable kernel; the verdict was then confirm=
ed
>> > from the previous boot's journal=2E
>> >
>> > Caveats:
>> >   - One machine was used for the bisect and for the power-off tests=
=2E
>> >   - No desktop session was running=2E
>> >   - sbs/sbshc were blocked on every boot, and Thunderbolt from step 1=
3
>> >     on=2E
>> >   - The laptop was powered from, and networked through, a Thunderbolt
>> >     dock during the bisect=2E An earlier test of a T2-patched
>> >     7=2E3=2E0-rc5 kernel with the dock unplugged also lost power, but=
 I
>> >     did not repeat the bisect undocked=2E
>> >   - Out-of-tree DKMS modules for the T2 hardware (t2smc, t2gmux,
>> >     t2smp, t2thunderbolt) were installed for these kernels and may
>> >     have been loaded, which would taint them=2E An earlier test with
>> >     those modules blocked still lost power=2E
>> >   - Step 12 ran 816 s before an unrelated oops, so it did not show
>> >     the cut and was treated as a skip rather than as good; this does
>> >     not change the result=2E
>> >   - The device that triggers the cut is not identified=2E
>> >
>> > APPENDIX B - FULL BISECT HISTORY
>> >
>> > Good: v7=2E2=2E9 (5fce161649b4)=2E Bad: v7=2E3-rc5 (72d3fcf802c4)=2E =
The first
>> > commit tested is the merge base, "Linux 7=2E2"=2E Observed =3D uptime=
 of the
>> > last line captured=2E Results: 8 good, 7 bad, 4 skip=2E
>> >
>> >  #  commit        result observed   subject
>> >  1  8d3ae59288f1  good   55=2E8 s     Linux 7=2E2
>> >  2  56ea4e86832d  good   67=2E7 s     nstree: check listing permissio=
n
>> >                                     before taking a namespace ref
>> >  3  93e4b3076b5f  bad    24=2E1 s     Merge tag 'char-misc-7=2E3-rc1'
>> >  4  21bd0802cd3f  good   60=2E1 s     Merge tag 'for-linus' (rdma)
>> >  5  0b0e645ed2c8  bad    22=2E9 s     Merge tag 'auxdisplay-v7=2E3-1'
>> >  6  e5f92606156a  good   69=2E5 s     Merge tag 'mm-nonmm-stable-2026=
-08-
>> >                                     22-16-57'
>> >  7  b6b019a1d9b9  good   69=2E2 s     Merge tag 'parisc-for-7=2E3-rc1=
'
>> >  8  b130a2caf5d3  skip   oops 5=2E3 s Merge branch
>> >                                     'pci/controller/tegra264'
>> >  9  455b454c87bb  good   69=2E0 s     i3c: mipi-i3c-hci: Add support =
for
>> >                                     AMD_PT I3C controller
>> > 10  9bb52aa1972d  skip   oops 5=2E5 s Merge branch
>> >                                     'pci/controller/dwc-meson'
>> > 11  b4b07fb82b9e  skip   oops 5=2E3 s Merge branch 'pci/wake'
>> > 12  651fb94aaf24  skip   oops 816 s alpha/PCI: Fix I/O port accessor
>> >                                     argument order in
>> >                                     pci_legacy_write()
>> > 13  625ae0ff41e5  bad    19=2E9 s     Merge branch 'pci/dt-binding'
>> > 14  9f91b2b716a0  bad    19=2E1 s     Merge branch 'pci/procfs'
>> > 15  ea55835bc538  bad    23=2E3 s     Merge branch 'pci/dpc'
>> > 16  d358e9ad15c2  bad    22=2E3 s     Merge branch 'pci/aer'
>> > 17  8446e1147f65  good   69=2E7 s     PCI/AER: Deduplicate logging of
>> >                                     Error Source Identification
>> > 18  f141f74c45c6  good   67=2E6 s     PCI/AER: Move retrieval of FEP =
and
>> >                                     TLP Log into helper
>> > 19  eddba19b8b5f  bad    17=2E9 s     PCI/AER: Support Advisory
>> >                                     Non-Fatal Errors
>> >
>> > Full hashes of the decisive steps:
>> >   eddba19b8b5f76d57424ee328a68fd495c5db857  (first bad)
>> >   f141f74c45c6f774eebdb7e45bd609be5122bfa8  (last good before it)
>> >   8446e1147f65563d374ffa54dc3ba81adb1342c5
>> >
>> > The v7=2E3-rc6 tests (a90ee4305c4a) used the same recipe and command =
line:
>> > unmodified, power off at 16=2E7 s; with only eddba19b8b5f reverted,
>> > survived the full 64 s capture=2E
>> >
>> > --
>> > Jason

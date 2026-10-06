Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED1221D89
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245848; cv=pass; b=bHsqfOootuNkuc7ZOnt5NAWjqs30yx71Km8Dq2fSnJHvRux1AAXkhLbFKEr+B0SfzXBk7Pm4ZppfjCaxo7jtVNvmk7dmjhtgEzSJNIwuhYkXFRTjk0wT5Li+Y4pEyWJLmtf1sxhe8SiSdofBseuPJ/Hf14kU2ODLMLCL2FLKfy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245848; c=relaxed/simple;
	bh=0JmaGJYuh35nK/8BZ4H4U/00AGleisLG2T3mzgxan0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzBzqZvZ+UXWI40FWJxNqhEnWqZbPGOraQJ1cSlyhP8J6VjFWpSodtYP9P3sXe78ymAsUfS4gN8c8PTqnAdgtDSYKybT+X9JWgOflW3WaQbDnNLXZgrBWXT7m5PNtAgSLWdqVn1snkYt5sijVc4+e6P2hBBLXlZ0wLNm9Y0kpZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rI4oS6Zy; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI4oS6Zy"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e20bb4583so452640966b.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 17:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791245844; cv=none;
        d=google.com; s=arc-20260327;
        b=c3Tdip3ZAIp5Eg+nWs3qjby0+T4bXgMSCVKj8lirrklsH6giDQCImHS6E0U4Q8fMrG
         2ihtD1zE27bKoRAfoI4OYmrOMlHQbAmjPyjx6RDFPG5P0e5y2uVKjaj3RQOrkPxIhq/M
         hM5e/c7JC1PBP3FAbjMi3J/qyJAM29OBwZMjKa8enhcZrjQcZ8FSYAYYvGf4oziaJLsC
         PyHm0IM/VETRntRGeeDQ2c7VOcgTB0C0wpzELjtbNE7khMoXd3ebvLP4XZ1d8gf5PNb5
         HgvmWgCG7W3gdBtvHPpT/oppCfTx84wECbNTKSDm6vzMHjbyVmQj/IUwYOH7vcMVcuDz
         Jgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r07T5TDn8OOFFjXx1vrgbi8gxWdkxcMtTsy75pUL8B0=;
        fh=ePZcyIRR7q0l54l59Fa/18/KZjuBm7uTOPA41VozZA0=;
        b=Qvi1cQ+OgmAizMg0bVCS97mIrLPJgqqmh0UrLoPed34l5NCDoa2lJSmb/j17Q1auvR
         MeDsGdGAGMp63/f6Q7c7V0N+cJU2kMetr9UqqpXrWWPoGn9bFv3+qtLjXqWnL1iqnast
         WLa5HpvNegeELC1DXdgRCkfDTBXL6l/DtURgp4V60HQYvarrCPo8Pc2GYJ4RKqoTVBMj
         ewW6XpqhpDYVQqPQVxxoPlIjVQL7N0MUkMJPtQbEPKGgKZ+McNBlaImle+WjwDevnSiC
         1mDiUIccpe8QfnjCkRRV8sEbFD4q1nBEsKFFV+n+piYyGIxqBRc1aNMgcOOPvT6+IIWp
         co9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791245844; x=1791850644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r07T5TDn8OOFFjXx1vrgbi8gxWdkxcMtTsy75pUL8B0=;
        b=rI4oS6ZyyorBzAuP2NP8Rw9F2bJmHDTNI5Zxr9bnT9CDZ7uBJX2CjKyJjDnNZO09Gl
         TDO//jLKQviJKsd+8cL79RVsupezcnaFYPsJgAQliA3yX7ppTXaF7/8DEE+6KgbKYpXs
         7Yo6uQwC/1e6PIACEE3xTFYesGWwLbxS5h7P33Ihrz9fvjIaTd97DKommSZ/lnk5Ptah
         +tY8Fees59P6aSY2gjMf3lcM4uSDJ6B7uXxx6jSAOzIxkECDHRjAhegEm7T9CZDVwQOE
         eDqdk6Enprox2CJ27OdipV9sJBa/QCPynWx6q7deqU+5Q/gzPWgj4mC9ujGZKFIow7se
         haig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791245844; x=1791850644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r07T5TDn8OOFFjXx1vrgbi8gxWdkxcMtTsy75pUL8B0=;
        b=bk3LwEs5sLqiHwu9Lals2+J1o292Msp4CQjTul62y53I2TIpDmuwri/+AtIbK4xVcR
         B3IgdJDiQD1Gx5Owo/bnYSm0jmApGkz/yPhf70dqJxvunnl6WMBmrDJv++8vi8V8DbZV
         lGUmiWpMRYHJ5ye0KP0KR5lafHB2nFAC9eh0crWG5LCATxQRBO7JxrMEJB2Rt75aFC0j
         QfbNkgNZOHcUix3lQR7BOughRDiAgeVrxY1uKzVkvGpZc0KfTRlx8cwJdWtyDSumywIm
         jlsS4O7mKV5aaO0OGwgpkB+mRyMvRRKGId2L1Wv3dCH4/VByeWwpOO/Zafr7ukm54JeH
         P24A==
X-Forwarded-Encrypted: i=1; AKwUvBy4rZadxrJ8lWuJqB+mpAJ1BNKNDv3bDHiRLURtnL+nCULnMwdUXSNABZGY4pq3/Xcv5z+xwXtXM4E=@vger.kernel.org
X-Gm-Message-State: AFuF++lsn7iFyazFpJDpx1qbOqY4g+uizBkRWr1tqTxYP2MtPRtHaqG9
	2+SQznFSkR3zMS+obOt/QrOeoKKfXCVrIRGT8trKxRu3acxlUkt5w24EntX3uEl1tTDfwq4cILE
	ZmVgWVmDNFpM3+PkwM2J9nUxeFX3L6F8=
X-Gm-Gg: AYBFou0n41LZg+KahkI58exwEQ2QISoGuX9X3p8QUEqBwv9muV0TjYUUfI6S0B9f+F7
	scOJDKpE3ceYhSGZuwc6wPQLi7P9jcJNeiDYXXnF/zupQ5ik5TTWjeAFUKgt661IWgL+Nv7/MuF
	h1UxH6tNTdp0TI4kIXHXmBGA5yF+3OhGUp/q+pZovxI5YRZX2mYrI0g9rZcvjzqEeBcjS/VkupG
	4LApFqf4dkrX3U8J5FuFxIuC2wZDo/LmTT4GWvm3ECIJcIvf/HMZJ+mHiVFPCWi7oPyOv3SXtIH
	3iDstzR1hwI1iTY9JeRwgQq30226c4VaFBIhetVX1e6Zam6onPt3fbivRk2cW+ZRfm1ARCp1P0t
	WEB/xYScST6w+smJzCcRFM1j4oTnriXqS2bnaGt1TeEEjvqBZK8R+WBwx1j5ALXKlZj7HNAhUh4
	aBSr+OiFn4xkwTH0xKhhky
X-Received: by 2002:a17:907:3f87:b0:c2e:856:2a08 with SMTP id
 a640c23a62f3a-c2e4a9b37a6mr1060029566b.1.1791245843786; Mon, 05 Oct 2026
 17:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
 <20261005231914.GA639967@bhelgaas>
In-Reply-To: <20261005231914.GA639967@bhelgaas>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Mon, 5 Oct 2026 20:17:12 -0400
X-Gm-Features: AclHuK9j27Ioljx_xBUUxI-DWOiypXojWI1vytbx4TSp5zELb0QExA5yqlQi7EQ
Message-ID: <CABZrw2F=pOOq7+puKohtYMihYqWCevCFc7rkAOETW4T5Nf4n8Q@mail.gmail.com>
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Aditya Garg <aditya.garg@linux.dev>, Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn, Lukas,

Thanks for the pointer. I ran that experiment on the same
MacBookPro16,1.

Kernel: v7.3-rc6 (a90ee4305c4a) plus exactly the two top commits of
l1k/linux aer_unbound, and nothing else (no T2 patches, no revert, no
diagnostic parameter):

  9ce840949ee9 PCI/ERR: Always notify drivers of slot reset
  db16ca536fd0 PCI/ERR: Allow unbound devices to recover from
               Uncorrectable Errors

The first one conflicts trivially in drivers/pci/pcie/err.c on rc6
(the TODO comment in its context is already gone); I resolved it by
making the same removal. The second applied cleanly. Same trimmed
config and boot recipe as my earlier bisect (console only, no
graphical session).

Result: the machine still loses power. It answered over ssh at about
16 s of uptime and the journal of that boot ends at 16.9 s with no
shutdown sequence. Unmodified v7.3-rc6 powered off at 16.7 s in my
earlier test, so these two commits make no difference here.

So on this machine the failure is not the "link reset before a
driver is bound" case from Alex's report. As in my earlier tests no
AER error message is logged before the power loss (only the usual
"OS assumes control of AER" line) and the Uncorrectable Error Status
registers are clear.

For reference, the earlier result with a diagnostic boot parameter
that leaves the Advisory Non-Fatal bit masked per device:

  masked only on 04:00.2 (Apple T2 Secure Enclave, 106b:1802):
      stays up (120 s)
  masked only on 04:00.0 and 04:00.1 (NVMe, T2 Bridge):
      power off at 14 s
  masked on all four Apple functions 04:00.0-.3: stays up (343 s)

So here the trigger is unmasking Advisory Non-Fatal Errors on that
one function. It looks like a second, separate way for
eddba19b8b5f to hurt a platform.

Would you accept a quirk that keeps the bit masked on Apple
106b:1802? I am happy to write and test that, or any other patch you
would like tried on this machine, and I can send lspci -vvv and the
journals.

Thanks,
Jason


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



--=20
Jason Perlow | Argonaut Media Communications

Voice/Text  (954) 242-3484 | jperlow@gmail.com | Blog: techbroiler.net
Read my Tech and Food Industry articles: https://linktr.ee/jperlow
Bluesky: https://bsky.app/profile/jperlow.bsky.social

Need to schedule a meeting with me? https://bit.ly/3y8P3Gp

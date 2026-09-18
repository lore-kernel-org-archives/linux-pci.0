Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1F4FDA68;
	Fri, 18 Sep 2026 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763590; cv=none; b=igLP4VUZGlh3d2rLf5NlW41HCtsC9TDRHxYbRjQAMzm9db8AqJjmauZipv39tI6wBzqt8aN15FixRWRsHa8nacGQTorl924ikcCe9oQaE4F/qJETdSWo3RVdyxI1jWdeYAyOTyEe80Ipp2UsapT/hMZND7T8rZcjJaT/G5DvPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763590; c=relaxed/simple;
	bh=Rnec9kno5YM6uc8Q7ljU6gUxJeh+FHwMKyko0Kl4dRk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D//idQ+aw8srDRzcF9l03bd6+fRjj+xwaB4f1BxvBQzTYwtf+zMuFZVf4z7c4S5Ho8gghDs71MvbhcgmXROSW8i1szGdwHhC5blaV26H2SbtF8xaYXldb09N1rAVLeO032x+V0MFXu+Z+XMOL/KMxeebk72MGkrWYyVJ2Cvrt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6+cgNtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6+cgNtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0B81F000FF;
	Fri, 18 Sep 2026 20:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789763588;
	bh=t63swa2vGWhSMVvriVniZSpmSRHDpgldIgevzPECtk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=F6+cgNtpAs8cWclG8vebBy/tDEuG5j6L1uJ6WS/PuGce8mwRuhSBX713t9RIM5r6n
	 igBpWAGnYuP+DzEp4mnkPwgCRd70Cc1CwHHFtcGneoxImOaAYDksjVdXDQ1QdQoo/R
	 +b3j99RWqbUPGsyjPs63UPoODgsEakbvLPGQ3h6XAqucUapCH6yGTMlv/BF7qGodys
	 RtUDMv9xMn2nX/nStscLCTq/rt2JZEPfaDjfU6GqT8wdjih6/mCy26sJmEZ4f9g503
	 pmvDOMmKVQSdhVgYYDWQnE26JurBhOTHwCJIRHgzxECRuFjm16Yt+B+BzHxJ4/aE3t
	 My7HMC2N3RmMQ==
Date: Fri, 18 Sep 2026 15:33:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pavel Shirshov <pshirshov@7mind.io>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: PCI/ASPM: Intel Battlemage (Arc Pro B70) bricks at boot when
 `pcie_aspm.policy=powersupersave` enables ASPM_L1.1 on AMD root port link
Message-ID: <20260918203307.GA1192845@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0598ec-1f93-4817-b54d-c7433e03830e@app.fastmail.com>

On Thu, May 07, 2026 at 11:14:04PM +0100, Pavel Shirshov wrote:
> The report and the patch below are completely claude'd but the quirk in the patch works.
> 
> PCI/ASPM: Intel Battlemage (Arc Pro B70) bricks at boot when
> pcie_aspm.policy=powersupersave enables ASPM_L1.1 on AMD root port link

I happened on this report that we never responded to.  I assume this
is still a problem?

It looks like it's not a regression, but should still be fixed.

> ================================================================
> SUMMARY
> ================================================================
> 
> On Linux 7.0.3, an Intel Arc Pro B70 (Battlemage / BMG-G31, GPU PCI
> ID 8086:e223) plugged into an AMD Ryzen 9 5950X system fails to wake
> from D3cold during PCI core enumeration when the kernel is booted
> with pcie_aspm.policy=powersupersave. The card is permanently
> inaccessible until reboot with a different policy.
> pcie_aspm.policy=powersave (L0s+L1, no substates) works correctly.
> 
> The failure surfaces in PCI core first; downstream xe driver bind
> then fails with -EPROTO:
> 
>     pcieport 0000:02:01.0: Unable to change power state from D3cold
>                            to D0, device inaccessible
>     pcieport 0000:02:02.0: Unable to change power state from D3cold
>                            to D0, device inaccessible
>     xe 0000:03:00.0: Unable to change power state from D3cold to D0,
>                      device inaccessible
>     xe 0000:03:00.0: [drm] Running in SR-IOV VF mode
>                      [misdetected: dead config space reads as 0xff]
>     xe 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed to reset
>                      GuC state (-EPROTO)
>     xe 0000:03:00.0: probe with driver xe failed with error -71
> 
> After the brick, "lspci -vvv -s 03:00.0" reports
> "!!! Unknown header type 7f" -- the canonical signature of a PCI
> device whose config space reads return all-ones, i.e. the link to the
> device is dead.
> 
> 
> ================================================================
> HARDWARE
> ================================================================
> 
> CPU / root complex:
>     AMD Ryzen 9 5950X (Starship/Matisse). The root port hosting the
>     BMG card is 0000:00:01.1 -- "Advanced Micro Devices, Inc. [AMD]
>     Starship/Matisse GPP Bridge" (subsystem 1022:1453).
> 
> GPU:
>     Intel Arc Pro B70 -- 8086:e223 (BMG-G31, subsystem 8086:1701).
> 
> On-card topology -- the card has a two-layer on-board PCIe switch:
>     0000:01:00.0  Intel 8086:e2ff -- BMG card upstream switch port,
>                                      PCIe 5.0 x16 capable (currently
>                                      downgraded to Gen4 x16).
>     0000:02:01.0  Intel 8086:e2f0 -- BMG card downstream switch
>                                      port, PCIe Gen1 x1 internal.
>     0000:03:00.0  Intel 8086:e223 -- GPU endpoint, PCIe Gen1 x1
>                                      internal.
> 
> Other:
>     BIOS has PCIe ASPM enabled in firmware. pcie_aspm=force is NOT
>     set on the kernel command line. Motherboard: ASRock X570
>     (specifics in attached dmidecode.txt).
> 
> 
> ================================================================
> REPRODUCER
> ================================================================
> 
> Boot any kernel >= 7.0 with kernel command line containing:
> 
>     pcie_aspm.policy=powersupersave xe.force_probe=*
> 
> (Also reproduces under earlier 6.x kernels.)
> 
> Reverting the cmdline to "pcie_aspm.policy=powersave" and rebooting
> restores the card. No firmware reset is required between attempts --
> the brick is purely a runtime link-state failure during kernel boot.
> 
> 
> ================================================================
> ASPM NEGOTIATION
> ================================================================
> 
> Captured with "lspci -vvv" on a working policy=powersave boot
> (attached: 20260507-204348-powersave-7.0.3.tar.zst).
> 
> Link 1: 00:01.1 AMD root  <->  01:00.0 BMG upstream
>     Lower end (AMD root, L1SubCap):
>         PCI-PM_L1.2-  PCI-PM_L1.1+  ASPM_L1.2-  ASPM_L1.1+
>     Upper end (BMG upstream, L1SubCap):
>         PCI-PM_L1.2+  PCI-PM_L1.1+  ASPM_L1.2+  ASPM_L1.1+
>     Active L1SubCtl1 under policy=powersave:
>         PCI-PM_L1.2-  PCI-PM_L1.1-  ASPM_L1.2-  ASPM_L1.1-
> 
> Link 2: 01:00.0  <->  02:01.0   (card-internal switch)
>     No L1SS capability advertised on either end.
> 
> Link 3: 02:01.0  <->  03:00.0   (card-internal to GPU)
>     No L1SS capability advertised on either end.
> 
> Conclusion: only Link 1 -- the platform-facing AMD<->BMG link -- is
> L1SS-capable on both ends, and the intersection is ASPM_L1.1 only
> (the AMD GPP root port advertises L1.1 but not L1.2). With
> policy=powersupersave, the kernel arms ASPM_L1.1 on this link. After
> that, every D3cold->D0 transition fails.
> 
> Both ends advertise multi-retimer support (Retimer+ 2Retimers+ on
> the AMD root port and on the BMG upstream port). Retimers + L1SS
> have a history of wake-recovery problems on other platforms; this
> may be the same class of issue.
> 
> 
> ================================================================
> TIMELINE -- failed boot, kernel 7.0.3
> ================================================================
> 
> Excerpted from dmesg-relevant.txt in the powersupersave capture:
> 
>     28.792s  pcieport 0000:00:01.1: PME: Signaling with IRQ 48
>                      [AMD root port for BMG]
>     28.842s  pcieport 0000:02:01.0: Unable to change power state from
>                      D3cold to D0, device inaccessible
>     28.843s  pcieport 0000:02:02.0: Unable to change power state from
>                      D3cold to D0, device inaccessible
>     ...
>     29.034s  xe 0000:03:00.0: Unable to change power state from
>                      D3cold to D0, device inaccessible
>     29.035s  xe 0000:03:00.0: [drm] Running in SR-IOV VF mode
>     29.035s  xe 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed
>                      to reset GuC state (-EPROTO)
>     29.035s  xe 0000:03:00.0: probe with driver xe failed with
>                      error -71
> 
> The PCI core's first wake attempt at 28.842s (the immediate parent
> bridge of the BMG GPU) fails before any driver probe runs. This
> confirms the failure is in the PCI/ASPM layer, not in xe; xe just
> sees the resulting dead config space and misclassifies the PF as a
> VF.
> 
> 
> ================================================================
> WORKING-POLICY LSPCI EXCERPTS  (relevant capabilities)
> ================================================================
> 
> policy=powersave baseline, root port 00:01.1:
> 
>     LnkCap:  Speed 16GT/s, Width x16, ASPM L1, Exit Latency L1 <64us
>     LnkCtl:  ASPM L1 Enabled
>     LnkSta:  Speed 16GT/s, Width x16
>     Capabilities: [370 v1] L1 PM Substates
>         L1SubCap:  PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+
>                    L1_PM_Substates+
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>         L1SubCtl2:
> 
> policy=powersave baseline, BMG upstream 01:00.0:
> 
>     LnkCap:  Speed 32GT/s, Width x16, ASPM L1, Exit Latency L1 <32us
>     LnkCtl:  ASPM L1 Enabled
>     LnkSta:  Speed 16GT/s (downgraded), Width x16
>     Capabilities: [244 v1] L1 PM Substates
>         L1SubCap:  PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                    L1_PM_Substates+
>         L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>         L1SubCtl2: T_PwrOn=14us
> 
> 
> ================================================================
> PROPOSED FIX
> ================================================================
> 
> Disable both L1SS substates on the BMG card's upstream switch port
> (8086:e2ff) via a DECLARE_PCI_FIXUP_FINAL. Standard ASPM L1 still
> applies, so the link still benefits from the deepest substate the
> BMG silicon handles correctly. The quirk keys on the card upstream
> port, which is shared across the BMG product family, so it covers
> all current BMG SKUs without enumerating individual GPU-endpoint
> IDs.
> 
> The patch is in the attached intel-bmg-disable-l1ss.patch. With the
> patch applied, pcie_aspm.policy=powersupersave boots cleanly on this
> hardware (verification in progress at time of report).
> 
> Empirical narrowing -- ASPM_L1.1 specifically is the trigger.
> 
>   An intermediate version of the quirk passed only
>   PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2 to
>   pci_disable_link_state(), leaving the PCI-PM substate bits armed.
>   After applying that variant, lspci reported
> 
>       L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1-
> 
>   on the BMG upstream port -- i.e. only the two ASPM substate bits
>   were cleared, the PCI-PM substate bits stayed armed -- yet the
>   system booted, xe bound, and the GPU operated normally. Combined
>   with the AMD root port advertising only ASPM_L1.1+ (not L1.2),
>   this isolates ASPM_L1.1 as the specific bit whose activation
>   bricks the BMG card. The PCI-PM L1.x substates were also disabled
>   in the final patch for hygiene, but they are not load-bearing for
>   the fix on this hardware (the GPU does not enter D3hot during
>   normal operation, so PCI-PM substates are inert).
> 
> Remaining open questions for review:
> 
>   1. Is the underlying defect in the AMD Starship root port (cannot
>      wake the link from ASPM_L1.1) or in the BMG e2ff upstream port
>      (cannot exit ASPM_L1.1 cleanly)? If the former, future BMG
>      cards on Intel platforms may not need this quirk; if the
>      latter, the quirk is correct for BMG everywhere. We do not
>      have a non-AMD reproducer to disambiguate.
> 
>   2. Should the quirk also apply to the AMD Starship/Matisse GPP
>      Bridge itself (1022:1483 / 1022:1484-class IDs, see
>      lspci-nn.txt)? That would be a broader brushstroke but might
>      protect other devices presenting the same negotiation.
> 
> 
> ================================================================
> WORKAROUND IN USE
> ================================================================
> 
> Until the quirk lands upstream, downstream users on this hardware
> must boot with pcie_aspm.policy=powersave (or default), losing
> ~25 W of idle savings that the deeper substates would otherwise
> provide.
> 
> 
> ================================================================
> ATTACHMENTS
> ================================================================
> 
> Tarballs produced by debug/20260507-aspm-capture.sh:
> 
>     20260507-204348-powersave-7.0.3.tar.zst
>         -- working baseline
> 
>     20260507-205055-powersupersave-7.0.3.tar.zst
>         -- failed reproduction
> 
> Each tarball contains:
> 
>     manifest.txt           kernel, policy, hostname, GPU BDFs
>     cmdline.txt            kernel command line
>     uname.txt              kernel version
>     nixos.txt              userspace metadata
>     dmidecode.txt          BIOS/board info
>     lspci-tree.txt         PCI topology
>     lspci-nn.txt           PCI device list
>     lspci-vvv-all.txt      full system lspci -vvv
> 
>     gpu-03_00_0/           per-device captures for the GPU and
>                            every PCI ancestor up to the root
>                            complex:
>         lspci-vvv.txt          GPU
>         parent-0-02_01_0.txt   BMG card-internal downstream switch
>         parent-1-01_00_0.txt   BMG card upstream port (e2ff)
>         parent-2-00_01_1.txt   AMD root port
>         sysfs.txt              selected sysfs attributes
> 
>     dmesg-full.txt                full kernel ring buffer
>     dmesg-relevant.txt            filtered for PCI/xe/ASPM/L1
>     journal-kernel-current-boot.txt
>     journal-kernel-prev-boot.txt
>     drivers.txt                   xe / i915 driver state,
>                                   /sys/class/drm
> 
> Patch: intel-bmg-disable-l1ss.patch  (attached separately)
> 
> NixOS 26.05 (nixpkgsRevision:
>     549bd84d6279f9852cae6225e372cc67fb91a4c1)
> 
> Kernel:
>     7.0.3 #1-NixOS SMP PREEMPT_DYNAMIC Thu Apr 30 09:13:05 UTC 2026



> PCI/ASPM: disable L1.1/L1.2 substates for Intel Battlemage discrete GPU upstream port
> 
> Intel Battlemage (BMG-G21 / BMG-G31, e.g. Arc Pro B70) discrete GPU cards
> expose a two-layer on-card PCIe switch:
> 
>     AMD/Intel root port  <->  8086:e2ff (BMG card upstream)
>                               8086:e2f0 (BMG card downstream)
>                               8086:e22x (BMG GPU endpoint, e.g. e223 = Arc Pro B70)
> 
> The platform-facing link (root port <-> 8086:e2ff) is the only link in the
> chain that advertises L1 PM Substates support on both ends. On AMD
> Starship/Matisse (Ryzen 5xxx) root ports, the intersection is ASPM_L1.1
> only (the AMD port advertises L1.1 but not L1.2). When pcie_aspm.policy=
> powersupersave arms ASPM_L1.1 on this link, the BMG card cannot recover
> from the resulting low-power state on subsequent D3cold->D0 transition,
> leaving the device permanently inaccessible:
> 
>     pcieport 0000:02:01.0: Unable to change power state from D3cold to D0, device inaccessible
>     xe 0000:03:00.0: Unable to change power state from D3cold to D0, device inaccessible
>     xe 0000:03:00.0: [drm] Running in SR-IOV VF mode    [misdetected: dead config space]
>     xe 0000:03:00.0: [drm] *ERROR* VF: Tile0: GT0: Failed to reset GuC state (-EPROTO)
>     xe 0000:03:00.0: probe with driver xe failed with error -71
> 
> Reproduces deterministically on Linux 7.0.3 with an Arc Pro B70 in an
> AMD Ryzen 9 5950X system. pcie_aspm.policy=powersave (L0s+L1 only, no
> substates) works correctly; pcie_aspm.policy=powersupersave bricks the
> card on every boot. The 6.x-era blanket `no_d3cold` quirk for Battlemage
> was narrowed to ASUS NUC13 only in 7.0, but that change is orthogonal:
> the failure here is link-state, not device-state, and surfaces
> regardless of d3cold_allowed.
> 
> Disable all four L1SS substates (ASPM_L1.1, ASPM_L1.2, PCI-PM_L1.1,
> PCI-PM_L1.2) on the BMG card's upstream port via a final PCI fixup.
> Standard ASPM L1 still applies, so the link still benefits from the
> deepest substate the BMG silicon actually handles correctly. The
> quirk is keyed on the upstream-port device ID 0xe2ff so it covers
> all current Battlemage SKUs (the GPU-endpoint ID varies by SKU, but
> the upstream switch is shared).
> 
> Empirical narrowing (verified post-fix): with a partial mask that
> disabled only ASPM_L1.{1,2} but left PCI-PM_L1.{1,2} armed, the
> system boots and operates correctly. This isolates ASPM_L1.1 as the
> specific trigger of the brick (the AMD root port advertises ASPM_L1.1
> but not ASPM_L1.2, so ASPM_L1.2 cannot have been activated). The
> PCI-PM substates only activate during D3hot transitions which the
> GPU does not undergo during normal use; they are disabled here for
> hygiene rather than necessity.
> 
> Reported-by: Pavel Shirshov <pavel@7mind.io>
> Signed-off-by: <FILL IN BEFORE SUBMITTING UPSTREAM>
> 
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6289,6 +6289,34 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
> +
> +/*
> + * Intel Battlemage discrete GPU cards (BMG-G21 / BMG-G31; Arc B580,
> + * Arc Pro B50/B60/B70) expose a two-layer on-card PCIe switch. The
> + * platform-facing link, between the host root port and the card's
> + * upstream switch port (PCI device ID 0xe2ff), is the only link in the
> + * chain advertising L1 PM Substates on both ends. On at least AMD
> + * Starship/Matisse root ports, where the intersection is ASPM_L1.1
> + * only, arming L1.1 leaves the BMG card unable to wake from D3cold:
> + *
> + *   pcieport 0000:02:01.0: Unable to change power state from D3cold
> + *                          to D0, device inaccessible
> + *   xe 0000:03:00.0: probe with driver xe failed with error -71
> + *
> + * Reproduces deterministically with pcie_aspm.policy=powersupersave,
> + * works correctly with policy=powersave (no substates). Disable L1SS
> + * substates on the BMG card upstream port; standard L1 ASPM is
> + * unaffected.
> + */
> +static void quirk_intel_bmg_no_l1ss(struct pci_dev *dev)
> +{
> +	pci_disable_link_state(dev, PCIE_LINK_STATE_L1_2 |
> +				    PCIE_LINK_STATE_L1_1 |
> +				    PCIE_LINK_STATE_L1_2_PCIPM |
> +				    PCIE_LINK_STATE_L1_1_PCIPM);
> +	pci_info(dev, "intel-bmg-aspm-quirk: L1.1/L1.2 substates disabled on BMG upstream port\n");
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xe2ff, quirk_intel_bmg_no_l1ss);
>  #endif
> 
>  #ifdef CONFIG_PCIE_DPC


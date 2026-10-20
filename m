Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513484;
	b=uFjDq0H33r9Fjp8sGtqiz54agx3rzJL76God7A4dvboU9UZ2SKXbvs2p4Q8E+HV/ZuQF
	 B5n2Uqdpug6J6aGCeLfJgm5ePcTalk8dbBOgAaiU/cjkAVTfeT+1m/32b/MCZYx+NOXo+
	 E3e48m9jwZF7UgSc2JQTYdGHmQRJHxGTZfwd3sRDItMSQe50mP/8X5DTWi/L3my9B20oT
	 bup/WrJWUiQ4QK11VbDu9Pbj6Ggj1t2idEmF9ePs45yk2cknjBNQ0DuY3uTcb0iGEm+pF
	 MZwoqYu7FewaMXWmHfhND2NIfcYZII+CWi3xfpoa0VrADfsjIm3QpkyAuHAGTwdm9mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=OigSq64J0rt4TZoDpYc+GBYQyOVQhjW9BeOIpOHcBFA=;
	b=BFPA7F4WDPcyKv/+OAisev+qMpatWcuqnWxHXT/w1s6l7Dc74ffJFLpuCTY16vo2VVvj
	 thf0wJhzZhZ6H9oVJD17VAzVlGFHT/rhyOpPQ4WCkWJtMkm+7WAaoJhdqWMs0gu7OxS0z
	 gaUwxx9yw9gTRmTWrX70wy2e0j3A5tmeYuZnlCicltLFvq8jRilX4tBMBBS6HXSg3Q5IZ
	 doSyjqEFz06ElRbzUKMy+2p3iCtWORJ0nRuU1mxuSgh+AB4UExZ4mPDYxUvFeR3MFlLkj
	 TE8Q6Qb50TR7xKwV3rnIN0kmsNY8y6bHS6QHvW4Ev0Iro2JwtQsiq2phKbsmnBRtUJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JcbfB6El;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D160A2608
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD9D160A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JcbfB6El
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-679a2b540f3so3233325d50.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792513483; x=1793118283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :user-agent:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OigSq64J0rt4TZoDpYc+GBYQyOVQhjW9BeOIpOHcBFA=;
        b=JcbfB6ElF0dXJk/pdHAhuxeqJ+cksCGm7FNEjK/67u2FsqW+EOwEhBzLJk+ylc5nNv
         HO1ChSiigoKMgW+OsknuONzCRobFmd2ys/9oBt/PJVw+vsfwTLcduSTXNDvDsq5PMq1R
         9B9FvRT0UiP9LXbwlBuf5i2UaQgCmDMIwC++Cq/fK0p00DDQbyVWt9TjncLwrGIo2QRz
         ub/5ieaLv9hU0DjWL4ZSoNFpjjHqbcRZt/YGoPyme5KFn43CkB1zlNFLbj0saVWc1XPS
         EH1yMbJXitOM4SmylHIQW2o7Of1BLnRMwllmhTZlRAV2S0Rm70u04080XyP3YKD/qC8I
         mgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792513483; x=1793118283;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :user-agent:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OigSq64J0rt4TZoDpYc+GBYQyOVQhjW9BeOIpOHcBFA=;
        b=qphcXLkJm9wvuPza5A1VrKNbIVvsO2qs3gKGJH6ZHYcGl+ASF4brKLpwVIQg8EGKAq
         vU/2IwMeU+6OUD1R21uWuYpSlg9cpJN17Y/wyJllDVS1iIsr+EhbY/G5gLRtPoP/hGjA
         4XFS53ruIir3nbwUcqm6uo9aI4uQ0cCRU6ydzt9ZmSQkPIStZvT+pmZUevgpuTL2Cu7X
         AUe5p8tQd3Qya7HAnoA4gxJoIFZS/yNApCuTmfrVTMRNXh0HfgJhy6g1PQ9nr5ZVxgOW
         JwcPWxawe19W4VEIHXrzU10XQ6VFuLi8oE6MTEN3RhC6MlVFbRSK0NFHK8t6830ywnLc
         kh8A==
X-Forwarded-Encrypted: i=1; AKwUvBw9qc7xp/2uLMwQ8vTIk5LPBrMxtWxMw8Eyp0cBJ+eXJDk1VEjVm5DXspm/IT912KYa7+XKF3bQYyw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4mbQWTys3uzN74qdJ5aX+CF3Uh1imA8Q6TG3XSMqzzR4qxDnd
	upJkteIsh97E5Nbt1DnkrKFnOkvefDysyUcCOO/PahuWST67FdW4GJKr
X-Gm-Gg: AYBFou1klagGjQb3LAONWXXZLEZ/qjWFagdjm/LLQiKNEMekV+kOhz/LT4sDGKk11Ll
	7n5nkb2xIG28nASH9NXcDuORv3DiPEq/NemqRCsRe3ZNMpAfUVNxPa/QpxNZZwQ7ty/AR6Gqqw0
	/iTjk8baP4qdOhOChQQ7b2zkPBG/uLoZPgqTs0Q1k4wreKbVhlNmzuMOacAi71YqI4cZjx4Ekbk
	2m/s28uLXVNNezDhkBXzVqccj0iTHL9B7gkUB64iVSkpaHLCR2uJduK8L79KyZQFdoYRwNN3rEN
	B/Qwx/7uwsh2pr3ypA9obcezq2+77gK8TYjoeq1Lj3VCZVwpNDgrzWq//x5vpnJ1qt7tr2yxVVL
	q61P//2FkULLOBa+08gS4QS8hdfMJc0D2aDyuDawhnoQVM8XqU34bfTP3jMAPzr5UF0O8GbwqrY
	PJR3n6uaiePzvNVuEMbFbDyvDl0VC6H4xogxLpBZsJxnWomNSwvowKvEx051fundIFDNt0qkFVY
	P/eGGbICj1Qt8Y6vKhR/D2Q3FecxaOS8asEHVLH1DvKifomic+fYWEpugYI7Q6/DV1oA/HjUs8w
	1rMsuToy0Nu5ZgrvHbcM0IkQsGaCKOOykelGna1wangB+4cNytgQ7gU8Ij7fAmU0lhq77podqHw
	wDg3Spg==
X-Received: by 2002:a05:690e:43c3:b0:679:980d:996d with SMTP id 956f58d0204a3-679ca75c039mr1677629d50.23.1792513482689;
        Tue, 20 Oct 2026 09:24:42 -0700 (PDT)
Received: from ehlo.thunderbird.net (212.153.88.200.l.sta.codetel.net.do. [200.88.153.212])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1e095efsm5543486d50.5.2026.10.20.09.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 09:24:41 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:24:40 -0400
From: Jason Perlow <jperlow@gmail.com>
To: aditya.garg@linux.dev, baolu.lu@linux.intel.com, dwmw2@infradead.org
CC: iommu@lists.linux.dev, bhelgaas@google.com, linux-pci@vger.kernel.org,
 arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 regressions@leemhuis.info
Subject: =?US-ASCII?Q?=5BREGRESSION=5D_intel-iommu/brcmfmac?=
 =?US-ASCII?Q?_DMAR_fault_on_Broadcom_PCIe_wifi=2C?=
 =?US-ASCII?Q?_v7=2E3-rc7_-=3E_v7=2E3_final_--_candida?=
 =?US-ASCII?Q?te_mechanism_and_proposed_fix_path?=
User-Agent: Thunderbird for Android
Message-ID: <7A444F17-F81B-4A33-A7AF-9E30B3EEFA67@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Resending, stupid Gmail mobile client/HTML/apologies =2E

=3D=3D=3D ORIGINAL REPORT =3D=3D=3D

Hardware: Intel CoffeeLake-H platforms, various=2E The affected device is =
a Broadcom BCM4364 802=2E11ac PCIe wifi adapter (14e4:4464) at 0000:05:00=
=2E0 on an Apple MacBookPro16,1 (T2 Mac)=2E Aditya, including you directly =
since this is T2 hardware; copying iommu/pci/wireless because the fault sig=
nature and the fact that it reproduces on only one of five tested machines =
(at the time of the original report -- see follow-up below, that has since =
changed) looked like it needed eyes on the core IOMMU/PCI path, not the dri=
ver=2E

SYMPTOM

Between a locally-built v7=2E3-rc7 kernel and a v7=2E3 final kernel (same =
=2Econfig template, same patch series beyond one T2-specific AER quirk that=
 is upstream in final and therefore held out of our patch set), the BCM4364=
 wifi firmware on the affected unit crash-loops continuously:

   brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4364b3-pcie for ch=
ip BCM4364/4
   brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4364/4 wl0: =2E=2E=2E
   ieee80211 phy0: brcmf_fw_crashed: Firmware has halted or crashed

repeating every ~6s, indefinitely=2E dmesg shows the actual mechanism -- a=
 real IOMMU DMAR page fault on the wifi device, timed to the same cadence a=
s the firmware crash:

   DMAR: DRHD: handling fault status reg 3
   DMAR: [DMA Read NO_PASID] Request device [0000:05:00=2E0] fault addr 0x=
ffeff000 [fault reason 0x06] PTE Read access is not set

Four such faults logged at uptime 13=2E4s/19=2E4s/25=2E3s/31=2E2s, each im=
mediately followed by a brcmf_fw_crashed event=2E intel_iommu=3Doff removes=
 the fault and the crash entirely (8+ minutes stable, single clean firmware=
 load, stable AP association)=2E The prior v7=2E3-rc7 kernel on the SAME un=
it has zero DMAR faults and zero firmware crashes with IOMMU on by default,=
 so this is a regression introduced somewhere in the rc7->final window on t=
his unit, not a long-standing issue=2E

ORIGINAL 1-of-5-machines SURVEY (since superseded, see follow-up)

We initially ran the identical kernel build across five machines and only =
one faulted at the time: the affected unit; a second MacBookPro16,1 with th=
e same BCM4364 chip; three non-Mac x86_64 machines spanning three more wifi=
 vendors (Intel iwlwifi AX201, Intel iwlwifi Centrino 2230, Realtek rtw89 8=
852BE), all clean=2E IOMMU was actively translating DMA on every one of the=
 five machines; only the one unit faulted at that time=2E

WHAT WE RULED OUT BEFORE WRITING IN

 * AER/ANFE quirk on the T2 Secure Enclave device: its PCI ID match is exa=
ct (Apple SEP, 106b:1802) and does not touch the wifi device (14e4:4464); r=
eal PCI topology on the affected unit also shows SEP and wifi on separate r=
oot ports (00:1b=2E0 -> [04] vs 00:1c=2E0 -> [05] off the PCH), so there's =
no shared-root-port mechanism either=2E
 * brcmfmac driver source: git diff v7=2E3-rc7=2E=2Ev7=2E3 -- drivers/net/=
wireless/broadcom/brcm80211/ is empty=2E
 * Our own config template: byte-identical between the rc7 and final build=
s=2E
 * The upstream Kconfig stanza for INTEL_IOMMU_DEFAULT_ON (drivers/iommu/i=
ntel/Kconfig): byte-identical text between v7=2E3-rc7 and v7=2E3 (default y=
, no depends on)=2E

THE ONE ANOMALY WE CAN'T YET EXPLAIN

Despite the last two items above being unchanged, the actual generated =2E=
config has CONFIG_INTEL_IOMMU_DEFAULT_ON unset after make olddefconfig agai=
nst the rc7 source tree, but =3Dy after the same process against the final =
source tree, even though our template explicitly answers "# CONFIG_INTEL_IO=
MMU_DEFAULT_ON is not set" in both cases=2E Our working theory is that some=
 other symbol started selecting/implying INTEL_IOMMU_DEFAULT_ON between rc7=
 and final -- which would override an explicitly-seeded "not set" answer du=
ring olddefconfig resolution -- but we have not identified which one yet=2E

=3D=3D=3D FOLLOW-UP (what changed since the original report) =3D=3D=3D

1=2E The second test unit we called "clean" (CHIMERA, identical MacBookPro=
16,1 model and BCM4364 chip to the affected unit) was NOT actually immune -=
- left running longer, it crashed at 41 minutes uptime with the identical s=
ignature=2E So this is not host-specific or even config-specific within a m=
odel; it is cumulative/probabilistic with firmware-crash retries, not a sta=
tic per-unit property=2E We now apply intel_iommu=3Doff to both units=2E

2=2E We tested iommu=2Estrict=3D1 (forcing synchronous TLB invalidation, n=
o lazy-unmap window) on the affected unit=2E It does NOT fix the problem --=
 9 firmware crashes and 18 DMAR faults in the first minute, same as baselin=
e with lazy invalidation=2E This rules out a stale-mapping-during-lazy-unma=
p race specifically=2E The IOMMU is failing to produce a valid mapping for =
the address the device requests, not failing to invalidate an old one in ti=
me=2E

CANDIDATE MECHANISM

The four DMAR fault addresses we captured are all exactly 4K-page-aligned,=
 clustered within a ~2MB window, with irregular (non-fixed-stride) deltas b=
etween them -- consistent with each firmware-crash retry requesting a genui=
nely fresh page, not a sub-page cacheable-alias bug=2E

Reading drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie=2Ec (v7=2E3)=
 shows why=2E On firmware crash, the bus =2Ereset op (brcmf_pcie_reset()) r=
uns this sequence, unconditionally, for every chip revision:

 1=2E Disable ASPM=2E
 2=2E A real hardware watchdog reset of the wifi chip's own silicon: WRITE=
CC32(devinfo, watchdog, 4) -- a write to the BCMA ChipCommon core's watchdo=
g register, Broadcom's standard SoC-wide hardware reset mechanism (used her=
e in place of a PCIe FLR)=2E
 3=2E Restore ASPM=2E
 4=2E Free the old ring buffers (brcmf_pcie_release_ringbuffers, dma_free_=
coherent) and allocate fresh ones (brcmf_pcie_init_ringbuffers -> dma_alloc=
_coherent, confirmed clean, correct DMA-API usage -- no raw pointer math, n=
o dma_map_single/dma_map_page misuse)=2E

So every firmware-crash recovery cycle contains an actual chip-level hardw=
are reset of the wifi silicon, sitting inside the normal recovery path, imm=
ediately before fresh DMA buffers are allocated=2E The IOMMU has no visibil=
ity into that internal chip reset -- it only tracks dma_alloc_coherent/dma_=
free_coherent calls=2E If the chip's internal DMA engine state (cached poin=
ters, in-flight descriptor/prefetch state) is not fully re-synchronized wit=
h the IOMMU's page tables across that reset window -- plausibly interacting=
 with whatever changed in pci_dev_wait()'s reset-timing behavior between v7=
=2E3-rc7 and final, one of the only real PCI-core diffs we could find betwe=
en those two tags -- a stale or premature DMA read from the chip in that wi=
ndow would produce exactly "PTE Read access is not set": a page the IOMMU h=
as no reason to have mapped yet=2E

This reads as plausibly Broadcom-specific rather than a generic any-PCIe-w=
ifi-vendor bug: in our survey across Intel iwlwifi (two chip generations) a=
nd Realtek rtw89, all clean on identical kernel/IOMMU config, none of those=
 drivers perform a full chip-level silicon watchdog reset as part of routin=
e firmware-crash recovery the way brcmfmac does=2E That is a direct consequ=
ence of Broadcom's wifi chips having their own embedded ARM co-processor an=
d firmware, versus a more host-driven firmware model elsewhere=2E

We have not proven this causally yet -- it is a source-grounded mechanism,=
 not a confirmed root cause=2E

PROPOSED FIX PATH

1=2E Bisect: the real fix, if this mechanism is right, most likely belongs=
 in one of two places -- (a) brcmfmac's reset sequence, inserting a synchro=
nization point (barrier, or a readback to force completion) between the poi=
nt where the fresh DMA mapping is guaranteed IOMMU-visible and the point wh=
ere the device is signaled ready to resume (brcmf_pcie_hostready / the mail=
box write that follows), or (b) PCI/IOMMU core, if pci_dev_wait()'s v7=2E3 =
behavior change doesn't give the IOMMU enough time to fully settle before t=
he device can issue a post-reset DMA=2E We don't yet know which=2E
2=2E We are rebuilding with CONFIG_DMA_API_DEBUG=3Dy to reproduce this on =
the affected unit=2E That should show the exact call site and timing of the=
 bad mapping, which would tell us definitively whether this is a one-line b=
rcmfmac timing fix or something deeper in IOMMU/PCI core=2E Will report bac=
k with results=2E
3=2E In the meantime, worth testing as a less blunt interim workaround tha=
n intel_iommu=3Doff: iommu=3Dpt (passthrough -- disables DMA remapping but =
keeps interrupt remapping)=2E Haven't tried this yet ourselves=2E

Happy to share full dmesg, the DMA_API_DEBUG output once we have it, or te=
st a proposed patch on real hardware -- we have the affected unit and can r=
eproduce on demand=2E

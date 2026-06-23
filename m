Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF666379EF5
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210730; cv=none; b=cL6mZby5EpkryFuv0nRgF0E6KeJ9LDQNDGaiKi/eUrImLh8e5Jr+YimAG6WR3XXtks79RYrmTH8npTX/cZlt3tvcdrt410LlTeW2NuLj/c/czXLAzGRQlI0WSWh2+4ntGO03j0NhQXt+ELGukke4Zf+Tgq0L9nI0YQQuOgtQlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210730; c=relaxed/simple;
	bh=8XkBg4KlI7ww2gsGdguvjCOorhLfEdFr34GILBMg9Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jBXJvGb+M5g/ZGPJh/T3sXSn6wM9heqmagarfq+8h8MWJ+YVtz2askK80l03VvBHMCA2T9aiPnyTXR63M1FyRxWtfLSFBGlCT4aZD4gE4eesYwJsT2TMGvz/DdUVWwa+rYgY9aJsEAziwtBfJymLIMOCAb2/0kwveQtuMhAb8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSm2MpRy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSm2MpRy"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso7137781a12.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782210727; x=1782815527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qkh/VbDh+NKBBYckhxh/lBQ/z9Y9ZEIStugjeMtCnZI=;
        b=OSm2MpRy9aCBb0c6Y1GfisoWUjlYfXxW04KE1BDHBJyXPjxp82XdJMBsumottPjqcm
         onMuk5m1JZCT26IgV0iCKjQUM+BI9Mfb3nFI1Ja3YrNNw+fGdlKIIlqNzp9BWKXiLhG9
         eyffKHhf0sfnvLNb73jBGN3wa0FjYs1uG2/vo0Q3TSPVdA/TDs8XpprqdXWkXNCQElDP
         VnIX0OVKLJkcDrDtl5ycpG9wc+B2gKSWoAA/R59MlVeNIykb6KkIZJIM3UwmZ9AAYNqE
         /9qXP+MaiT8ddj0W32CMBZAF7TcGh6Y2YlKlq6J6Mh2B0ouvIrf+gPVUNaAiU3Fjqwzi
         Gw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782210727; x=1782815527;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qkh/VbDh+NKBBYckhxh/lBQ/z9Y9ZEIStugjeMtCnZI=;
        b=RRbDcCPf45XVzwBbN5fR6va0O+/qAdOmCYAniWOw1Yv5v/4woh85e12DC8ctniKVXa
         XoqkCceeH39VAiexGM4WA1FuUypXZ4ZCh8H0cB9MbMjtktD+6qf6BU9tEVeaEBk/2h38
         su2q00n2VJC5AO61b7vBYTUn8erVmnmLBI/8CxPXypx/RsX56e8I0k5LV3sZWr+guhwz
         qGdgkyNUWGT0D3eGZs5bbJ46Bt9/X9i1OLn6mVKS5/r5suryIrznPm6VT9CB/2aC0P0I
         fw7orIIKGdwj9k7HlxD1mjNMAwnEGsHo/qBP9AD5v/1tR0ghvHZPQhEel9HtH8J/5/07
         pJdg==
X-Forwarded-Encrypted: i=1; AFNElJ+wm0374AzTMyKLhuRcV5uptbhO7/s0IrWOISp17Ijgk4ZrBc62yEV0qxIiAK2IK/+L7Hi1Ok9dRQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy12cf9Ro83xa8wOBPBuxk9xFwOMJTaGbdmWaqkKsoT7V7Vpzv
	sjgGpeNBunVBsxpp6BJ4uWj3ay3qXNlA8GH+r7HNrYUqtzyNADKCqZ4J
X-Gm-Gg: AfdE7ckX3o4L1z+dm7fn56nzx++Kx09RXk3KJ6vhCn6CeXnVNVu+SWHE5Q3J955My1V
	m8GoUdikGC6O2w5RfygnzVlcuqmziId93S14uDHMVV8RUMJcInEN3VgSH0zZ2ZR691f2fMLMjqW
	l5sW95E/0ssPXpDBhpncjqQVvd0XiYdQKz8oVbeh+G7l1fCEsSvfweDFYxiYIYdc7snJR3WZynC
	jBKT54XCtPr11AZDFtFmxUeOHgEWie2ooOSkjFW5Za0MEhstw49Cr1AVmkb9a9Q0b6XaxIkrdXU
	9cfk/GkPXUrWfxVyhR2MifvZi79WKp0xxBj0GtXuWY3iCVxVd+Q2EVqg9jsobJ1cHoP2KAodhk8
	XruapqPysuBB8pZF7/8/C4/uSiO8QCegbBeNWD3l0CiPqf0L3tHKCwsDtnSK0doDcm1qzuLBa9h
	3cV6CodxfJFbv5xeWHiltCXq3jtHDD8/y0VXyNpV59O64lhY/cgXmA/jZyHHH/xgwwdWG+g3FUb
	FGR/2hg
X-Received: by 2002:a05:6402:2710:b0:697:d645:a9db with SMTP id 4fb4d7f45d1cf-697d645acfamr1626215a12.23.1782210727148;
        Tue, 23 Jun 2026 03:32:07 -0700 (PDT)
Received: from localhost (dhcp-91-156.inf.ed.ac.uk. [129.215.91.156])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be31c73sm4625527a12.17.2026.06.23.03.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:32:05 -0700 (PDT)
Date: Tue, 23 Jun 2026 11:32:04 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: nathan.lynch@amd.com
Cc: shivankg@amd.com, Stephen.Bates@amd.com,
	PradeepVineshReddy.Kodamati@amd.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: SDXI on AMD EPYC (in relation to =?utf-8?B?TmF0aGFu4oCZ?=
 =?utf-8?Q?s?= SDXI dmaengine patchset)
Message-ID: <20260623103204.qvmd5luse4vmhwl3@wrangler>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan and Shivank,

As Shivank already probably knows, I've been experimenting with kernel
memory offloading lately, especially in the context of THP/compaction.

I am in fact in the process of doing some experiments with Shivank's
page acceleration series [1] on Intel Sapphire Rapids with Intel DSA.
The major problem so far is that migrate_pages() is largely bottlenecked
by rmap, not copy bandwidth. However, that's a different story for now.

I have a dual-socket AMD EPYC 9004 in the lab (I pasted /proc/cpuinfo at
the end) and I wanted to see if I can get the SDXI series from Nathan [2]
to work on them, as this will open the door for me to experiment more on
AMD hardware.

I don't know if these CPUs are equipped with these accelerators or not.
lspci is showing these devices (four on each NUMA node):

# lspci | grep SDXI
06:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
21:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
41:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
64:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
81:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
a3:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
c1:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI
e1:00.1 System peripheral: Advanced Micro Devices, Inc. [AMD] SDXI

All of them have these PCI specs

vendor=3D0x1022
device=3D0x14dc
class=3D0x088000
subsystem_vendor=3D0x1458
subsystem_device=3D0x1000
BARs=3D 	BAR0/1 512 KiB prefetchable
	BAR2/3 512 KiB prefetchable

Class 0x088000 is:
base class    0x08  System peripheral
subclass      0x80  Other system peripheral

However, the PCI device class does not actually match the class from
Nathan's patchset [2]:

+#define PCI_CLASS_ACCELERATOR_SDXI		0x120100

+static const struct pci_device_id sdxi_id_table[] =3D {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
+	{ }
+};

So these functions appear to be exposed as generic system peripherals
(base class 0x08, subclass 0x80) rather than as SDXI processing
accelerators (base class 0x12, subclass 0x01).

Do you know whether these AMD 1022:14dc on this platform are actually
SDXI accelerators? And if so, whether the class code 0x088000 is
a firmware issue, or just the old (pre-standard) class used?

I tried to force probe these devices by also matching against 1022:14dc,
but the system resets after pcim_enable_device().

So I would like to know if these devices are actually SDXI engines, and if
so, whether Nathan's SDXI driver should bind to them at all, or whether
additional enablement/firmware is required.

Thank you

[1] https://lore.kernel.org/all/20260428155043.39251-2-shivankg@amd.com/
[2] https://lore.kernel.org/all/20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.co=
m/

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 25
model           : 17
model name      : AMD EPYC 9224 24-Core Processor
stepping        : 1
microcode       : 0xa101158
cpu MHz         : 1500.000
cache size      : 1024 KB
physical id     : 0
siblings        : 48
core id         : 0
cpu cores       : 24
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 16
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe=
1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl xtopology nonstop_tsc c=
puid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 pcid =
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_leg=
acy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs ski=
nit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpuid_=
fault cpb cat_l3 cdp_l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_=
enhanced vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512=
f avx512dq rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni avx51=
2bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_t=
otal cqm_mbm_local user_shstk avx512_bf16 clzero irperf xsaveerptr rdpru wb=
noinvd amd_ppin cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean =
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif=
 x2avic v_spec_ctrl vnmi avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes v=
pclmulqdq avx512_vnni avx512_bitalg avx512_vpopcntdq la57 rdpid overflow_re=
cov succor smca fsrm flush_l1d debug_swap
bugs            : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass s=
rso spectre_v2_user tsa vmscape
bogomips        : 4999.84
TLB size        : 3584 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 52 bits physical, 57 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

--=20
~karim

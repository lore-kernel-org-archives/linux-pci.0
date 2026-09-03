Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C0F3EC80C
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417088; cv=none; b=sha14SwYIsz7x+H5/wlp8Ny3KPutbnw6d1mmnE7njFl8V6GwF2IhvIGc0WuDi/waP3Osxg8wjCk0uk61IFCblXlHdqjSsyCxRpfU7vaSTm3vyWNSEMD7yFlMeVOHiuZ+Gt7zo0ESk+26dt0J7L0KjddaQZsXHzoXl3Fg5uOjirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417088; c=relaxed/simple;
	bh=O2PFFrdk6gWzx5hgro99kvBdUZP8FTuMdm9dvKkUErI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nh3QfmjrBFv8TtUlwvk2EnB9zRyDiucbVGiMSLXI6jOSnizX35pXCCpPTr9stGJ3R3WeT41tnu0u3GxVFFj842AcHNMetGyTEBZjlPBb7DXW63UMkPZxIqlnT/zwlU4SzoYEnXDnQYa8fronUGfgzRMsjlMUR5wXGO1k8bgXdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exabit.io; spf=none smtp.mailfrom=exabit.io; dkim=pass (2048-bit key) header.d=exabit-io.20251104.gappssmtp.com header.i=@exabit-io.20251104.gappssmtp.com header.b=HuRaf1uJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exabit.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=exabit.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exabit-io.20251104.gappssmtp.com header.i=@exabit-io.20251104.gappssmtp.com header.b="HuRaf1uJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1925388b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exabit-io.20251104.gappssmtp.com; s=20251104; t=1788417086; x=1789021886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oyn1eAlWhmjTg1gDpWtJ1K38m8614GuSxJp7RLTJwds=;
        b=HuRaf1uJNYkvowiZ9PheKqPlM3ytNZmb0kYSsiHRu/gcVWoaV3gDdNCDvu+cJbUJNW
         QGaVf8IeFitAT9J2Nt3YbxPT6ylQQ1s/j6LOTDC4CtqUWG5ycbXNZwRFLvj74dohpU9n
         PMRajO8mphOuIdqPmZHro6ZQGFs2llUQ0LJ1FoWhXOe5vZV730CpOaXxNbqJpmq6MQwL
         v1tdY+otwpQ9bspYgdicMDxDFD0EwK3jrnphR0oxrlbL9eCNMTZgy4Ww8SNwyzuhRAcS
         tqzo8LIU+lyD0L4o8RobEh/Xad68bhuU/t4rwofIi89M6eKyfJXQY9El2Y58fQi8j1jJ
         zPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788417086; x=1789021886;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oyn1eAlWhmjTg1gDpWtJ1K38m8614GuSxJp7RLTJwds=;
        b=haBZ45fg5L6sv0Oi6Uhc/WUTvny6UAEYOmULX1yBskF9pzht8GPN2W4YwlpRIr73ja
         thHk+7J2LkUeUBN5cbPfaJnfwurRIv6RY6BXyLlgIzWt242geEl/09i81BD/MX8uMCff
         cfXixHz0nh1F3lFFG9he1b47fU3trWGeBNuxKXwR06j0c7T9de88qYAvQwNDg4LFPGuO
         PP9uoD3YJiOqY4DxiXlMIiWl8VOgchSgJ6Dp/QiBP04zP4MkrqVPM/tazIxpiplr8/iY
         UIZbK74MDuXo3UnGVw50Q9sXyTgORDkhs4cp64Jj01FG0ZhrfQHeOdeQ2ACQ9xTfhfsQ
         XDGA==
X-Gm-Message-State: AFuF++mS1RB3EsCdLd7tyIqbYa63xQzRQxDCrt+WVMNkyif8Jj3VAaWQ
	inVrbxLNxwXT0VLUQD4pbVh2RKLbrIg2kQ0FZ9I+uqa8P9oTj81iDv8li+1UVHB7SP3vmuUiYyP
	r9c2Ttdc=
X-Gm-Gg: AYBFou0b8O1rhqkX/1NayfJ02/rf3/tSxGnNG8LMCgnVgndRY1Mvm0zKkC16dUbYV4y
	4sGXkts5pzVGc+wJIysRFRZG797BM+sp+UDj7nK108Ks6JIbKaykiXl26sjw9CNdbon+80W9yeR
	EDsteX/3L02HjChNMDFtn5JqEZLYFIFxtRHCpGgnXURimzviAX9b0p93I2qS+6w/+jNFKWAEIIA
	QUCf/y57acUG49cTuVxBxgCboi5qdA0rbS8Prg7anxGmsA4xSiVsuxYuwPx8X66cvaBmJvJU50r
	CWuqNeC8pJoblVllc2EX0i78LRi9cUjrcQKRyfv3fQ2vQ8TBNtjCyMQozDFGUNFhaY7DE7bOSnf
	mD3vmhoqSy8H6IP9cxdQXHfjD3hedkxyr8xhjaHEEM5uEEnxx3/Kklrdrd5Uz3O5va8wcPZ0sIN
	fqGkVh8nNFOhuoG2PhCEjtjXeFvxMKPGQWmBhMI0cf7HfywYc4jxY8fkTma0F78vXe5my1sw053
	kYPCBQEobOkCgCdizJoxp3nxpc=
X-Received: by 2002:a05:6a00:c8d:b0:83e:b443:965e with SMTP id d2e1a72fcca58-85ed5ccca45mr14370109b3a.3.1788417085359;
        Wed, 02 Sep 2026 23:31:25 -0700 (PDT)
Received: from macpro2019-01.. (c-71-236-167-8.hsd1.or.comcast.net. [71.236.167.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db23f8d8asm2536761b3a.12.2026.09.02.23.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 23:31:24 -0700 (PDT)
From: Nikolas Joshua Britton <nbritton@exabit.io>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	regressions@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Nikolas Joshua Britton <nbritton@exabit.io>
Subject: PCI: bridge window undersized when child bridge windows are larger than their alignment (regression since 3958bf16e2fe, v7.0)
Date: Thu,  3 Sep 2026 06:31:24 +0000
Message-ID: <20260903063124.9316-1-nbritton@exabit.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On a Mac Pro 7,1 with two Radeon Pro Vega II Duo cards, enabling 32 GB
Resizable BARs leaves exactly half the GPU dies with no BAR at all. The
shared root-port prefetchable window is sized as the plain sum of its two
child bridge windows, but each child secretly requires a 32 GB-aligned
start, so the window that gets allocated is ~32 GB smaller than the span
that is actually needed. The second child of each pair loses,
deterministically.

There is 1 TiB of free space in the host bridge's _CRS window, so this is
not address-space exhaustion.

This is a regression. On the same machine, with the same script
(resize-amdgpu-bars, https://github.com/exabit-io/resize-amdgpu-bars,
which performs the sequence under "Reproduction" below at boot) and the
same sequence of operations, Ubuntu's 6.8.0-138 (upstream 6.8.12),
6.11.0-29, 6.14.0-37 and 6.17.0-42 kernels all size the shared window at
96 GiB (48 GiB per child) and all four dies get their 32 GiB BAR on the
first attempt, every time (each kernel tested from a full power-off).
7.0.0-30 is based on upstream 7.0.12 and fails identically from a cold
boot and from a warm reboot. I have traced it to commit 3958bf16e2fe
("PCI: Stop over-estimating bridge window size"), first shipped in v7.0;
analysis and a proposed one-line fix are below. Ubuntu's setup-bus.c is
byte-identical to v7.0.12, which already includes 8cb081667377 ("PCI:
Fix alignment calculation for resource size larger than align") and
dc4b4d04e1ca ("PCI: Prevent shrinking bridge window from its required
size"), so those do not cover this case; current master has no further
change to this logic.


System
------

  Machine:  Apple Inc. MacPro7,1, BIOS 2103.160.2.0.0
  Fails:    7.0.0-30-generic (Ubuntu 24.04 HWE, 7.0.0-30.30~24.04.1,
            upstream 7.0.12)
            self-built upstream v7.0.12, unpatched, Ubuntu config trimmed
            with localmodconfig (control; fails identically)
  Works:    6.8.0-138-generic  (Ubuntu 24.04 GA, upstream 6.8.12)
            6.11.0-29-generic  (Ubuntu 24.04, linux-generic-6.11)
            6.14.0-37-generic  (Ubuntu 24.04, linux-generic-6.14)
            6.17.0-42-generic  (Ubuntu 24.04, linux-generic-6.17)
            (all four: identical 96 GiB window layout, 4/4 dies, one
            4-node XGMI hive, no traces; verified 2026-09-02)
            self-built v7.0.12 + the patch below (same config as the
            control): 4/4 dies, 128 GiB root-port window, cold boot and
            warm reboot, no traces
  Cmdline:  ro log_buf_len=16M pci=realloc mitigations=off
            (the 6.x and the self-built 7.0.12 boots also carried
            intremap=no_x2apic_optout; it has no bearing on this)
  GPUs:     4x Vega20 [1002:66a3], two dies per Vega II Duo card
  BAR0 ReBAR capability: 256MB 512MB 1GB 2GB 4GB 8GB 16GB 32GB
  BAR2 (doorbell): 2MB, fixed in practice


Topology
--------

Each Duo card presents two dies behind ONE root port, each die on its own
sub-bridge chain:

  +-[0000:06]-+-00.0-[07-0e]--00.0-[08-0e]--+-08.0-[09-0b]--00.0-[0a-0b]--00.0-[0b]--00.0  Vega20
             |                              \-10.0-[0c-0e]--00.0-[0d-0e]--00.0-[0e]--00.0  Vega20
  +-[0000:16]-+-00.0-[17-1e]--00.0-[18-1e]--+-08.0-[19-1b]--00.0-[1a-1b]--00.0-[1b]--00.0  Vega20
                                            \-10.0-[1c-1e]--00.0-[1d-1e]--00.0-[1e]--00.0  Vega20

So 08:08.0 and 08:10.0 are siblings sharing the prefetchable window of
07:00.0 / 06:00.0. Each subtree contains one Vega20 with BAR0 = 32 GB
(alignment 32 GB) plus BAR2 = 2 MB, i.e. each child bridge window is
32 GB + 2 MB = 0x800200000.

Both cards fail identically. Card 2 (16:00.0 / 18:08.0 / 18:10.0) is
omitted below for brevity; its trace is byte-for-byte analogous.


The arithmetic
--------------

  host bridge _CRS window   0x90000000000-0x9ffffffffff   1 TiB free
  06:00.0 / 07:00.0 window  0x90000000000-0x910003fffff   0x1000400000
                                                          (64 GiB + 4 MiB)

  08:08.0 window assigned   0x90000000000-0x908001fffff   0x800200000
  next free address                       0x90800200000
  08:10.0 needs 32 GiB alignment, so its next legal start is
                                          0x91000000000
  08:10.0 would then end at               0x91800200000
  but the parent window ends at           0x91000400000  <-- ~32 GiB short

  span actually required    0x90000000000-0x91800200000   0x1800200000
                                                          (96 GiB + 2 MiB)
  span allocated                                          0x1000400000
                                                          (64 GiB + 4 MiB)
  shortfall                                               0x7ffe00000
                                                          (32 GiB - 2 MiB)

The telling detail: 0x90800200000 + 0x800200000 = 0x91000400000, which is
*exactly* the parent window's exclusive end. In other words, had the child
bridge windows only needed ~1 MiB alignment, the two of them would have
fit perfectly, to the byte. The sizing pass produced a window that is
correct if and only if the children can be packed back-to-back, which
they cannot, because the assignment pass then enforces the real 32 GiB
alignment inherited from the BAR inside each child.


Good kernel, for comparison
---------------------------

Same hardware, same steps, 6.17.0-42 (6.8, 6.11 and 6.14 are identical).
The parent is sized for the worst-case packing, and both children fit:

  0000:06:00.0: 90000000000-917ffffffff [size=96G]      <- shared parent
  0000:08:08.0: 90000000000-90bffffffff [size=48G]
  0000:08:10.0: 90c00000000-917ffffffff [size=48G]
  0000:0b:00.0: Region 0: Memory at 90000000000 (64-bit, prefetchable) [size=32G]
  0000:0e:00.0: Region 0: Memory at 91000000000 (64-bit, prefetchable) [size=32G]

i.e. 96 GiB = 3 x 32 GiB: each child gets (32 GiB + 2 MiB) rounded up to
the next 32 GiB boundary plus slack, so the second child's aligned start
is always inside the parent. That is the 3A + eps span from the arithmetic
below, and 7.0 allocates 2A + 2 eps instead.


dmesg (7.0)
-----------

Sizing and assignment of the shared window, then the two children:

  pci 0000:06:00.0: bridge window [mem 0x90000000000-0x910003fffff 64bit pref]: assigned
  pci 0000:07:00.0: bridge window [mem 0x90000000000-0x910003fffff 64bit pref]: assigned
  pci 0000:08:08.0: bridge window [mem 0x90000000000-0x908001fffff 64bit pref]: assigned
  pci 0000:08:10.0: bridge window [mem size 0x800200000 64bit pref]: can't assign; no space
  pci 0000:08:10.0: bridge window [mem size 0x800200000 64bit pref]: failed to assign

The failure then cascades down the losing chain, and the endpoint is left
with neither BAR0 nor BAR2:

  pci 0000:0c:00.0: bridge window [mem size 0x800200000 64bit pref]: can't assign; no space
  pci 0000:0d:00.0: bridge window [mem size 0x800200000 64bit pref]: can't assign; no space
  pci 0000:0e:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't assign; no space
  pci 0000:0e:00.0: BAR 0 [mem size 0x800000000 64bit pref]: failed to assign
  pci 0000:0e:00.0: BAR 2 [mem size 0x00200000 64bit pref]: can't assign; no space
  pci 0000:0e:00.0: BAR 2 [mem size 0x00200000 64bit pref]: failed to assign
  pci 0000:0e:00.0: BAR 5 [mem 0x74600000-0x7467ffff]: assigned

Note BAR5 (the 512 KB register aperture, non-prefetchable) still gets
assigned. That matters for the downstream impact described below: the
device is half-alive rather than obviously dead.

Resulting state, from lspci -vv. The entire losing chain has no
prefetchable window whatsoever:

  0000:08:08.0: 90000000000-908001fffff [size=32770M]    <- winner
  0000:09:00.0: 90000000000-908001fffff [size=32770M]
  0000:0a:00.0: 90000000000-908001fffff [size=32770M]
  0000:08:10.0: [disabled]                               <- loser
  0000:0c:00.0: [disabled]
  0000:0d:00.0: [disabled]
  0000:06:00.0: 90000000000-910003fffff [size=65540M]    <- shared parent

And /sys/bus/pci/devices/0000:0e:00.0/resource:

  0x0000000000000000 0x0000000000000000 0x0000000000000000   BAR0 unassigned
  0x0000000000000000 0x0000000000000000 0x0000000000000000
  0x0000000000000000 0x0000000000000000 0x0000000000000000   BAR2 unassigned
  0x0000000000000000 0x0000000000000000 0x0000000000000000
  0x0000000000006000 0x00000000000060ff 0x0000000000040101
  0x0000000074600000 0x000000007467ffff 0x0000000000040200   BAR5 assigned


Observation
-----------

Observed, and I think not in dispute:

  - the sizing pass produced a parent window exactly equal to the sum of
    the two child window sizes (0x800200000 * 2 = 0x1000400000);
  - the assignment pass refused to place the second child at
    0x90800200000, which is 2 MiB-aligned and would have fit exactly;
  - therefore assignment enforced an alignment that sizing did not budget
    for.

Where in the code: pbus_size_mem() sums the child bridge windows
without regard to the alignment the assignment pass will enforce on
them. The analysis, a small model that reproduces every number above,
and a one-line fix that has been A/B tested on this machine are in
"Root cause" and "Proposed fix" below, before the list of gaps.

The shortfall is structural rather than specific to 32 GB. For N=2
siblings each needing (A + eps) at alignment A, the required span is
2A + (A + eps) = 3A + eps, while the sum is 2A + 2eps. I have confirmed
this at the other end of the range: after one failed 32 GiB attempt,
writing the ReBAR index back to 256 MiB and re-enumerating fails in
exactly the same way, because the firmware's original 770 MiB windows
(~3A + eps for A = 256 MiB) are gone and the kernel re-sizes the parent
to 2A + 2 eps:

  pci 0000:06:00.0: bridge window [mem 0x90000000000-0x900203fffff 64bit pref]: assigned
                                              (512 MiB + 4 MiB)
  pci 0000:08:08.0: bridge window [mem 0x90000000000-0x900101fffff 64bit pref]: assigned
  pci 0000:08:10.0: bridge window [mem size 0x10200000 64bit pref]: can't assign; no space
  pci 0000:0e:00.0: BAR 0 [mem size 0x10000000 64bit pref]: can't assign; no space
  pci 0000:0e:00.0: BAR 2 [mem size 0x00200000 64bit pref]: can't assign; no space

So on 7.0 there is no in-place recovery once the kernel has re-sized the
window: the only layouts that ever work are the ones the firmware left
behind. 16 GB and 8 GB remain untested but I would not expect them to
differ.


Downstream impact: this is not a soft failure
---------------------------------------------

The BAR-less die is not merely unusable. Because BAR5 is still assigned,
amdgpu probes it, its register reads return garbage, and
RCC_IOV_FUNC_IDENTIFIER comes back with bit 0 set. The driver concludes
the device is an SR-IOV *virtual function*:

  amdgpu 0000:0b:00.0: register mmio base: 0x74400000     <- healthy die
  amdgpu 0000:0e:00.0: register mmio base: 0x74600000
  amdgpu 0000:0e:00.0: MCBP is enabled                    <- only set when
                                                             amdgpu_sriov_vf()

It then calls amdgpu_virt_request_full_gpu() ->
xgpu_ai_request_full_gpu_access() and waits forever for a hypervisor
mailbox that does not exist:

  amdgpu 0000:0e:00.0: trn=2 ACK should not assert! wait again !
  (repeating roughly 2490 times per 5 seconds, indefinitely)

  xgpu_ai_mailbox_trans_msg+0x1a9/0x1f0 [amdgpu]
  xgpu_ai_send_access_requests+0x21/0xe0 [amdgpu]
  xgpu_ai_request_full_gpu_access+0x1a/0x30 [amdgpu]
  amdgpu_virt_request_full_gpu+0x2a/0x70 [amdgpu]
  amdgpu_device_ip_early_init.constprop.0+0x173/0x780 [amdgpu]
  amdgpu_device_init+0x83d/0x1180 [amdgpu]
  amdgpu_driver_load_kms+0x1a/0xd0 [amdgpu]
  amdgpu_pci_probe+0x1df/0x590 [amdgpu]

modprobe wedges in uninterruptible D state holding the device mutex,
blocks the AER IRQ thread, and never returns:

  INFO: task irq/34-aerdrv:1554 blocked for more than 122 seconds.
  INFO: task irq/34-aerdrv:1554 is blocked on a mutex likely owned by
        task modprobe:1583.

SIGKILL does not touch it; systemd's TimeoutStartSec fires and the unit
goes to "failed" while the task stays in the cgroup. The machine needs a
reboot. The remaining two dies are never probed at all.

So the practical outcome of the sizing bug with a plain "modprobe amdgpu"
is: 1 of 4 GPUs usable (the healthy die of the first card; its BAR-less
sibling wedges the probe and the second card is never reached), no XGMI
hive (kfd reports a single-node hive), and an unkillable task on every
boot. Keeping the BAR-less dies away from the driver with
driver_override, which resize-amdgpu-bars now does, gets 2 of 4 dies and
a 2-node hive; that is the "2/4 dies" figure under "Proposed fix" below.
Whether amdgpu should be more defensive about probing a device with
an unassigned BAR0 is a separate question for amd-gfx, and I've cc'd them,
but the PCI-side undersizing is the trigger.


Reproduction
------------

With the four dies at their default 256 MB BAR0 (this is what
resize-amdgpu-bars does at boot, done by hand):

  1. Set BAR0 to 32 GB on all four dies (ReBAR control register at
     capability offset 0x200, control at 0x208, size index in bits 8-13,
     index 15 = 2^35):

       setpci -s 0000:0b:00.0 0x208.l=00000f40
       (likewise for 0e:00.0, 1b:00.0, 1e:00.0)

  2. Force full re-enumeration so the kernel re-sizes every bridge window
     from scratch:

       echo 1 > /sys/bus/pci/devices/0000:06:00.0/remove
       echo 1 > /sys/bus/pci/devices/0000:16:00.0/remove
       echo 1 > /sys/bus/pci/rescan

  3. dmesg shows the "can't assign; no space" trace above; 0e:00.0 and
     1e:00.0 have BAR0 and BAR2 unassigned, 0b:00.0 and 1b:00.0 are fine.

Fully deterministic across many attempts: the first-enumerated die of
each card always wins.


Root cause
----------

Since 3958bf16e2fe, pbus_size_mem() sizes a bridge window as

    size += max(r_size, align);        /* per child */
    size0 = ALIGN(size, win_align);    /* win_align = 1 MB */

with calculate_head_align() making only the window *start* satisfy the
largest child alignment. The tight fit is gap-free only if, in the
descending-alignment assignment order, every child's size is a multiple
of the alignments of the children placed after it. That holds for BARs
(size == alignment) but not for bridge windows: their size is the sum of
what is below them, while their alignment (IORESOURCE_STARTALIGN) is that
of the largest BAR below them.

Here each sub-bridge window holds BAR0 (32 GiB) + BAR2 (2 MiB doorbell),
so it is sized 32 GiB + 2 MiB with 32 GiB alignment. The root port sums
two of them: 64 GiB + 4 MiB. Assignment then places the first child at
offset 0 (ends at 32 GiB + 2 MiB) and must put the second at the next
32 GiB boundary, i.e. 64 GiB .. 96 GiB + 2 MiB. Needed 96 GiB + 2 MiB,
sized 64 GiB + 4 MiB -> "can't assign; no space" for the second die.

    pci 0000:06:00.0: bridge window [mem 0x90000000000-0x910003fffff 64bit pref]: assigned
    pci 0000:08:08.0: bridge window [mem 0x90000000000-0x908001fffff 64bit pref]: assigned
    pci 0000:0b:00.0: BAR 0 [mem 0x90000000000-0x907ffffffff 64bit pref]: assigned
    pci 0000:0b:00.0: BAR 2 [mem 0x90800000000-0x908001fffff 64bit pref]: assigned
    pci 0000:0e:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't assign; no space
    pci 0000:0e:00.0: BAR 2 [mem size 0x00200000 64bit pref]: can't assign; no space

The same arithmetic at the default 256 MiB BAR0 gives 512 MiB + 4 MiB
sized vs 768 MiB + 2 MiB needed, which is why even reverting the BAR
size does not recover (the firmware's original windows were larger).

Up to v6.17, calculate_memsize() rounded each bridge window up to its own
min_align (ALIGN(size, min_align); the old calculate_mem_align() gave
16 GiB here), so each sub-bridge window was 48 GiB and the root port
96 GiB, and siblings packed by accident. A small model of both versions
of pbus_size_mem() reproduces every number seen on this machine
(48G/96G on 6.8-6.17; 32770M/65540M and 258M/516M on 7.0).

This is the tail-side sibling of the head-side under-estimation Guenter
Roeck raised on 2026-03-05 for the same series (4M@4M + 3M@1M + 1M@1M
needing 9 MiB in an 8 MiB window), which 8cb081667377 addressed for the
head alignment bookkeeping only.

Proposed fix
------------

Pad a child up to its alignment when its size is not a multiple of it:

    -			size += max(r_size, align);
    +			size += ALIGN(r_size, align);

This is a no-op for BARs, so the v7.0 tight fit for leaf resources is
kept; for bridge windows it restores the pre-v7.0 parent sizing. It
over-estimates by up to one alignment unit (128 GiB here rather than the
exact 96 GiB + 2 MiB); an exact version would have to walk the children
in assignment order and simulate the offsets. The diff follows below the
"---" line at the end of this mail; the full patch with changelog and
Signed-off-by is ready and I will send it as a separate [PATCH] if that
is preferred.

Tested on the same machine, same script, same sequence (2026-09-02):

  v7.0.12 unpatched (control): identical to 7.0.0-30. Root-port window
    0x90000000000-0x900203fffff (512 MiB + 4 MiB at the 256 MiB baseline
    the kernel falls back to), "can't assign; no space" on 0e:00.0 and
    1e:00.0, 2/4 dies, 2-node XGMI hive.
  v7.0.12 + patch: 4/4 dies with 32 GiB BAR0, 4-node XGMI hive, from a
    cold boot and again from a warm reboot. Window layout for card 1:

      pci 0000:06:00.0: bridge window [mem 0x90000000000-0x91fffffffff 64bit pref]: assigned   (128 GiB)
      pci 0000:07:00.0: bridge window [mem 0x90000000000-0x91fffffffff 64bit pref]: assigned
      pci 0000:08:08.0: bridge window [mem 0x90000000000-0x90fffffffff 64bit pref]: assigned   (64 GiB)
      pci 0000:09:00.0: bridge window [mem 0x90000000000-0x90fffffffff 64bit pref]: assigned
      pci 0000:0a:00.0: bridge window [mem 0x90000000000-0x908001fffff 64bit pref]: assigned   (32 GiB + 2 MiB)
      pci 0000:0b:00.0: BAR 0 [mem 0x90000000000-0x907ffffffff 64bit pref]: assigned
      pci 0000:0b:00.0: BAR 2 [mem 0x90800000000-0x908001fffff 64bit pref]: assigned
      pci 0000:08:10.0: bridge window [mem 0x91000000000-0x91fffffffff 64bit pref]: assigned
      pci 0000:0e:00.0: BAR 0 [mem 0x91000000000-0x917ffffffff 64bit pref]: assigned
      pci 0000:0e:00.0: BAR 2 [mem 0x91800000000-0x918001fffff 64bit pref]: assigned

    The padding is applied once, where 09:00.0 sums its 32 GiB + 2 MiB
    child (alignment 32 GiB) to 64 GiB; the levels above are plain sums
    of already-aligned children. Net cost 128 GiB per card instead of
    the exact 96 GiB + 2 MiB, out of 1 TiB available.


Why the repro does not use the sysfs resource0_resize interface
----------------------------------------------------------------

The repro above pokes the ReBAR control register with setpci and then
forces a rescan instead of using the sanctioned interface
(echo 15 > .../resource0_resize). That is deliberate: the sanctioned
interface cannot grow a die that sits behind the card's own PCIe switch,
on any kernel, and that is the reason resize-amdgpu-bars exists at all.
It was the first thing I tried, and I re-measured it on 7.0.12 for this
report so the failure is on record with the kernel's own lines.

    Measured (7.0.12 vanilla, unit masked, amdgpu blacklisted, so all
    four dies sat at the firmware 256 MB and nothing was bound; the
    sibling die's BARs stay assigned whether or not a driver is bound):

      # echo 15 > /sys/bus/pci/devices/0000:0b:00.0/resource0_resize
      write error: No space left on device            (-ENOSPC)

      pci 0000:0b:00.0: BAR 0 [mem 0x9ffe0000000-0x9ffefffffff 64bit pref]: releasing
      pcieport 0000:0a:00.0: bridge window [mem 0x9ffe0000000-0x9fff01fffff 64bit pref]: releasing
      pcieport 0000:09:00.0: bridge window [mem 0x9ffe0000000-0x9fff01fffff 64bit pref]: releasing
      pcieport 0000:08:08.0: bridge window [mem 0x9ffe0000000-0x9fff01fffff 64bit pref]: releasing
      pcieport 0000:07:00.0: bridge window [mem 0x9ffc0000000-0x9fff01fffff 64bit pref]: was not released (still contains assigned resources)
      pcieport 0000:06:00.0: bridge window [mem 0x9ffc0000000-0x9fff01fffff 64bit pref]: was not released (still contains assigned resources)
      pcieport 0000:08:08.0: bridge window [mem size 0x800200000 64bit pref]: can't assign; no space
      pci 0000:0b:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't assign; no space
      pci 0000:0b:00.0: BAR 0 [mem 0x9ffe0000000-0x9ffefffffff 64bit pref]: old value restored

    Parent window (06:00.0 and 07:00.0, shared by both dies) before and
    after: 0x9ffc0000000-0x9fff01fffff, 770 MB, unchanged. Writing 8 back
    returned 0 and every window came back byte-identical. The whole thing
    took under half a second and nothing hung.

    So the sysfs path fails the same way for the user (-ENOSPC, "old
    value restored", BAR stays 256 MB) but for a reason one level below
    the sizing bug: the shared window on the two bridges above the switch
    is never released while the sibling die's BARs are assigned in it, so
    the three bridge windows on the way down have to grow to 32 GB + 2 MB
    inside a 770 MB parent, and cannot. The in-place path never gets to
    re-size the shared window at all; it is limited to what fits in the
    firmware layout. That is independent of this bug (it would fail the
    same way on a fixed kernel and on 6.17), and it is why my tool grows a
    dual-die module by removing the whole module and rescanning from the
    root port instead. The sysfs write is not a workaround here and does
    not exercise the sizing path this patch fixes; the setpci + rescan
    repro and amdgpu's own resize at probe (below) are the two routes that
    reach it, and both fail with "can't assign; no space" on unpatched 7.0.


What I have not tested
----------------------

I want to be straight about the gaps:

  - I have not tested 16 GB or 8 GB BARs (see the structural argument
    above; 256 MB and 32 GB are the two data points).

  - amdgpu's own resize at probe time (amdgpu_device_resize_fb_bar ->
    pci_resize_resource) hits the same wall on 7.0. From an earlier boot
    where amdgpu was allowed to autoload with the dies still at 256 MB:

      amdgpu 0000:1b:00.0: BAR 2 [mem 0xbfff0000000-0xbfff01fffff 64bit pref]: old value restored
      amdgpu 0000:1b:00.0: BAR 0 [mem 0xbffe0000000-0xbffefffffff 64bit pref]: old value restored
      amdgpu 0000:1b:00.0: Not enough PCI address space for a large BAR.
      amdgpu 0000:1b:00.0: [drm] Detected VRAM RAM=32752M, BAR=256M

    That path fails closed (ReBAR index reverted, driver continues at
    256 MB), so it does not trigger the hang described above, but it
    does not get a large BAR either.

  - I have not bisected by booting: the commit was identified by reading
    setup-bus.c across the versions and confirmed by the A/B test of
    v7.0.12 with and without the one-line patch (see "Proposed fix"). If
    a real bisection would still help I can run it.

Happy to test patches, gather more traces, or run with any debug options
that would help. The machine is otherwise idle and I can reboot it freely.


Available on request (not attached; the largest is 1.1 MB):
  - full dmesg from the failing boot
  - lspci -vvnn and lspci -tvnn
  - the trimmed allocation trace for card 1
  - lspci -vv from the 6.17 boot (working layout)
  - the sizing model (pci-window-sim.py, 130 lines)
  - full dmesg from the v7.0.12 control boot and the v7.0.12 + patch boot
  - lspci -vvnn from the v7.0.12 + patch boot


#regzbot introduced: 3958bf16e2fe

---
 drivers/pci/setup-bus.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1329,7 +1329,17 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 				continue;
 
 			r_size = resource_size(r);
-			size += max(r_size, align);
+			/*
+			 * Resources are assigned in descending alignment
+			 * order, so a tight-fit sum is only gap-free if each
+			 * size is a multiple of the alignments that follow.
+			 * BARs always are (size == align); bridge windows
+			 * are not (arbitrary size, IORESOURCE_STARTALIGN to
+			 * their largest BAR), and two 32G+2M windows aligned
+			 * to 32G need 96G+2M of span, not 64G+4M. Pad such
+			 * resources up to their alignment.
+			 */
+			size += ALIGN(r_size, align);
 
 			/*
 			 * If resource's size is larger than its alignment,

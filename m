Received: from sg-1-102.ptr.blmpb.com (sg-1-102.ptr.blmpb.com [118.26.132.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1A315D5A
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093594; cv=none; b=H0r/L6f6pFgELDSi4WEKkHK6+Ed++Cml+wii+NiZeX4nfhYVVhxYdbbw71E7OXFCQNsnCSPW+oKtrBbAkeKEx9l5DR85Z4nEe/YUYRV0nd4X3eXD31rx+hBra6z8QXVcq/FBdw2h8dKw17GiZBkGBhxSOi84XdBU9jEigfckjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093594; c=relaxed/simple;
	bh=AI+fpNkvzKsjXNqo1sKeZnU6L1alw0hSpubZwaWowvc=;
	h=Message-Id:Subject:Date:To:Mime-Version:Content-Type:Cc:From; b=S9kVA0PgjFI9KLS0W5iwDPJOyP9KMLr+PExrcCjLO617LmihLXvdApl9ysrQsRTtkjR0vK/xNZhfIaKwLEkCCWe4pOVgsDLNm5gBNrOCBlAht4nnHipaADeFXgfJWhLGSCft36/rwoRPFPcPvMC72HlXglzZ8O2zMcgug/bmXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NRVJ85Hz; arc=none smtp.client-ip=118.26.132.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NRVJ85Hz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1769093578; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=X3ztz+XDnlkRxS///+z4HFvJtNYD146sae4/QUhcKpE=;
 b=NRVJ85HzyDcTk+yh6Zt/OvgcOIevBmpch+Fd4+SwqffPFSkKETalk8OenhQfmvH+XnjpFD
 PskAL9L5wjLxb7ZXU5T4/rBBCcGlY+7arTbmXUV+8viZG+/UktCE2QFemO701CPjs+dn8e
 nQ8QNcEoJN36cRg7cg+Kshp1qmX5VyT2Thaz2oDzuP+KxziMmyQDRL3zIDhcUFdqfZ5C0r
 KrbuIj/n89Tcxs0JEkP7frzEVBNwU7zoSQARbtizR6S2Uc98CdTS0q20MdR4lAqz7SgizA
 2e81LqDbeSS3r1XtYmcfdJyJuRYTgPgdtQcv89euTsnri8K1psFhkdHJYaVycw==
Message-Id: <20260122145208.1013-1-guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+2697239c8+6393cd+vger.kernel.org+guojinhui.liam@bytedance.com>
Subject: [PATCH v2 0/3] Add NUMA-node-aware synchronous probing to driver core
Date: Thu, 22 Jan 2026 22:52:05 +0800
X-Mailer: git-send-email 2.17.1
To: <dakr@kernel.org>, <alexanderduyck@fb.com>, <bhelgaas@google.com>, 
	<bvanassche@acm.org>, <dan.j.williams@intel.com>, 
	<gregkh@linuxfoundation.org>, <helgaas@kernel.org>, <rafael@kernel.org>, 
	<tj@kernel.org>, <frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>

Hi all,

** Overview **

This patchset introduces NUMA-node-aware synchronous probing.

Drivers can initialize and allocate memory on the device=E2=80=99s local
node without scattering kmalloc_node() calls throughout the code.
NUMA-aware probing was added to PCI drivers in 2005 and has
benefited them ever since.

The asynchronous probe path already supports NUMA-node-aware
probing via async_schedule_dev() in the driver core. Since NUMA
affinity is orthogonal to sync/async probing, this patchset adds
NUMA-node-aware support to the synchronous probe path.

** Background **

The idea arose from a discussion with Bjorn and Danilo about a
PCI-probe issue [1]:

when PCI devices on the same NUMA node are probed asynchronously,
pci_call_probe() calls work_on_cpu(), pins every probe worker to
the same CPU inside that node, and forces the probes to run serially.

Testing three NVMe devices on the same NUMA node of an AMD EPYC 9A64
2.4 GHz processor (all on CPU 0):

  nvme 0000:01:00.0: CPU: 0, COMM: kworker/0:1, probe cost: 53372612 ns
  nvme 0000:02:00.0: CPU: 0, COMM: kworker/0:2, probe cost: 49532941 ns
  nvme 0000:03:00.0: CPU: 0, COMM: kworker/0:3, probe cost: 47315175 ns

Since the driver core already provides NUMA-node-aware asynchronous
probing, we can extend the same capability to the synchronous probe
path. This solves the issue and lets other drivers benefit from
NUMA-local initialization as well.

[1] https://lore.kernel.org/all/20251227113326.964-1-guojinhui.liam@bytedan=
ce.com/

** Changes **

The series makes three main changes:

1. Adds helper __device_attach_driver_scan() to eliminate duplication
   between __device_attach() and __device_attach_async_helper().
2. Introduce helper __driver_probe_device_node() and use it to enable
   NUMA-local synchronous probing in __device_attach(), device_driver_attac=
h(),
   and __driver_attach().
3. Removes the now-redundant NUMA code from the PCI driver.

** Test **

I added debug prints to nvme, mlx5, usbhid, and intel_rapl_msr and
ran tests on an AMD EPYC 9A64 system (Updated test results for the
new patchset are provided below):

NUMA topology of the test machine:
  # lscpu |grep NUMA
  NUMA node(s):                            2
  NUMA node0 CPU(s):                       0-63,128-191
  NUMA node1 CPU(s):                       64-127,192-255

1. Without the patchset
   - PCI drivers (nvme, mlx5) probe sequentially on CPU 0
   - USB and platform drivers pick random CPUs in the udev worker

   nvme 0000:01:00.0: CPU: 0, COMM: kworker/0:1, cost: 54013202 ns
   nvme 0000:02:00.0: CPU: 0, COMM: kworker/0:2, cost: 53968911 ns
   nvme 0000:03:00.0: CPU: 0, COMM: kworker/0:4, cost: 48077276 ns

   mlx5_core 0000:41:00.0: CPU: 0, COMM: kworker/0:2 cost: 506256717 ns
   mlx5_core 0000:41:00.1: CPU: 0, COMM: kworker/0:2 cost: 514289394 ns

   usb 1-2.4: CPU: 163, COMM: (udev-worker), cost 854131 ns
   usb 1-2.6: CPU: 163, COMM: (udev-worker), cost 967993 ns

   intel_rapl_msr intel_rapl_msr.0: CPU: 61, COMM: (udev-worker), cost: 371=
7567 ns

2. With the patchset
   - PCI probes are spread across CPUs inside the device=E2=80=99s NUMA nod=
e
   - Asynchronous nvme probes are ~35 % faster; synchronous mlx5 times
     are unchanged
   - USB probe times are virtually identical
   - Platform driver (no NUMA node) falls back to the original path

   nvme 0000:01:00.0: CPU: 3, COMM: kworker/u1025:1, cost: 34244206 ns
   nvme 0000:02:00.0: CPU: 1, COMM: kworker/u1025:2, cost: 33883391 ns
   nvme 0000:03:00.0: CPU: 2, COMM: kworker/u1025:3, cost: 33943040 ns

   mlx5_core 0000:41:00.0: CPU: 3, COMM: kworker/u1025:1, cost: 507206174 n=
s
   mlx5_core 0000:41:00.1: CPU: 3, COMM: kworker/u1025:1, cost: 514927642 n=
s

   usb 1-2.4: CPU: 4, COMM: kworker/u1025:8, cost: 991417 ns
   usb 1-2.6: CPU: 2, COMM: kworker/u1025:5, cost: 935112 ns

   intel_rapl_msr intel_rapl_msr.0: CPU: 17, COMM: (udev-worker), cost: 484=
9967 ns

3. With the patchset, unbind/bind cycles also spread PCI probes across
   CPUs within the device=E2=80=99s NUMA node:

   nvme 0000:02:00.0: CPU: 130, COMM: kworker/u1025:4, cost: 35086209 ns

** Final **

Comments and suggestions are welcome.

Best Regards,
Jinhui

---
v1: https://lore.kernel.org/all/20260107175548.1792-1-guojinhui.liam@byteda=
nce.com/

Changelog in v1 -> v2:
 - Reword the first patch=E2=80=99s commit message for accuracy and add
   Reviewed-by tags; no code changes.
 - Refactor the second patch to reduce complexity: introduce
   __driver_probe_device_node() and update the signature of
   driver_probe_device() to support NUMA-node-aware synchronous
   probing. (suggested by Danilo)
 - The third patch resolves conflicts with three patches from
   patchset [2] that have since been merged into linux-next.git.
 - Update the test data in the cover letter for the new patchset.

[2] https://lore.kernel.org/all/20260101221359.22298-1-frederic@kernel.org/

Jinhui Guo (3):
  driver core: Introduce helper function __device_attach_driver_scan()
  driver core: Add NUMA-node awareness to the synchronous probe path
  PCI: Clean up NUMA-node awareness in pci_bus_type probe

 drivers/base/dd.c        | 147 +++++++++++++++++++++++++++++----------
 drivers/pci/pci-driver.c | 116 +++---------------------------
 include/linux/pci.h      |   4 --
 kernel/sched/isolation.c |   2 -
 4 files changed, 118 insertions(+), 151 deletions(-)

--=20
2.20.1

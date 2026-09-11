Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876A47A87C;
	Fri, 11 Sep 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148631; cv=none; b=sDHONEcFRHog/GVdm8ve56CoikQKWo7nPMHlfIretEzNAMqEOE+0Wb4J1piZ7K1REwgVyg+jwJe0b3+q4orDSt7C6RfMwmjjTE8hhtTRhDnXwYehX6huLRKplnF2Tpoy/Vaf0PM/zEOlaYo8KecLi/urYzteDcyMdRoUmzSg7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148631; c=relaxed/simple;
	bh=7clnLXdEIuFpN7LTxituD33Y5fqNsaN2TTZBJ8XeuHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IFY6/GQsNnkpxc3IreSeg2ew+x4LHyFxZtiIXshR5NkGC11lAUO6YTpIwLEs5HjxXL78RFkfaVyMt1AsJp3pop2WcC89bYmvMzA2FnHaSULxM6ys1RkkOiBoTZw2O8XbZtrgyC9M/0R8fQTWdVQ0/ZxLawTl1Ez2L/cUuxiNmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Axk3husz; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Axk3husz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789148628; x=1820684628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jhtWmKJe4+1aWN9w6ZaOQx0/ok/ilrwKiyY3ZBnEbgU=;
  b=Axk3husz+x1hd3U6rShexgD+pOQFWDBa8zaJL2xBIn4EYpj0ITtDEiNc
   lyqG3ChxXt3Jxl/frr6ReSefWq2SZY+wu00OqMmWHeU9OJ0iz0Fi9jtBy
   JKQ7bPNVc3AyHR49Y9rqmcY7bXC4rp7ed2Z5pR8FR23qhWvnqJS0FgE2h
   0fchQGPOIc8V/AHjlmMTpWOPoUp/tDQAoh15XsctL2HIyqBsuJFu5x4sq
   Z7n/d/RERv6WBxcQMsPeVOcOFteBvSLwz6kNimUV3WMq/av69hprWml7q
   Hg8wqEEj3pqRKTu3+c0OOnP+GqWOS+vAS4yZkCnuJxQ+QvXuvqpND6/MP
   g==;
X-CSE-ConnectionGUID: 0apJ6hH4RbuksreetJYz1g==
X-CSE-MsgGUID: smBKYmIARwORn27Fw/LWEQ==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28356981"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:43:44 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:27167]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 93dcf805-6571-49c8-90e1-c5c85668cc7f; Fri, 11 Sep 2026 17:43:44 +0000 (UTC)
X-Farcaster-Flow-ID: 93dcf805-6571-49c8-90e1-c5c85668cc7f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 17:43:44 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 17:43:41 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
	<tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alex Williamson
	<alex@shazbot.org>, <kvm@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 0/8] kernfs, driver core: staged sysfs registration
Date: Fri, 11 Sep 2026 19:43:32 +0200
Message-ID: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Once SR-IOV enablement becomes part of a kexec-based live update
(LUO), 100-1000s of VFs would perform initialization in parallel [1],
each VF adding ~60-80 kernfs nodes to sysfs, each node acquiring the
kernfs_rwsem write lock once (after [2]). Acquiring one global lock to
add a single node, potentially hundreds of thousands of times per
enable - a reality on datacenter-level HW - does not scale. The
eventual goal, not built in this set, is enabling SR-IOV on all PFs in
parallel; with PFs on different NUMA nodes, cores on different nodes
then compete for the same global lock. We need some way of reducing
its use.

When performing device_add() on a VF, the device's sysfs nodes do not
need to be visible while being built: publish them once fully built,
taking the global lock once.

This series implements that as an opt-in staged registration mode. The
device's subtree is created fully initialized, but not linked into its
parent's children rbtree and not activated, so no name lookup can reach
it; its creator reaches it through kobj->sd. While staged, the kernfs
add, lookup and remove entry points - kernfs_add_one(),
kernfs_find_and_get_ns() and the two kernfs_remove() paths - serialize
on a mutex hashed by the staged-top node, a second NR_KERNFS_LOCKS-entry
array alongside the existing node_mutex, instead of the root's
kernfs_rwsem; unrelated staged subtrees serialize only when they hash to
the same slot. The staged paths bump the parent's timestamps under the
subtree mutex, not kernfs_iattr_rwsem, so a kernfs_setattr() there can
skew ctime/mtime on a node that is not yet visible; no opt-in path does
it. kernfs_publish() then links and activates the whole subtree in one
kernfs_rwsem write hold - one write hold per staged subtree instead of
one write acquisition per node. Attributes added after publication pay
per node as before. The device announces itself only after publication,
and struct kernfs_node does not grow: KERNFS_STAGED takes its last free
flag bit and the staged-top marker aliases the FILE-only KERNFS_HAS_MMAP
under a DIR-only rule, rather than widening the field. In this series,
PCI SR-IOV VFs and VFIO's group chardev and vfio-dev class devices opt
in.

Lock statistics and SR-IOV init time for 4x PF (NVMe, 255 VFs each), on
the reproducer from the parallel VF initialization cover letter [1]:

  lock_stat:
  Lock                     wait: Before     After   contentions: Before   After
  iommu_probe_device_lock      12367 ms   9612 ms                   990     838
  &root->kernfs_rwsem           2189 ms    843 ms                 62799   16466
  gdp_mutex                      314 ms    410 ms                   191     153

  Stage                 SR-IOV init time:
  S0 (baseline)         3027 ms
  S1                     999 ms
  S2                     995 ms
  S3                     991 ms
  S4                     943 ms
  S5 (this series)       944 ms

Reproducer disclaimer:
I lean primarily on lock_stat numbers to defend the improvements. In
the reproducer, the residual iommu_probe_device_lock dominates the
window and masks the later series' wall-time gains; reducing that lock
further is out of scope for this set, but the dominant residual is
named in the iommu series [4].

On real hardware - a large dual-socket arm64 Neoverse V2 server with
thousands of VFs - iommu_probe_device_lock is nowhere near the top
due to other optimizations on that path, and kernfs_rwsem is the top
waited lock, which is what this series improves.
The five series together cut SR-IOV initialization by 65%; parallel
initialization [1] alone accounts for less than 5% of that, so the
reduction comes from the lock work in this and the preceding series.

Two transients are new: a symlink from a published directory into the
staged subtree resolves -ENOENT until publication, and a child device
registered inside the window is fully registered and bindable before its
sysfs tree is visible - its uevents are suppressed, and its addition is
replayed once the window closes (KOBJ_ADD, then KOBJ_BIND if it bound
meanwhile). Not fully addressed: an in-window KOBJ_CHANGE is dropped
rather than reconstructed, and if the opted-in registration fails the
queued children stay suppressed, so userspace sees neither their
addition nor their removal. A device should opt in only when its
children, if any, tolerate that. Non-opted devices are behaviorally
unchanged.

Patch 6, which defers those uevents, has no trigger from either opt-in
here - it exists for wakeup-source registration that an opted-in caller
does not control - and can be dropped in favour of stating the
restriction as an opt-in condition.

The existing KERNFS_ROOT_CREATE_DEACTIVATED does not help here: it
batches only activation - each node is still linked under the root write
lock.

RFC question: Is an opt-in staged mode an acceptable direction for
kernfs and the driver core, or should we pursue another direction? For
the creation window only, this splits the global lock from one
acquisition per node to one per device_add(), with the staged subtree
serialized on a hashed mutex instead for as long as it is staged.

This replaces the previously attempted optimization with lazy-sysfs [3].

Testing:
This series adds a KUnit suite. The lock_stat and timing figures come
from the public reproducer. The full series has also been tested on
current datacenter server hardware with thousands of VFs.

[1] https://lore.kernel.org/r/20260911-vfopt-s1-v1-0-693271dc0226@amazon.de
[2] https://lore.kernel.org/r/20260911-vfopt-s3-v1-0-66e3602f76f7@amazon.de
[3] https://lore.kernel.org/lkml/20260702174033.32116-1-sakacpav@amazon.de/
[4] https://lore.kernel.org/r/20260911-vfopt-s2-v1-0-fff3db7e01c2@amazon.de

Pavol Sakac (8):
  kernfs: factor out reusable directory helpers
  kernfs: add staged directory creation and publication
  sysfs: add opt-in staged directory creation and publication
  driver core: Register opted-in devices through the staged sysfs path
  drivers: base: test: Add KUnit suite for staged sysfs registration
  driver core: Defer uevents for devices registered in a staged window
  PCI/IOV: Register virtual functions through the staged sysfs path
  vfio: Opt the group and vfio-dev class devices into staged sysfs

 drivers/base/base.h                    |    1 +
 drivers/base/bus.c                     |   29 +-
 drivers/base/core.c                    |  193 ++++
 drivers/base/test/.kunitconfig         |    1 +
 drivers/base/test/Kconfig              |   12 +
 drivers/base/test/Makefile             |    1 +
 drivers/base/test/staged-device-test.c | 1406 ++++++++++++++++++++++++
 drivers/pci/iov.c                      |    2 +
 drivers/vfio/group.c                   |    7 +
 drivers/vfio/vfio_main.c               |    3 +
 fs/kernfs/dir.c                        |  573 ++++++++--
 fs/kernfs/mount.c                      |    4 +-
 fs/sysfs/dir.c                         |   78 +-
 include/linux/device.h                 |   26 +
 include/linux/kernfs.h                 |   46 +
 include/linux/kobject.h                |   25 +
 include/linux/sysfs.h                  |   12 +
 17 files changed, 2352 insertions(+), 67 deletions(-)
 create mode 100644 drivers/base/test/staged-device-test.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
prerequisite-patch-id: 999e5d0fa76c26a057422f88454b1fefbb9b3822
prerequisite-patch-id: 40e7a6b4269c49235c297e1e8907cc85f39ec7bb
prerequisite-patch-id: 2de5f9198a49c3b10381455c3eb05a1445faaf9a
prerequisite-patch-id: 0bbae0313618b47cfedf5109565d41268cd6a48c
prerequisite-patch-id: 25f377891ba4b2c3915ccf6ac908074d0b427391
prerequisite-patch-id: 05867d594d1c5402821ee7f2172dd450b6e17659
prerequisite-patch-id: 99fc0938e1512adfaaa311f08a0ed1d7d0a4dc92
prerequisite-patch-id: 8898e957c193dcad8b70a534043a5e73ca3b8afe
prerequisite-patch-id: b5e8437666e8dd2a8cb5bcd4605665b3fab9556d
prerequisite-patch-id: d4e1d35cf3614bfbe325e03ab00d4882f222d599
prerequisite-patch-id: 747f6bb8326988a36f206a3a87ac8403dd616e3d
prerequisite-patch-id: e8d4a978122173cf6c708e4b730e1fa33bc1be57
-- 
2.47.3


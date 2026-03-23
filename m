Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5171386548
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310327; cv=none; b=E3G/tAPArc63COj5RjEBYb1N7waDxl1W473ebMLBZK0B0SKeyeoNz7M7eyy3ypf712XsFsAI1ukXlniPIjUSlMpu89GnLNVqvffIrFOWRCbSnzOtKAVAa7XYPfIoxnxpCrDL/MF5FNPQHYCniNn+uqNZZVTy4Fu+SgM6ka/xp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310327; c=relaxed/simple;
	bh=Xh0VD6c2DOiBYyNXtlX2CiZhzQ4nziyD7BKX5GcXGCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hoOwkux9mRv0O2D7kFPvrW3jCiSBaVStnWTwvrk/3zkgVHCbJNtNDab8I8zmb+FiwF+s8l0Nh2yShAwkk4HP4TvPnk4BM+oq6hm9QvhrBSh52lawuW+NnAIHCoh0WrOYcVJM8ylqOZ/k5YkUkgYfIurt7eWu4uFsIq0OBZMbli8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5GR4Kwg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5GR4Kwg"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b059511554so3283505ad.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310324; x=1774915124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7UW0RmcLc1SB8VXNrTH33hzd4ZkDSbd/G4mL4V5lhA=;
        b=o5GR4KwglfgJGcj5bp7gGsk36lVS0yOcgt+DzXm3gJOZxuYR7i9lYKXiw1RZjz3kIX
         qAL0rQkLoIc6YXKRWBa3MG6X+5Ayd8QUsy86K/SeHd++O95BxLnU0G9nwgdU8vY3lqEk
         6/2gzybg5r8tm/V8LDDpMjy4awdshqFuuTB40RM23Jknh5XRhZO8rAz5jM68ClgO+D7v
         jC1lDzWsMhuczOeLAmY15eLgaHzL4U/02phpopjJKZtBLEClstBkpIWwmRuR41obhDRG
         YcuKmHKdWv03ogegnVpR6ud+js3rIjRtCSiSI1PhGV3GPB9ghf4SgbMNgRp5hP4k3wci
         raTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310324; x=1774915124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7UW0RmcLc1SB8VXNrTH33hzd4ZkDSbd/G4mL4V5lhA=;
        b=o/ax5j9wl3PJWyZpFXH+chnjunc9NqklRgVXE5O1eDxsUCDMv4H+zs92N+gH3+jyCI
         JfsJAuDSTAD/knPYPV373Fyb+kYTZoCbiS+Wf2QFBOZCSyH/mljM8KQGdhLatibJO/oH
         zsHF+5cW/3juKMQw4uIzqUk8YhN8YAg4uAft9GIsciAfn51ARX3XAVzIyVA5yEAiJWKn
         03SqstTJeVH4lsu8/4xjgS437EnIMecmE84C/gTL7pwL8rydNPvZDzOmCfYB0O3ai34I
         VBO1+0NiFB6Y6H3DEVrAhTPq8JENGlJGpJ+lgzzTHmofkxlYKnjc021Fm3Y27sb13LiM
         uTuw==
X-Forwarded-Encrypted: i=1; AJvYcCUSFp8P0ImLKgO5IqmVKEHpd7mBrRmktKZmhDT5FI7khimu3VdNU2QwuXMYVkqTmqwnaTA7P0hnRik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwi9iVvQBuZY0RxjAayUi9FrxbvqWD6u+wOP0WJhpxSwdxw5y
	P2VhGmJZ8vNgs0fUDXaWRktlOoc44pILblyPnOaoUsOTmTj5r8GuSjcQizCkVDuHvxSYZ/v17Bo
	s0v/knbi9CPzEuQ==
X-Received: from plbjx15.prod.google.com ([2002:a17:903:138f:b0:2b0:5b78:8e47])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e54a:b0:2b0:9183:ce1e with SMTP id d9443c01a7336-2b09183d6ddmr75835585ad.30.1774310324185;
 Mon, 23 Mar 2026 16:58:44 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:56 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-5-dmatlack@google.com>
Subject: [PATCH v3 04/24] PCI: Inherit bus numbers from previous kernel during
 Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Inherit bus numbers from the previous kernel during a Live Update when
one or more PCI devices are being preserved, even if pci=assign-busses
is enabled.

During a Live Update, preserved devices will be allowed to continue
performing memory transactions. Thus the kernel cannot change the fabric
topology, including changing bus numbers, since that would requiring
disabling and flushing any memory transactions first.

So if pci=assign-busses is enabled, ignore it during the Live Update and
inherit all bus numbers assigned by the previous kernel. This will not
break users that rely on pci=assign-busses for their system to function
correctly since the system can be assumed to be in a functional state
already if a Live Update is underway. In other words, pci=assign-busses
would establish a functional topology during the initial cold boot, and
then that topology would remain fixed across any subsequent Live
Updates.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++-
 drivers/pci/liveupdate.c                      |  5 ++-
 drivers/pci/probe.c                           | 35 ++++++++++++++++---
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a550630644..beff9f3f8e3b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5156,7 +5156,11 @@ Kernel parameters
 				explicitly which ones they are.
 		assign-busses	[X86] Always assign all PCI bus
 				numbers ourselves, overriding
-				whatever the firmware may have done.
+				whatever the firmware may have done. Ignored
+				during a Live Update, where the kernel must
+				inherit the PCI topology (including bus numbers)
+				to avoid interrupting ongoing memory
+				transactions of preserved devices.
 		usepirqmask	[X86] Honor the possible IRQ mask stored
 				in the BIOS $PIR table. This is needed on
 				some systems with broken BIOSes, notably
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index a3dbe06650ff..c1251f4f8438 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -84,7 +84,10 @@
  * Update:
  *
  *  * The PCI Segment, Bus, Device, and Function numbers assigned to the device
- *    are guaranteed to remain the same across Live Update.
+ *    are guaranteed to remain the same across Live Update. Note that this is
+ *    true even if pci=assign-busses is set on the command line. The kernel will
+ *    always inherit bus numbers assigned by the previous kernel during a Live
+ *    Update.
  *
  * This list will be extended in the future as new support is added.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c60222d45659..165056d71e66 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1369,6 +1369,34 @@ bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 	return true;
 }
 
+static bool pci_assign_all_busses(void)
+{
+	if (!pcibios_assign_all_busses())
+		return false;
+
+	/*
+	 * During a Live Update, preserved devices are are allowed to continue
+	 * performing memory transactions. Thus the kernel cannot change the
+	 * fabric topology, including changing bus numbers, since that would
+	 * requiring disabling and flushing any memory transactions first.
+	 *
+	 * So if pci=assign-busses is enabled, ignore it during the Live Update
+	 * and inherit all bus numbers assigned by the previous kernel. This
+	 * will not break users that rely on pci=assign-busses for their system
+	 * to function correctly since the system can be assumed to be in a
+	 * functional state already if a Live Update is underway. In other
+	 * words, pci=assign-busses should be used to establish working bus
+	 * numbers during the initial cold boot, and then that topology would
+	 * then remain fixed across any subsequent Live Updates.
+	 */
+	if (pci_liveupdate_incoming_nr_devices()) {
+		pr_info_once("Ignoring pci=assign-busses and inheriting bus numbers during Live Update\n");
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
  * @bus: Parent bus the bridge is on
@@ -1396,6 +1424,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
 				  int pass)
 {
+	const bool assign_all_busses = pci_assign_all_busses();
 	struct pci_bus *child;
 	u32 buses;
 	u16 bctl;
@@ -1448,8 +1477,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		goto out;
 	}
 
-	if ((secondary || subordinate) &&
-	    !pcibios_assign_all_busses() && !broken) {
+	if ((secondary || subordinate) && !assign_all_busses && !broken) {
 		unsigned int cmax, buses;
 
 		/*
@@ -1491,8 +1519,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken)
-
+			if (assign_all_busses || broken)
 				/*
 				 * Temporarily disable forwarding of the
 				 * configuration cycles on all bridges in
-- 
2.53.0.983.g0bb29b3bc5-goog


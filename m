Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB240DFDB
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 00:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509345; cv=none; b=Xs3pTLdWioGssgFMqhQyFJ6g+O6PbJx+42Fvn4BpmsdyrGJaFOFg6oB7jEfeMZcyD1Wje2wjnpFLHLpljLtgZjlJVyhvVld39fu9dFZv0lJFS/4kq+A9V9VeSmP4o6Mb8tAsfgXybrFmWwF5BAu5anqnrQNaA1ovR9rmEyAXCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509345; c=relaxed/simple;
	bh=tHRXmR6VQcmnd19CwjoHzYakRyuHtTseVwT528iMuKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j4o0MIe8ta8R1O18AxkDwn2A1gpJ5o1G6/atbI98kEsm2tEbwkcMqe48li43aM3Ozsb4q2HLxmrk9obeqfMJNHWD/U1B8mpFqJkLSHK79RATjkPQP/tY5qAFQ2oli0DimTxW4dMyvd4qsjrhGHYdRQLWJDWqAuOvZZ8OaRlhQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPy0PUVJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPy0PUVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A63CC19425;
	Thu, 30 Apr 2026 00:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509345;
	bh=tHRXmR6VQcmnd19CwjoHzYakRyuHtTseVwT528iMuKU=;
	h=From:To:Cc:Subject:Date:From;
	b=DPy0PUVJW83UpfZBqsi9lPec3HuIW0irun3ai/DHBzijhJESyj4qF+RXyeNgIBOAA
	 EFja8nDGuyRbaZhUXqE1id/anUIloU4f7hRqmjIBsotYl05NwkFbMEI4MwVNt+Qxoo
	 CfWmZI+meDAB/SjVHKHiur9bxDKALzXzK7abQz/y7L19RzH7Mzm+Nh4rHNRWm9poV8
	 nc3aWfvDTgkeI3fohtYVcBztol4mbfcaY84nPW2p9SVh+NMaI6f1GREfoWc7nw1sGZ
	 DOAH11qdGwLA7E2i5QP0IKlSnekSO7xqmLCKbduwN3xTJO5vC0793/JViF+txU3xAK
	 7hCsmL3I37Qsw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Shuan He <heshuan@bytedance.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/proc: Fix race between pci_proc_init() and pci_bus_add_device()
Date: Thu, 30 Apr 2026 00:35:42 +0000
Message-ID: <20260430003542.455198-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_proc_attach_device() creates procfs entries for PCI devices and is
called from pci_bus_add_device().  It returns early if proc_initialized
is not yet set.

On x86 with ACPI, PCI enumeration occurs at subsys_initcall, before
pci_proc_init() sets proc_initialized at device_initcall.  The
for_each_pci_dev() loop in pci_proc_init() creates procfs entries for
these already-enumerated devices.  This loop runs without holding any
lock.

On ARM64 with devicetree, PCI host bridges probe at device_initcall.
With async probing enabled, pci_bus_add_device() can run concurrently
with pci_proc_init(), and both may call pci_proc_attach_device() for
the same device, leading to duplicate proc_create_data() calls.

Thus, wrap the for_each_pci_dev() loop with pci_lock_rescan_remove() to
serialise against concurrent PCI bus operations.  Add an early return in
pci_proc_attach_device() when dev->procent is already set, making the
function idempotent and symmetric with pci_proc_detach_device() which
clears this field.

While at it, update code to match preferred style and help with
readability.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/proc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index ce36e35681e8..9326f235bc58 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -425,6 +425,9 @@ int pci_proc_attach_device(struct pci_dev *dev)
 	if (!proc_initialized)
 		return -EACCES;
 
+	if (dev->procent)
+		return 0;
+
 	if (!bus->procdir) {
 		if (pci_proc_domain(bus)) {
 			sprintf(name, "%04x:%02x", pci_domain_nr(bus),
@@ -464,12 +467,17 @@ int pci_proc_detach_bus(struct pci_bus *bus)
 static int __init pci_proc_init(void)
 {
 	struct pci_dev *dev = NULL;
+
 	proc_bus_pci_dir = proc_mkdir("bus/pci", NULL);
 	proc_create_seq("devices", 0, proc_bus_pci_dir,
-		    &proc_bus_pci_devices_op);
+			&proc_bus_pci_devices_op);
+
 	proc_initialized = 1;
+
+	pci_lock_rescan_remove();
 	for_each_pci_dev(dev)
 		pci_proc_attach_device(dev);
+	pci_unlock_rescan_remove();
 
 	return 0;
 }
-- 
2.54.0


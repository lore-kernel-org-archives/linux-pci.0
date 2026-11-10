Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794270881;
	b=gWaYyelZXLkPsi8XOKfztwnKaQ2VNhJAo5dQCNM2rmC9Vz5ItlzBiuBukiW9QSgJ3iD/
	 ToPqDhRaG4hCPZj3xbO/jUObQ3NFTpSYHcMbk4DeZhEXKRHtoECFP4Yehm3d2L6JF4V9M
	 joegiuBndv/jMhEsNb5C1KFKZcTMSJquwVtOZYZtg+/f8sc4jubmF6B28wbOTLdHrPUHN
	 L/8Au8NqjMmXv8BtnqjVaXu7s3tSiaSlfdfEg+T696EijRbNc6sFaJ+sMsnM+iuWxaBMH
	 qtPnekYjGDE+LEtW1oke5UU8uBJGYiq2vL+Fldd/en+uegP2suKQjg7vbq859BHexFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270881;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hcKTdDaZfM80Gl3tkcJkXhmRBH6bjwN4PFTdj1fxgss=;
	b=kF0poX282/kQFF7qMa1Au6Vt8/UNsI6opbKsalhuXPMOsS2w1iKWrZxnlq/37v3acw4y
	 KYjzfifVo4g6pAGfCZt4rEAX0FUdC3anbt9j73mnLfz8DuHtmEg08cWr/ftF8v7Ot6itX
	 fdwydn7K8ifm6h9WvMgwo8P6Jpg0jrRdfFXkBZu63tz64Gm8FZzBW/rrhCCe8jFiz3glc
	 /BLw2KMC8hVeY8+FfEPnkZ9W6DP+PEw7dodyYdumF4ZfoPbFIOTwHgqsnCkWH+idsoAOB
	 aQGl8GU74/79BV89EX3w0Rg3f2mGWfwyXgG7npGCxpc2HGqDtfxAeGceCLF/dLVQvxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiuUUdma;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F6606A335;
	Tue, 10 Nov 2026 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiuUUdma
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794270880;
	b=TofMPJ0vMDkxoX0yHW1dZRlO0VoPoaY6EaVQp3gNztwp1f0Hq6x2xGueEtyhdKPqaonU
	 dUMkrpLr0g4eSdWdU5opPObbP8Boja0z72oMEFfvZNMC3dikZEVvb1yDR8AxqUpLzRhYx
	 t08vbAXq/wIJ6W8s6R4KMsK2gEH1HrZn5Qtiy81rgBzGg7Xw1W+oe53BsdZCjNhHMf2JF
	 SMFJDdzUCVA40clhi2fUE2zBitGBAwOpffqEMYzdWtMujOgjM7p8RY6tuAENxAy+X7/If
	 3xi4YuF9pPNuE7IEjjwxufvzN5mW4XrbZeeeIfj1MKSfh/rU43MpTHqGH5f5MCGNT6A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794270880;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hcKTdDaZfM80Gl3tkcJkXhmRBH6bjwN4PFTdj1fxgss=;
	b=Me1y1UokA5eW1nrVGrXqIeIlqyYRcCvdWyU8+GWfC9W/CQD6XzaF4dwE6DRuVs+LMFU4
	 jG77xrrbYK96o19mAX9Szh09oS2jg2FPDVAU+6sabIKXv2xugjf6SxIJdJPwgCqDH14jt
	 yb20ZNcirf0ykkZZ3/EKZ/VlgnLlugidPx+CQigZ/arI0vWNah6jfnNgTbW7xL9NrksB1
	 U6q8UQ8rzafVfV+x3osJLIZBJIW9SYTQSnXaclFqA6T1h5TR1IMdJ4yD2SgkYxEFS3VJW
	 riu9vQr3QBzdRSQ9d3/pwUpRulAnAGK5VYQZBqbwZJa64twXf7LHBUm5VYrdVFtqIDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3BE211F008A2;
	Tue, 10 Nov 2026 00:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794270880;
	bh=hcKTdDaZfM80Gl3tkcJkXhmRBH6bjwN4PFTdj1fxgss=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ZiuUUdmaYHu+fXfXcu8bQ7ca1ANufdpc+ZasXEnBEHF5J/CY2UucTcn7+S2SPFAxX
	 EGW2Rwrk0BRuBYxpZjrRUqDFc1+1umSNLX16mSXoGjccNqd1j9WFZCvXt1MtHHjAah
	 mwAH6OGhvQQZikAppxXLRI4XGmJKw2LPZZBAoA/avXZ/pjo1fSJAu6OLAfIDKoi3n0
	 GLkGxuqm9sTR/k90u8qLNoPDPRKzZivOZ2t9Ba5wR2u8j17kumPWQgOHKOpN+smInx
	 car0uMbiCnhAqF4GRdKBHVqnid700ld7Y4Vq42d06zBZx1qnL4FHufsWAKxKOcaizF
	 kSEGD6JWH7DEA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BDDC84872D;
	Tue, 10 Nov 2026 00:34:39 +0000 (UTC)
From: Kameron Markham via B4 Relay <devnull+kameron.markham.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 16:34:26 -0800
Subject: [PATCH] PCI: Don't add failed disabled ROM BARs to fail_head
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-r730-disabled-rom-fail-head-v1-1-88ef813d125e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJFm8moC/yXMwQrCMAwA0F8ZORtoO3Dqr4iHdEldZG6STBHG/
 t2qx3d5K7iYisOpWcHkpa7zVBF3DfQDTVdB5WpIIe1jDEe0rg3I6pRHYbT5joV0xEGIsZUgh0S
 ly1ygDg+Tou/ffr787c98k375lrBtH/dC6JB/AAAA
X-Change-ID: 20261109-r730-disabled-rom-fail-head-3e0e82af7bdf
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 linux-pci@vger.kernel.org, regressions@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794270877; l=6291;
 i=kameron.markham@gmail.com; s=kameron-wsl; h=from:subject:message-id;
 bh=S9URQyCNdcnam0CBqF71fXBw/t0UmK4Lo+/6b3bh+NA=;
 b=FPKw5AKmp9jixVuwNr6ltPkJoxna5KGLHvhoWP9jqF7kE7fouwNngkDCU2FFH6cB4LR2RTqxX
 EWU/oPAEkeSBDpzyenoOlgM1im84Li4riv0WZrD0jn9xBcfaZRq96pc
X-Developer-Key: i=kameron.markham@gmail.com; a=ed25519;
 pk=L2HWL2ipoxbiQNcyRjFYout0zPIWDXvYaMwgw7T8G1Q=
X-Endpoint-Received: by B4 Relay for kameron.markham@gmail.com/kameron-wsl
 with auth_id=1470
X-Original-From: Kameron Markham <kameron.markham@gmail.com>
Reply-To: kameron.markham@gmail.com
Content-Transfer-Encoding: 7bit

From: Kameron Markham <kameron.markham@gmail.com>

On Dell PowerEdge R730 servers with "SR-IOV Global Enable" disabled in
the BIOS setup, kernels since v6.15 hard-reset while igb probes the
on-board Intel I350 NIC. The iDRAC logs PWR2262 ("The Intel Management
Engine has reported an internal system error"), CPU0000 (IERR) and a
CPU machine check, and the BIOS sometimes halts in POST afterwards
(PST0208). v6.14 boots fine on the same machine.

With SR-IOV Global Enable disabled, the firmware does not assign the VF
BARs of the on-board 82599 NIC, so pci_realloc_detect() enables
resource reallocation automatically. On the first assignment pass the
disabled Expansion ROM BARs of three devices cannot be assigned:

  pci 0000:02:00.0: ROM [mem size 0x00100000 pref]: can't assign; no space
  pci 0000:01:00.1: ROM [mem size 0x00080000 pref]: can't assign; no space
  pci 0000:07:00.1: ROM [mem size 0x00080000 pref]: can't assign; no space

Before commit 96336ec70264 ("PCI: Perform reset_resource() and build
fail list in sync"), __assign_resources_sorted() did not put a failed
disabled ROM BAR on fail_head ("If the failed resource is a ROM BAR and
it will be enabled later, don't add it to the list."). That commit moved
the check into the new loop at the end of the function, but passes an
idx that is not computed for the resource being checked, so the check
no longer recognizes ROM BARs. Commit 2499f5348431 ("PCI: Rework
optional resource handling") then removed the check.

The failed disabled ROM BARs therefore end up on fail_head, and
pci_assign_unassigned_root_bus_resources() starts another round that
releases and reassigns bridge windows the firmware set up, including
the window of the PCH root port 00:1c.4 and the I350 behind it:

  PCI: No. 2 try to assign unassigned res
  pci 0000:00:1c.4: resource 14 [mem 0x91a00000-0x91bfffff] released
  pci 0000:00:1c.4: bridge window [mem 0x92200000-0x924fffff]: assigned
  pci 0000:07:00.0: BAR 0 [mem 0x92200000-0x9227ffff]: assigned

The machine resets when igb then accesses the I350 at the new address.
Why the platform does not tolerate the move is not known.

Restore the old behavior: add pci_resource_is_disabled_rom(), the
helper the first of these commits already called, and don't put a
failed disabled ROM BAR on fail_head. Such a BAR is still reset as before.
Other failed resources, including optional SR-IOV BARs, are still added
to fail_head, so reallocation can still make room for them.

Tested on a Dell PowerEdge R730 (BIOS 2.19.0, SR-IOV Global Enable
disabled): v6.17 and v7.4-rc2 hard-reset on every boot without this
patch and boot normally with it; no second assignment round happens and
the I350 keeps its firmware-assigned window. Enabling SR-IOV Global
Enable in the BIOS, or booting with pci=realloc=off, also avoids the
problem.

The bisection, the analysis, this patch and this changelog were done
with the help of an AI coding assistant (Claude, by Anthropic). All
testing was done on the hardware described above.

Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222253
Cc: stable@vger.kernel.org
Signed-off-by: Kameron Markham <kameron.markham@gmail.com>
---
Notes for reviewers (not part of the changelog):

- Bisected between v6.14 (good) and v6.17 (bad) on the affected machine
  with test kernels booted from RAM over PXE. 96336ec70264 does not
  build on its own (pci_resource_is_disabled_rom() is not defined by any
  commit), so for the bisect it was built with a one-line definition
  identical to the open-coded check it replaced. Its parent e89df6d2beae
  boots; 96336ec70264 resets.

- Only the SR-IOV Global Enable BIOS switch matters: stock v6.17 boots
  with only that switch enabled, and still resets with X2APIC and I/OAT
  enabled but SR-IOV disabled. (User reports often recommend all three.)

- Alternative considered: make pci_assign_unassigned_root_bus_resources()
  retry only when a required resource failed. That would also change how
  failed optional SR-IOV BARs drive reallocation, so this patch restores
  the pre-v6.15 behavior for disabled ROM BARs only.

- Serial console logs of good and bad boots, the bisect log, the BIOS
  switch matrix and the test scripts are attached to the bugzilla entry
  in the Closes: tag.

- Tool use, per Documentation/process/generated-content.rst: Claude
  (Anthropic) running in Claude Code, driven by the submitter, ran the
  automated bisection on the hardware, read the PCI resource assignment
  code, proposed this change and drafted this message. The submitter
  reviewed the change and the analysis.
---
 drivers/pci/setup-bus.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed16ef7c26..6506e44866 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -377,6 +377,17 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 	}
 }
 
+/*
+ * A disabled Expansion ROM BAR is only enabled later if it is needed, so
+ * failing to assign it does not leave the device unusable.
+ */
+static bool pci_resource_is_disabled_rom(const struct pci_dev *dev,
+					 const struct resource *res)
+{
+	return pci_resource_num(dev, res) == PCI_ROM_RESOURCE &&
+	       !(res->flags & IORESOURCE_ROM_ENABLE);
+}
+
 bool pci_resource_is_optional(const struct pci_dev *dev, int resno)
 {
 	const struct resource *res = pci_resource_n(dev, resno);
@@ -743,7 +754,12 @@ static void __assign_resources_sorted(struct list_head *head,
 		if (resource_assigned(res))
 			continue;
 
-		if (fail_head) {
+		/*
+		 * Don't put a disabled ROM BAR on fail_head: failing to
+		 * assign it must not trigger the release and reassignment
+		 * of bridge windows that are already in use.
+		 */
+		if (fail_head && !pci_resource_is_disabled_rom(dev, res)) {
 			pci_dev_res_add_to_list(fail_head, dev, res,
 						0 /* don't care */,
 						0 /* don't care */);

---
base-commit: 6633c535abc356ff868e72025ecd65aa0106630d
change-id: 20261109-r730-disabled-rom-fail-head-3e0e82af7bdf

Best regards,
--  
Kameron Markham <kameron.markham@gmail.com>



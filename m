Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D444C3148D2;
	Fri, 16 Oct 2026 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153165; cv=none; b=fe8Cx0gL+cL5LJVW0+xNAuXYzs8MRqE8l4uIOdwqgzVS88RhkloingaNL8zaCzG3OaEi+N637PJMrbk7Q5VT8uH/RcVjgw6v4YVRf2BmKZ1/PjuYlui3ycmioZxiBuSD3jK3tsPpc1EKqr4+wR2dhe5L54F0WYI6HWioRECaHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153165; c=relaxed/simple;
	bh=DSH+AvFSx4rSB2I3L8SguVd7gi22r4ADmAr9vYB5kcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lT4ydttBOZarS91LYJZexYH0g0X3baK5F/aB9XVpL/s+4373wcd/hhcckSto6CAEeL2bI2Z92TnjUa/c07coiNQnkSjvQu+kuhfcPg6SL0bDq5J2fTSXjoDpIjHHKL+euu/Nn1Yp1ccUAuMJdP3Cic7BJD4FpSwmbxSQmecE7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekWjNZ3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekWjNZ3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8B31F000C4;
	Fri, 16 Oct 2026 12:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153163;
	bh=ez3WTV3wXyvA2qsEtDAAQhPoUgCZjt1BQZubvtpWNZk=;
	h=From:Date:Subject:To:Cc;
	b=ekWjNZ3oSUYSugEFRILIitc33dot8jDfMAsAu3L7ZxBrfGUkTXBND8H8f3sHfaeB5
	 YhuhBLru0j1fax7LCg2S+n4m5DoAF1j3s50gEkd9f1SlcKg0tgoUPWj8GO1I2az//v
	 mTngxnRLSentOqEJb/9148sDZz0+e782qQAzbC4TEhtSARDbvIph8DcAXTX+DO+JZS
	 AflpWonu+iXo1y8Qtld7zpLvvJ4o7hhjQgRc1s89xZl7cp01bKpr04RpGpijqwnyt0
	 8VtB7PEh7uLoisupMcQgCbXVQXG5L14/+XiI3O+nhLZz+G4TWzT3LlwYChvJFBOJki
	 qe+0FtkLPrVLw==
From: Eugen Hristev <ehristev@kernel.org>
Date: Fri, 16 Oct 2026 15:18:53 +0300
Subject: [PATCH] PCI: iproc-msi: Bound events handled per IRQ
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-iproc-irq-v1-1-ebaaf027f29e@kernel.org>
X-B4-Tracking: v=1; b=H4sIACwW0moC/yXMTQ5AMBBA4avIrDVpiQZXEQvGYCz8TBFJ4+6K5
 Ze8PA+OhMlBGXkQOtnxMgeYOAIcm3kgxV0wJDqxRhureJUFFcumCsxy7CktTJZD6Fehnq/vVdW
 /3dFOhPs7gPt+ANvf8extAAAA
X-Change-ID: 20261016-iproc-irq-9c58cfe39158
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Eugen Hristev <ehristev@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3668; i=ehristev@kernel.org;
 h=from:subject:message-id; bh=DSH+AvFSx4rSB2I3L8SguVd7gi22r4ADmAr9vYB5kcU=;
 b=owGbwMvMwCXWkjcnuXne3fmMp9WSGLIuiTmaH81mvvydS+xJknra+zdi0Ruqila8a7yUvfF2m
 dR+i7DJHaUsDGJcDLJiiizVJv9qhft3uJ90tVSBmcPKBDKEgYtTACZi+o3hf8qOixl2CeGVK1tu
 v10b+czn3r+ne3dVzQ5ccmdmfKGqfSwjw4PkKO2mFPW/bzwzV2Usuil/qUwvm3c790/hgw+q40/
 3swEA
X-Developer-Key: i=ehristev@kernel.org; a=openpgp;
 fpr=AB184498D27A77B65D7852C81EB31E020EAC2FC8

Limit each iProc MSI parent IRQ to 16 event-queue entries.

A continuously fed queue could otherwise keep the chained handler running
and starve other work. The budget still drains pending events and lets the
next parent interrupt continue processing, improving fairness and bounding
interrupt-handler latency.

Without this starvation avoidance, one CPU can stall indefinitely
in the loop and not serve other interrupts, timers, etc.

While testing it with an Ethernet NIC,  when too many MSI interrupts
come in, CPU might get starved:

Connecting to host 192.168.30.1, port 5201
[  5] local 192.168.30.2 port 52586 connected to 192.168.30.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   240 MBytes  2.01 Gbits/sec    2    334 KBytes
[  5]   1.00-2.00   sec  63.2 MBytes   531 Mbits/sec    1   1.41 KBytes
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  177.568497] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  177.568913] rcu:     0-...!: (1 GPs behind) idle=28ac/1/0x4000000000000002 softirq=28922/28930 fqs=1
[  177.569457] rcu:     (detected by 1, t=5256 jiffies, g=21629, q=819 ncpus=4)
[  177.569870] Sending NMI from CPU 1 to CPUs 0:

With this bounded approach, IRQ handler will complete and continue
to serve MSI events on the next handler invocation.

Assisted-by: Github Copilot
Signed-off-by: Eugen Hristev <ehristev@kernel.org>
---
 drivers/pci/controller/pcie-iproc-msi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 9ba242ab9596..6649807822d2 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -29,6 +29,9 @@
 /* Number of entries in each event queue */
 #define EQ_LEN                         64
 
+/* Bound parent interrupt handler such that a queue cannot starve CPU. */
+#define IPROC_MSI_MAX_EVENTS_PER_IRQ   16
+
 /* Size of each event queue memory region */
 #define EQ_MEM_REGION_SIZE             SZ_4K
 
@@ -326,6 +329,7 @@ static void iproc_msi_handler(struct irq_desc *desc)
 	struct iproc_msi_grp *grp;
 	struct iproc_msi *msi;
 	u32 eq, head, tail, nr_events;
+	unsigned int event_budget = IPROC_MSI_MAX_EVENTS_PER_IRQ;
 	unsigned long hwirq;
 
 	chained_irq_enter(chip, desc);
@@ -360,9 +364,11 @@ static void iproc_msi_handler(struct irq_desc *desc)
 			break;
 
 		/* process all outstanding events */
-		while (nr_events--) {
+		while (nr_events && event_budget) {
 			hwirq = decode_msi_hwirq(msi, eq, head);
 			generic_handle_domain_irq(msi->inner_domain, hwirq);
+			nr_events--;
+			event_budget--;
 
 			head++;
 			head %= EQ_LEN;
@@ -373,6 +379,8 @@ static void iproc_msi_handler(struct irq_desc *desc)
 		 * head pointer.
 		 */
 		iproc_msi_write_reg(msi, IPROC_MSI_EQ_HEAD, eq, head);
+		if (!event_budget)
+			break;
 
 		/*
 		 * Now go read the tail pointer again to see if there are new

---
base-commit: b810335a0699d1810683796b0e3ffe8827ddfe6c
change-id: 20261016-iproc-irq-9c58cfe39158

Best regards,
--  
Eugen Hristev <ehristev@kernel.org>


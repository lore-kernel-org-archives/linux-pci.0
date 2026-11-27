Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785885;
	b=4Vf6/NHxmRn59T4ei7tJHsFhuGkiZm7hiVKzCGzSCmzSLkqruwVECfoJ263UaHw6aZp0
	 mGp+amYrBMCTshznDqaXu55NRfdW34uYE80domvk44tfPe0dS1oO+fK7svRp3vsxUAHSk
	 LtetlHnJjPgrx0RWlFHbwmecOrsMMEsFhu4SbaNnzcG/yv6lTdBvP1aAdZ7oke5cczidg
	 qq1ihZKhz2/lpLx+T/DAUcbGhedlzbAc8nHxo0BMzAUjH0jxi68FCHhAaHWGVqGN9Dpd8
	 JARQ8i440pv+fVJ36dhLZQ8gsEtlf+5upFQOTScX13SP7utujmZGWdsX6JPgdrRh77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785885;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ke43JPhEnJGPpaeciemetpcSJWEN0vUthfmPFNtgsXQ=;
	b=DmersJGwz6RuDICZiPr/5yZPURV2x5/455FVtnRRuELtYGmuLzzU1MUabpZuJukMkoY/
	 CKkBiVZlEu8kEuy2EahjmJdaIE7OzQndxSe6PrTmVz0w6sF5c4HFdcNBW9mSCHlwiFqzc
	 AVLycyE8/FCh3h+jSz3y65cnGyh8LiqFn5FbU0fTlSYLykltz3S6gPo6KFIrqueN1m+VX
	 f1aFyH8Rs4g5PIwAhr8aCHfpvgtVKnzO39NSOlZy8FVjOhezB5V3Ngn9bBFNbF96nW1Zl
	 5qrig+sIdKmmv3bhIvOlptqShAqBkaNy5Zt2oQ2LHl0td5+8OdImXZKyDAgCDc/Dk7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mE5fA+vt;
	arc=none smtp.remote-ip=115.124.30.118
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCEB606A31C;
	Fri, 27 Nov 2026 13:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFCEB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mE5fA+vt
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795785872; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Ke43JPhEnJGPpaeciemetpcSJWEN0vUthfmPFNtgsXQ=;
	b=mE5fA+vt7veHCnIHOmAXemNPKGOGAwTyIKCziGD7JgmOvNmT1Yuov8AqptT6TnLzzUWoFQ59Y89NmU2QcWTE/xWuwvSF/kAZYEf1Pp3/gqBpAIvB+gzSeQ2zXZwISY+1TPrFt+o78qFiXKQPxrUopCa/IFtFLvfVjWsBWSOAhmo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XFY7eEg_1795785871;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0XFY7eEg_1795785871 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 21:24:31 +0800
Date: Fri, 27 Nov 2026 21:24:30 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anju Zheng <zaj01616726@alibaba-inc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH RFC] PCI: Add warning about possible danger for
 pcie_bus_perf mode
Message-ID: <awmEjs8VnJO5XIXd@U-2FWC9VHC-2323.local>
References: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
 <awfv0WKc6iblVA9E@infradead.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awfv0WKc6iblVA9E@infradead.org>

On Thu, Nov 26, 2026 at 12:37:37AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 25, 2026 at 11:58:29PM +0800, Feng Tang wrote:
> > During stability test, there was a bug that running 'mount' on a type
> > of commercial NVME disk failed on an arm64 server and raised PCIe RAS
> > error and panic the kernel later, when using "pci=pcie_bus_perf" kernel
> > cmdline parameter.
> > 
> > The NVME device has MPS(Max Payload Size) capability of 256 bytes while
> > its corresponding root port is capable of 512 bytes. When enabling
> > PCIE_BUS_PERFORMANCE mode, its MPS and MRRS(Max Read Request Size) are
> > both set to 256, while the root port's are both set to 512. But the
> > NVME device doesn't comply with PCIe spec (v6.3), Section 7.5.3.4:
> 
> Please add a quirk for these devices now that you have identified
> this problem.

Following is a draft patch as suggested, which can solve this issue. Please
help to review, thanks!

- Feng

---

From 829623aa7afa9e2e19a232d3968ef8c282cda3e4 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@linux.alibaba.com>
Date: Thu, 26 Nov 2026 17:22:59 +0800
Subject: [PATCH] PCI: Quirk devices with broken MRRS function under
 PCIE_BUS_PERFORMANCE mode

During stability test with "pci=pcie_bus_perf" cmdline parameter, there
was a bug that running 'mount' on one commercial NVMe disk failed on an
arm64 server, raised PCIe RAS error of "Malformed TLP", and panic the
kernel. The issue can't be reproduced after removing "pci=pcie_bus_perf".

The NVMe device has MPS(Max Payload Size) capability of 256 bytes while
its corresponding root port is capable of 512 bytes. When enabling
PCIE_BUS_PERFORMANCE mode, its MPS and MRRS(Max Read Request Size) are
both set to 256, while the root port's are both set to 512. But the
NVMe device doesn't comply with PCIe spec (v6.3), Section 7.5.3.4:

"
Max_Read_Request_Size - This field sets the maximum Read Request size
for the Function as a Requester. The Function must not generate Read
Requests with a size exceeding the set value
"

that it doesn't honor the MRRS setting, and sends out Memory Read request
with length of 512 bytes, and when root port replies CplD packet with 512
bytes payload which exceeds device's MPS, PCIe RAS error is issued.

The problem can be reproduced on some arm64 server and Intel server.

This caused some data damage, and there were quite a few NVMe cards of
the same type damaged (though we are not sure these are directly related).

So add a quirk for this kind of devices which don't honor MRRS part of
PCIe spec, and under PCIE_BUS_PERFORMANCE mode, set their corresponding
root ports' MPS/MRRS to match theirs.

Reported-by: Anju Zheng <zaj01616726@alibaba-inc.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/pci/probe.c  | 24 ++++++++++++++++++++++++
 drivers/pci/quirks.c | 21 +++++++++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 46 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..9d8b2091cc46 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2932,11 +2932,14 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+static void pcie_write_mrrs(struct pci_dev *dev);
 static void pcie_write_mps(struct pci_dev *dev, int mps)
 {
 	int rc;
 
 	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
+		struct pci_bus	*bus;
+
 		mps = 128 << dev->pcie_mpss;
 
 		if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
@@ -2956,6 +2959,27 @@ static void pcie_write_mps(struct pci_dev *dev, int mps)
 			 * allowable MPS based on its parent bus).
 			 */
 			mps = min(mps, pcie_get_mps(dev->bus->self));
+
+		/*
+		 * Quirk for devices that issue Memory Read Requests larger
+		 * than their MRRS.  "Performance" only guarantees a child's MPS
+		 * is <= its parent's, so the corresponding root port may have
+		 * bigger MPS than the device. When such a device sends out a
+		 * Memory Read request with length > MRRS, and the root port
+		 * returns CplD packet with length larger than device's MPS,
+		 * "Malformed TLP" AER error or Machine Check Error(x86) could
+		 * be triggered. So decrease the root port's MPS/MRRS down to
+		 * match device's.
+		 */
+		bus = dev->bus;
+		if (dev->broken_mrrs && bus->self &&
+		    pci_pcie_type(bus->self) == PCI_EXP_TYPE_ROOT_PORT &&
+		    pcie_get_mps(bus->self) > mps) {
+			pci_info(dev, "Device has broken MRRS function, limiting MPS of upstream %s to %d\n",
+				 pci_name(bus->self), mps);
+			pcie_set_mps(bus->self, mps);
+			pcie_write_mrrs(bus->self);
+		}
 	}
 
 	rc = pcie_set_mps(dev, mps);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..4560a116ae98 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6423,3 +6423,24 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * Some commercial NVMe controllers do not honor their Max_Read_Request_Size:
+ * they issue Memory Read Requests larger than the MRRS the kernel programmed
+ * (under pci=pcie_bus_perf the kernel sets MRRS == MPS).  In PERFORMANCE mode
+ * the upstream Root Port may be left with a larger MPS than the device, so it
+ * may reply CplD packets with length larger than the device's MPS.  The device
+ * then reports them as Malformed TLPs, raising PCIe RAS error or Machine Check
+ * Error(for x86).
+ *
+ * Flag such devices so that later on pcie_write_mps() can force the corresponding
+ * root port's MPS down to match the device, keeping CplD packet length within
+ * the device's MPS.
+ *
+ * This only affects PCIE_BUS_PERFORMANCE mode.
+ */
+static void quirk_broken_mrrs(struct pci_dev *dev)
+{
+	dev->broken_mrrs = 1;
+}
+DECLARE_PCI_FIXUP_HEADER(0x144d, 0xa80a, quirk_broken_mrrs);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..adeafed52ff6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -504,6 +504,7 @@ struct pci_dev {
 	 */
 	unsigned int	external_facing:1;
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
+	unsigned int	broken_mrrs:1;		/* Issues read request with length > MRRS */
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
-- 
2.39.5 (Apple Git-154)




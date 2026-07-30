Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5A3B52E1
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 07:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396149; cv=none; b=PIUabAubnCR8JfTJE5zIXoCFHAedwASVkjZSXUsEmzFaugQaOBHswZFzKYDNx2CqTWniqv4zAlp+/wgfsLHeXyz4uLdNgjfAq0BWgr5wgd21bA/EWthN9E4NBdmu/b2Uy2T03EfkRNjnrBgFFOwixX44ZicVXhyMsyMA0GLfO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396149; c=relaxed/simple;
	bh=1m1zRVCjFpLmYBbrYHApJxG21yrffcHK2luGX6t0UpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpXojTNd0iXpOq0qBQ4CfiIGwVl90JlT0Kztv6O8d7SE/OpKur0shhifz+lJ0MO2WInmzSClK7vEBdZ6OxjRl83w42E/KIkPEPCSkPAvBvEWQz3EzxnsHzXW1s5XL/1Vs2QKSwA6SwJtj7QBQMdhHdR5DfUUEqqclVNV40tG7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nearthlab.com; spf=none smtp.mailfrom=nearthlab.com; dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.b=YKR5Wlax; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.b="YKR5Wlax"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1556527b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 00:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nearthlab.com; s=google; t=1785396147; x=1786000947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IrNx642kewl/zDKJOpDkLzgjGLhqUgb7rTigNrbEyMI=;
        b=YKR5WlaxLVD0bB0VLGd4c5K5ljh62hLdKcgdCte3sUTFTTBK8gncVKhN3aTQE+xkA+
         59T00eG5fz6RRhUoXETdkfem/VEB4nzsDRyGzTh6R7aLAEx0tlGRfBPQcnXNsRL2bnKU
         DE1YruiK3klekv09ATV+HvZzITIEZLZqWkBAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785396147; x=1786000947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IrNx642kewl/zDKJOpDkLzgjGLhqUgb7rTigNrbEyMI=;
        b=tUAlG16rQBXHXNjwYHY6y5SVvvK+0/bpn35VF+tGasylygHMQgnOy5Gm3KAImSUml3
         ScyDD3ilW1VVQlQ8GdYgioAzM5wpKxumLlrgnwISlplnO5Lk0SCqAEBqPMU7U7kdndCz
         vdt1Av1DcLtobaSBdJ6sqxWvdyXeVUlGXkhW9fJrbJ6dnL4o7AlYVfchw3mFPHSoife6
         QWrcmNk4BhVnne+525YHaxybuvFabpiXySnRjvXslWeC1jCtteD5/S+2yvoIOJQAqWX/
         kAtETvEaeKJHIkcR9y+tRh09sucEYHTC4x/aF3pOuTsKN567xlKLlIBEI+wM2ScQ+iMb
         aAkw==
X-Forwarded-Encrypted: i=1; AHgh+RqRXd2E63HcsB+9aL+ac06OuSSV71/dRmgj+iyDba8csWUxihBO19gwFJcEt/scbeuZVSk5KrdE7vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZc8/0Twb4bOOEXBLjU04usFeSV25+GPNbZieQQ9pxQrP919uP
	n9ABJLT4xpyuvTYU/DEUA9iZ+es5m9cNRoYLyZ9Rf7LY9Qe8NWdUNeUKAGvned3SbD0=
X-Gm-Gg: AR+sD10Fl/UjArrz5CAOMaID9da0iExI7L5LjpmTMu7Ogc0i72xN5OUGeepbOZPTeVt
	NS/VJlXVg2ZfvwFheFQjaQFzrgVXWvFuepcO2fa0MXhX70te5juiBWJ3Q1QRmake8+gXR8uV+Vn
	+EMyUtHHMShP6QH4KDXIO9NqHe5ytaehfXlkPM0aeTzArrcNi2u6WlsolMqPH2gWLPH61jQA0ph
	DIP0j+Fktvd/6AURZSsmEE7HX16SGdG9E6+C0L3BKY/vuyMhBTkaTGnXjCGwcoC0CL3nmyjZyi/
	sxCdyy6Nvzxl7/y0vTbxI6seIO5OdpoC4bFewHe6k7Vlv+uRs4+9gCk4pAoyrGBkWzZI7I8BQ47
	a17DIjMLFnV6LfLxsxt5VcpyqiexSqAJhmAKDT8UMHJec9khsTW14Y7kd0HaEJD97vvtNfskyc+
	xV5rL8P2M//jHjc8MS0tWk+8YTOuuhC1h09wC98j7iTn0N16f+Y2KiY4QgjLkqU3yn/UYk9vWUP
	rhsuw9x
X-Received: by 2002:a05:6a00:a16:b0:848:4080:afe8 with SMTP id d2e1a72fcca58-84ebc2384fcmr1614396b3a.22.1785396146880;
        Thu, 30 Jul 2026 00:22:26 -0700 (PDT)
Received: from sangwoohan-nearthlab ([121.133.119.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02fa4c9sm2573323b3a.32.2026.07.30.00.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:22:26 -0700 (PDT)
From: Sangwoo Han <sangwoo.han@nearthlab.com>
To: jim2101024@gmail.com,
	florian.fainelli@broadcom.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sangwoo.han@nearthlab.com
Subject: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are handed out
Date: Thu, 30 Jul 2026 16:22:15 +0900
Message-ID: <20260730072215.2090974-1-sangwoo.han@nearthlab.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brcm_msi_alloc() reserves a naturally aligned power-of-two region with
bitmap_find_free_region(order_base_2(nr_irqs)), but the irqdomain core
releases the vectors of a block one at a time:

  /* irq_domain_free_irqs_hierarchy() */
  for (i = 0; i < nr_irqs; i++)
          if (irq_domain_get_irq_data(domain, irq_base + i))
                  domain->ops->free(domain, irq_base + i, 1);

That loop is the only caller of an irq_domain's ops->free(), so
brcm_irq_domain_free() always sees nr_irqs == 1 and
bitmap_release_region() clears exactly one bit per call. A request whose
vector count is not a power of two therefore reserves
roundup_pow_of_two(nr_irqs) bits but releases only nr_irqs of them, and
the difference stays set for the lifetime of the controller.

Multi-MSI regions are order-aligned and the controller has at most 32
MSIs, so the pool is quickly exhausted. Observed on a BCM2712 with a
5-vector endpoint behind a 4-port PCIe switch: the switch ports take
hwirq 0x0-0x3 and the endpoint's block walks 0x8 -> 0x10 -> 0x18 across
three driver reloads until no aligned order-3 region is left.
pci_alloc_irq_vectors() then falls back to a single vector for the rest
of the boot, silently multiplexing the endpoint's four completion
interrupts onto one hwirq.

Devices that ask for a non-power-of-two vector count are not exotic:
wil6210 asks for 3, the MHI modems for 5 (Quectel EM1xx, Foxconn SDX55,
Telit FN990, MediaTek MV3x) or 7 (Qualcomm v1), ath11k WCN6750 for 28
and ptp_ocp for 17. MSI-X is unaffected because it allocates one
descriptor per vector with nvec_used == 1, so the order is always zero.

Reserve exactly the vectors that are handed out, at a base found with
bitmap_find_next_zero_area(), and clear exactly the vectors that are
freed. The number of reserved bits then matches the number the core
releases, whatever arity it uses.

The base still has to be aligned: PCI Local Bus Specification 3.0
(section 6.8.1.6) lets the endpoint encode the vector number in the low
order_base_2(nr_irqs) bits of the Message Data register, and in this
controller those bits are the hwirq itself. The alignment mask has to be
roundup_pow_of_two(nr_irqs) - 1 rather than nr_irqs - 1:
bitmap_find_next_zero_area() requires a mask of the form 2^k - 1. No
align_offset is needed because the bitmap index is the value the
endpoint ORs in, see brcm_msi_compose_msi_msg().

For a power-of-two nr_irqs the alignment and the region length are both
nr_irqs, so the base returned is the same as before and those
allocations are unaffected.

Fixes: 198acab1772f ("PCI: brcmstb: Enable Multi-MSI")
Cc: stable@vger.kernel.org
Signed-off-by: Sangwoo Han <sangwoo.han@nearthlab.com>
---

Notes:
    Tested on a BCM2712 (Raspberry Pi 5) with a 5-vector endpoint behind a
    4-port PCIe switch, running 6.12.25 where brcm_msi_alloc() and
    brcm_msi_free() are byte-identical to mainline. Without the patch the
    endpoint's block walks 0x8 -> 0x10 -> 0x18 over three driver reloads and
    then falls back to a single vector for the rest of the boot; with it the
    block returns to 0x8 on all of eight reload cycles and the inner
    domain's mapped count round-trips cleanly.
    
    Compile-tested on mainline for arm64 with W=1 and C=1 (sparse); no new
    warnings.

 drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 8a0c353d2a..6c5166666d 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -595,11 +595,22 @@ static struct irq_chip brcm_msi_bottom_irq_chip = {
 
 static int brcm_msi_alloc(struct brcm_msi *msi, unsigned int nr_irqs)
 {
+	/*
+	 * brcm_msi_compose_msi_msg() puts hwirq in the low order bits of the
+	 * message data, which a Multi-MSI endpoint rewrites per vector, so a
+	 * block's base must be aligned to the Multiple Message Enable count.
+	 */
+	unsigned long align_mask = roundup_pow_of_two(nr_irqs) - 1;
 	int hwirq;
 
 	mutex_lock(&msi->lock);
-	hwirq = bitmap_find_free_region(msi->used, msi->nr,
-					order_base_2(nr_irqs));
+	hwirq = bitmap_find_next_zero_area(msi->used, msi->nr, 0, nr_irqs,
+					   align_mask);
+	if (hwirq >= msi->nr) {
+		mutex_unlock(&msi->lock);
+		return -ENOSPC;
+	}
+	bitmap_set(msi->used, hwirq, nr_irqs);
 	mutex_unlock(&msi->lock);
 
 	return hwirq;
@@ -609,7 +620,7 @@ static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq,
 			  unsigned int nr_irqs)
 {
 	mutex_lock(&msi->lock);
-	bitmap_release_region(msi->used, hwirq, order_base_2(nr_irqs));
+	bitmap_clear(msi->used, hwirq, nr_irqs);
 	mutex_unlock(&msi->lock);
 }
 
-- 
2.53.0


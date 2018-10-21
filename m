Return-Path: <SRS0=lW7W=NB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7211ECDE44
	for <linux-pci@archiver.kernel.org>; Sun, 21 Oct 2018 15:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8D520652
	for <linux-pci@archiver.kernel.org>; Sun, 21 Oct 2018 15:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK02FETH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8D520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeJUXe5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 21 Oct 2018 19:34:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33997 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeJUXe4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Oct 2018 19:34:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id z25-v6so7385331wmf.1
        for <linux-pci@vger.kernel.org>; Sun, 21 Oct 2018 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+LFreJ4yYQnRsJyy1+wSK6OMiA2wNZadXrLA8MgJkVc=;
        b=bK02FETH3SgFfuOM3KmHYd57b+0zTerLGPL+ieJcWCbQRVMQHi22807PXuurAn+Fl/
         Vfg8Q0HKJ9xi06KKjLqXe/amEZKHBXV8XFvJDU4LcJlOKDcP2uJkQ3vA9az5B5XgKsQr
         BXmYwXjUTJWPZkEPg252kBnZ0bucJMRj8WnGsyoHhuuczdO6xclt6lZJ0dJJ1besUzFH
         1HqkJBZPH9576HY2FCWVCL0Gf2JQc8R6Ivf/gdj0SIMFHppvJbNM0lpi4ftFP6tyg+H/
         FgwgKcS2E6B5zAUIFBrTWlj+vo+IHFq7bxR5Ahh/m5i2rGh7tJoA+Sx3p5I6lYZDm9fC
         a6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+LFreJ4yYQnRsJyy1+wSK6OMiA2wNZadXrLA8MgJkVc=;
        b=uMuSiDX4gXsOzw2gj7aAeFfSBakVgNFDKMh+YHUZhiz6QqRunOlr8A8XGF39htBSol
         DMU51PrPxn/s/1/7QpwDJJVmccGvt9yce1+Z9H+6kXpQabXunVROGgOJMK0Pg+2RUgmD
         j1OsOgvzKTr0IB6o2zeZvHVlSEQnepazbQzNpwucKUOuLYAIO/1tdC1FTLfEJPjmNgyD
         24YWGcJ5MJcjn3+Dweb8itCwEtZVhvNSSRNMP4dyj4f4wATtay+DT3/ppTVfvMGqlBVL
         l0XjCY6vZkpmM/f6mCbDcVBShZ5C2jPFVyQrDhUFMyi/2LABCP4s5DeXWhjRdvZtFyDS
         rxsA==
X-Gm-Message-State: ABuFfog/LegrTKS4SpK2wh6HQIjUfOlvo+yefhfowtp5iDF1qv1FXzc6
        jI3jZ1FkRJUIzfxT6V/WSfE3fWTm2Fo=
X-Google-Smtp-Source: ACcGV63XpmwhSuVs7vhF2BujAXXD7YNsz1ArpWixJZgV7KTpJppQOF7kqzUNolH8NLpGKb5IIlgtoQ==
X-Received: by 2002:a1c:9fd5:: with SMTP id i204-v6mr12737492wme.88.1540135214694;
        Sun, 21 Oct 2018 08:20:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:3006:9cbf:497e:31c2? (p200300EA8BD43F0030069CBF497E31C2.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:3006:9cbf:497e:31c2])
        by smtp.googlemail.com with ESMTPSA id 18-v6sm9431510wmw.26.2018.10.21.08.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 08:20:14 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: switch remaining pci_printk(KERN_DEBUG users to pci_dbg
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <44473b8c-c9d3-733c-a4b1-18904f4d62b2@gmail.com>
Date:   Sun, 21 Oct 2018 17:20:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_printk messages with level KERN_DEBUG are written to the syslog
even if CONFIG_DEBUG isn't defined. This may confuse users, e.g. if
the debug messages include "not supported" or "failed to". To avoid
this switch the remaining pci_printk(KERN_DEBUG users to pci_dbg.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/bus.c       |  3 +--
 drivers/pci/pci.c       | 39 +++++++++++++++++++--------------------
 drivers/pci/probe.c     | 17 ++++++++---------
 drivers/pci/setup-bus.c | 26 +++++++++++++-------------
 4 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5cb40b251..ddee5f461 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -288,8 +288,7 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 		res->end = end;
 		res->flags &= ~IORESOURCE_UNSET;
 		orig_res.flags &= ~IORESOURCE_UNSET;
-		pci_printk(KERN_DEBUG, dev, "%pR clipped to %pR\n",
-				 &orig_res, res);
+		pci_dbg(dev, "%pR clipped to %pR\n", &orig_res, res);
 
 		return true;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fb63b3d89..e60fd652d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2711,19 +2711,19 @@ void pci_pm_init(struct pci_dev *dev)
 			dev->d2_support = true;
 
 		if (dev->d1_support || dev->d2_support)
-			pci_printk(KERN_DEBUG, dev, "supports%s%s\n",
-				   dev->d1_support ? " D1" : "",
-				   dev->d2_support ? " D2" : "");
+			pci_dbg(dev, "supports%s%s\n",
+				dev->d1_support ? " D1" : "",
+				dev->d2_support ? " D2" : "");
 	}
 
 	pmc &= PCI_PM_CAP_PME_MASK;
 	if (pmc) {
-		pci_printk(KERN_DEBUG, dev, "PME# supported from%s%s%s%s%s\n",
-			 (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
-			 (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
-			 (pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
-			 (pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
-			 (pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" : "");
+		pci_dbg(dev, "PME# supported from%s%s%s%s%s\n",
+			(pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
+			(pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
+			(pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
+			(pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
+			(pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" : "");
 		dev->pme_support = pmc >> PCI_PM_CAP_PME_SHIFT;
 		dev->pme_poll = true;
 		/*
@@ -2886,18 +2886,17 @@ static int pci_ea_read(struct pci_dev *dev, int offset)
 	res->flags = flags;
 
 	if (bei <= PCI_EA_BEI_BAR5)
-		pci_printk(KERN_DEBUG, dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   bei, res, prop);
+		pci_dbg(dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
+			bei, res, prop);
 	else if (bei == PCI_EA_BEI_ROM)
-		pci_printk(KERN_DEBUG, dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   res, prop);
+		pci_dbg(dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
+			res, prop);
 	else if (bei >= PCI_EA_BEI_VF_BAR0 && bei <= PCI_EA_BEI_VF_BAR5)
-		pci_printk(KERN_DEBUG, dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   bei - PCI_EA_BEI_VF_BAR0, res, prop);
+		pci_dbg(dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
+			bei - PCI_EA_BEI_VF_BAR0, res, prop);
 	else
-		pci_printk(KERN_DEBUG, dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   bei, res, prop);
-
+		pci_dbg(dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
+			bei, res, prop);
 out:
 	return offset + ent_size;
 }
@@ -4114,8 +4113,8 @@ int pci_set_cacheline_size(struct pci_dev *dev)
 	if (cacheline_size == pci_cache_line_size)
 		return 0;
 
-	pci_printk(KERN_DEBUG, dev, "cache line size of %d is not supported\n",
-		   pci_cache_line_size << 2);
+	pci_dbg(dev, "cache line size of %d is not supported\n",
+		pci_cache_line_size << 2);
 
 	return -EINVAL;
 }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b1c05b505..bd986a1c1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -317,7 +317,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	res->flags = 0;
 out:
 	if (res->flags)
-		pci_printk(KERN_DEBUG, dev, "reg 0x%x: %pR\n", pos, res);
+		pci_dbg(dev, "reg 0x%x: %pR\n", pos, res);
 
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
@@ -384,7 +384,7 @@ static void pci_read_bridge_io(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + io_granularity - 1;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
+		pci_dbg(dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -406,7 +406,7 @@ static void pci_read_bridge_mmio(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
+		pci_dbg(dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -459,7 +459,7 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
+		pci_dbg(dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -489,9 +489,8 @@ void pci_read_bridge_bases(struct pci_bus *child)
 			if (res && res->flags) {
 				pci_bus_add_resource(child, res,
 						     PCI_SUBTRACTIVE_DECODE);
-				pci_printk(KERN_DEBUG, dev,
-					   "  bridge window %pR (subtractive decode)\n",
-					   res);
+				pci_dbg(dev, "  bridge window %pR (subtractive decode)\n",
+					res);
 			}
 		}
 	}
@@ -1626,8 +1625,8 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->revision = class & 0xff;
 	dev->class = class >> 8;		    /* upper 3 bytes */
 
-	pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
-		   dev->vendor, dev->device, dev->hdr_type, dev->class);
+	pci_dbg(dev, "[%04x:%04x] type %02x class %#08x\n",
+		dev->vendor, dev->device, dev->hdr_type, dev->class);
 
 	if (pci_early_dump)
 		early_dump_pci_device(dev);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed960436d..34c1d0e84 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -255,10 +255,10 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(add_res->dev, idx,
 						  add_size, align))
-				pci_printk(KERN_DEBUG, add_res->dev,
-					   "failed to add %llx res[%d]=%pR\n",
-					   (unsigned long long)add_size,
-					   idx, res);
+				pci_dbg(add_res->dev,
+					"failed to add %llx res[%d]=%pR\n",
+					(unsigned long long)add_size,
+					idx, res);
 		}
 out:
 		list_del(&add_res->list);
@@ -955,9 +955,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0,
 			    min_align);
-		pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx\n",
-			   b_res, &bus->busn_res,
-			   (unsigned long long)size1-size0);
+		pci_dbg(bus->self, "bridge window %pR to %pR add_size %llx\n",
+			b_res, &bus->busn_res,
+			(unsigned long long)size1-size0);
 	}
 }
 
@@ -1100,10 +1100,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
-		pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
-			   b_res, &bus->busn_res,
-			   (unsigned long long) (size1 - size0),
-			   (unsigned long long) add_align);
+		pci_dbg(bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
+			b_res, &bus->busn_res,
+			(unsigned long long) (size1 - size0),
+			(unsigned long long) add_align);
 	}
 	return 0;
 }
@@ -1568,8 +1568,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	release_child_resources(r);
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
-		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
-					PCI_BRIDGE_RESOURCES + idx, r);
+		pci_dbg(dev, "resource %d %pR released\n",
+			PCI_BRIDGE_RESOURCES + idx, r);
 		/* keep the old size */
 		r->end = resource_size(r) - 1;
 		r->start = 0;
-- 
2.19.1



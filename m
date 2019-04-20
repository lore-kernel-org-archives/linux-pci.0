Return-Path: <SRS0=j1yu=SW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24854C282DD
	for <linux-pci@archiver.kernel.org>; Sat, 20 Apr 2019 04:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B920421479
	for <linux-pci@archiver.kernel.org>; Sat, 20 Apr 2019 04:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4004ktK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfDTEH3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Apr 2019 00:07:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36547 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfDTEH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Apr 2019 00:07:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id u17so5254965lfi.3;
        Fri, 19 Apr 2019 21:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y8sdBCBwGrUnTs8U4AYcwmsSBmZk8arcrkhjjzqHCGs=;
        b=N4004ktKf6dsGtBPAomwdEwzukX2prDz9CX3UoWpat0hCmK2KjubCEXeqnaUUtLhRt
         kiuEEDk9JkTZZpxYuDCwp5OQmWBOb3D5Ufqig34d6UbJKsn6dCtgfks7QC87RUOjL1FD
         vSATfTZBac+1uwtDt4wqzl1bQYRPiAT9hPVF/vDpGNsezU145N/CRXj0T1fIf3X5+CT+
         r8zlhHmpjsLgTf7fj8Tm55AWUlgJqZcyx3nwPwQ5LFmq7+yfgRGi294P4mgjG8doRuSQ
         ohjnfVl0DMG+wlGqalPoOhv/7y/chPXM5LaY+peEbHt0mOk56gW1tiiAIAg3P4oHkPN3
         miVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y8sdBCBwGrUnTs8U4AYcwmsSBmZk8arcrkhjjzqHCGs=;
        b=d6OMsugg4caW072Tt+Ym43wgm3yHhn380pPkAW15m2sYHZB0tMregfvnc4oDEgJbLl
         FDFQewjkVhkaooTHiO0C4mIqnOn0/V8dtIi8TqG3vKs6f2jinC59VKyojIItJ/0T1I0b
         GFIUrT74bLSAf/klfRFg0W6Iix/inLj66+TfS74HnInD+ff8sQIR+cmzzsVGEMrUfQ7+
         g4C4atje+4gb0fhOR1xwlgKYM5SMXjqFBusq7kn1DY8eyc2SO2FIR2YxlLKpXz7oFkLJ
         l7QnruVV2bHMht/LsQF6Ov9jGwJvbb9Zpqj2HXbB4yu6p4KhIjKef72AmHfiarbHJaEj
         n4qw==
X-Gm-Message-State: APjAAAVnthI3MIBozqMgtE8jnUdsupxb2l01ZKFoKlj482yHI/UkwewD
        nV2xLMpNJRSGK9hme/mU0e0=
X-Google-Smtp-Source: APXvYqwcUz7h776kaTgjtT6n58ep8qV58FHqikaT5wFX8bDHKBJuGOxqwB+t3coKlr49m39dsL/JKg==
X-Received: by 2002:ac2:4465:: with SMTP id y5mr3991015lfl.82.1555733245404;
        Fri, 19 Apr 2019 21:07:25 -0700 (PDT)
Received: from localhost.localdomain (93-96-157.netrun.cytanet.com.cy. [93.109.96.157])
        by smtp.gmail.com with ESMTPSA id m1sm1538319lfk.84.2019.04.19.21.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 21:07:24 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     bhelgaas@google.com
Cc:     konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: use pci_*(), dev_*() and pr_*() instead of pci_printk()
Date:   Sat, 20 Apr 2019 07:07:20 +0300
Message-Id: <1555733240-19875-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace pci_printk with pci_*, dev_*() and pr_*() to avoid checkpatch
warnings.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/pci/bus.c          |  3 +--
 drivers/pci/pci.c          | 14 +++++++-------
 drivers/pci/probe.c        | 21 +++++++++------------
 drivers/pci/setup-bus.c    | 15 +++++++--------
 drivers/pci/xen-pcifront.c |  7 +++----
 5 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index a742ef5..25e91ae 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -291,8 +291,7 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 		res->end = end;
 		res->flags &= ~IORESOURCE_UNSET;
 		orig_res.flags &= ~IORESOURCE_UNSET;
-		pci_printk(KERN_DEBUG, dev, "%pR clipped to %pR\n",
-				 &orig_res, res);
+		pci_info(dev, "%pR clipped to %pR\n", &orig_res, res);
 
 		return true;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a24a8bc..d439151 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2789,14 +2789,14 @@ void pci_pm_init(struct pci_dev *dev)
 			dev->d2_support = true;
 
 		if (dev->d1_support || dev->d2_support)
-			pci_printk(KERN_DEBUG, dev, "supports%s%s\n",
+			pci_info(dev, "supports%s%s\n",
 				   dev->d1_support ? " D1" : "",
 				   dev->d2_support ? " D2" : "");
 	}
 
 	pmc &= PCI_PM_CAP_PME_MASK;
 	if (pmc) {
-		pci_printk(KERN_DEBUG, dev, "PME# supported from%s%s%s%s%s\n",
+		pci_info(dev, "PME# supported from%s%s%s%s%s\n",
 			 (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
 			 (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
 			 (pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
@@ -2964,16 +2964,16 @@ static int pci_ea_read(struct pci_dev *dev, int offset)
 	res->flags = flags;
 
 	if (bei <= PCI_EA_BEI_BAR5)
-		pci_printk(KERN_DEBUG, dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
+		pci_info(dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
 			   bei, res, prop);
 	else if (bei == PCI_EA_BEI_ROM)
-		pci_printk(KERN_DEBUG, dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
+		pci_info(dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
 			   res, prop);
 	else if (bei >= PCI_EA_BEI_VF_BAR0 && bei <= PCI_EA_BEI_VF_BAR5)
-		pci_printk(KERN_DEBUG, dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
+		pci_info(dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
 			   bei - PCI_EA_BEI_VF_BAR0, res, prop);
 	else
-		pci_printk(KERN_DEBUG, dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
+		pci_info(dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
 			   bei, res, prop);
 
 out:
@@ -4200,7 +4200,7 @@ int pci_set_cacheline_size(struct pci_dev *dev)
 	if (cacheline_size == pci_cache_line_size)
 		return 0;
 
-	pci_printk(KERN_DEBUG, dev, "cache line size of %d is not supported\n",
+	pci_info(dev, "cache line size of %d is not supported\n",
 		   pci_cache_line_size << 2);
 
 	return -EINVAL;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index eea7847..89fdfd4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -317,7 +317,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	res->flags = 0;
 out:
 	if (res->flags)
-		pci_printk(KERN_DEBUG, dev, "reg 0x%x: %pR\n", pos, res);
+		pci_info(dev, "reg 0x%x: %pR\n", pos, res);
 
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
@@ -435,7 +435,7 @@ static void pci_read_bridge_io(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + io_granularity - 1;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
+		pci_info(dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -457,7 +457,7 @@ static void pci_read_bridge_mmio(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
+		pci_info(dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -510,7 +510,7 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
+		pci_info(dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -540,8 +540,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 			if (res && res->flags) {
 				pci_bus_add_resource(child, res,
 						     PCI_SUBTRACTIVE_DECODE);
-				pci_printk(KERN_DEBUG, dev,
-					   "  bridge window %pR (subtractive decode)\n",
+				pci_info(dev, "  bridge window %pR (subtractive decode)\n",
 					   res);
 			}
 		}
@@ -1695,7 +1694,7 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->revision = class & 0xff;
 	dev->class = class >> 8;		    /* upper 3 bytes */
 
-	pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
+	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
 		   dev->vendor, dev->device, dev->hdr_type, dev->class);
 
 	if (pci_early_dump)
@@ -3091,7 +3090,7 @@ int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 	conflict = request_resource_conflict(parent_res, res);
 
 	if (conflict)
-		dev_printk(KERN_DEBUG, &b->dev,
+		dev_info(&b->dev,
 			   "busn_res: can not insert %pR under %s%pR (conflicts with %s %pR)\n",
 			    res, pci_is_root_bus(b) ? "domain " : "",
 			    parent_res, conflict->name, conflict);
@@ -3111,8 +3110,7 @@ int pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
 
 	size = bus_max - res->start + 1;
 	ret = adjust_resource(res, res->start, size);
-	dev_printk(KERN_DEBUG, &b->dev,
-			"busn_res: %pR end %s updated to %02x\n",
+	dev_info(&b->dev, "busn_res: %pR end %s updated to %02x\n",
 			&old_res, ret ? "can not be" : "is", bus_max);
 
 	if (!ret && !res->parent)
@@ -3130,8 +3128,7 @@ void pci_bus_release_busn_res(struct pci_bus *b)
 		return;
 
 	ret = release_resource(res);
-	dev_printk(KERN_DEBUG, &b->dev,
-			"busn_res: %pR %s released\n",
+	dev_info(&b->dev, "busn_res: %pR %s released\n",
 			res, ret ? "can not be" : "is");
 }
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 418023a..45ae8a6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -257,7 +257,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(add_res->dev, idx,
 						  add_size, align))
-				pci_printk(KERN_DEBUG, add_res->dev,
+				pci_info(add_res->dev,
 					   "failed to add %llx res[%d]=%pR\n",
 					   (unsigned long long)add_size,
 					   idx, res);
@@ -920,7 +920,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0,
 			    min_align);
-		pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx\n",
+		pci_info(bus->self, "bridge window %pR to %pR add_size %llx\n",
 			   b_res, &bus->busn_res,
 			   (unsigned long long)size1-size0);
 	}
@@ -1065,7 +1065,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
-		pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
+		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
 			   b_res, &bus->busn_res,
 			   (unsigned long long) (size1 - size0),
 			   (unsigned long long) add_align);
@@ -1533,7 +1533,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	release_child_resources(r);
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
-		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
+		pci_info(dev, "resource %d %pR released\n",
 					PCI_BRIDGE_RESOURCES + idx, r);
 		/* keep the old size */
 		r->end = resource_size(r) - 1;
@@ -1598,7 +1598,7 @@ static void pci_bus_dump_res(struct pci_bus *bus)
 		if (!res || !res->end || !res->flags)
 			continue;
 
-		dev_printk(KERN_DEBUG, &bus->dev, "resource %d %pR\n", i, res);
+		dev_info(&bus->dev, "resource %d %pR\n", i, res);
 	}
 }
 
@@ -1732,8 +1732,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 		int max_depth = pci_bus_get_depth(bus);
 
 		pci_try_num = max_depth + 1;
-		dev_printk(KERN_DEBUG, &bus->dev,
-			   "max bus depth: %d pci_try_num: %d\n",
+		dev_info(&bus->dev, "max bus depth: %d pci_try_num: %d\n",
 			   max_depth, pci_try_num);
 	}
 
@@ -1768,7 +1767,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 		goto dump;
 	}
 
-	dev_printk(KERN_DEBUG, &bus->dev,
+	dev_info(&bus->dev,
 		   "No. %d try to assign unassigned res\n", tried_times + 1);
 
 	/* third times and later will not check if it is leaf */
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 14cf0f4..7ab7455 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -291,8 +291,7 @@ static int pci_frontend_enable_msix(struct pci_dev *dev,
 				vector[i] = op.msix_entries[i].vector;
 			}
 		} else {
-			printk(KERN_DEBUG "enable msix get value %x\n",
-				op.value);
+			pr_info("enable msix get value %x\n", op.value);
 			err = op.value;
 		}
 	} else {
@@ -364,12 +363,12 @@ static void pci_frontend_disable_msi(struct pci_dev *dev)
 	err = do_pci_op(pdev, &op);
 	if (err == XEN_PCI_ERR_dev_not_found) {
 		/* XXX No response from backend, what shall we do? */
-		printk(KERN_DEBUG "get no response from backend for disable MSI\n");
+		pr_info("get no response from backend for disable MSI\n");
 		return;
 	}
 	if (err)
 		/* how can pciback notify us fail? */
-		printk(KERN_DEBUG "get fake response frombackend\n");
+		pr_info("get fake response frombackend\n");
 }
 
 static struct xen_pci_frontend_ops pci_frontend_ops = {
-- 
2.7.4


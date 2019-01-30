Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB94C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 17:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB042184D
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548867983;
	bh=iJCfhl4idjAo8RareOx2BQFx3jKZU6evYVhqWFVbUFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gcx1h38+KDiuntDZ5KwetGgFE/SN4x/RPQVyTTrCXOa6ACQM3fhebhT5tLIgEW1j/
	 vp36SynZAqXM/P/H3fdJ1XazEjfQ08fvGmAhqRa2/MjuO6hZVLWCoTSxB6/c+CZ8hn
	 OA7M20aFLU+PRsLyeOHSo8v1FyaBampZqDtKkyvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbfA3RGW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:06:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbfA3RGW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 12:06:22 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 381DD20989;
        Wed, 30 Jan 2019 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548867980;
        bh=iJCfhl4idjAo8RareOx2BQFx3jKZU6evYVhqWFVbUFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1fie8BrC5rjM3TNwbOPhnuVOvfrum0Ulwq+aPQ8jvn9BMUjupGVgSDVd/70dbbhTx
         O8Rx/nuRvjRzaR3K2K8oDY6r0Z13Dsf/fWpvz+wVEQYvbQmW+HXezZ+2mUrRwIIdfN
         lqsgGAkfwtKsJxLjdn9finik1eRF36DLwxUWVPdI=
Date:   Wed, 30 Jan 2019 11:06:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     honghui.zhang@mediatek.com
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, marc.zyngier@arm.com,
        jianjun.wang@mediatek.com, yt.shen@mediatek.com,
        matthias.bgg@gmail.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com
Subject: Re: [PATCH v9 2/9] PCI: Using PCI configuration space header type
 instead of class type to assign resource
Message-ID: <20190130170612.GH229773@google.com>
References: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
 <1539686690-24068-3-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539686690-24068-3-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 16, 2018 at 06:44:43PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The PCI configuration space header type defines the layout of the rest
> of the header (PCI r3.0 sec 6.1, PCIe r4.0 sec 7.5.1.1.9) while the
> resource assignment is based on the configuration space layout instead
> of its class type. Using configuration space header type instead of
> class type for the resource assignment.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>

I applied the patch below to pci/enumeration for v5.1.

I dropped the hunk that removed the PCI_CLASS_BRIDGE_HOST check per
Lorenzo's concern.  Let me know if you have any other concerns.


commit b2fb5cc57469
Author: Honghui Zhang <honghui.zhang@mediatek.com>
Date:   Tue Oct 16 18:44:43 2018 +0800

    PCI: Rely on config space header type, not class code
    
    The PCI configuration space header type tells us whether the device is a
    bridge, a CardBus bridge, or a normal device, and defines the layout of the
    rest of the header (PCI r3.0 sec 6.1, PCIe r4.0 sec 7.5.1.1.9).
    
    When we rely on the header format, e.g., when we're dealing with bridge
    windows, we should check the header type, not the class code.  The class
    code is loosely related to the header type, but is often incorrect and the
    spec doesn't actually require it to be related to the header format.
    
    Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
    Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
    [bhelgaas: changelog, keep the PCI_CLASS_BRIDGE_HOST check]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9d8e3c837de..e9d938e14ba8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6000,8 +6000,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	 * to enable the kernel to reassign new resource
 	 * window later on.
 	 */
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
-	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
 			r = &dev->resource[i];
 			if (!(r->flags & IORESOURCE_MEM))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e2e4154cdd9..128459a0ffba 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1779,9 +1779,6 @@ int pci_setup_device(struct pci_dev *dev)
 		break;
 
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
-		if (class != PCI_CLASS_BRIDGE_PCI)
-			goto bad;
-
 		/*
 		 * The PCI-to-PCI bridge spec requires that subtractive
 		 * decoding (i.e. transparent) bridge must have programming
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1941bb0a6c13..ec44a0f3a7ac 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1186,12 +1186,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		if (!b)
 			continue;
 
-		switch (dev->class >> 8) {
-		case PCI_CLASS_BRIDGE_CARDBUS:
+		switch (dev->hdr_type) {
+		case PCI_HEADER_TYPE_CARDBUS:
 			pci_bus_size_cardbus(b, realloc_head);
 			break;
 
-		case PCI_CLASS_BRIDGE_PCI:
+		case PCI_HEADER_TYPE_BRIDGE:
 		default:
 			__pci_bus_size_bridges(b, realloc_head);
 			break;
@@ -1202,12 +1202,12 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	if (pci_is_root_bus(bus))
 		return;
 
-	switch (bus->self->class >> 8) {
-	case PCI_CLASS_BRIDGE_CARDBUS:
+	switch (bus->self->hdr_type) {
+	case PCI_HEADER_TYPE_CARDBUS:
 		/* don't size cardbuses yet. */
 		break;
 
-	case PCI_CLASS_BRIDGE_PCI:
+	case PCI_HEADER_TYPE_BRIDGE:
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
@@ -1356,13 +1356,13 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 		__pci_bus_assign_resources(b, realloc_head, fail_head);
 
-		switch (dev->class >> 8) {
-		case PCI_CLASS_BRIDGE_PCI:
+		switch (dev->hdr_type) {
+		case PCI_HEADER_TYPE_BRIDGE:
 			if (!pci_is_enabled(dev))
 				pci_setup_bridge(b);
 			break;
 
-		case PCI_CLASS_BRIDGE_CARDBUS:
+		case PCI_HEADER_TYPE_CARDBUS:
 			pci_setup_cardbus(b);
 			break;
 

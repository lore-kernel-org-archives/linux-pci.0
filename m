Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866F9C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 14:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8C621871
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 14:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeLROeR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:34:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60405 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeLROeR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 09:34:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E917720824; Tue, 18 Dec 2018 15:34:14 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id BAB62207D9;
        Tue, 18 Dec 2018 15:34:04 +0100 (CET)
Date:   Tue, 18 Dec 2018 15:34:04 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Regression with commit PCI: mvebu: Convert to PCI emulated
 bridge config space
Message-ID: <20181218153404.45b038cf@windsurf>
In-Reply-To: <20181218144702.752d97cd@windsurf>
References: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
        <20181218144702.752d97cd@windsurf>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Luis,

On Tue, 18 Dec 2018 14:47:02 +0100, Thomas Petazzoni wrote:

> Thanks for the bug report! I have an idea of what could be causing
> this, I've cooked a patch, I'm doing a build test. I of course won't be
> able to test it as I don't have amdgpu hardware, but I'll share the
> patch with you for testing.

Could you try the below patch:

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index fa0fc46edb0c..62468415e063 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -469,6 +469,23 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
        return PCI_BRIDGE_EMUL_HANDLED;
 }
 
+static pci_bridge_emul_read_status_t
+mvebu_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
+                                    int reg, u32 *value)
+{
+       switch(reg) {
+       case PCI_ROM_ADDRESS1:
+               /* We don't support the PCI ROM mechanism */
+               *value = 0;
+               break;
+
+       default:
+               return PCI_BRIDGE_EMUL_NOT_HANDLED;
+       }
+
+       return PCI_BRIDGE_EMUL_HANDLED;
+}
+
 static void
 mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
                                      int reg, u32 old, u32 new, u32 mask)
@@ -555,6 +572,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 }
 
 struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
+       .read_base = mvebu_pci_bridge_emul_base_conf_read,
        .write_base = mvebu_pci_bridge_emul_base_conf_write,
        .read_pcie = mvebu_pci_bridge_emul_pcie_conf_read,
        .write_pcie = mvebu_pci_bridge_emul_pcie_conf_write,

If that fixes the problem for you, I'll send it as a proper patch with
a commit log that explains the issue.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

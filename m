Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB526C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 15:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DDA218EA
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 15:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbfAaPq7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:46:59 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44889 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaPq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 10:46:58 -0500
X-Originating-IP: 90.88.147.226
Received: from windsurf (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id ED8BBE000E;
        Thu, 31 Jan 2019 15:46:54 +0000 (UTC)
Date:   Thu, 31 Jan 2019 16:46:53 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Leigh Brown <leigh@solinno.co.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Out-of-tree mwlwifi driver crashes
Message-ID: <20190131164653.2599d6e7@windsurf>
In-Reply-To: <8eb5b2981e6e60e91a3eacbb88a5ee7b@solinno.co.uk>
References: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
        <20190129155913.163f1e98@windsurf>
        <a56827554c95a3bcd8435d72167d35f9@solinno.co.uk>
        <20190129163117.0af2ebb3@windsurf>
        <8eb5b2981e6e60e91a3eacbb88a5ee7b@solinno.co.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Leigh,

On Tue, 29 Jan 2019 15:36:56 +0000
Leigh Brown <leigh@solinno.co.uk> wrote:

> Apologies, I use webmail.  I have attached two files with the results
> from running lspci -vvv -xxx

Thanks, that was very useful. I believe the issue comes from the fact
that your PCIe device has prefetchable BARs, while none of the 5 PCIe
devices I have here has prefetchable BARs. The pci-mvebu driver doesn't
support such BARs, but the change to the common PCI bridge emulation
logic made the prefetchable memory base / limit register read-write
while they were read-only before.

To verify this hypothesis, could you apply the following patch (on top
of 4.20), and see if it solves the problem ? Thanks!

This is probably not the right/correct fix, but it will at least allow
to verify that the problem is understood correctly.

Thomas

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 129738362d90..f99b80c19809 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -142,11 +142,7 @@ const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
        },
 
        [PCI_PREF_MEMORY_BASE / 4] = {
-               /* The high 12-bits of pref mem base/limit are RW */
-               .rw = GENMASK(31, 20) | GENMASK(15, 4),
-
-               /* The low four bits of pref mem base/limit are RO */
-               .ro = GENMASK(19, 16) | GENMASK(3, 0),
+               .ro = ~0,
        },
 
        [PCI_PREF_BASE_UPPER32 / 4] = {


-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:35393 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab3LIW2A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 17:28:00 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so3377101qeb.36
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 14:28:00 -0800 (PST)
Date: Mon, 9 Dec 2013 15:27:54 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: =?iso-8859-1?Q?Bj=F8rn?= Erik Nilsen <ben@datarespons.no>
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	"marex@denx.de" <marex@denx.de>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kishon@ti.com" <kishon@ti.com>,
	"Mohit.KUMAR@st.com" <Mohit.KUMAR@st.com>,
	"ajay.khandelwal@st.com" <ajay.khandelwal@st.com>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	"Eric.Nelson@boundarydevices.com" <Eric.Nelson@boundarydevices.com>,
	"troy.kisky@boundarydevices.com" <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v5 0/2] Kernel oops from pci_disable_msi
Message-ID: <20131209222754.GC2135@google.com>
References: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com>
 <1385732125-28630-1-git-send-email-ben@datarespons.no>
 <20131209204349.GA2135@google.com>
 <52a632f0.e42c980a.3d86.ffff8faeSMTPIN_ADDED_MISSING@mx.google.com>
 <CAErSpo7KrWaP5e0TU+J4M+3mU0hUFr9fbt9GFyx8ghBrEJpugQ@mail.gmail.com>
 <52a63678.4902980a.6fd7.ffffa2b9SMTPIN_ADDED_MISSING@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <52a63678.4902980a.6fd7.ffffa2b9SMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 09, 2013 at 10:30:17PM +0100, Bjørn Erik Nilsen wrote:
> 
> 9. des. 2013 kl. 22:21 skrev Bjorn Helgaas <bhelgaas@google.com>:
> 
> > On Mon, Dec 9, 2013 at 2:15 PM, Bjørn Erik Nilsen <ben@datarespons.no> wrote:
> >> Hi Bjorn,
> >> 
> >> 9. des. 2013 kl. 21:43 skrev Bjorn Helgaas <bhelgaas@google.com>:
> >> 
> >>> On Fri, Nov 29, 2013 at 02:35:23PM +0100, Bjørn Erik Nilsen wrote:
> >>>> This patchset address Marek Vasut's comments on the previous
> >>>> patches. I decided to split into two separate commits as they are
> >>>> unrelated.
> >>>> 
> >>>> Bjørn Erik Nilsen (2):
> >>>> PCI: designware: Fix crash in dw_msi_teardown_irq
> >>>> PCI: designware: Remove redundant call to pci_write_config
> >>> 
> >>> Hi Bjørn,
> >>> 
> >>> There's been a fair amount of discussion about the first patch, so I'm
> >>> ignoring these for now.  Please repost these (again) when that all settles
> >>> down.
> >> 
> >> I'm under the impression that all concerns have been addressed and that the discussion has settled down.
> >> 
> >> What are the outstanding issues to be solved regarding these patches?
> >> 
> >> I'm asking because these patches are acked-by Marek Vasut and Jingoo Han as well as tested-by Mohit Kumar (and obviously myself).
> >> 
> >> Jingoo Han confirms he can reproduce the crash on Exynos and that the first patch fixes the problem.
> > 
> > I didn't trace through the discussion closely enough to follow
> > complaints and their resolution or retraction.  Can you post the
> > current version including the acks, just so I make sure I get the
> > latest stuff?
> 
> I'm not able to repost right now, but I can do it tomorrow morning if needed.
> 
> v5 (as posted) is the latest however, and the amendment is:
> 
> Acked-by: Marek Vasut <marex@denx.de>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Tested-by: Mohit Kumar <mohit.kumar@st.com>

OK, I added these and applied to a pci/host-designware branch for v3.14.  I
also added the following cleanup patch as suggested by Marek:


commit 0b8cfb6aa3aabc96177b1e68ef13d2eb5c686606
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Dec 9 15:11:25 2013 -0700

    PCI: designware: Use typical "for" loop idiom
    
    It's conventional to use "for" rather than "while" for simple iteration.
    No functional change.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 5274085ecd4b..1c92833a4ed3 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -214,8 +214,7 @@ static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
 {
 	unsigned int i, res, bit, val;
 
-	i = 0;
-	while (i < nvec) {
+	for (i = 0; i < nvec; i++) {
 		irq_set_msi_desc_off(irq_base, i, NULL);
 		clear_bit(pos + i, pp->msi_irq_in_use);
 		/* Disable corresponding interrupt on MSI interrupt controller */
@@ -224,7 +223,6 @@ static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
 		val &= ~(1 << bit);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
-		++i;
 	}
 }
 
@@ -268,8 +266,7 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 	 * descs are also successfully allocated.
 	 */
 
-	i = 0;
-	while (i < no_irqs) {
+	for (i = 0; i < no_irqs; i++) {
 		if (irq_set_msi_desc_off(irq, i, desc) != 0) {
 			clear_irq_range(pp, irq, i, pos0);
 			goto no_valid_irq;
@@ -281,7 +278,6 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
 		val |= 1 << bit;
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
-		i++;
 	}
 
 	*pos = pos0;

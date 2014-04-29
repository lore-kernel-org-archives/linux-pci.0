Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:64084 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874AbaD2XGP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 19:06:15 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so1001240iec.7
        for <linux-pci@vger.kernel.org>; Tue, 29 Apr 2014 16:06:15 -0700 (PDT)
Date: Tue, 29 Apr 2014 17:06:12 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Coverity CID 146454: pcie_bus_configure_settings() use of
 uninitialized variable
Message-ID: <20140429230612.GA9795@google.com>
References: <CAErSpo7OVbiZ=W1N0Zfb=p3KDsDCkq7Xq1CqzQTeANfvWWZ9yw@mail.gmail.com>
 <533E0F84.1050302@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <533E0F84.1050302@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 04, 2014 at 09:48:52AM +0800, Yijing Wang wrote:
> Hi Bjorn,
>    Jon seems to send a patch to fix this long ago. Link: http://patchwork.ozlabs.org/patch/191054/
> But this patch cannot be applied now. I think we can just set smpss = 0 in this function as the default value.

Yep.  It's ugly, but I don't have time to try to make it prettier.  I'll
apply the patch below.

> On 2014/4/4 0:09, Bjorn Helgaas wrote:
> > Coverity complains that "smpss" is used uninitialized in
> > drivers/pci/probe.c in pcie_bus_configure_settings() when calling
> > pcie_bus_configure_set():
> > 
> > 1642        pcie_bus_configure_set(bus->self, &smpss);
> > 1643        pci_walk_bus(bus, pcie_bus_configure_set, &smpss);
> > 
> > "smpss" may be uninitialized, and pcie_bus_configure_set()
> > dereferences the pointer it receives.
> > 
> > This is CID 146454.
> > 
> > Bjorn


PCI: Fix use of uninitialized MPS value

From: Bjorn Helgaas <bhelgaas@google.com>

If "pcie_bus_config == PCIE_BUS_PERFORMANCE", we don't initialize "smpss",
so we pass a pointer to garbage into pcie_bus_configure_set(), where we
compute "mps" based on the garbage.  We then pass the garbage "mps" to
pcie_write_mps(), which ignores it in the PCIE_BUS_PERFORMANCE case.

Coverity isn't smart enough to deduce that we ignore the garbage (it's a
lot to expect from a human, too), so initialize "smpss" to a safe value in
all cases.

Found by Coverity (CID 146454).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index fe89a982a3da..490031fd2108 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1617,7 +1617,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
  */
 void pcie_bus_configure_settings(struct pci_bus *bus)
 {
-	u8 smpss;
+	u8 smpss = 0;
 
 	if (!bus->self)
 		return;

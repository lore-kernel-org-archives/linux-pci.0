Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41068 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660AbbLCRVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Dec 2015 12:21:31 -0500
Date: Thu, 3 Dec 2015 11:21:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pcie_aspm: Make link_state_store consistent with
 link_state_show
Message-ID: <20151203172128.GA17565@localhost>
References: <6ff64f0313c4e6400ef536017078e58ec3487c71.1447949082.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6ff64f0313c4e6400ef536017078e58ec3487c71.1447949082.git.luto@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 19, 2015 at 08:05:35AM -0800, Andy Lutomirski wrote:
> If CONFIG_PCIEASPM_DEBUG is set, then pci devices have a link_state
> attribute.  Reading that attribute shows the state as a bit mask: 1
> means L0S upstream, 2 means L0S downstream, and 4 means L1.
> 
> Oddly, writing to link_state is inconsistent and gets translated,
> leading to mysterious results in which the value you store isn't
> comparable the value you load back out.
> 
> Fix it by making link_state_store match link_state_show.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Applied to pci/aspm for v4.5, thanks!  You didn't touch the
"aspm_disabled" check, but I moved it above the input validation code to
make the patch look like the attached.  I think it's better to not
even look at the input if aspm_disabled, and this also puts the
validation code all together.

Let me know if you object.

Bjorn


commit 57d86a0485a30145382ad03b9504cc03ba4641c7
Author: Andy Lutomirski <luto@kernel.org>
Date:   Thu Nov 19 08:05:35 2015 -0800

    PCI/ASPM: Make sysfs link_state_store() consistent with link_state_show()
    
    If CONFIG_PCIEASPM_DEBUG is set, then PCI devices have a link_state
    attribute.  Reading that attribute shows the state as a bit mask: 1
    means L0S upstream, 2 means L0S downstream, and 4 means L1.
    
    Oddly, writing to link_state is inconsistent and gets translated, leading
    to mysterious results in which the value you store isn't comparable the
    value you load back out.
    
    Fix it by making link_state_store() match link_state_show().
    
    [bhelgaas: Check "aspm_disabled" *before* validating input.  When
    "aspm_disabled" is set, this changes the error for invalid input from
    -EINVAL to -EPERM.]
    
    Signed-off-by: Andy Lutomirski <luto@kernel.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 317e355..2dfe7fd 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -834,21 +834,15 @@ static ssize_t link_state_store(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link, *root = pdev->link_state->root;
-	u32 val, state = 0;
-
-	if (kstrtouint(buf, 10, &val))
-		return -EINVAL;
+	u32 state;
 
 	if (aspm_disabled)
 		return -EPERM;
-	if (n < 1 || val > 3)
-		return -EINVAL;
 
-	/* Convert requested state to ASPM state */
-	if (val & PCIE_LINK_STATE_L0S)
-		state |= ASPM_STATE_L0S;
-	if (val & PCIE_LINK_STATE_L1)
-		state |= ASPM_STATE_L1;
+	if (kstrtouint(buf, 10, &state))
+		return -EINVAL;
+	if ((state & ~ASPM_STATE_ALL) != 0)
+		return -EINVAL;
 
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);

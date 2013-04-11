Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5701 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765536Ab3DKXOD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2013 19:14:03 -0400
From: "Benenati, Chris J" <chris.j.benenati@intel.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Apparent bug in pci_platform_power_transition() [drivers/pci/pci.c]
Date: Thu, 11 Apr 2013 23:13:49 +0000
Message-ID: <27806FC4E5928A408B78E88BBC67A2306F466BBA@ORSMSX101.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In 3.2, the marked lines (***) below were added:

static int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state)
{                               
        int error;

        if (platform_pci_power_manageable(dev)) {
               error = platform_pci_set_power_state(dev, state);
               if (!error)            
                       pci_update_current_state(dev, state);
 ***           /* Fall back to PCI_D0 if native PM is not supported */
 ***           if (!dev->pm_cap)
 ***                   dev->current_state = PCI_D0;
        } else {
               error = -ENODEV;
               /* Fall back to PCI_D0 if native PM is not supported */
               if (!dev->pm_cap)
                       dev->current_state = PCI_D0;
        }

        return error;
}

If the target state is PCI_D3, the new code serves to *undo* the marked code below executed by the preceding call to pci_update_current_state() when PCI PM registers are not present:

void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
{
    if (dev->pm_cap) {
        u16 pmcsr;

        pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
        dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
    } else {
***     dev->current_state = state;
    }
}

This is despite the fact that platform_pci_power_manageable() indicated that the platform FW could handle it and the succeeding call to platform_pci_set_power_state() succeeded. That means that devices with FW support but no PCI PM support will be left in the wrong state.

It appears the new "if" statement should be "else if":

       if (!error)            
               pci_update_current_state(dev, state);
 ***   else if (!dev->pm_cap) /* Fall back to PCI_D0 if native PM is not supported */
 ***           dev->current_state = PCI_D0;

Rafael concurs with me.

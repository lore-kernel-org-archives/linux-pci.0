Return-Path: <SRS0=O/vh=KH=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=O/vh=KH=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 23 Jul 2018 14:19:54 +0530
From: poza@codeaurora.org
To: helgaas@kernel.org, keith.busch@intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, linux-pci-owner@vger.kernel.org, Bharat Kumar Gogada
 <bharatku@xilinx.com>
Subject: [RFC] SERR# handling by Linux
In-Reply-To: <cba588cfb69aaa933adf2e8a31be6041@codeaurora.org>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <b5ba83a0fd8694905528f740a186b891@codeaurora.org>
 <BL0PR02MB4849D9F256912CC9B869A20EA5580@BL0PR02MB4849.namprd02.prod.outlook.com>
 <3bd31b729f9f335fcd906a8164c0a4cb@codeaurora.org>
 <BL0PR02MB4849C990B8C0822ECA45746AA5530@BL0PR02MB4849.namprd02.prod.outlook.com>
 <cba588cfb69aaa933adf2e8a31be6041@codeaurora.org>
Message-ID: <cea1d9ab0561ea5d2db288f7624283e8@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn and Keith,

This discussion is to extend the idea of follwing patch.
[PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow

PCIe Spec
7.6.2.1.3 Command Register (Offset 04h)

SERR# Enable – See Section 7.6.2.1.14.
When Set, this bit enables reporting upstream of Non-fatal and Fatal 
errors detected by the Function to the Root Complex. Note that errors 
are reported if enabled either through this bit or through the PCI 
Express specific bits in the Device Control register (see Section 
7.6.3.4).
In addition, for Functions with Type 1 Configuration Space headers, this 
bit controls transmission by the primary interface of ERR_NONFATAL and 
ERR_FATAL error Messages forwarded from the secondary interface. This 
bit does not affect the transmission of forwarded ERR_COR messages.
A Root Complex Integrated Endpoint that is not associated with a Root 
Complex Event Collector is permitted to hardwire this bit to 0b.
Default value of this bit is 0b.


7.6.2.3.13 Bridge Control Register
SERR# Enable – See Section 7.6.2.1.147.5.1.8.
This bit controls forwarding of ERR_COR, ERR_NONFATAL and ERR_FATAL from 
secondary to primary.

6.2.3.2.2
The transmission of these error Messages by class (correctable, 
non-fatal, fatal) is enabled using the Reporting Enable bits of the 
Device Control register (see Section 7.6.3.4) or the SERR# Enable bit in 
the PCI Command register (see Section 7.6.2.1.3).


AER driver touches device control (and choose not to touch PCI_COMMAND)
On the hand SERR# of Bridge Control Register is not set either.

The meaning of both the SERR# for type-1 configuration space seems to me 
the same.
both essentially says that ERR_NONFATAL and ERR_FATAL from secondary to 
primary.
except that bridge control setting, also forwards ERR_COR messages while 
Command Register settings affect only ERR_NONFATAL and ERR_FATAL.

there are 2 cases,
1)hotplug Enabled slot is inserted with type-1 configuration space 
(bridge) and
2) hot plug disabled, where on our platform we typically set #SERR by 
firmware

So yes it makes sense to set #SERR bit by AER driver if it fins bridge.
but we not only have do
[PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow

but also we have to cover hotplug case and hence
pci_aer_init() should call
      pci_enable_pcie_error_reporting(dev);


something like below.

int pci_aer_init(struct pci_dev *dev)
{
         int rc;

	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);

         pci_enable_pcie_error_reporting(dev);
	return pci_cleanup_aer_error_status_regs(dev);
}


int pci_enable_pcie_error_reporting(struct pci_dev *dev)
{
         int ret;

	if (pcie_aer_get_firmware_first(dev))
		return -EIO;

	if (!dev->aer_cap)
		return -EIO;

         if (!IS_ENABLED(CONFIG_ACPI) &&
             dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
         u16 control;

         /*
          * A Type-1 PCI bridge will not forward ERR_ messages coming
          * from an endpoint if SERR# forwarding is not enabled.
          */
         pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
         control |= PCI_BRIDGE_CTL_SERR;
         pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
     }

     return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, 
PCI_EXP_AER_FLAGS);
}
EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);

also we have to remove pci_enable_pcie_error_reporting() call from the 
drivers.
because aer_init will do it for all the devices.

although I am not very sure is it safe to detect enable error reporting 
by default for all the error devices ?
e.g. setting PCI_EXP_DEVCTL.

probably drivers might want to call pci_disable_pcie_error_reporting() 
who doesnt want to participate in error reporting.

Regards,
Oza.

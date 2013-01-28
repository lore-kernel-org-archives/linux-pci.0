Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:58458 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754174Ab3A1MqT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 07:46:19 -0500
Message-ID: <1359377173.1345.25.camel@x61.thuisdomein>
Subject: pciehp: errors on resume
From: Paul Bolle <pebolle@tiscali.nl>
To: Oliver Neukum <oneukum@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 28 Jan 2013 13:46:13 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

0) Since release v3.7 a laptop I use prints these errors at every
resume:
    pciehp 0000:00:1c.1:pcie04: Device 0000:03:00.0 already exists at 0000:03:00, cannot hot-add
    pciehp 0000:00:1c.1:pcie04: Cannot add device at 0000:03:00

That must have been caused by commit
87683e22c646e563061a91f4a0106e6913acebf8 ("PCI: pciehp: Always implement
resume, regardless of pciehp_force param").

1) Those messages appear to be printed for the wireless card that is
apparently attached to one of this laptop's two pcie ports:
    lspci | grep -e 00:1c.1 -e 03:00.0
    00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 03)
    03:00.0 Network controller: Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection (rev 61)

    lspci -vt | grep -e 1c.1 -e 03
           +-1c.1-[03]----00.0  Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection

2) There are no apparent issues with this wireless card on all those
resumes. So could these errors somehow be suppressed? 

3) For what it's worth, the callchain that triggers these errors seems
to be:
    pciehp_resume()
        pciehp_enable_slot()
            board_added()
                pciehp_configure_device()
                    pci_get_slot()
                    ctrl_err([...] "Device %s already exists " [...])
                ctrl_err([...] "Cannot add device at [...]")


Paul Bolle


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753255AbdK1AcO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Nov 2017 19:32:14 -0500
Date: Mon, 27 Nov 2017 18:32:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [Question] Unsupported Request During PCI Enumeration
Message-ID: <20171128003208.GB11228@bhelgaas-glaptop.roam.corp.google.com>
References: <26340670-2744-b2e0-eed7-eb8e0ad2bc84@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26340670-2744-b2e0-eed7-eb8e0ad2bc84@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 22, 2017 at 03:38:59PM +0800, Dongdong Liu wrote:
> I found a correctable error when boot linux kernel. The corrected
> error is UR (Unsupported Request). It seems that PCIe device will
> produce UR during PCIe enumeration. 

It seems normal to me that UR would be reported during enumeration.
During enumeration we don't know what devices are present, so we
attempt to read the Vendor ID of each possible device.  If the device
doesn't exist, I would expect the upstream switch port to generate a
UR completion.  See the implementation notes in PCIe r3.1, sec 2.3.1
and sec 2.3.2.

Is this what you're seeing?  Do you think this is wrong?

> We have configured _HPX in firmware to make sure UR report is
> enabled after calling pci_configure_device().

> If I disable UR report by setting Device Control Register
> Unsupported Request Reporting Enable to 0 ,it will not report the
> correctable error.  But disable UR report is not responsible, so my
> question is how to make sure it does not report the correctable
> error during enumeration and after enumeration, PCIe device can
> report UR correctly ?

Per spec, the hardware power-on default is that Unsupported Request
Reporting Enable is 0, i.e., UR reporting is disabled.

Firmware may enable UR reporting.  It looks like the PCI core enables
UR reporting in pci_enable_pcie_error_reporting() when we enable AER
(and a few drivers call pci_enable_pcie_error_reporting() directly).

We do turn off Master Abort reporting in pci_scan_bridge_extend() when
scanning below a bridge.  UR reporting during enumeration seems
analogous to that, but we don't currently turn it off.

Maybe we should turn off UR reporting and restore it afterwards, as we
do for PCI_BRIDGE_CTL_MASTER_ABORT?

> [  127.158876] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 2
> [  127.171734] {1}[Hardware Error]: It has been corrected by h/w and requires no further action
> [  127.181872] {1}[Hardware Error]: event severity: corrected
> [  127.189099] {1}[Hardware Error]:  Error 0, type: corrected
> [  127.195437] {1}[Hardware Error]:   section_type: PCIe error
> [  127.201697] {1}[Hardware Error]:   port_type: 5, upstream switch port

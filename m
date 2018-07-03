Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:53749 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932910AbeGCIJM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 04:09:12 -0400
Date: Tue, 3 Jul 2018 10:09:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Coccinelle report for drivers/pci/
Message-ID: <20180703080910.GB21136@wunner.de>
References: <7db07760-49fe-e94b-62fc-556ba02c8e9e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7db07760-49fe-e94b-62fc-556ba02c8e9e@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 02, 2018 at 09:45:55PM -0400, Sinan Kaya wrote:
> drivers/pci/hotplug/pciehp_pci.c:67:5-7: Unneeded variable: "rc". Return "0" on line 110

Fixed by
https://patchwork.ozlabs.org/patch/930379/


> drivers/pci/hotplug/pcihp_skeleton.c:98:5-11: Unneeded variable: "retval". Return "0" on line 106
> drivers/pci/hotplug/pcihp_skeleton.c:84:5-11: Unneeded variable: "retval". Return "0" on line 92
> drivers/pci/hotplug/pcihp_skeleton.c:201:5-11: Unneeded variable: "retval". Return "0" on line 210
> drivers/pci/hotplug/pcihp_skeleton.c:171:5-11: Unneeded variable: "retval". Return "0" on line 180
> drivers/pci/hotplug/pcihp_skeleton.c:186:5-11: Unneeded variable: "retval". Return "0" on line 195
> drivers/pci/hotplug/pcihp_skeleton.c:156:5-11: Unneeded variable: "retval". Return "0" on line 165
> drivers/pci/hotplug/pcihp_skeleton.c:137:5-11: Unneeded variable: "retval". Return "0" on line 150
> drivers/pci/hotplug/pcihp_skeleton.c:112:5-11: Unneeded variable: "retval". Return "0" on line 131

Fixed by 6c9c6bd4e2c8 ("PCI: hotplug: Delete skeleton driver"),
queued on Bjorn's pci/hotplug branch for 4.19.

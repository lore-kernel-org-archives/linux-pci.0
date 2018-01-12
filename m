Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27941 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933994AbeALQeY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jan 2018 11:34:24 -0500
Date: Fri, 12 Jan 2018 18:34:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: Regression (sort of): PCI/portdrv: Turn off PCIe services during
 shutdown
Message-ID: <20180112163420.GF27654@lahna.fi.intel.com>
References: <20180112104929.GA10599@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180112104929.GA10599@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 12, 2018 at 11:49:29AM +0100, Lukas Wunner wrote:
> I believe Mika has a MacBookPro13,3 with Alpine Ridge (Thunderbolt 3)
> and could verify if that also has this issue. These MacBook Pros have
> two Thunderbolt controllers, so if affected, the commit would delay
> reboot by 16 seconds.

Checked the MacBook with 2 x AR and it does have NoCompl+ for the
hotplug downstream ports. Also tried reboot the system and it does not
take 16s, more like 1-2s.

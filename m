Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:42449 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbeBVIfp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Feb 2018 03:35:45 -0500
Date: Thu, 22 Feb 2018 09:35:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: George Cherian <gcherian@caviumnetworks.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Message-ID: <20180222083543.GA14945@wunner.de>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan>
 <20180220015433.GA9656@wunner.de>
 <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
 <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
 <20180221095435.xe5lmes7mpxca3en@wunner.de>
 <d0f6a588-23e7-123e-267c-5257c21bb38a@caviumnetworks.com>
 <20180221232040.GA52685@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180221232040.GA52685@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 21, 2018 at 05:20:40PM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 21, 2018 at 04:25:08PM +0530, George Cherian wrote:
> > I have found another configuration where this fails.
> > Following is the configuration
> > 1) Connected a PCIe Intel i40 card under the root port.
> > 2) unbind the i40 driver and bind with vfio-pci driver.
> > 3) Run lspci in a loop. "lspci -s xx:xx.xx -vvv"
> > 
> > I get the same synchronous external abort.
> > In this case the vfio-pci driver probe it moves the device (i40) to
> > D3hot provided disable_idle_d3 is not set. lspci tries to do
> > the config_access which fails with synchronous external abort when
> > the root port transitions to D3hot.
> 
> It *looks* like rpm_resume() should resume parent devices, i.e., the
> root port, but I don't know that code at all.

It does that unless the ignore_children flag is set, which only few
drivers do.

Sounds to me like another missing pci_config_pm_runtime_get() somewhere
but it's hard to tell without a stacktrace.

Thanks,

Lukas

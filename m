Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeIGLUX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Sep 2018 07:20:23 -0400
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on resume
To: Daniel Drake <drake@endlessm.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org,
        peter@lekensteyn.nl, kherbst@redhat.com,
        andriy.shevchenko@linux.intel.com, rafael.j.wysocki@intel.com,
        keith.busch@intel.com, mika.westerberg@linux.intel.com,
        jonathan.derrick@intel.com, kugel@rockbox.org, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org, nic_swsd@realtek.com
References: <20180907053614.6540-1-drake@endlessm.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <3b37e4fd-c793-bd52-7d70-950f846a7d5a@kernel.org>
Date: Thu, 6 Sep 2018 23:40:56 -0700
MIME-Version: 1.0
In-Reply-To: <20180907053614.6540-1-drake@endlessm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/6/2018 10:36 PM, Daniel Drake wrote:
> +	if (pci_dev->class == PCI_CLASS_BRIDGE_PCI << 8)
> +		pci_setup_bridge_mmio_pref(pci_dev);

This should probably some kind of a quirk rather than default
for the listed card as it sounds like you are dealing with
broken hardware.

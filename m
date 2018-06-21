Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:15720 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933190AbeFUMGF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jun 2018 08:06:05 -0400
Date: Thu, 21 Jun 2018 15:06:00 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Rajat Jain <rajatja@google.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 23/32] PCI: pciehp: Avoid slot access during reset
Message-ID: <20180621120600.GY2558@lahna.fi.intel.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <c91a547edf3d2de26c38a7452cabacf636891e3f.1529173804.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c91a547edf3d2de26c38a7452cabacf636891e3f.1529173804.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
>  struct controller {
>  	struct mutex ctrl_lock;
>  	struct pcie_device *pcie;
> +	struct rw_semaphore reset_lock;

Is there any particular reason why you can't use a regular mutex here?

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeHTCgv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Aug 2018 22:36:51 -0400
Subject: Re: [PATCH v8 2/2] PCI: pciehp: Mask AER surprise link down error if
 hotplug is enabled
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180818065126.77912-1-okaya@kernel.org>
 <20180818065126.77912-2-okaya@kernel.org>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <75a82f6d-10dc-d980-8abf-8e1410f866cb@kernel.org>
Date: Sun, 19 Aug 2018 19:23:36 -0400
MIME-Version: 1.0
In-Reply-To: <20180818065126.77912-2-okaya@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/18/2018 2:51 AM, Sinan Kaya wrote:
>   	cleanup_slot(ctrl);
> +	pciehp_control_surprise_error(ctrl, true);

I think I need to move this one line up but I'd like to see some input
here and also ask for some testing.

I don't have any hardware to test.

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757247AbeEJNSI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 09:18:08 -0400
Date: Thu, 10 May 2018 08:18:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v15 1/9] PCI: Unify wait for link active into generic PCI
Message-ID: <20180510131806.GD173327@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-2-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525323838-1735-2-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 01:03:50AM -0400, Oza Pawandeep wrote:
> + * pcie_wait_for_link - Wait for link till it's active/inactive
> + * @pdev: Bridge device
> + * @active: waiting for active or inactive ?

s/inactive ?/inactive?/

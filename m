Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22740 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeCNUuc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 16:50:32 -0400
Date: Wed, 14 Mar 2018 14:52:30 -0600
From: Keith Busch <keith.busch@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2] PCI/DPC: Fix PCI legacy interrupt acknowledgement
Message-ID: <20180314205230.GF29867@localhost.localdomain>
References: <1521042648-20522-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521042648-20522-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 09:20:48PM +0530, Oza Pawandeep wrote:
> Current DPC driver acknowledges the interrupt in deferred work, which works
> since MSI are edge triggered.
> 
> But when MSI is disabled (e.g. pci=nomsi boot option) port service
> driver falls back to PCI legacy INT interrupt.
> 
> With current code we do not acknowledge the interrupt back in dpc_irq()
> and we get dpc interrupt storm.
> 
> This patch acknowledges the interrupt in interrupt handler.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

Thanks, this looks good to me.

Reviewed-by: Keith Busch <keith

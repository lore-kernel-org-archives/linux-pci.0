Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:30662 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932287AbeAaQYn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Jan 2018 11:24:43 -0500
Date: Wed, 31 Jan 2018 09:28:26 -0700
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
Subject: Re: [PATCH] PCI/DPC: Fix INT legacy interrupt in dpc_irq
Message-ID: <20180131162826.GD27735@localhost.localdomain>
References: <1517415535-21850-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517415535-21850-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 31, 2018 at 09:48:55PM +0530, Oza Pawandeep wrote:
> Current dpc driver acknowledge the interrupt in deferred work, which works
> okay since LPI are edge triggered.
> But when RP does not have MSI support, port service driver falls back to
> legacy GIC SPI interrupts, and with current code we do not acknowledge the
> interrupt and we get dpc interrupt storm.
> This patch acknowledges the interrupt in interrupt handler.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

Thanks, looks good to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>

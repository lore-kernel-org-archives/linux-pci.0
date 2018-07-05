Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42356 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbeGEPMn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jul 2018 11:12:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 05 Jul 2018 20:42:41 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 0/6] Fix issues and cleanup for ERR_FATAL and
 ERR_NONFATAL
In-Reply-To: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
Message-ID: <e2cdfff7ddffc3e10dc800c31bd27864@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Could you help to review this series ?

Regards,
Oza.

On 2018-06-22 15:28, Oza Pawandeep wrote:
> These are follow up patches for the series which modifies ERR_FATAL 
> handling.
> although there were couple of problems existed before which, itis also 
> fixing.
> 
> patch-1:
> Fixes the problem where ERR_FATAL and ERR_NONFATAL status should be 
> cleared
> taking severity mask into account.
> 
> patch-2:
> Takes care of clearing error fatal status
> 
> patch-3:
> Follow up patch where no more need of handling ERR_FATAL
> case.
> 
> patch-4:
> Fixes clearing device status in case of uncorrectable errors.
> (e.g. ERR_FATAL and ERR_NONFATAL)
> 
> patch-5:
> Fixes clearing device status in case of correctable errors.
> 
> patch-6:
> Follow up patch where no more need of handling pci_channel_io_frozen
> in pcie_portdrv_slot_reset()
> 
> Oza Pawandeep (6):
>   PCI/AER: Take severity mask into account while clearing error bits
>   PCI/AER: Clear uncorrectable fatal error status bits
>   PCI/ERR: Cleanup ERR_FATAL of error broadcast
>   PCI/AER: Clear device error status bits during ERR_FATAL and
>     ERR_NONFATAL
>   PCI/AER: Fix correctable status bits clearing in device register
>   PCI/PORTDRV: Remove ERR_FATAL handling from pcie_portdrv_slot_reset()
> 
>  drivers/pci/pcie/aer.c         | 35 
> +++++++++++++++++++++++------------
>  drivers/pci/pcie/err.c         | 15 +++++++--------
>  drivers/pci/pcie/portdrv_pci.c | 18 ------------------
>  include/linux/aer.h            |  5 +++++
>  4 files changed, 35 insertions(+), 38 deletions(-)

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:59148 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934419AbeEWU0q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 May 2018 16:26:46 -0400
To: dmeyer@gigaio.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org
References: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
 <1527106686-18852-2-git-send-email-dmeyer@gigaio.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <553308ee-9c6f-2e1e-1ce8-03b739d1acb0@deltatee.com>
Date: Wed, 23 May 2018 14:26:41 -0600
MIME-Version: 1.0
In-Reply-To: <1527106686-18852-2-git-send-email-dmeyer@gigaio.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2 1/2] NTB: Migrate PCI Constants to Cannonical PCI
 Header
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 23/05/18 02:18 PM, dmeyer@gigaio.com wrote:
> +#define PCI_DEVICE_ID_MICROSEMI_PFX24XG3	0x8531

I think Bjorn asked not to add the device IDs to the pci_ids.h and to
just use the raw IDs in quirks.h. switchtec.c already uses the raw values.

Besides that, it looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

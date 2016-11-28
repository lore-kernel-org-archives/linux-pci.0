Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932468AbcK1QUq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Nov 2016 11:20:46 -0500
Date: Mon, 28 Nov 2016 11:30:56 -0500
From: Keith Busch <keith.busch@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] drivers/pci/host/vmd: Fix suspend handlers unused warning
Message-ID: <20161128163056.GC2609@localhost.localdomain>
References: <20161126182957.6144-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161126182957.6144-1-bp@alien8.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 26, 2016 at 07:29:57PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Fix:
> 
>   drivers/pci/host/vmd.c:731:12: warning: ‘vmd_suspend’ defined but not used [-Wunused-function]
>    static int vmd_suspend(struct device *dev)
>               ^
>   drivers/pci/host/vmd.c:739:12: warning: ‘vmd_resume’ defined but not used [-Wunused-function]
>    static int vmd_resume(struct device *dev)
>               ^
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Thanks for the fix.

Reviewed-by: Keith Busch <keith.busch@intel.com>

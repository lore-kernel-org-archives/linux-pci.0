Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753010AbcHVStU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Aug 2016 14:49:20 -0400
Date: Mon, 22 Aug 2016 13:49:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pratyush Anand <panand@redhat.com>
Cc: dongbo4@huawei.com, bhelgaas@google.com, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] pcie/designware: Viewport assignment update
Message-ID: <20160822184915.GH18628@localhost>
References: <cover.1467647958.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1467647958.git.panand@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 04, 2016 at 09:44:41PM +0530, Pratyush Anand wrote:
> Most of the designware PCIe platforms have more than 2 viewports. So, patch
> 1/2 allows to fix viewport-2 for IO transaction for such cases.
> When we have only two viewports, then patch 2/2 exchange viewport
> assignment of memory and cfg transaction. It helps to fix a possibility of
> corruption for memory transaction. However, there still exist possibility
> of an IO transaction to be corrupted. We can not do much for <=2 viewports.
> See, patch log for detail.
> 
> Dong Bo (1):
>   pcie/designware: Exchange viewport of `MEMORYs' and `CFGs/IOs'
> 
> Pratyush Anand (1):
>   pcie/designware: Keep viewport fixed for IO transaction if
>     num_viewport > 2
> 
>  .../devicetree/bindings/pci/designware-pcie.txt    |  3 ++
>  drivers/pci/host/pcie-designware.c                 | 32 +++++++++++++++-------
>  drivers/pci/host/pcie-designware.h                 |  1 +
>  3 files changed, 26 insertions(+), 10 deletions(-)

Applied (with Rob's ack on 1/2) to pci/host-designware for v4.9, thanks!

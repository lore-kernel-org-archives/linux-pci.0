Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36624 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeDIXWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 19:22:49 -0400
Received: by mail-it0-f66.google.com with SMTP id 15-v6so12479687itl.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Apr 2018 16:22:49 -0700 (PDT)
Message-ID: <5ACBF5C6.60601@fredlawl.com>
Date: Mon, 09 Apr 2018 18:22:46 -0500
From: Frederick Lawler <fred@fredlawl.com>
MIME-Version: 1.0
To: mike.marciniszyn@intel.com, dennis.dalessandro@intel.com
CC: linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] IB/hfi1: Cleanup PCIe link configuration
References: <1523244898-25942-1-git-send-email-fred@fredlawl.com>
In-Reply-To: <1523244898-25942-1-git-send-email-fred@fredlawl.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Frederick Lawler wrote:
> The IB/hfi1 driver uses custom macros to configure link speed. Some macros were
> previously replaced, but not fully. This patch series addresses the 
> configuration inconsistencies and introduces minor cleanup by replacing
> redundant magic number usage.
> 
> --
> V2: s/LINK/LNK
> 
> Frederick Lawler (2):
>   IB/hfi1: Replace custom hfi1 macros with PCIe macros
>   IB/hfi1: Cleanup PCIe speed link configuration
> 
>  drivers/infiniband/hw/hfi1/pcie.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 

CC: linux-pci@vger.kernel.org

-- 
Frederick Lawler

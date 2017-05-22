Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbdEVXn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 May 2017 19:43:56 -0400
Date: Mon, 22 May 2017 18:43:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Wesley Yung <wesley.yung@microsemi.com>,
        Sammy Hui <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        Wei Zhang <wzhang@fb.com>, Krishna Dhulipala <krishnad@fb.com>
Subject: Re: [PATCH 0/2] pcie/dpc: Fixes
Message-ID: <20170522234353.GI19733@bhelgaas-glaptop.roam.corp.google.com>
References: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 28, 2017 at 12:02:47PM -0400, Keith Busch wrote:
> Hi Bjorn,
> 
> Two small patches for bugs found from testing on new platforms and
> hardware.
> 
> Keith Busch (2):
>   pcie/dpc: Skip DPC event if device is not present
>   pcie/dpc: Fix control register setting
> 
>  drivers/pci/pcie/pcie-dpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to pci/dpc for v4.13, thanks, Keith!

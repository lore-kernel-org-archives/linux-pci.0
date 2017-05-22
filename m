Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934097AbdEVVyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 May 2017 17:54:05 -0400
Date: Mon, 22 May 2017 16:54:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fixes for Switchtec Driver
Message-ID: <20170522215402.GE19733@bhelgaas-glaptop.roam.corp.google.com>
References: <1494866693-2850-1-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494866693-2850-1-git-send-email-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 15, 2017 at 10:44:51AM -0600, Logan Gunthorpe wrote:
> Hi Bjorn,
> 
> Can you please apply the following two patches? The first is
> a cleanup to use a new helper function I added (it had to wait
> until both patchsets were in). The second is a minor bug fix to
> the driver we found last week.
> 
> Thanks!
> 
> Logan
> 
> 
> Logan Gunthorpe (2):
>   switchtec: utilize new device_add_cdev helper function
>   switchtec: fix minor bug with partition id register
> 
>  drivers/pci/switch/switchtec.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Since we merged the Switchtec driver during the v4.12 merge window, I
applied these to for-linus for v4.12, with the following changelogs to
correct a few typos:

commit 9871e9bb5cf6
Author: Logan Gunthorpe <logang@deltatee.com>
Date:   Mon May 22 16:52:30 2017 -0500

    switchtec: Fix minor bug with partition ID register
    
    When a switch endpoint is configured without NTB, the mmio_ntb registers
    will read all zeros.  However, in corner case configurations where the
    partition ID is not zero and NTB is not enabled, the code will have the
    wrong partition ID and this causes the driver to use the wrong set of
    drivers.  To fix this we simply take the partition ID from the system info
    region.
    
    Reported-by: Dingbao Chen <dingbao.chen@microsemi.com>
    Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

commit e40cf640b8f6 (refs/patches/for-linus/switchtec-use-new)
Author: Logan Gunthorpe <logang@deltatee.com>
Date:   Mon May 22 16:52:24 2017 -0500

    switchtec: Use new cdev_device_add() helper function
    
    Convert from "cdev_add() + device_add()" to cdev_device_add(), and from
    "device_del() + cdev_del()" to cdev_device_del().
    
    [bhelgaas: changelog]
    Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

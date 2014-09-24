Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:50264 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbaIXNlc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 09:41:32 -0400
Received: by mail-ig0-f174.google.com with SMTP id r10so6519599igi.13
        for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2014 06:41:31 -0700 (PDT)
Date: Wed, 24 Sep 2014 07:41:29 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/3] MSI cleanup update
Message-ID: <20140924134129.GD13850@google.com>
References: <1411528171-1927-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411528171-1927-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 24, 2014 at 11:09:31AM +0800, Yijing Wang wrote:
> v3->v4: fix the build error under powerpc, I missed to replace
> 		its __read_msi_msg() in last patch.
> 
> Yijing Wang (3):
>   MSI/powerpc: Use __read_msi_msg() instead of read_msi_msg()
>   PCI/MSI: Remove unused function read_msi_msg()
>   PCI/MSI: Rename __read_msi_msg() to read_msi_msg()
> 
>  arch/powerpc/platforms/pseries/msi.c |    2 +-
>  arch/x86/pci/xen.c                   |    2 +-
>  drivers/pci/msi.c                    |    9 +--------
>  include/linux/msi.h                  |    3 +--
>  4 files changed, 4 insertions(+), 12 deletions(-)

Applied to pci/msi for v3.18, thanks!

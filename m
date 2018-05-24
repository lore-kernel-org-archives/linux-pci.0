Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44726 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965042AbeEXNTl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 09:19:41 -0400
Date: Thu, 24 May 2018 14:19:33 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bhelgaas@google.com, kys@microsoft.com, haiyangz@microsoft.com,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH 0/3] PCI: hv: cleanup patches
Message-ID: <20180524131933.GA22455@e107981-ln.cambridge.arm.com>
References: <20180523171114.5136-1-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523171114.5136-1-sthemmin@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2018 at 10:11:11AM -0700, Stephen Hemminger wrote:
> These are minor code cleanups found while reviewing and implementing
> other things in Hyper-V PCI host driver.
> 
> Stephen Hemminger (3):
>   PCI: hv: remove unused reason for refcount handler
>   PCI: hv: convert remove_lock to refcount
>   PCI: hv: use list_for_each_entry
> 
>  drivers/pci/host/pci-hyperv.c | 105 ++++++++++++----------------------
>  1 file changed, 37 insertions(+), 68 deletions(-)

Applied to pci/hv for v4.18, thanks.

Lorenzo

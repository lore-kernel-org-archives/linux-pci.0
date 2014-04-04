Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4371 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaDDBtM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 21:49:12 -0400
Message-ID: <533E0F84.1050302@huawei.com>
Date: Fri, 4 Apr 2014 09:48:52 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Coverity CID 146454: pcie_bus_configure_settings() use of uninitialized
 variable
References: <CAErSpo7OVbiZ=W1N0Zfb=p3KDsDCkq7Xq1CqzQTeANfvWWZ9yw@mail.gmail.com>
In-Reply-To: <CAErSpo7OVbiZ=W1N0Zfb=p3KDsDCkq7Xq1CqzQTeANfvWWZ9yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
   Jon seems to send a patch to fix this long ago. Link: http://patchwork.ozlabs.org/patch/191054/
But this patch cannot be applied now. I think we can just set smpss = 0 in this function as the default value.

Thanks!
Yijing.

On 2014/4/4 0:09, Bjorn Helgaas wrote:
> Coverity complains that "smpss" is used uninitialized in
> drivers/pci/probe.c in pcie_bus_configure_settings() when calling
> pcie_bus_configure_set():
> 
> 1642        pcie_bus_configure_set(bus->self, &smpss);
> 1643        pci_walk_bus(bus, pcie_bus_configure_set, &smpss);
> 
> "smpss" may be uninitialized, and pcie_bus_configure_set()
> dereferences the pointer it receives.
> 
> This is CID 146454.
> 
> Bjorn
> 
> 


-- 
Thanks!
Yijing


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0075.outbound.protection.outlook.com ([65.55.169.75]:8848
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S966365AbcBDQUu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 11:20:50 -0500
Subject: Re: AMD-Vi: Unable to write to IOMMU perf counter.
To: Andreas Hartmann <andihartmann@01019freenet.de>,
	<linux-pci@vger.kernel.org>
References: <56B365E0.4020100@01019freenet.de>
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Message-ID: <56B37292.1000201@amd.com>
Date: Thu, 4 Feb 2016 09:47:30 -0600
MIME-Version: 1.0
In-Reply-To: <56B365E0.4020100@01019freenet.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andreas,

On 2/4/2016 8:53 AM, Andreas Hartmann wrote:
> Hello!
>
> The following happens with Linux 4.4.1 during boot on an MSI A78M-E35
> board. Additionally, I attached the complete dmesg.

I was working on upstreaming changes to the AMD IOMMU Perf to fix some 
of the similar issue I saw on a different platform.  Would you please 
check to see if this patch series would fix this?

https://lkml.org/lkml/2016/1/1/141

Thanks,
Suravee

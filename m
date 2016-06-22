Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([58.251.152.179]:5285 "EHLO
	szxga05-in.huawei.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750907AbcFVBKS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2016 21:10:18 -0400
Subject: Re: [PATCH v1 00/25] PCI: Request host bridge window resources
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160618180735.GB20504@localhost> <57692BD0.6030609@huawei.com>
 <20160621150352.GB31917@localhost>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>, <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	<linux-kernel@vger.kernel.org>, Ray Jui <rjui@broadcom.com>,
	<rfi@lists.rocketboards.org>, <linux-renesas-soc@vger.kernel.org>,
	"Simon Horman" <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	<linux-tegra@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	<linux-arm-kernel@lists.infradead.org>
From: wangyijing <wangyijing@huawei.com>
Message-ID: <5769E4ED.4050904@huawei.com>
Date: Wed, 22 Jun 2016 09:07:57 +0800
MIME-Version: 1.0
In-Reply-To: <20160621150352.GB31917@localhost>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



在 2016/6/21 23:03, Bjorn Helgaas 写道:
> On Tue, Jun 21, 2016 at 07:58:08PM +0800, wangyijing wrote:
>> Hi Bjorn, use devm_request_resource() for host bridge resource is cool,
>> what about do the similar change for x86, now we request host bridge resource
>> in pci_acpi_root_add_resources() in x86, and we would release the host bridge
>> resource when host bridge device refcount reach 0. This logic may introduce issue,
>> E.g.
>> If we try to remove a pci host bridge, but there is a child pci device which refcount
>> cannot decrease to 0 after remove the device, in this case, its parent pci_bus and
>> parent device, all their refcount cannot reach to 0, the result is pci host bridge
>> refcount can not reach 0, so its .release_fn() won't be called, and host bridge
>> resouces can not release. If we want to add the pci host bridge again, all pci devices
>> can not work because the resource is conflict with the old.
>>
>> devm resource would be released when the driver detach, this is better than what we do now, I think.
> 
> I'm not going to convert pci_root.c to use devm right now.  That might
> be a good thing, but this current series is mostly trivial.  I think
> changing pci_root.c would not be trivial, so that looks like a project
> all by itself.

OK.

> 
> I don't quite follow the example of removing a host bridge while a
> child PCI device refcount is non-zero.  That sounds like an invalid
> scenario regardless of whether the resources are released by a
> .release_fn() or by devm.

I would send a draft patch to describe and fix the issue, because it's not related to
this series, so let's discuess it in another thread. :)

Thanks!
Yijing.


> 
> Bjorn
> 
> .
> 


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35369 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab2BXRQp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 12:16:45 -0500
MIME-Version: 1.0
In-Reply-To: <20120224065921.GA28932@avionic-0098.mockup.avionic-design.de>
References: <20120220191804.GA14499@avionic-0098.adnet.avionic-design.de>
	<74CDBE0F657A3D45AFBB94109FB122FF17BD8BC302@HQMAIL01.nvidia.com>
	<20120222082449.GA15157@avionic-0098.adnet.avionic-design.de>
	<CAErSpo4TfpGmx+HZ1ZnZwj3ZP_cQMCzkMT+6JK6ztYp2zWJcxw@mail.gmail.com>
	<20120223060355.GA21091@avionic-0098.mockup.avionic-design.de>
	<CAErSpo7wSB-uCjV4YeA-fUOHPtugn4ASXScN3MndVybfkk8mOw@mail.gmail.com>
	<20120224065921.GA28932@avionic-0098.mockup.avionic-design.de>
Date: Fri, 24 Feb 2012 22:46:06 +0530
Message-ID: <CAHM4w1k1_Yp56tpfPqDxT1WHQWRB5xe_Zs-BEj+n5rVmuyAJiw@mail.gmail.com>
Subject: Re: PCIe device tree support
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Olof Johansson (olof@lixom.net)" <olof@lixom.net>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Stephen Warren <swarren@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I too had similar query.
I have written a PCIe host driver for SPEAr platform (ARM Arch).
This driver is registered on paltform bus.
It is for Designware IP, so I believe that most of its part
can be re-usaable for other person.
 have kept common and SPEAr specific part separately.
But,  I am not sure about its best location.
I believe best would have been to keep in driver/pci/pcie/hosts/.
But it uses pci_common_init function which is specific to ARM platform.
So it limits option to arch/arm.
But, if I keep it in arch/arm/mach-spear13xx/ , then it will limit others
from using synopsys specific code.

What do you suggest?

Regards
Pratyush


On Fri, Feb 24, 2012 at 12:29 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> * Bjorn Helgaas wrote:
>> I agree that if the code isn't shared at all, there's no point in
>> putting it in a generic place like drivers/pci/.
>
> Alright, I'll keep the driver in arch/arm/mach-tegra/ then.
>
> Thierry

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:37891 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbdKJAqb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2017 19:46:31 -0500
Cc: Kishon Vijay Abraham I <kishon@ti.com>, shawn.lin@rock-chips.com,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Lorenzo Pieralisi for PCI host bridge
 drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20171108201510.18601.30578.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171108202602.GA19676@bhelgaas-glaptop.roam.corp.google.com>
 <4805cf13-3e33-31fb-ab25-1adb4ed13b9c@ti.com>
 <20171109150528.GA7629@bhelgaas-glaptop.roam.corp.google.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <c990c9af-7d7c-27f9-30e5-2ebda49b8b3b@rock-chips.com>
Date: Fri, 10 Nov 2017 08:46:29 +0800
MIME-Version: 1.0
In-Reply-To: <20171109150528.GA7629@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2017/11/9 23:05, Bjorn Helgaas wrote:
> On Thu, Nov 09, 2017 at 11:28:36AM +0530, Kishon Vijay Abraham I wrote:
>> Hi Bjorn,
>>
>> On Thursday 09 November 2017 01:56 AM, Bjorn Helgaas wrote:
>>> On Wed, Nov 08, 2017 at 02:15:10PM -0600, Bjorn Helgaas wrote:
>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>
>>>> Add Lorenzo Pieralisi as maintainer for PCI native host bridge drivers and
>>>> the endpoint driver framework.
>>>>
>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> This is on my for-linus branch, and I intend to merge it for v4.14.
>>
>> There is already an entry for PCI endpoint in MAINTAINERS file. Can Lorenzo be
>> added there?
>>
>> PCI ENDPOINT SUBSYSTEM
>> M:      Kishon Vijay Abraham I <kishon@ti.com>
>> L:      linux-pci@vger.kernel.org
>> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
>> S:      Supported
>> F:      drivers/pci/endpoint/
>> F:      drivers/misc/pci_endpoint_test.c
>> F:      tools/pci/
> 
> Right, thanks, I forgot all about this separate entry.  I added Lorenzo
> there, resulting in the patch below.
> 
> My practice has been that all the PCI patches (everything in
> drivers/pci plus some include and x86/pci stuff) have been merged via
> my tree.
> 
> This includes things in drivers/pci/{host,dwc,endpoint,switch}, which
> are non-core things and usually specific to a chipset.  I try to
> ensure they have individual maintainers designated, and I ask for
> their acks for non-trivial changes because I have no specs and no
> hardware for testing them.  But I think it's still good to have one
> person look over them all to try to keep some consistency across them
> because they are all quite similar.
> 
> So my hope is that Lorenzo can take over that oversight role from me,
> not that he would replace any of those designated maintainers.
> 
> Ideally, this will be transparent to patch submitters except that they
> should add Lorenzo to the "To:" line (keeping linux-pci and other
> interested parties).
> 
> 
> commit 6b7be529634bbfbf6395f23217a66d731fbed0a0
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Nov 8 08:49:49 2017 -0600
> 
>      MAINTAINERS: Add Lorenzo Pieralisi for PCI host bridge drivers
>      
>      Add Lorenzo Pieralisi as maintainer for PCI native host bridge drivers and
>      the endpoint driver framework.
>      
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>      Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index db412a627d96..6ce341e86fec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10378,6 +10378,7 @@ F:	drivers/pci/dwc/*keystone*
>   
>   PCI ENDPOINT SUBSYSTEM
>   M:	Kishon Vijay Abraham I <kishon@ti.com>
> +M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>   L:	linux-pci@vger.kernel.org
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
>   S:	Supported
> @@ -10429,6 +10430,15 @@ F:	include/linux/pci*
>   F:	arch/x86/pci/
>   F:	arch/x86/kernel/quirks.c
>   
> +PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
> +M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +L:	linux-pci@vger.kernel.org
> +Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/

So, does that mean the patch(es) for host drivers shoube be based on
this tree instead of yours? If yes, which tree should be preferred if
a patchset wanna touch both of pci core and host drivers?

> +S:	Supported
> +F:	drivers/pci/host/
> +F:	drivers/pci/dwc/
> +
>   PCIE DRIVER FOR AXIS ARTPEC
>   M:	Niklas Cassel <niklas.cassel@axis.com>
>   M:	Jesper Nilsson <jesper.nilsson@axis.com>
> 
> 
> 

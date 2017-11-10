Return-Path: <SRS0=Ba5j=CI=ti.com=kishon@kernel.org>
Return-Path: <SRS0=Ba5j=CI=ti.com=kishon@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Lorenzo Pieralisi for PCI host bridge
 drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20171108201510.18601.30578.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171108202602.GA19676@bhelgaas-glaptop.roam.corp.google.com>
 <4805cf13-3e33-31fb-ab25-1adb4ed13b9c@ti.com>
 <20171109150528.GA7629@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e1c5d6fe-3709-1931-dbac-010ac7751ba2@ti.com>
Date: Fri, 10 Nov 2017 11:16:24 +0530
MIME-Version: 1.0
In-Reply-To: <20171109150528.GA7629@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 09 November 2017 08:35 PM, Bjorn Helgaas wrote:
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

Makes sense.

I'm also thinking if we should change the tree in PCI ENDPOINT SUBSYSTEM to
git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git or maybe
git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/?

since most of the endpoint patches also deals with modifying the controller
drivers.

Thanks
Kishon

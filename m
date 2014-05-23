Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <537E9B0A.9050704@amd.com>
Date: Thu, 22 May 2014 19:49:14 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Robert Richter <rric@kernel.org>,
	Daniel J Blueman <daniel@numascale.com>,
	Andreas Herrmann <herrmann.der.user@googlemail.com>,
	<linux-kernel@vger.kernel.org>,
	Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>,
	<linux-pci@vger.kernel.org>, "Borislav Petkov" <bp@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH V5 0/4] x86/pci Fix numa_node info for AMD hostbridge
 and misc clean up
References: <1399567461-15928-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140521231615.26447.38060.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140521231615.26447.38060.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Resending due to mail client crashing]

On 5/21/2014 6:17 PM, Bjorn Helgaas wrote:
> [resending because I forgot to copy the lists, sorry guys]
>
> Hi Suravee,
>
> Sorry it took me so long to get to these patches.  Here's my proposal.  I
> reordered them and added some comments in the code and changelogs, but I
> think your patches look fine as-is.
>
> So I just need comments on these two significant changes:
>
>    1) I added a patch to stop enabling ECS after Fam16h, because that's
>    another case of CPU-dependent code that we should not need to keep
>    carrying.  I don't think there are any post-Fam16h CPUs yet, but I
>    certainly don't want to do anything that will keep them from working when
>    they do arrive.  It would be useful if somebody could test this on
>    current platforms by tweaking the patch so we don't enable ECS on Fam15h.

I'm okay with this. In my V4 patch, I also tested disabling ECS on 
family15h already and that seems to work fine.  But I would not mind 
deprecate this for post fam16h processors.

>
>    2) I dropped the quirk_amd_nb_node() removal.  I could be convinced
>    otherwise, but I don't really object to the quirk because it is already
>    explicitly limited to specific devices, and removing it will change
>    things in sysfs.  I think the changes would be harmless as far as the
>    kernel is concerned, since there are no drivers for these devices.  But
>    Andreas added the quirk because of complaints, so apparently somebody is
>    looking at what's in sysfs, and I don't want to get the same complaints
>    again by removing it.  However, I will certainly ask questions if I see
>    the quirk being extended to more devices.

I'm okay with keeping this.

> The AMD BKDG does say the BIOS should provide an MCFG table (sec 2.8 of
> 42301), so I think it provides guidance matching the intent of my "stop
> enabling ECS" patch.  But the BKDG doesn't mention _PXM at all.  Is there
> any chance you could squeeze in a mention of that, so BIOS writers know
> that they *should* provide it?  I want to avoid more fire-drills in the
> future.
>
> Bjorn

The ship for family15h stuff have sailed and we probably would not be 
able to get them to change.  We are going to have to keep an eye on the 
future platforms to make sure that the _PXM info is documented for 
future platforms.

I have tested this patch set and they seems to be ok now.

Suravee

>
> ---
>
> Bjorn Helgaas (1):
>        x86/PCI: Stop enabling ECS for AMD CPUs after Fam16h
>
> Myron Stowe (1):
>        x86/PCI: Warn if we have to "guess" host bridge node information
>
> Suravee Suthikulpanit (2):
>        x86/PCI: Work around AMD Fam15h BIOSes that fail to provide _PXM
>        x86/PCI: Clean up and mark early_root_info_init() as deprecated
>
>
>   arch/x86/pci/acpi.c    |    6 +++
>   arch/x86/pci/amd_bus.c |   87 +++++++++++++++++++++++++++++++-----------------
>   2 files changed, 62 insertions(+), 31 deletions(-)
>


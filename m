Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55256450.3010309@broadcom.com>
Date: Wed, 8 Apr 2015 10:24:32 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Scott Branden <sbranden@broadcom.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v2 0/2] iProc PCIe driver Kconfig changes
References: <1427267293-29585-1-git-send-email-rjui@broadcom.com> <55158425.3020608@broadcom.com> <20150408171317.GA25163@google.com>
In-Reply-To: <20150408171317.GA25163@google.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Okay I'll send out a new patch set based on v4.0-rc1 today. The new
patch set will be with subject:

[PATCH v8 0/4] pci: iproc: Add Broadcom iProc PCIe support

Thanks,

Ray

On 4/8/2015 10:13 AM, Bjorn Helgaas wrote:
> On Fri, Mar 27, 2015 at 09:24:05AM -0700, Ray Jui wrote:
>> Hi Bjorn,
>>
>> Do you think the following changes are okay? If so, could you pull them in?
>>
>> Thanks!
> 
> Hi Ray,
> 
> I'm a little bit lost because these patches don't apply on top of what I
> currently have in my pci/host-iproc branch.   I haven't merged that branch
> into "next yet, so can you just repost the entire set of all the iproc
> stuff, based on v4.0-rc1?  Then I'll just merge the final stuff with no
> fixups.
> 
> Bjorn
> 
>> On 3/25/2015 12:08 AM, Ray Jui wrote:
>>> This patch series contains two patches to address iProc PCIe Kconfig related
>>> issues. The first patch adds more protection to PCIE_IPROC so it cannot be
>>> accidentally enabled for non-ARM based platforms. The second patch changes the
>>> config name of the iProc PCIe platform driver from PCIE_IPROC_PLTFM to
>>> PCIE_IPROC_PLATFORM. The driver name is also changed from pcie-iproc-pltfm.c
>>> to pcie-iproc-platform.c so it's consistent with the config name change.
>>>
>>> Changes from v1:
>>>  - Changes the driver name from pcie-iproc-pltfm.c to pcie-iproc-platform.c
>>>
>>> Ray Jui (2):
>>>   pci: iproc: fix PCIE_IPROC in Kconfig
>>>   pci: iproc: change PCIE_IPROC_PLTFM to PCIE_IPROC_PLATFORM
>>>
>>>  drivers/pci/host/Kconfig                           |    4 +++-
>>>  drivers/pci/host/Makefile                          |    2 +-
>>>  .../{pcie-iproc-pltfm.c => pcie-iproc-platform.c}  |    0
>>>  3 files changed, 4 insertions(+), 2 deletions(-)
>>>  rename drivers/pci/host/{pcie-iproc-pltfm.c => pcie-iproc-platform.c} (100%)
>>>

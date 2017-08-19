Return-Path: <SRS0=qcMK=7V=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=qcMK=7V=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170819171018.GR28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1501861696-25767-1-git-send-email-oza.oza@broadcom.com> <20170819171018.GR28977@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Sat, 19 Aug 2017 23:48:44 +0530
Message-ID: <CAMSpPPc1XGp60Uz0Kg+riG1u5CA3PFVojQhNu+x9rTEkadR-Eg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] PCI: iproc: SOC specific fixes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 19, 2017 at 10:40 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Aug 04, 2017 at 09:18:14PM +0530, Oza Pawandeep wrote:
>> PCI: iproc: Retry request when CRS returned from EP
>> Above patch adds support for CRS in PCI RC driver, otherwise if not
>> handled at lower level, the user space PMD (poll mode drivers) can
>> timeout.
>>
>> PCI: iproc: add device shutdown for PCI RC
>> This fixes the issue where certian PCI endpoints are not getting
>> detected on Stingray SOC after reboot.
>>
>> Changes Since v6:
>
> This current series is v6, so I guess you mean "since v5".
>
>> Bjorn's comments addressed.
>> Added reference to PCIe spec and iproc Controller spec in Changelog.
>>
>> Changes Since v5:
>> Ray's comments addressed.
>>
>> Changes Since v4:
>> Bjorn's comments addressed.
>>
>> Changes Since v3:
>> [re-send]
>>
>> Changes Since v2:
>> Fix compilation errors for pcie-iproc-platform.ko which was caught by
>> kbuild.
>>
>> Oza Pawandeep (2):
>>   PCI: iproc: Retry request when CRS returned from EP
>>   PCI: iproc: add device shutdown for PCI RC
>>
>>  drivers/pci/host/pcie-iproc-platform.c |   8 ++
>>  drivers/pci/host/pcie-iproc.c          | 139 +++++++++++++++++++++++++++++----
>>  drivers/pci/host/pcie-iproc.h          |   1 +
>>  3 files changed, 132 insertions(+), 16 deletions(-)
>
> What is this series based on?  It doesn't apply to my master branch,
> my next branch, or my pci/host-iproc branch.  It's always best to base
> patches on my master branch, unless they depend on something that's
> not there.

I am on master branch.
It looks like following Lorenzo Pieralisi's iproc patches have gone in
breaking it.

commit 64bcd00a7ef54d3d55d7eaa8b058e5125d215129
commit 527740765629142993966afbd7a836fc47fb30ee
commit 022adcfc4666a375185d14a43d1de1cdc58d8905

I think both the patch sets were running in parallel.
I will rebase the patches.

Regards,
Oza.

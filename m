Return-Path: <robh@kernel.org>
Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180321211904.GF38649@bhelgaas-glaptop.roam.corp.google.com>
References: <20180321144254.7406-1-lorenzo.pieralisi@arm.com> <20180321211904.GF38649@bhelgaas-glaptop.roam.corp.google.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 27 Mar 2018 11:34:32 -0500
Message-ID: <CAL_Jsq+89X862Zyt4S_hYdpg-HbgEgxUfhx6r_HvihpxSe6c-A@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] PCI DT header refactoring and compile test improvements
To: Bjorn Helgaas <helgaas@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>,
	Xiaowei Song <songxiaowei@hisilicon.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Tanmay Inamdar <tinamdar@apm.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 21, 2018 at 4:19 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Mar 21, 2018 at 02:42:44PM +0000, Lorenzo Pieralisi wrote:
>> Rebased/reworked a patch series previously posted by Rob Herring[1].
>>
>> v1 -> v2:
>>       - Rebased against v4.16-rc1
>>       - Refactored/split patches
>>
>> [1] https://marc.info/?l=linux-pci&m=152043736711658&w=2
>>
>> Original cover letter
>> ---------------------
>>
>> This started with just moving private functions from of_pci.h to
>> drivers/pci/pci.h, but I was annoyed with trying to build all the right
>> configs, so I enabled COMPILE_TEST on a bunch of drivers. Then I fixed
>> the fallout from doing that. I'm sending this as all one series, but
>> really there is no dependency for the header refactoring patch.
>>
>> Needless to say, this series is *compile tested* only. This is based on
>> Bjorn's for-linus branch (and the of_pci.h fix there).
>>
>> Rob
>>
>> Fengguang Wu (4):
>>   PCI: kirin: struct kirin_pcie_driver can be static
>>   PCI: faraday: struct faraday_pci_variant can be static
>>   PCI: rcar: Fix semicolon.cocci warnings
>>   PCI: v3-semi: Fix semicolon.cocci warnings
>
> If these titles were "Make XXX static" and "Remove unnecessary
> semicolon" they would read the same as all the others, i.e., they
> would start with a verb and contain a little more information.  "Fix
> XXX warnings" is not really very informative all by itself.

Not sure who you are directing the comment to, but they are generated
patches. Fixing what generates them would be more useful than
maintainers fixing up the commit messages. Of course, following the
varied whims of different maintainers is probably not scriptable.

Rob

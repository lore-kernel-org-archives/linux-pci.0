Return-Path: <robh@kernel.org>
Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180321211628.GE38649@bhelgaas-glaptop.roam.corp.google.com>
References: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
 <20180321144254.7406-3-lorenzo.pieralisi@arm.com> <20180321211628.GE38649@bhelgaas-glaptop.roam.corp.google.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 27 Mar 2018 11:39:57 -0500
Message-ID: <CAL_JsqJDzGHix=C43FTry_AsUszXVrk_W=01OGnb8+EB0Mi9Jw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] PCI: iproc: Remove dependency on ARM specific
 struct pci_sys_data
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>,
	Xiaowei Song <songxiaowei@hisilicon.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Tanmay Inamdar <tinamdar@apm.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, Ley Foon Tan <lftan@altera.com>,
	Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 21, 2018 at 4:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Mar 21, 2018 at 02:42:46PM +0000, Lorenzo Pieralisi wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> The iproc driver is using ARM's struct pci_sys_data simply to store a
>> private data pointer. This is completely unnecessary, so store the
>> private data directly in bus->sysdata as is done on arm64.
>
> Oh, thank you, this is awesome!
>
> struct pci_sys_data is still referenced in mvebu and rcar.  I didn't
> look closely enough to see if they could be similarly simplified.

I did.

> I guess not, because they use pci_common_init_dev().  They look
> tantalizingly close to being able to use pci_scan_root_bus_bridge()
> like everybody else, though.

Yes, that is the problem. It shouldn't be hard, just needs someone
with h/w to test.

Rob

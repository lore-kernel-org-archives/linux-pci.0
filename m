Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:46158 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdLGKF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Dec 2017 05:05:59 -0500
Received: by mail-wr0-f177.google.com with SMTP id x49so6806279wrb.13
        for <linux-pci@vger.kernel.org>; Thu, 07 Dec 2017 02:05:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ed6d811e-608e-e6aa-7b07-2f2d2d68adbd@ti.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <297fa17e12cf0f2fb223c05eeb18570707ff5bf1.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171201122048.GB25010@red-moon> <ed6d811e-608e-e6aa-7b07-2f2d2d68adbd@ti.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 7 Dec 2017 11:05:17 +0100
Message-ID: <CAOFm3uGQzAOrAmQLx7uJ0SJGQxMSB+oAniq9wd93tvupKWv=uA@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: cadence: add EndPoint Controller driver for
 Cadence PCIe controller
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Cyrille,


On Tue, Dec 5, 2017 at 10:19 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Friday 01 December 2017 05:50 PM, Lorenzo Pieralisi wrote:
>> On Thu, Nov 23, 2017 at 04:01:50PM +0100, Cyrille Pitchen wrote:
>>> This patch adds support to the Cadence PCIe controller in endpoint mode.
>>
>> Please add a brief description to the log to describe the most salient
>> features.
>>
>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>>> ---
>>>  drivers/pci/cadence/Kconfig           |   9 +
>>>  drivers/pci/cadence/Makefile          |   1 +
>>>  drivers/pci/cadence/pcie-cadence-ep.c | 553 ++++++++++++++++++++++++++++++++++
>>>  3 files changed, 563 insertions(+)
>>>  create mode 100644 drivers/pci/cadence/pcie-cadence-ep.c
>>>
>>> diff --git a/drivers/pci/cadence/Kconfig b/drivers/pci/cadence/Kconfig
>>> index 120306cae2aa..b2e6af71f39e 100644
>>> --- a/drivers/pci/cadence/Kconfig
>>> +++ b/drivers/pci/cadence/Kconfig
>>> @@ -21,4 +21,13 @@ config PCIE_CADENCE_HOST
>>>        mode. This PCIe controller may be embedded into many different vendors
>>>        SoCs.
>>>
>>> +config PCIE_CADENCE_EP
>>> +    bool "Cadence PCIe endpoint controller"
>>> +    depends on PCI_ENDPOINT
>>> +    select PCIE_CADENCE
>>> +    help
>>> +      Say Y here if you want to support the Cadence PCIe  controller in
>>> +      endpoint mode. This PCIe controller may be embedded into many
>>> +      different vendors SoCs.
>>> +
>>>  endif # PCI_CADENCE
>>> diff --git a/drivers/pci/cadence/Makefile b/drivers/pci/cadence/Makefile
>>> index d57d192d2595..61e9c8d6839d 100644
>>> --- a/drivers/pci/cadence/Makefile
>>> +++ b/drivers/pci/cadence/Makefile
>>> @@ -1,2 +1,3 @@
>>>  obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
>>>  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>>> +obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
>>> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
>>> new file mode 100644
>>> index 000000000000..a1d761101a9c
>>> --- /dev/null
>>> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
>>> @@ -0,0 +1,553 @@
>>> +/*
>>> + * Cadence PCIe host controller driver.
>>
>> You should update this comment.
>>
>>> + *
>>> + * Copyright (c) 2017 Cadence
>>> + *
>>> + * Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License along with
>>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>>> + */

Would you consider using the new SPDX ids instead of this long legalese blurb?
You can  check tglx's doc patches for details and Linus comments on
why he wants it a certain way with C++ // comments.

Here this could come out much streamlined with this top level comment block:

// SPDX-License-Identifier: GPL-2.0
// Copyright (c) 2017 Cadence
// Cadence PCIe host controller driver.
// Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>

This is only a suggestion, but everyone kinda likes it when the
licensing boilerplate is minimal and out of the visual way in order to
focus is on what matters most: the code!
Thank you for your kind consideration.
-- 
Cordially
Philippe Ombredanne

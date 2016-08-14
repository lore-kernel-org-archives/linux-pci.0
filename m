Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:34703 "EHLO
	mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbcHNQmc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Aug 2016 12:42:32 -0400
Received: by mail-ua0-f173.google.com with SMTP id k90so45930969uak.1
        for <linux-pci@vger.kernel.org>; Sun, 14 Aug 2016 09:42:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1470817968909.9956@dji.com>
References: <1470817968909.9956@dji.com>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Sun, 14 Aug 2016 22:12:30 +0530
Message-ID: <CAHM4w1kxhbbhWi+4_gqNPPPMWZ=0zJEB637pfn-gkytkbaZQ+Q@mail.gmail.com>
Subject: Re: Synopsys pcie driver question
To: First Light <xiaoguang.chen@dji.com>
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@gmail.com" <bhelgaas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,


On Wed, Aug 10, 2016 at 2:03 PM, First Light <xiaoguang.chen@dji.com> wrote:
> Hi, Dear maintainers for sysnopsys pcie driver

Please always keep the mailing list in CC, so that you can have
response from wider audience.

>
> I have one question for this driver
>
>
> we are using synopsys PCIE IP in our platform,and I'm
> trying to use linux driver(drivers/pci/host/pcie-designware.c) to bring up
> this IP.
>
> but I met one issue which I cannot understand whether it is software issue
> or hardware issue,
> please help to clearify.  thank you very much!
>
> In pcie-designware.c, the interface to read config is dw_pcie_rd_conf
> function, below is part of the code:
>
> if (bus->number == pp->root_bus_nr)
> return dw_pcie_rd_own_conf(...)
> else
> return dw_pcie_rd_other_conf(...)
>
> this part of code checks if it is the root bus, if so, read own config
> registers, otherwise use DBF way to read configs from EPs.
>
> In our platform, we put one SSD device under bus0 device1. during
> enumration, when above software code try to read ssd's registers,
>
> it found the bus is 0, so it reads the RC's register, but not the SSD's
> register.
>

How do you know that when it tried to read bus 0, it was your SSD
device? That should always be RC.  Did you check if linkup was OK for
your endpoint device? Do you see "link up" in your dmesg?


> so our ssd is never enumrated.

Which host platform for designware do you use? Is that host driver in mainline?
Does other standard PCIe card work with your host?

~Pratyush

>
> is there any way to do some hardware or software configuration to make
> it work? or do we need to change our hardware design?
>
>
> Thanks
> Xiaoguang
>
>
>
>
>
> This email and any attachments thereto may contain private, confidential,
> and privileged material for the sole use of the intended recipient. Any
> review, copying, or distribution of this email (or any attachments thereto)
> by others is strictly prohibited. If you are not the intended recipient,
> please contact the sender immediately and permanently delete the original
> and any copies of this email and any attachments thereto.
>
> 此电子邮件及附件所包含内容具有机密性，且仅限于接收人使用。未经允
> 许，禁止第三人阅读、复制或传播该电子邮件中的任何信息。如果您不属于以上电子邮件的目标接收者，请您立即通知发送人并删除原电子邮件及其相关的附件。

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:33231 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932348AbdAIJcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2017 04:32:45 -0500
Subject: Re: [PATCH v5] PCI: add a new directory for designware core
To: Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
References: <1483707168-1436-1-git-send-email-kishon@ti.com>
 <4757539.Mx4pNLiAHf@wuerfel> <586F97B8.8040300@ti.com>
 <ed3b67ec-1764-bd48-379c-b449678b79a4@synopsys.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nsekhar@ti.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5873588C.1080809@ti.com>
Date: Mon, 9 Jan 2017 15:01:56 +0530
MIME-Version: 1.0
In-Reply-To: <ed3b67ec-1764-bd48-379c-b449678b79a4@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 06 January 2017 07:10 PM, Joao Pinto wrote:
> Hello,
> 
> Às 1:12 PM de 1/6/2017, Kishon Vijay Abraham I escreveu:
>> Hi Arnd,
>>
>> On Friday 06 January 2017 06:31 PM, Arnd Bergmann wrote:
>>> On Friday, January 6, 2017 6:22:48 PM CET Kishon Vijay Abraham I wrote:
>>>> Group all the PCI drivers that use designware core in dwc directory.
>>>> dwc IP is capable of operating in both host mode and device mode and
>>>> keeping it inside the *host* directory is misleading.
>>>
>>> I have no objections to the patch, it makes a lot of sense, but I think
>>> the reasoning above is a bit questionable, as a lot of the other
>>> host drivers (at least tegra, mvebu and xgene, probably more) equally support
>>> endpoint mode and remain in the same directory.
>>>
>>> Any suggestion to what we should do with them?
>>
>> I'm not sure of the exact IP's used by these SoCs. Now that we decided to group
>> the drivers by IPs used, the best would be identify the IPs used in these SoCs
>> and create a separate directory for each of the IPs. If the vendors own IP is
>> used, then create a directory with the name of the vendor?. I'm sure such a
>> change would increase the number of directories but I'm not sure what else to
>> do here.
> 
> In case of designware based drivers you already did the clean up nicely. Next
> would be, like Arnd is sugesting, to do the same to the others. If they are all
> self-contained I suggest we leave them as they are and in the future if a
> endpoint variant driver comes up for any of them, we can suggest to add a folder
> with the vendor or SoC name in order to follow the rule. What do you think?

That's my idea as well. Arnd, do you think it's okay not to disturb other
drivers/directories until endpoint support is added to those drivers?

Thanks
Kishon

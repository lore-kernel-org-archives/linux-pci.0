Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:46936 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbdH1Aq2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2017 20:46:28 -0400
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: rockchip: Use gpiod_set_value_cansleep() to allow
 reset via expanders
To: Fabio Estevam <festevam@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <1503187634-3823-1-git-send-email-festevam@gmail.com>
 <20170824163323.GG31858@bhelgaas-glaptop.roam.corp.google.com>
 <1690109.dqujpfY2W8@phil>
 <CAOMZO5Dh7Mxv-wePiQnW8VG5o=LeBZ1ZfUaPuHbnmqNoYW=3-g@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <d44b8ac6-9896-485d-d54e-b96e44d4d0c9@rock-chips.com>
Date: Mon, 28 Aug 2017 08:46:29 +0800
MIME-Version: 1.0
In-Reply-To: <CAOMZO5Dh7Mxv-wePiQnW8VG5o=LeBZ1ZfUaPuHbnmqNoYW=3-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/8/28 8:27, Fabio Estevam wrote:
> On Thu, Aug 24, 2017 at 1:37 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> 
>>> Waiting for Shawn's ack...
>>
>> we might want to include him then, as I'm not sure if he patrols the
>> linux-pci list :-) . [I've added him]

Aha, I also patrol linux-rockchip for pcie-rockchip, but this patch
didn't include it either.

> 
> Sorry, I missed to add Shawn on Cc. I have just resent the patch with him on Cc.
> 

Don't worry. I will check it out ASAP.

> Thanks
> 
> 
> 

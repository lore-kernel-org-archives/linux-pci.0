Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:47729 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758773AbdEXAyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2017 20:54:36 -0400
Subject: Re: [PATCH] PCI: rockchip: check link status when validating device
To: Brian Norris <briannorris@chromium.org>
References: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
 <20170523180048.GA115572@google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <3fea7598-501e-6131-612a-977f005e9a2b@rock-chips.com>
Date: Wed, 24 May 2017 08:54:14 +0800
MIME-Version: 1.0
In-Reply-To: <20170523180048.GA115572@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Brian,

在 2017/5/24 2:00, Brian Norris 写道:
> On Fri, May 19, 2017 at 02:58:27PM +0800, Shawn Lin wrote:
>> This patch checks the link status before reading and
>> writing configure space of devices attached to the RC.
>> If the link status is down, we shouldn't try to access
>> the devices.
>
> I'm curious, in what situations are you seeing the link down? In all the
> cases where I can manage to screw up my endpoint and see system aborts
> due to config accesses, this check still says the link is up. Presumably
> you have some test cases that benefit from this though.

Of course. This patch doesn't prevent all these cases, for instance,
you do a memory read/write in the EP function driver, since it doesn't
call these two APIs at all.

The reason for me to added this check is that I saw a external abort
down to rockchip_pcie_rd_own_conf, of which I highly suspected was that
the link was re-init or total broken at that time.


>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/pci/host/pcie-rockchip.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index 0e020b6..1e64227 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -275,9 +275,21 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
>>  	rockchip_pcie_write(rockchip, val, PCIE_CORE_TXCREDIT_CFG1);
>>  }
>>
>> +static inline bool rockchip_pcie_link_up(struct rockchip_pcie *rockchip)
>> +{
>> +	return PCIE_LINK_UP(rockchip_pcie_read(rockchip,
>> +					PCIE_CLIENT_BASIC_STATUS1));
>> +}
>> +
>>  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>>  				      struct pci_bus *bus, int dev)
>>  {
>> +	/* do not access the devices if the link isn't completed */
>> +	if (bus->number != rockchip->root_bus_nr) {
>> +		if (!rockchip_pcie_link_up(rockchip))
>> +			return 0;
>> +	}
>
> Seems like this should be the last check in the function, after you
> check that the bus and dev numbers are reasonable?
>

I am fine with either one.


> Brian
>
>> +
>>  	/* access only one slot on each root port */
>>  	if (bus->number == rockchip->root_bus_nr && dev > 0)
>>  		return 0;
>> --
>> 1.9.1
>>
>>
>
>
>

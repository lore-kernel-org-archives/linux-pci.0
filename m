Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:43220 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbaDHQZn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 12:25:43 -0400
Date: Tue, 08 Apr 2014 12:25:38 -0400 (EDT)
Message-Id: <20140408.122538.300463519945725052.davem@davemloft.net>
To: ogerlitz@mellanox.com
Cc: weiyang@linux.vnet.ibm.com, yevgenyp@mellanox.com,
	amirv@mellanox.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [Patch net-next] net/mlx4_core: match pci_device_id including
 dynids
From: David Miller <davem@davemloft.net>
In-Reply-To: <53439BBE.4070708@mellanox.com>
References: <1396750050-7183-1-git-send-email-weiyang@linux.vnet.ibm.com>
	<20140407.144340.688537373203786487.davem@davemloft.net>
	<53439BBE.4070708@mellanox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Or Gerlitz <ogerlitz@mellanox.com>
Date: Tue, 8 Apr 2014 09:48:30 +0300

> On 07/04/2014 21:43, David Miller wrote:
>> From: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Date: Sun,  6 Apr 2014 10:07:30 +0800
>>
>>> Fix issue introduced by commit: 97a5221 "net/mlx4_core: pass
>>> pci_device_id.driver_data to __mlx4_init_one during reset".
>>>
>>> pci_match_id() just match the static pci_device_id, which may return
>>> NULL if
>>> someone binds the driver to a device manually using
>>> /sys/bus/pci/drivers/.../new_id.
>>>
>>> This patch wrap up a helper function __mlx4_remove_one() which does
>>> the tear
>>> down function but preserve the drv_data. Functions like
>>> mlx4_pci_err_detected() and mlx4_restart_one() will call this one with
>>> out
>>> releasing drvdata.
>>>
>>> Tested on ConnectX-3.
>>>
>>> CC: Bjorn Helgaas <bhelgaas@google.com>
>>> CC: Amir Vadai <amirv@mellanox.com>
>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Please resubmit this when the net-next tree opens back up, thanks.
> 
> Dave, this patch is for net, since it fixes an issue in the current
> code (actually it relates to a patch
> that was merged after 3.14-rc7, so it would eventually might go to
> -stable too). The author wasn't very
> familiar with the exact differences/nature of net vs. net-next, so it
> might created some confusion here, I'v
> sent him few private notes to explain how things go...

Then please resubmit this patch with the proper subject line, th ank you.

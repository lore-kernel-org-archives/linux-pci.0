Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:33521 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754698AbaDHHUS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 03:20:18 -0400
Message-ID: <5343A2D8.20803@mellanox.com>
Date: Tue, 8 Apr 2014 10:18:48 +0300
From: Or Gerlitz <ogerlitz@mellanox.com>
MIME-Version: 1.0
To: Guo Chao <yan@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, <talal@mellanox.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com> <1394222924-28886-1-git-send-email-yinghai@kernel.org> <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com> <20140408025738.GA3198@yanx>
In-Reply-To: <20140408025738.GA3198@yanx>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/04/2014 05:57, Guo Chao wrote:
> On Fri, Apr 04, 2014 at 04:43:27PM -0600, Bjorn Helgaas wrote:
>> On Fri, Mar 7, 2014 at 1:08 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> When one of children resources does not support MEM_64, MEM_64 for
>>> bridge get reset, so pull down whole pref resource on the bridge under 4G.
>>>
>>> If the bridge support pref mem 64, will only allocate that with pref mem64 to
>>> children that support it.
>>> For children resources if they only support pref mem 32, will allocate them
>>> from non pref mem instead.
>>>
>>> If the bridge only support 32bit pref mmio, will still have all children pref
>>> mmio under that.
>>>
>>> -v2: Add release bridge res support with bridge mem res for pref_mem children res.
>>> -v3: refresh and make it can be applied early before for_each_dev_res patchset.
>>> -v4: fix non-pref mmio 64bit support found by Guo Chao.
>>> -v7: repost as ibm's powerpc system work again when
>>>      1. petiboot boot kernel have this patch.
>>>      2. or mellanox driver added new .shutdown member.
>>>      discussion could be found at:
>>>           http://marc.info/?t=138968064500001&r=1&w=2
>> I think this fixes some sort of bug, and I suppose if I spent a few
>> hours decoding the discussion you mention (the 44 message-long
>> "mlx4_core probe error after applying Yinghai's patch" discussion), I
>> might be able to figure out what it is.
>>
> The result of 44 message-long discussion is: the Mellanox card's failure is
> due to a bug in its driver instead of this patch.


So just to make sure we're on the same page -- fixing the bug is carried 
out through netdev, e.g this 3.14-rc8
upstream commit 97a5221 "net/mlx4_core: pass pci_device_id.driver_data 
to __mlx4_init_one during reset"
and now this one more fix which is under discussion 
http://marc.info/?l=linux-pci&m=139675010015646&w=2, right?



>
> The patch refines the logic of using prefetchable window, so that 64-bit
> prefetchable BARs have a chance to be really prefetchable. It does not fix
> any bugs, instead, it exposes one.


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:41484 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756445AbaDHH50 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 03:57:26 -0400
Message-ID: <5343AB8B.5070409@mellanox.com>
Date: Tue, 8 Apr 2014 10:55:55 +0300
From: Or Gerlitz <ogerlitz@mellanox.com>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Guo Chao <yan@linux.vnet.ibm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, <talal@mellanox.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com> <1394222924-28886-1-git-send-email-yinghai@kernel.org> <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com> <20140408025738.GA3198@yanx> <5343A2D8.20803@mellanox.com> <20140408074135.GA12126@richard>
In-Reply-To: <20140408074135.GA12126@richard>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/04/2014 10:41, Wei Yang wrote:
>> >So just to make sure we're on the same page -- fixing the bug is
>> >carried out through netdev, e.g this 3.14-rc8
>> >upstream commit 97a5221 "net/mlx4_core: pass
>> >pci_device_id.driver_data to __mlx4_init_one during reset"
>> >and now this one more fix which is under discussion
>> >http://marc.info/?l=linux-pci&m=139675010015646&w=2, right?
> No, this onehttp://marc.info/?l=linux-pci&m=139675010015646&w=2  is another
> bug in mlx4 driver, missing a proper pci_dev_data in mlx4_init_one.
>
> The bug discussing in this thread is the driver "forget" to release the
> "owner" during kexec. So this device couldn't be usded after kexec.
>
Can you guys please open a kernel.org bugzilla ticket, or better... work 
on a patch?

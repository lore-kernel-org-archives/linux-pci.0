Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:38790 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205Ab3CLCwx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2013 22:52:53 -0400
Message-ID: <513E983E.6050400@huawei.com>
Date: Tue, 12 Mar 2013 10:51:42 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz>
In-Reply-To: <513E7E1E.80508@fold.natur.cuni.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/3/12 9:00, Martin Mokrejs wrote:
> Hi,
>   I cold-booted a computer with the card inserted before power-on and collected
> lspci output and express card slot status every second. Then I tried eject and
> hotplug inserts and it appearts the card is not detected, actually maybe pciehp
> is not even suppoosed to work in this case as the slot was occupied during boot.
> But let me come to it later.
> 
> I noted the following on the very first eject of the so far cold-plugged card
> that lspci properly reports PresDet change on the Changed: line. The only time
> I ever saw it. ;-)

Hi Martin,
   PresDet change bit will be cleaned as soon as pciehp driver received the inturrupt from hardware,
So it's difficult to capture the change.

> 
> 
> I re-plugged the card and ejected several times while the while loops
> collecting lspci and slot_status via the setpci shell command harvested
> data. Still, in dmesg there was nothing logged regarding card insert/eject.
> Eventually, I tried rmmod sata_sil24 (did NOT need 'rmmod -f') and that
> did log something new.

No new dmesg info when insert/eject maybe indicate the pciehp driver never received the
interrupt or there is no bit set about Presence Detect Changed here. Or there is debug info
like :
pcie_isr: intr_loc %x at least.

eSATA card SiI 3132, no XHCI, hotplug only got problem with 3.9-rc1? or both at 3.7 3.8?


-- 
Thanks!
Yijing


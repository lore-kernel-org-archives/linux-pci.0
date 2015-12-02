Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57237 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963AbbLBQN3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2015 11:13:29 -0500
Subject: Re: [PATCH] PCI/AER: enable SERR# forwarding and role-based error
 reporting
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1445894704-28277-1-git-send-email-okaya@codeaurora.org>
 <20151201185157.GE9306@localhost> <565DF34C.6030606@codeaurora.org>
 <565DFE50.5030708@codeaurora.org> <20151201230710.GA32381@localhost>
 <565E76E9.1020307@codeaurora.org>
Cc: Christopher Covington <cov@codeaurora.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, timur@codeaurora.org, jcm@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <565F18A5.1080204@codeaurora.org>
Date: Wed, 2 Dec 2015 11:13:25 -0500
MIME-Version: 1.0
In-Reply-To: <565E76E9.1020307@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/1/2015 11:43 PM, Sinan Kaya wrote:
> Setting the SERR# forwarding must have made the trick. This part was
> just an additional clearing of the errors.
> 

Nope, I was just enabling non-advisory fatal error from the mask
register. Not clearing it.

> I'll retest without this bit.

Here we go.

/#lspci
00:00.0 Class 0604: 17cb:0400
01:00.0 Class 0604: 10b5:8732
02:08.0 Class 0604: 10b5:8732
03:00.0 Class 0604: 10b5:8732
04:00.0 Class 0604: 10b5:8732
05:00.0 Class 0604: 10b5:8749
05:00.1 Class 0880: 10b5:87d0
05:00.2 Class 0880: 10b5:87d0
05:00.3 Class 0880: 10b5:87d0
05:00.4 Class 0880: 10b5:87d0
06:08.0 Class 0604: 10b5:8749
06:09.0 Class 0604: 10b5:8749
06:10.0 Class 0604: 10b5:8749
06:11.0 Class 0604: 10b5:8749
06:12.0 Class 0604: 10b5:8749
07:00.0 Class ff00: 1172:e001


This is after removing the PCI_ERR_COR_ADV_NFAT setting which looks much
better to me. I'll post a new patch without PCI_ERR_COR_ADV_NFAT.

/#[24.358445]pcieport_0006:00:00.0:_AER:_Multiple_Corrected_error_received:_id=0640
[   24.358559] pcieport 0006:06:08.0: PCIe Bus Error:
severity=Corrected, type=Physical Layer, id=06
[   24.358571] pcieport 0006:06:08.0:   device [10b5:8749] error
status/mask=00002081/0000e000
[   24.358583] pcieport 0006:06:08.0:    [ 0] Receiver Error         (First)
[   24.358593] pcieport 0006:06:08.0:    [ 7] Bad DLLP
[   24.358616] pcieport 0006:00:00.0: AER: Multiple Corrected error
received: id=0640
[   24.358708] pcieport 0006:00:00.0: AER: Multiple Corrected error
received: id=0640
[   24.358800] pcieport 0006:00:00.0: AER: Multiple Corrected error
received: id=0640
[   24.358892] pcieport 0006:00:00.0: AER: Multiple Corrected error
received: id=0640




Below is the test result with the original code.
<remove card>

pcieport_0006:00:00.0:_AER:_Multiple_Corrected_error_received:_id=0640
pcieport 0006:01:00.0: PCIe Bus Error: severity=Corrected,
type=Transaction Layer, id=0100(Receiver ID)
pcieport 0006:01:00.0:   device [10b5:8732] error
status/mask=00002000/0000c000
pcieport 0006:01:00.0:    [13] Advisory Non-Fatal
pcieport 0006:02:08.0: PCIe Bus Error: severity=Corrected,
type=Transaction Layer, id=0240(Receiver ID)
pcieport 0006:02:08.0:   device [10b5:8732] error
status/mask=00002000/0000c000
pcieport 0006:02:08.0:    [13] Advisory Non-Fatal
pcieport 0006:03:00.0: PCIe Bus Error: severity=Corrected,
type=Transaction Layer, id=0300(Receiver ID)
pcieport 0006:03:00.0:   device [10b5:8732] error
status/mask=00002000/0000c000
pcieport 0006:03:00.0:    [13] Advisory Non-Fatal
pcieport 0006:04:00.0: PCIe Bus Error: severity=Corrected,
type=Transaction Layer, id=0400(Receiver ID)
pcieport 0006:04:00.0:   device [10b5:8732] error
status/mask=00002000/0000c000
pcieport 0006:04:00.0:    [13] Advisory Non-Fatal
pcieport 0006:06:08.0: PCIe Bus Error: severity=Corrected, type=Physical
Layer, id=0640(Receiver ID)
pcieport 0006:06:08.0:   device [10b5:8749] error
status/mask=00002001/0000c000
pcieport 0006:06:08.0:    [ 0] Receiver Error
pcieport 0006:06:08.0:    [13] Advisory Non-Fatal
pcieport 0006:06:08.0:   Error of this Agent(0640) is reported first
pcieport 0006:00:00.0: AER: Multiple Corrected error received: id=0640
pcieport 0006:06:09.0: PCIe Bus Error: severity=Corrected,
type=Transaction Layer, id=0648(Receiver ID)
pcieport 0006:06:09.0:   device [10b5:8749] error
status/mask=00002000/00008000
pcieport 0006:06:09.0:    [13] Advisory Non-Fatal
pcieport 0006:06:10.0: PCIe Bus Error: severity=Corrected,
type=Transaction Layer, id=0680(Receiver ID)
pcieport 0006:06:10.0:   device [10b5:8749] error
status/mask=00002000/0000c000
pcieport 0006:06:10.0:    [13] Advisory Non-Fatal
pcieport 0006:06:11.0: PCIe Bus Error: severity=Corrected,
type=Transaction Layer, id=0688(Receiver ID)
pcieport 0006:06:11.0:   device [10b5:8749] error
status/mask=00002000/00008000
pcieport 0006:06:11.0:    [13] Advisory Non-Fatal
pcieport 0006:06:12.0: PCIe Bus Error: severity=Corrected,
type=Transaction Layer, id=0690(Receiver ID)
pcieport 0006:06:12.0:   device [10b5:8749] error
status/mask=00002000/00008000
pcieport 0006:06:12.0:    [13] Advisory Non-Fatal
pcieport 0006:00:00.0: AER: Multiple Corrected error received: id=0640
pcieport 0006:00:00.0: AER: Multiple Corrected error received: id=0640
pcieport 0006:00:00.0: AER: Multiple Corrected error received: id=0640
pcieport 0006:00:00.0: AER: Multiple Corrected error received: id=0640
/ #





-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project

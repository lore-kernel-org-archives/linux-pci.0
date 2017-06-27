Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:29204 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751513AbdF0JYT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2017 05:24:19 -0400
From: Ryder Lee <ryder.lee@mediatek.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [RESEND PATCH] critical patch to fix pci-tree build bot failure
Date: Tue, 27 Jun 2017 17:24:10 +0800
Message-ID: <1498555451-55073-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Stephen and Andrew,

Could you help to apply this patch? Seems Bjorn didn't response it these days.

This patch(based on pci-next tree) will fix the following build bot failure:
>> On Mon, Jun 26, 2017 at 09:47:36AM +0100, Build bot for Mark Brown wrote:
>>
>> This build failure is still present in -next:
>>
>> >     arm-allmodconfig
>> > ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit 
>> > declaration of function 'pci_register_host_bridge' 
>> > [-Werror=implicit-function-declaration]
>>
>> and we're at -rc7 now.

This is because pci/host-mediatek is a seperate branch in pci-tree, but merge together without proper modifications(eg. some API changes).

Hi Bjorn,
I rewrote commit message. Please ignore my previous one, sorry for inconvenience.

Thanks a lot!

Ryder Lee (1):
  PCI: mediatek: change to use the new host bridge interface

 drivers/pci/host/pcie-mediatek.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
1.9.1

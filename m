Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33641 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbCTWYe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2015 18:24:34 -0400
Received: by obcxo2 with SMTP id xo2so88125832obc.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 15:24:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150320212045.GL26935@google.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
	<20150320212045.GL26935@google.com>
Date: Sat, 21 Mar 2015 06:24:33 +0800
Message-ID: <CADLM8XPXViGNVAr4wuf2goS06bY3oq0cHQV1vPimyKNNjZg3=w@mail.gmail.com>
Subject: Re: [PATCH V14 00/21] Enable SRIOV on Power8
From: Wei Yang <weiyang.kernel@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2015-03-21 5:20 GMT+08:00 Bjorn Helgaas <bhelgaas@google.com>:
> On Fri, Mar 20, 2015 at 11:06:16AM +0800, Wei Yang wrote:
>> This patchset enables the SRIOV on POWER8.
>>
>> The general idea is put each VF into one individual PE and allocate required
>> resources like MMIO/DMA/MSI. The major difficulty comes from the MMIO
>> allocation and adjustment for PF's IOV BAR.
>>
>> On P8, we use M64BT to cover a PF's IOV BAR, which could make an individual VF
>> sit in its own PE. This gives more flexiblity, while at the mean time it
>> brings on some restrictions on the PF's IOV BAR size and alignment.
>
> For patches 03-12 (the "PCI: " ones):
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> It's fine if you want to take all these via the powerpc tree.  I don't see
> much if anything in my queue that will conflict with them.
>

Thanks, Bjorn :-)

I will work with Ben/Gavin to merge it on ppc.
If anything change in PCI core, I will let you know.

Have a nice weekend :-)

> Bjorn
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev



-- 
Richard Yang
Help You, Help Me

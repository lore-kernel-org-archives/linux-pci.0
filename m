Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:54754 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbbCXBPe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2015 21:15:34 -0400
Message-ID: <5510BAAD.3080607@huawei.com>
Date: Tue, 24 Mar 2015 09:15:25 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	kbuild test robot <fengguang.wu@intel.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [pci:pci/enumeration-yw7 32/35] drivers/pci/host-bridge.c:147:24:
 sparse: symbol 'pci_find_host_bridge' was not declared. Should it be static?
References: <201503240247.Lu2Ttzhc%fengguang.wu@intel.com> <CAErSpo6zfA7t-CeYx1_aBYEcV=LFueWYE_bndH-s-ktjL_goPg@mail.gmail.com>
In-Reply-To: <CAErSpo6zfA7t-CeYx1_aBYEcV=LFueWYE_bndH-s-ktjL_goPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> sparse warnings: (new ones prefixed by >>)
>>
>>>> drivers/pci/host-bridge.c:147:24: sparse: symbol 'pci_find_host_bridge' was not declared. Should it be static?
>>
>> Please review and possibly fold the followup patch.
> 
> It does look like pci_find_host_bridge() is only used inside
> drivers/pci/host-bridge.c and could be static.  Given that it's only
> used there, it doesn't even need to be renamed, so maybe you could
> even just drop the rename patch, too.

OK.

Hi Bjorn, because this series involved lots platforms and host bridge chips, and this version takes a lot of changes.
So I didn't take lot of time to cross build this series in all the platforms in my local. I hope you could see the changes
first, and I will refresh and fix the details soon.

Thanks!
Yijing.

> 
> Bjorn
> 
> 


-- 
Thanks!
Yijing


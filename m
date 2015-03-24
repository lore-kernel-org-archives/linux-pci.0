Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:36392 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbbCXDlK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2015 23:41:10 -0400
Message-ID: <5510DCCE.5060007@huawei.com>
Date: Tue, 24 Mar 2015 11:41:02 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: kbuild test robot <fengguang.wu@intel.com>,
	"kbuild-all@01.org" <kbuild-all@01.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [pci:pci/enumeration-yw7 32/35] drivers/pci/host-bridge.c:147:24:
 sparse: symbol 'pci_find_host_bridge' was not declared. Should it be static?
References: <201503240247.Lu2Ttzhc%fengguang.wu@intel.com> <CAErSpo6zfA7t-CeYx1_aBYEcV=LFueWYE_bndH-s-ktjL_goPg@mail.gmail.com> <5510BAAD.3080607@huawei.com> <CAErSpo5ycJbuUi4A903=DbWABDr9kKti+b68VCdtgzgpAmp2sQ@mail.gmail.com>
In-Reply-To: <CAErSpo5ycJbuUi4A903=DbWABDr9kKti+b68VCdtgzgpAmp2sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/24 10:29, Bjorn Helgaas wrote:
> On Mon, Mar 23, 2015 at 8:15 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>>> sparse warnings: (new ones prefixed by >>)
>>>>
>>>>>> drivers/pci/host-bridge.c:147:24: sparse: symbol 'pci_find_host_bridge' was not declared. Should it be static?
>>>>
>>>> Please review and possibly fold the followup patch.
>>>
>>> It does look like pci_find_host_bridge() is only used inside
>>> drivers/pci/host-bridge.c and could be static.  Given that it's only
>>> used there, it doesn't even need to be renamed, so maybe you could
>>> even just drop the rename patch, too.
>>
>> OK.
>>
>> Hi Bjorn, because this series involved lots platforms and host bridge chips, and this version takes a lot of changes.
>> So I didn't take lot of time to cross build this series in all the platforms in my local. I hope you could see the changes
>> first, and I will refresh and fix the details soon.
> 
> I just put them on a branch for build testing.  I will review them
> more closely when the build problems are resolved.
> 
> FYI, I'll be on vacation from Mar 25 - Apr 2, so I won't be able to do
> much then.

OK, I post out the new v8 version which fixed the build problems and drop the unnecessary patch.

Happy vacation!

Thanks!
Yijing.

> 
> Bjorn
> 
> 


-- 
Thanks!
Yijing


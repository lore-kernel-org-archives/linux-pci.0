Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:58079 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbaHBAZu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Aug 2014 20:25:50 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so6417348pdi.11
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2014 17:25:49 -0700 (PDT)
Content-Type: text/plain;
	charset=gb2312
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
From: Ethan Zhao <ethan.kernel@gmail.com>
In-Reply-To: <53DB84E6.1070206@solarflare.com>
Date: Sat, 2 Aug 2014 08:25:40 +0800
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vasundhara Volam <vasundhara.volam@emulex.com>
Message-Id: <107835EF-8941-4621-952F-E1583F7E3636@gmail.com>
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <CABawtvPwxovKV==8RVCL1OcsdfnZDDjr=d1uYp-A=bAzYbmKww@mail.gmail.com> <53DB84E6.1070206@solarflare.com>
To: Edward Cree <ecree@solarflare.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> 在 2014年8月1日，下午8:15，Edward Cree <ecree@solarflare.com> 写道：
> 
>> On 01/08/14 04:51, Ethan Zhao wrote:
>> Though I like this patch, it shows direct style, but it will change
>> the meaning of a function not mentioned here.
>> 
>>  int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
> Am I missing something here, or is that exactly the function mentioned
> in the patch title / subject line?
> 
>> So far seems no driver call pci_sriov_set_totalvfs() with numvfs = 0
>> and the patch will change the behavior of the drivers, but it will
>> definitely change the test cases and documents related to IOV.
> As for test cases and documents, I can't find any in the kernel tree -
> if I grep for pci_sriov_set_totalvfs, the only mentions I find are:
> * The declaration in include/linux/pci.h.  Doesn't have any comments.
> * The definition in drivers/pci/iov.c.  The comment doesn't document the
> behaviour in the numvfs = 0 case.
> * Documentation/ABI/testing/sysfs-bus-pci.  Describes the function's
> purpose "reduce the value read from [the sriov_totalvfs sysfs file]" but
> doesn't say anything about the numvfs = 0 case.
> * the Intel igb and ixgbe ethernet drivers.  Both pass nonzero constants
> for numvfs.
> * the Emulex benet driver.  This went into Dave Miller's net-next branch
> on 30/06/2014 (so hasn't hit Linus' or other trees yet), but it looks to
> me like it might call with numvfs = 0.  CCing the author of that patch
> (Vasundhara Volam) for comments.

I mean some test cases or doc that are out of kernel tree ... such as some Distro, 
not only Hardware vendors.

Thanks.
Ethan

> 
> -Edward
> The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:4388 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751509Ab3CABPK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Feb 2013 20:15:10 -0500
Message-ID: <513000F2.10502@cn.fujitsu.com>
Date: Fri, 01 Mar 2013 09:14:26 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Myron Stowe <myron.stowe@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joe Lawrence <Joe.Lawrence@stratus.com>,
	linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>
Subject: Re: [PATCH 1/2] PCI: ASPM exit link state code could skip devices
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com> <alpine.DEB.2.02.1301181322500.31163@jlaw-desktop.mno.stratus.com> <51122BED.8090308@cn.fujitsu.com> <CAErSpo6aGiuBbgcVfcduPk++7B_zzuk2Y+fjLiJBvdOqnU+Qmw@mail.gmail.com> <5122F276.80807@cn.fujitsu.com> <CAErSpo7BeCiKHecJgX9GBR7DYf4M9mrXK+qMLMDXFykxq5C7sQ@mail.gmail.com> <512AFDB7.5030105@cn.fujitsu.com> <CAL-B5D0xN6bs3oXugS9FOS5bQiFRJQ9766u5wsXw4UQdUmwfyw@mail.gmail.com> <512DAAC9.8030400@cn.fujitsu.com> <CAE9FiQU6Sj=wkare0VCJwP1Yr09o=xVMrhsY_xJ1_41=YMkwMg@mail.gmail.com> <512F35D3.6080009@cn.fujitsu.com> <CAE9FiQV2=B-qw7SSXRL7wj6F=3O7tXnX3JbLXCtrk62nV=MOfA@mail.gmail.com>
In-Reply-To: <CAE9FiQV2=B-qw7SSXRL7wj6F=3O7tXnX3JbLXCtrk62nV=MOfA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/28/2013 11:11 PM, Yinghai Lu wrote:

> On Thu, Feb 28, 2013 at 2:47 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>> On 02/27/2013 02:47 PM, Yinghai Lu wrote:
>>
>>> On Tue, Feb 26, 2013 at 10:42 PM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>>>>     I just agree with Bjorn's analysis. And I have test Yinghai's patch on kernel 3.8
>>>> , but it seems does not work. More infos, please refer to bugzilla:
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=54411
>>>
>>> you need to test that on linus's tree of 2013-02-26.
>>> or v3.9-rc1
>>
>> Hi Yinghai,
>>         I test your patch on linus' tree of 2-26
>> commit d895cb1af15c04c522a25c79cc429076987c089b
>> But it still does not work~
> 
> Still have full of warning in dmesg?

> or double remove does not work.

No, there is no warning in dmesg on booting, just concurrent removal does not work!

Thanks,
Gu

> 
> Thanks
> 
> Yinghai
> 



Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:54083
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753522Ab2FUN3Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 09:29:16 -0400
Message-ID: <4FE32130.20706@amd.com>
Date: Thu, 21 Jun 2012 15:27:12 +0200
From: Wei Wang <wei.wang2@amd.com>
MIME-Version: 1.0
To: Jan Beulich <JBeulich@suse.com>
CC: SherryHurwitz <sherry.hurwitz@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>, <stable@kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	KonradRzeszutek Wilk <konrad.wilk@oracle.com>,
	<linux-pci@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	<ebiederm@xmission.com>
Subject: Re: [PATCH] PCI/MSI: don't disable AMD IOMMU MSI on Xen dom0
References: <4FD72FE4.80009@amd.com> <4FD778C802000078000897EF@nat28.tlf.novell.com> <4FD76976.2020203@citrix.com> <4FD78DE6020000780008986D@nat28.tlf.novell.com> <4FD9D559.9050206@amd.com> <4FDA0ECD0200007800089FEA@nat28.tlf.novell.com> <4FDA0028.3090609@amd.com> <4FE30CBB020000780008B06B@nat28.tlf.novell.com> <4FE303C4.3060705@amd.com> <4FE32A81020000780008B11B@nat28.tlf.novell.com> <4FE31385.3060502@amd.com> <4FE3337C020000780008B177@nat28.tlf.novell.com> <4FE31D5A.7060701@amd.com> <4FE33CB9020000780008B1C4@nat28.tlf.novell.com>
In-Reply-To: <4FE33CB9020000780008B1C4@nat28.tlf.novell.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/21/2012 03:24 PM, Jan Beulich wrote:
>>>> On 21.06.12 at 15:10, Wei Wang<wei.wang2@amd.com>  wrote:
>> On 06/21/2012 02:45 PM, Jan Beulich wrote:
>>>>>> On 21.06.12 at 14:28, Wei Wang<wei.wang2@amd.com>   wrote:
>>>> AMD IOMMU is an independent pci-e endpoint, and this function will not
>>>> be used for other purposes other than containing an iommu. So I don't
>>>> see that iommu will share bdf value with other devices.
>>>
>>> The question is not regarding bdf, but regarding whether under
>>> the same seg:bus:dev there might be multiple functions, one of
>>> which is the IOMMU, and if so, whether the IOMMU would be
>>> guaranteed to have a non-zero function number.
>>
>> In a real system (single or multiple iommu), amd iommu shares the same
>> device number with north bridge but has function number 2.. (e.g
>> bus:00.2) Howerver according to spec, it does not guaranteed to have
>> non-zero function number. So what is the problem you see if iommu uses
>> fun0 on a multi-func device?
>
> If it's on func 0 and gets hidden completely (as done by your
> partial patch), other functions won't be found when scanning
> for them (because secondary functions get looked at only
> when func 0 actually exists, as otherwise evaluating the header
> type register is invalid).

OK, understood. Then I think we do need to allow pci cfg read for iommu 
device.

Thanks
Wei

> Jan
>
>



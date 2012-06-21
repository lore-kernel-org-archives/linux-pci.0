Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:53492 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752464Ab2FUNM5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 09:12:57 -0400
Message-ID: <4FE31D5A.7060701@amd.com>
Date: Thu, 21 Jun 2012 15:10:50 +0200
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
References: <4FD72FE4.80009@amd.com> <4FD778C802000078000897EF@nat28.tlf.novell.com> <4FD76976.2020203@citrix.com> <4FD78DE6020000780008986D@nat28.tlf.novell.com> <4FD9D559.9050206@amd.com> <4FDA0ECD0200007800089FEA@nat28.tlf.novell.com> <4FDA0028.3090609@amd.com> <4FE30CBB020000780008B06B@nat28.tlf.novell.com> <4FE303C4.3060705@amd.com> <4FE32A81020000780008B11B@nat28.tlf.novell.com> <4FE31385.3060502@amd.com> <4FE3337C020000780008B177@nat28.tlf.novell.com>
In-Reply-To: <4FE3337C020000780008B177@nat28.tlf.novell.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/21/2012 02:45 PM, Jan Beulich wrote:
>>>> On 21.06.12 at 14:28, Wei Wang<wei.wang2@amd.com>  wrote:
>> On 06/21/2012 02:06 PM, Jan Beulich wrote:
>>>>>> On 21.06.12 at 13:21, Wei Wang<wei.wang2@amd.com>   wrote:
>>>> I also evaluated the possibility of hiding iommu device from dom0. I
>>>> think the change is no quite a lot, at least, for io based pcicfg
>>>> access. A proof-of-concept patch is attached.
>>>
>>> This completely hides the device from Dom0, but only when
>>> config space is accessed via method 1. Did you not see my
>>> earlier patch doing this for MCFG as well
>> Could you please provide a particular c/s number?... (I saw too many c/s
>> might be related to this topic). so that I could work out a patch to
>> support both i/o and mmcfg.
>
> I sent this to you yesterday, so you'd be able to test whether
> it actually fulfills its purpose before we discuss whether this is
> acceptable for 4.2. See
> http://lists.xen.org/archives/html/xen-devel/2012-06/msg01129.html

Oh, yes I found it, my email filter did not work well so I did not see 
it at the right folder. I will test right now.

>
>> (albeit only disallowing
>>> writes, so allowing the device to still be seen by Dom0)?
>> Sounds better to me...this still allows user to check iommu status from
>> lspci.
>>
>>> Whether completely hiding the device is actually okay I can't
>>> easily tell: Would IOMMUs always be either at func 0 of a single-
>>> unction device, or at a non-zero func of a multi-function one? If
>>> not, other devices may get hidden implicitly.
>>
>> AMD IOMMU is an independent pci-e endpoint, and this function will not
>> be used for other purposes other than containing an iommu. So I don't
>> see that iommu will share bdf value with other devices.
>
> The question is not regarding bdf, but regarding whether under
> the same seg:bus:dev there might be multiple functions, one of
> which is the IOMMU, and if so, whether the IOMMU would be
> guaranteed to have a non-zero function number.

In a real system (single or multiple iommu), amd iommu shares the same 
device number with north bridge but has function number 2.. (e.g 
bus:00.2) Howerver according to spec, it does not guaranteed to have 
non-zero function number. So what is the problem you see if iommu uses 
fun0 on a multi-func device?

Thanks,
Wei

> Jan
>
>



Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:46742 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab1KJHjW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2011 02:39:22 -0500
Message-ID: <4EBB7F9B.8050703@jp.fujitsu.com>
Date: Thu, 10 Nov 2011 16:39:07 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai.lu@oracle.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH] pciehp: Wait for link get trained in pci_check_link_status()
References: <4EB88238.4050409@oracle.com> <4EB8F434.6090003@jp.fujitsu.com> <4EB94A51.6070809@oracle.com> <4EB9A50D.1040302@oracle.com>
In-Reply-To: <4EB9A50D.1040302@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(2011/11/09 6:54), Yinghai Lu wrote:
> On 11/08/2011 07:27 AM, Yinghai Lu wrote:
>
>> On 11/08/2011 01:19 AM, Kenji Kaneshige wrote:
>>>
>>> What about the patch below? I think it's much simpler and has less impact.
>>
>> Should work. will try it today.
>
>
> yes, that works too.
>
> Thanks
>
> Yinghai
>

I updated the patch with description. I split it into two and
a logic is a little changed. Could you check these?

Regards,
Kenji Kaneshige


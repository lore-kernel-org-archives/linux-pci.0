Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:35600 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab1KKReD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2011 12:34:03 -0500
Message-ID: <4EBD5C6C.9010606@oracle.com>
Date: Fri, 11 Nov 2011 09:33:32 -0800
From: Yinghai Lu <yinghai.lu@oracle.com>
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Greg KH <gregkh@suse.de>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] pciehp: wait 100 ms after Link Training check
References: <4EB88238.4050409@oracle.com>	<4EB8F434.6090003@jp.fujitsu.com>	<4EB94A51.6070809@oracle.com>	<4EB9A50D.1040302@oracle.com>	<4EBB7F9B.8050703@jp.fujitsu.com>	<4EBB8058.6090500@jp.fujitsu.com>	<4EBC21C0.5070806@oracle.com> <20111111093212.3cceee91@jbarnes-desktop>
In-Reply-To: <20111111093212.3cceee91@jbarnes-desktop>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/11/2011 09:32 AM, Jesse Barnes wrote:

> On Thu, 10 Nov 2011 11:10:56 -0800
> Yinghai Lu <yinghai.lu@oracle.com> wrote:
> 
>> On 11/09/2011 11:42 PM, Kenji Kaneshige wrote:
>>
>>> If the port supports Link speeds greater than 5.0 GT/s, we must wait
>>> for 100 ms after Link training completes before sending configuration
>>> request.
>>>
>>> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>>
>>
>>
>> Acked-by: Yinghai Lu <yinghai@kernel.org>
>> Tested-by: Yinghai Lu <yinghai@kernel.org>
> 
> Applied these two to my for-linus branch, thanks guys.
> 


Thanks, We may need to put them into stable too.

Yinghai

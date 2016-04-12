Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36418 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbcDLToW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2016 15:44:22 -0400
Subject: Re: Hot reset in downstream direction (RC to EP)
To: L H <swdevgid@gmail.com>
References: <570827D5.5060201@ti.com>
 <CAA8O7CpAB18JOC6ri9xf_hnrKqRAjv5TdPO1cEHfd+98BhhV7A@mail.gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <570D5025.4080905@ti.com>
Date: Tue, 12 Apr 2016 15:44:37 -0400
MIME-Version: 1.0
In-Reply-To: <CAA8O7CpAB18JOC6ri9xf_hnrKqRAjv5TdPO1cEHfd+98BhhV7A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/12/2016 02:28 PM, L H wrote:
> I've never observed a hot reset during enumeration.  One of the
> possible triggers for the RC to issue a hot reset is after receipt of
> a fatal AER message (assuming AER is enabled).
> 
Lance,

Ok. Thanks for the response.

Murali

> Lance
> 
> On Fri, Apr 8, 2016 at 4:51 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>> I see that hot reset is something the RC port initiate to have EP reset
>> through link management.
>>
>> ==========================================================================
>> PCIe reset sequences – The PCI Express protocol specifies a hot reset
>> mechanism, where downstream components reset through link notification.
>> Root ports should validate that this mechanism can be applied and the
>> hot reset indication is properly detected by a remote device.
>> Endpoint applications should determine the level of chip reset desired
>> in case of hot reset detection on the link to validate proper functionality.
>> ===========================================================================
>>
>> Does this happen during the enumeration? As this goes in in band, the EP's
>> link should be up. Can someone tell me what are the triggering points for
>> this from RC to EP? Does Linux RC support this? It is supposed to a bit
>> in RC's bridge configuration space that triggers this reset.
>>
>> --
>> Murali Karicheri
>> Linux Kernel, Keystone
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Murali Karicheri
Linux Kernel, Keystone

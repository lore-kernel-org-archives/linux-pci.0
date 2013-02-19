Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:35854 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758628Ab3BSKIB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Feb 2013 05:08:01 -0500
Message-ID: <51234EE2.6050807@cn.fujitsu.com>
Date: Tue, 19 Feb 2013 18:07:30 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: Wei Yang <weiyang@linux.vnet.ibm.com>,
	Oliver Neukum <oneukum@suse.de>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pciehp: errors on resume
References: <1359377173.1345.25.camel@x61.thuisdomein>  <512336fb.42d70e0a.73ed.ffffc77eSMTPIN_ADDED_BROKEN@mx.google.com> <1361266095.26423.19.camel@x61.thuisdomein>
In-Reply-To: <1361266095.26423.19.camel@x61.thuisdomein>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/19/2013 05:28 PM, Paul Bolle wrote:

> Richard,
> 
> On Tue, 2013-02-19 at 16:25 +0800, Wei Yang wrote:
>> Sorry for bothering, I am looking at this and try to understand the process, 
>> while get some confusion.
>>
>> 1. The error log will be printed every time suspend/resume, no matter whether
>>    the device is plug in/plug out during the suspend as discussed below?
>>
>>    If the device is always there, no one touch it, the error message still be
>>    printed?
>>
>> 2. In my mind, before the pcied_init is called, those pci_dev are
>>    already enumerated, such as the wireless card in this case. 
>>
>>    During the boot stage, if the pciehp_force is set to true, the error messge
>>    still be printed? Since I don't have those devices to create pcie_device, I
>>    can't test this.
>>
>> 3. Do you think it would be find to remove those devices at the suspend stage?
>>    Then they will be added again at the resume stage?
> 
> Bypassing your questions, I'd like to point you at
> http://article.gmane.org/gmane.linux.kernel.pci/20077 , in which Rafael
> suggested a possible solution to this situation. (There's some extra
> info in other messages in this thread.)


Yes, Rafael's suggestion seems a possible solution to this situation.
In my mind, it's impossible to figure out a unique pci device with
the registers in the PCI config space, something like "vender_id + device_id"
can not describe a unique device.
The pcie device has a feature likes "series number" which could be used to figure
out a unique one, but this feature is optional. If it's not set, we still
can not detect a unique pcie device.
Sorry for my poor knowledge, if what I said has any mistake, please figure it out!:)

Thanks,
Gu 

 


> I must confess that I'm not at all sure how to implement it and that so
> far I have, rather cowardly, not even drafted a solution along those
> lines.
> 
> 
> Paul Bolle
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



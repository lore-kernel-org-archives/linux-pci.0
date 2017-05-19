Return-Path: <SRS0=JHWj=4Z=redhat.com=vkuznets@kernel.org>
Return-Path: <SRS0=JHWj=4Z=redhat.com=vkuznets@kernel.org>
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Jork Loeser <Jork.Loeser@microsoft.com>, kys@microsoft.com
Cc: Stephen Hemminger <stephen@networkplumber.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "helgaas\@kernel.org" <helgaas@kernel.org>,  "olaf\@aepfle.de" <olaf@aepfle.de>,  Stephen Hemminger <sthemmin@microsoft.com>,  "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,  "jasowang\@redhat.com" <jasowang@redhat.com>,  "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,  "marcelo.cerri\@canonical.com" <marcelo.cerri@canonical.com>,  "apw\@canonical.com" <apw@canonical.com>,  "devel\@linuxdriverproject.org" <devel@linuxdriverproject.org>,  "leann.ogasawara\@canonical.com" <leann.ogasawara@canonical.com>
Subject: Re: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
	<1495134870-18225-5-git-send-email-jloeser@linuxonhyperv.com>
	<20170518165854.46fd92fa@xeon-e3>
	<CY4PR21MB06313801D2312E9686F3520AF1E50@CY4PR21MB0631.namprd21.prod.outlook.com>
Date: Fri, 19 May 2017 12:03:04 +0200
In-Reply-To: <CY4PR21MB06313801D2312E9686F3520AF1E50@CY4PR21MB0631.namprd21.prod.outlook.com>
	(Jork Loeser's message of "Fri, 19 May 2017 02:13:55 +0000")
Message-ID: <87k25dupt3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Jork Loeser <Jork.Loeser@microsoft.com> writes:

>> -----Original Message-----
>> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
>> Sent: Thursday, May 18, 2017 16:59
>> 
>> > From: Jork Loeser <jloeser@microsoft.com>
>> >
>> > Update the Hyper-V vPCI driver to use the Server-2016 version of the
>> > vPCI protocol, fixing MSI creation and retargeting issues.
>> >
>> > Signed-off-by: Jork Loeser <jloeser@microsoft.com>
>> 
>> This patch conflicts with already submitted patch that removes
>> vmbus_cpu_number_to_vp_number()
>> 
>> commit 4b28e5c28cc32652d200a31795e38ee6c819a4a2
>> Author: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Date:   Mon May 15 13:38:26 2017 -0700
>> 
>>     hyper-v: globalize vp_index
>> 
>>     To support implementing remote TLB flushing on Hyper-V with a hypercall
>>     we need to make vp_index available outside of vmbus module. Rename and
>>     globalize.
>
> Thank you Stephen, easy enough to adapt. 
>
> Bjorn, Greg, Vitaly: Do you have an ETA on when Vitaly's patch will be in the PCI or linux-next branch so I can rev?
>

I was a bit surprised to see that these patches missed 4.12, K. Y. ACKed
them:

http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2017-May/105466.html

and no other concerns were expressed.

To my understanding these patches should go through Greg's char-misc
tree. K. Y., Greg, please let me know if I need to rebase/resend.

-- 
  Vitaly

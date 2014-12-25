Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:41647 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaLYPqH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Dec 2014 10:46:07 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so15709130wid.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2014 07:46:05 -0800 (PST)
Message-ID: <549C313A.7090504@gmail.com>
Date: Thu, 25 Dec 2014 16:46:02 +0100
From: =?windows-1252?Q?Marek_Kord=EDk?= <kordikmarek@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
References: <CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>	<1418074683.13358.1.camel@kernel.crashing.org>	<CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>	<20141208233855.GA15713@shangw>	<CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>	<20141220002306.GB30834@google.com>	<CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>	<CAErSpo7JAcLa_2gNkOG+oSHb1cbBXdEa-TVW0=amBptRB8-fNA@mail.gmail.com>	<CAE9FiQV6nxeMcLQ6YBR_c5tNGGjiKgL+Z4vcGpK21j-14V8SKw@mail.gmail.com>	<CAE9FiQVggbU5u__0z8p33J9hQ39CtQ-vpQbZyjG-LO9aqN05Lw@mail.gmail.com>	<20141223214106.GA27291@google.com> <CAE9FiQUoA_vz78sEnHtDAmzTJcwL0PdUe9jwLw+H9h3+omq+WA@mail.gmail.com>
In-Reply-To: <CAE9FiQUoA_vz78sEnHtDAmzTJcwL0PdUe9jwLw+H9h3+omq+WA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/24/2014 03:29 AM, Yinghai Lu wrote:
> On Tue, Dec 23, 2014 at 1:41 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>>
>> Can you do this so it clips to any upstream bridge, whether it's a host
>> bridge or a PCI-to-PCI bridge?  It doesn't seem like this has to be
>> specific to host bridge windows -- any device below a PCI-to-PCI bridge has
>> to use address space forwarded by that upstream bridge.
>
> ok, please check attached v2.
>
>>
>> I wish this were in generic code.  There's nothing architecture-specific
>> about the problem, but this patch only fixes things on x86.  Can you make a
>> similar change in the corresponding code for other arches, as well?
>
> ok, later after x86.
>
> Thanks
>
> Yinghai
>

I checked (only) v2 of your patch on versions 3.18.0 and 3.18.1. The 
result of both versions is that booting stops with kernel panic. I don't 
how to get the full log (there is nothing in journalctl and dmesg after 
booting some working kernel - maybe if you can give me some hint what to 
google) so I will attach photo of screen to the bugzilla issue.

Marek

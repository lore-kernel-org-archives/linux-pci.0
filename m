Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:39160 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263Ab2G3Q5f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jul 2012 12:57:35 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: huang ying <huang.ying.caritas@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	<87r4s0opck.fsf@nemi.mork.no> <87pq7ko532.fsf@nemi.mork.no>
	<1343190864.10311.26.camel@yhuang-dev> <87k3xskvqq.fsf@nemi.mork.no>
	<CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
	<874now7xi8.fsf@nemi.mork.no> <1343292851.3874.12.camel@yhuang-dev>
	<87k3xqyfm3.fsf@nemi.mork.no> <1343367309.3874.21.camel@yhuang-dev>
	<87sjcd4lgs.fsf@nemi.mork.no> <1343618131.3874.37.camel@yhuang-dev>
	<871ujtr7rz.fsf@nemi.mork.no>
	<CAC=cRTO7A2MSWX9hV3sR2xpJc5+c2-0+QhsyM0gURFhLfnNW-A@mail.gmail.com>
Date: Mon, 30 Jul 2012 18:57:23 +0200
In-Reply-To: <CAC=cRTO7A2MSWX9hV3sR2xpJc5+c2-0+QhsyM0gURFhLfnNW-A@mail.gmail.com>
	(huang ying's message of "Mon, 30 Jul 2012 21:31:39 +0800")
Message-ID: <873949p4p8.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

huang ying <huang.ying.caritas@gmail.com> writes:

> On Mon, Jul 30, 2012 at 4:08 PM, Bjørn Mork <bjorn@mork.no> wrote:
>> Huang Ying <ying.huang@intel.com> writes:
>>
>>> Do you have time to test the following patch to fix the lspci issue?
>>>
>>> Subject: [BUGFIX] PCI/PM: Keep parent bridge active when read/write config reg
>>
>>
>> Sure.  But keep this going and I will file a request for modular build
>> of the PCI subsystem :-)
>
> Why?  All not so old PC hardware has PCI/PCIe devices.

So that I didn't have to reboot all the time to test your new patches...

It was a (bad) joke.  I don't really think my laptop would work all that
well without PCI.


Bjørn

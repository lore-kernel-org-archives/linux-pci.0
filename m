Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38349 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753761Ab2G3Nbk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Jul 2012 09:31:40 -0400
MIME-Version: 1.0
In-Reply-To: <871ujtr7rz.fsf@nemi.mork.no>
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	<87r4s0opck.fsf@nemi.mork.no>
	<87pq7ko532.fsf@nemi.mork.no>
	<1343190864.10311.26.camel@yhuang-dev>
	<87k3xskvqq.fsf@nemi.mork.no>
	<CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
	<874now7xi8.fsf@nemi.mork.no>
	<1343292851.3874.12.camel@yhuang-dev>
	<87k3xqyfm3.fsf@nemi.mork.no>
	<1343367309.3874.21.camel@yhuang-dev>
	<87sjcd4lgs.fsf@nemi.mork.no>
	<1343618131.3874.37.camel@yhuang-dev>
	<871ujtr7rz.fsf@nemi.mork.no>
Date: Mon, 30 Jul 2012 21:31:39 +0800
Message-ID: <CAC=cRTO7A2MSWX9hV3sR2xpJc5+c2-0+QhsyM0gURFhLfnNW-A@mail.gmail.com>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
From: huang ying <huang.ying.caritas@gmail.com>
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: Huang Ying <ying.huang@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2012 at 4:08 PM, Bjørn Mork <bjorn@mork.no> wrote:
> Huang Ying <ying.huang@intel.com> writes:
>
>> Do you have time to test the following patch to fix the lspci issue?
>>
>> Subject: [BUGFIX] PCI/PM: Keep parent bridge active when read/write config reg
>
>
> Sure.  But keep this going and I will file a request for modular build
> of the PCI subsystem :-)

Why?  All not so old PC hardware has PCI/PCIe devices.

Best Regards,
Huang Ying

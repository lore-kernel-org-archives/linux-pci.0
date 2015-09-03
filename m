Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36511 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572AbbICOxL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Sep 2015 10:53:11 -0400
Received: by wibz8 with SMTP id z8so101885404wib.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2015 07:53:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20150903T113710-656@post.gmane.org>
References: <loom.20150831T091131-859@post.gmane.org> <CAE9FiQWNA1BEGom757xtbc0zFjFqZ9uqKwj2kM7EFDDKXEL6fw@mail.gmail.com>
 <loom.20150901T110001-176@post.gmane.org> <CAE9FiQUxU2FCxFKQ=6ZdnJL8fU-YxAOjQmMSAP_YBG1gEG+ntA@mail.gmail.com>
 <loom.20150902T084450-322@post.gmane.org> <CAE9FiQWgrymUN07D5rFr0XVrF1Ays606JaWQCfH47Av0cv8q0g@mail.gmail.com>
 <loom.20150903T080202-734@post.gmane.org> <loom.20150903T113710-656@post.gmane.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Sep 2015 09:52:50 -0500
Message-ID: <CAErSpo6KYCM99H5J0JvYymNmbn-O1NfVwo4Lp7B=2cXCFQwnOw@mail.gmail.com>
Subject: Re: PCI rescan : can't assign mem [SOLVED]
To: Peio <peio@azkarate.eu>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 3, 2015 at 4:45 AM, Peio <peio@azkarate.eu> wrote:
> Peio <peio <at> azkarate.eu> writes:
>
>>
>> Yinghai Lu <yinghai <at> kernel.org> writes:
>>
>> > boot with pci=nocrs ?
>> >
>> > Try to get BIOS update.
>> >
>> > > If I change BIOS parameters I'll need a fresh install or the actual
> kernel
>> > > reconigzes changes?.
>> > should not.
>> >
>>
>> I'll try pci=nocrs and BIOS update.
>> Thank you Yinghai.
>>
>>
> I solved the issue.
>
> 1.- Boot kernel with pci=nocrs parameter (linux assigns lot of memory ro pci
> root bus).
>
> 2.- Remove upstream bridge :
> sudo echo 1 > /sys/bus/pci/devices/0000:00:1c.0/remove
>
> 3.- Rescan PCI bus
> sudo echo 1 > /sys/bus/pci/rescan

This is a workaround, not a solution.  It is not safe to use
"pci=nocrs" in general because it can break things related to resource
assignment, including hot-add of new devices.

I haven't looked at the problem in detail, but if the BIOS gives us a
_CRS with host bridge windows that are too small to accommodate all
your devices, there's really nothing the kernel can do about it.  You
just have to regard it as a limitation of that platform.

Bjorn

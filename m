Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45298 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab2FSC5Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jun 2012 22:57:16 -0400
Received: by dady13 with SMTP id y13so7765643dad.19
        for <linux-pci@vger.kernel.org>; Mon, 18 Jun 2012 19:57:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120619014642.GA2310@ram-ThinkPad-T61>
References: <20120618050333.GA13469@ram-ThinkPad-T61>
	<CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
	<20120619014642.GA2310@ram-ThinkPad-T61>
Date: Mon, 18 Jun 2012 19:57:16 -0700
Message-ID: <CAE9FiQUAGfXppTWwgbCEui9jFd3f75Fi4X-AvUkT0z3TNuqwyw@mail.gmail.com>
Subject: Re: [RFC PATCH] methods to access resources of a struct pci_dev
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 18, 2012 at 6:46 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Mon, Jun 18, 2012 at 11:30:13AM -0700, Yinghai Lu wrote:
>> I have patchset on this, please check
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>>  for-pci-for-each-res-addon
>>
>
>
> Amazing, when are you pushing those patches in?  Looks like you have
> patches for everything :)
>
> Do you also have patches that change all the places that directly access
> the ->resource structure?

maybe not. could still have some left over.

>
> Also does Bjorn pull regularly from your tree?  Is making patches
> against your tree the right approach?

No.

Bjorn will get patches from my branch and have to update change log at least.
and then into pci/next.

current still have several branch in the waiting list
for-pci-res-alloc
for-pci-busn-alloc
for-pci-root-bus-hotplug
for-pci-for-each-res-addon

also for-x86-irq and for-iommu are for pci root bus hotplug related too, but
need to push them to tip pci related get merged.

Current status: for-pci-busn-alloc is pending with
http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=patch;h=b00469b377231ebe0b76248ec6d1866b51966c97
Bjorn thought that is too complicated.

Thanks

Yinghai

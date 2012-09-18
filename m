Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50844 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622Ab2IRAD5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2012 20:03:57 -0400
Received: by bkwj10 with SMTP id j10so2825574bkw.19
        for <linux-pci@vger.kernel.org>; Mon, 17 Sep 2012 17:03:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120904032717.GD2438@ram-ThinkPad-T61>
References: <20120822101533.GA2332@ram-ThinkPad-T61>
	<CAE9FiQVDkzFkjrBrZC9JpLW7JoquE_f-5BKGrbmmZMHFVcw=cw@mail.gmail.com>
	<CAE9FiQW5KkgszD2F4aez-jtXABkiPmUDVqTiFF8MDNKxWLopxA@mail.gmail.com>
	<CAE9FiQXyVB5AGGOd+a-SatL+dEo7Nvx=zPswtZ1QLk5QSLMm4Q@mail.gmail.com>
	<20120823050958.GB2332@ram-ThinkPad-T61>
	<CAE9FiQVq=6Shv_4taNzN3h4OBs1PgoFJZqV0i3tRvmz04qZbXw@mail.gmail.com>
	<20120827073335.GE20843@ram-ThinkPad-T61>
	<CAE9FiQVEuH=ZwL4R+wyO0H0853hQ8bpGBYKQJwkAJ5g7FKtY7g@mail.gmail.com>
	<20120903090821.GC2438@ram-ThinkPad-T61>
	<CAE9FiQV+_cuDV1WqVZK5SO4JYuJ8_=Gj3qG3Rz9bJsGhUSLV4w@mail.gmail.com>
	<20120904032717.GD2438@ram-ThinkPad-T61>
Date: Mon, 17 Sep 2012 17:03:56 -0700
Message-ID: <CAE9FiQVWdXed+v20Y-m6QeSpJ1H1F6yP9BVu5v=5PBM4mr=kog@mail.gmail.com>
Subject: Re: [RFC PATCH v3 ]pci: pci resource iterator
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 3, 2012 at 8:27 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Mon, Sep 03, 2012 at 11:20:45AM -0700, Yinghai Lu wrote:
>> On Mon, Sep 3, 2012 at 2:08 AM, Ram Pai <linuxram@us.ibm.com> wrote:
>> > On Mon, Sep 03, 2012 at 01:07:46AM -0700, Yinghai Lu wrote:
>> >
>> > Anyway I am ok with either patch.
>>
>> please check -v7.
>
> Looks good to me. I am inlining the patch for others to comment.
> BTW: your patch that introduces pci_dev_resource_n() will have
> to be applied before applying this patch.
>
>

just updated for-pci-for-each-res-addon branch...

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-for-each-res-addon

now it only depends on pci-root-bus-hotplug now, and
pci-root-bus-hotplug only depends on pci/next without busn-alloc.

So after Bjorn accept pci-root-bus-hotplug, we could push that to him.

Please check for-pci-for-each-addon branch.
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-for-each-res-addon

Thanks

Yinghai

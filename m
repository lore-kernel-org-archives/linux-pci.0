Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59294 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab2IUG1W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2012 02:27:22 -0400
Received: by bkuw11 with SMTP id w11so601281bku.19
        for <linux-pci@vger.kernel.org>; Thu, 20 Sep 2012 23:27:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120921061833.GC2401@ram-ThinkPad-T61>
References: <CAE9FiQW5KkgszD2F4aez-jtXABkiPmUDVqTiFF8MDNKxWLopxA@mail.gmail.com>
	<CAE9FiQXyVB5AGGOd+a-SatL+dEo7Nvx=zPswtZ1QLk5QSLMm4Q@mail.gmail.com>
	<20120823050958.GB2332@ram-ThinkPad-T61>
	<CAE9FiQVq=6Shv_4taNzN3h4OBs1PgoFJZqV0i3tRvmz04qZbXw@mail.gmail.com>
	<20120827073335.GE20843@ram-ThinkPad-T61>
	<CAE9FiQVEuH=ZwL4R+wyO0H0853hQ8bpGBYKQJwkAJ5g7FKtY7g@mail.gmail.com>
	<20120903090821.GC2438@ram-ThinkPad-T61>
	<CAE9FiQV+_cuDV1WqVZK5SO4JYuJ8_=Gj3qG3Rz9bJsGhUSLV4w@mail.gmail.com>
	<20120904032717.GD2438@ram-ThinkPad-T61>
	<CAE9FiQVWdXed+v20Y-m6QeSpJ1H1F6yP9BVu5v=5PBM4mr=kog@mail.gmail.com>
	<20120921061833.GC2401@ram-ThinkPad-T61>
Date: Thu, 20 Sep 2012 23:27:20 -0700
Message-ID: <CAE9FiQXwNtpoHvJ7SxFvSHxj599kjNe8tcN_cGchZMaX74fzXA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 ]pci: pci resource iterator
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 20, 2012 at 11:18 PM, Ram Pai <linuxram@us.ibm.com> wrote:

> Checked and the patch looks good.
>
> But later you have added another patch which introduces lot many macros ...
>
> Will that patch also be pushed to Bjorn? I thought Bjorn resisted the
> idea of having multiple such iterators..

no. I removed that patches 3 days ago...

please check it again.

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-for-each-res-addon

-Yinghai

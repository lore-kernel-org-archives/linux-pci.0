Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:50991 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab2IUGSk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2012 02:18:40 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Fri, 21 Sep 2012 00:18:40 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 193E73E4003D
	for <linux-pci@vger.kernel.org>; Fri, 21 Sep 2012 00:18:36 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q8L6IbZk211596
	for <linux-pci@vger.kernel.org>; Fri, 21 Sep 2012 00:18:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q8L6Iaao006767
	for <linux-pci@vger.kernel.org>; Fri, 21 Sep 2012 00:18:37 -0600
Date: Fri, 21 Sep 2012 14:18:33 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v3 ]pci: pci resource iterator
Message-ID: <20120921061833.GC2401@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVWdXed+v20Y-m6QeSpJ1H1F6yP9BVu5v=5PBM4mr=kog@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2012 at 05:03:56PM -0700, Yinghai Lu wrote:
> On Mon, Sep 3, 2012 at 8:27 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> > On Mon, Sep 03, 2012 at 11:20:45AM -0700, Yinghai Lu wrote:
> >> On Mon, Sep 3, 2012 at 2:08 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> >> > On Mon, Sep 03, 2012 at 01:07:46AM -0700, Yinghai Lu wrote:
> >> >
> >> > Anyway I am ok with either patch.
> >>
> >> please check -v7.
> >
> > Looks good to me. I am inlining the patch for others to comment.
> > BTW: your patch that introduces pci_dev_resource_n() will have
> > to be applied before applying this patch.
> >
> >
> 
> just updated for-pci-for-each-res-addon branch...
> 
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-for-each-res-addon
> 
> now it only depends on pci-root-bus-hotplug now, and
> pci-root-bus-hotplug only depends on pci/next without busn-alloc.
> 
> So after Bjorn accept pci-root-bus-hotplug, we could push that to him.
> 
> Please check for-pci-for-each-addon branch.
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci-for-each-res-addon

Checked and the patch looks good. 

But later you have added another patch which introduces lot many macros ...

Will that patch also be pushed to Bjorn? I thought Bjorn resisted the
idea of having multiple such iterators..

This is the patch I am talking about:

commit a37fbc4685ab086581f9842630c997ca78186ea4
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Mon Sep 3 00:32:00 2012 -0700

PCI: Add for_each_resource helpers to make resource loop easier.
 
+#define resno_is_for_bridge(n)                                        \ 
+       ((n) >= PCI_BRIDGE_RESOURCES && (n) <= PCI_BRIDGE_RESOURCE_END)
+
+/* all (include bridge) resources */
+#define for_each_pci_dev_all_resource(dev, res, i)                     \
	+ for_each_pci_resource(dev, res, i, PCI_ALL_RES)
	.......
	......

-- 
Ram Pai


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:47239 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab2FSBqy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jun 2012 21:46:54 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Mon, 18 Jun 2012 19:46:53 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5608F3E40051
	for <linux-pci@vger.kernel.org>; Tue, 19 Jun 2012 01:46:49 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5J1knic147370
	for <linux-pci@vger.kernel.org>; Mon, 18 Jun 2012 19:46:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5J1knZW016780
	for <linux-pci@vger.kernel.org>; Mon, 18 Jun 2012 19:46:49 -0600
Date: Tue, 19 Jun 2012 09:46:42 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] methods to access resources of a struct pci_dev
Message-ID: <20120619014642.GA2310@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120618050333.GA13469@ram-ThinkPad-T61>
 <CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 18, 2012 at 11:30:13AM -0700, Yinghai Lu wrote:
> On Sun, Jun 17, 2012 at 10:03 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> > PCI: methods to access resources of struct pci_dev
> >
> > Currently pci_dev structure holds an array of 17 PCI resources; six base
> > BARs, one ROM BAR, four BRIDGE BARs, six sriov BARs.  This is wasteful.
> > A bridge device just needs the 4 bridge resources. A non-bridge device
> > just needs the six base resources and one ROM resource. The sriov
> > resources are needed only if the device has SRIOV capability.
> >
> > The pci_dev structure needs to be re-organized to avoid unnecessary
> > bloating.  However too much code outside the pci-bus driver, assumes the
> > internal details of the pci_dev structure, thus making it hard to
> > re-organize the datastructure.
> >
> > As a first step this patch provides generic methods to access the
> > resource structure of the pci_dev.
> >
> > Once this patch is accepted, I have another 40+ patches that modify all
> > the files that directly access the resource structure, to use the new
> > methods provided in the first step.
> >
> > Finally we can re-organize the resource structure in the pci_dev
> > structure and correspondingly update the methods.
> 
> I have patchset on this, please check
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>  for-pci-for-each-res-addon
> 


Amazing, when are you pushing those patches in?  Looks like you have
patches for everything :)

Do you also have patches that change all the places that directly access
the ->resource structure?

Also does Bjorn pull regularly from your tree?  Is making patches
against your tree the right approach?

RP


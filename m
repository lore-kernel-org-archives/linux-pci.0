Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:44017 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab2AOQGM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2012 11:06:12 -0500
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Sun, 15 Jan 2012 09:06:11 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q0FG69nQ150990
	for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2012 09:06:09 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q0FG681T003661
	for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2012 09:06:09 -0700
Date: Mon, 16 Jan 2012 00:05:58 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
Message-ID: <20120115160558.GA2601@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
 <1323247984-15281-3-git-send-email-yinghai@kernel.org>
 <20120113163922.GH7380@ram-ThinkPad-T61>
 <CAE9FiQWTVA=LDViVyfSXX6thgGv4TzOpqidVyG6FAdWQqAMWEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQWTVA=LDViVyfSXX6thgGv4TzOpqidVyG6FAdWQqAMWEg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 13, 2012 at 03:28:29PM -0800, Yinghai Lu wrote:
> On Fri, Jan 13, 2012 at 8:39 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> > On Wed, Dec 07, 2011 at 12:53:01AM -0800, Yinghai Lu wrote:
> >
> >        I am worried that this approach will resurface old bug
> > https://bugzilla.kernel.org/show_bug.cgi?id=15960
> 
> will ask them to test for-pci2 branch.
> 
> >
> >        With your approach; on a system with not enough resources to satisfy
> > all the devices, when you fail to allocate 'required+optional' in the first
> > round and fall back to assigning only the 'required' resources, you can get the
> > reassignment order wrong, thus not allocate resources to devices for which the
> > BIOS had originally allocated resources, and hence end up disabling the device.
> 
> so even required can not be satisfied?

Yes. Even required cannot be satisfied fully.

RP


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:50088 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab2APD06 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2012 22:26:58 -0500
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Sun, 15 Jan 2012 20:26:57 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q0G3Qtsf121066
	for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2012 20:26:55 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q0G3QrPi013544
	for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2012 20:26:54 -0700
Date: Mon, 16 Jan 2012 11:26:49 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	peter.henriksson@gmail.com,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
Message-ID: <20120116032649.GC2601@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
 <1323247984-15281-3-git-send-email-yinghai@kernel.org>
 <20120113163922.GH7380@ram-ThinkPad-T61>
 <CAE9FiQWTVA=LDViVyfSXX6thgGv4TzOpqidVyG6FAdWQqAMWEg@mail.gmail.com>
 <20120115160558.GA2601@ram-ThinkPad-T61>
 <CAE9FiQX2wG9pEZHJE8LD7kL=eiCnFsaS6dRmyNf8F2Kgg=WcpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQX2wG9pEZHJE8LD7kL=eiCnFsaS6dRmyNf8F2Kgg=WcpQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 15, 2012 at 05:14:26PM -0800, Yinghai Lu wrote:
> On Sun, Jan 15, 2012 at 8:05 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> > On Fri, Jan 13, 2012 at 03:28:29PM -0800, Yinghai Lu wrote:
> >> On Fri, Jan 13, 2012 at 8:39 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> >> > On Wed, Dec 07, 2011 at 12:53:01AM -0800, Yinghai Lu wrote:
> >> >
> >> >        I am worried that this approach will resurface old bug
> >> > https://bugzilla.kernel.org/show_bug.cgi?id=15960
> >>
> >>
> >> so even required can not be satisfied?
> >
> > Yes. Even required cannot be satisfied fully.
> 
> double check that bug, it is caused by we stop IO type too early.
> 
> attached patch should fix the problem.
> 
> Also I updated for-pci2 in my tree.
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci2
> 
> Peter Henriksson,
> Can you try for-pci2 branch on your setup with Xonar DX?

Peter should confirm it. But this patch will not fix the issue AFAICT.
Its not just about 'not enough resources', it also about making the right
choice of 'who should get the resource if there is contention'. Only the BIOS
knows about it. But we trash the BIOS's allocation and don't use that
knowledge when it comes to making those hard choices.

RP


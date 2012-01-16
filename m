Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:39577 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab2APK3T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2012 05:29:19 -0500
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Mon, 16 Jan 2012 03:29:19 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q0GATFEq146856
	for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2012 03:29:16 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q0GAT8Kg019927
	for <linux-pci@vger.kernel.org>; Mon, 16 Jan 2012 03:29:11 -0700
Date: Mon, 16 Jan 2012 18:29:01 +0800
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
Message-ID: <20120116102901.GA2377@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
 <1323247984-15281-3-git-send-email-yinghai@kernel.org>
 <20120113163922.GH7380@ram-ThinkPad-T61>
 <CAE9FiQWTVA=LDViVyfSXX6thgGv4TzOpqidVyG6FAdWQqAMWEg@mail.gmail.com>
 <20120115160558.GA2601@ram-ThinkPad-T61>
 <CAE9FiQX2wG9pEZHJE8LD7kL=eiCnFsaS6dRmyNf8F2Kgg=WcpQ@mail.gmail.com>
 <20120116032649.GC2601@ram-ThinkPad-T61>
 <CAE9FiQXk7mbThC5HxhZm0-h4b7QsYKszz48w0xQG=TLWL2nWVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQXk7mbThC5HxhZm0-h4b7QsYKszz48w0xQG=TLWL2nWVw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 15, 2012 at 08:54:46PM -0800, Yinghai Lu wrote:
> On Sun, Jan 15, 2012 at 7:26 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> >> Also I updated for-pci2 in my tree.
> >>
> >>       git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> >> for-pci2
> >>
> >> Peter Henriksson,
> >> Can you try for-pci2 branch on your setup with Xonar DX?
> >
> > Peter should confirm it. But this patch will not fix the issue AFAICT.
> 
> Do you have similar setup to test that ?

No. :(

> 
> > Its not just about 'not enough resources', it also about making the right
> > choice of 'who should get the resource if there is contention'. Only the BIOS
> > knows about it. But we trash the BIOS's allocation and don't use that
> > knowledge when it comes to making those hard choices.
> 
> in extreme case, will let the user to use "pci=norealloc" to disable
> changing pci bridge resource set by BIOS.

I know its a pathological case. But still this issue will be viewed as a
regression.  I had to struggle to solve this regression in order to get your
realloc patch re-accepted. Don't know if you can successfully make a case
to by-pass the regression this time.

One way to solve this problem is to allocate 'required' resources first, and
later aggressively try to allocate 'required+optional' resources. However
aggressively allocation of those 'required+optional' resource would require
ensuring minimal internal fragmentation.

RP


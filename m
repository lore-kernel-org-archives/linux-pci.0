Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:63881 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbaLTA4a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Dec 2014 19:56:30 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so1460651qcv.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2014 16:56:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
References: <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
 <20141204173411.GA5949@google.com> <CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
 <1417777177.4741.69.camel@kernel.crashing.org> <20141208004735.GA15508@shangw>
 <CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
 <1418074683.13358.1.camel@kernel.crashing.org> <CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
 <20141208233855.GA15713@shangw> <CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
 <20141220002306.GB30834@google.com> <CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 19 Dec 2014 17:56:08 -0700
Message-ID: <CAErSpo7JAcLa_2gNkOG+oSHb1cbBXdEa-TVW0=amBptRB8-fNA@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
To: Yinghai Lu <yinghai@kernel.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 19, 2014 at 5:34 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Dec 19, 2014 at 4:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Mon, Dec 08, 2014 at 04:21:34PM -0800, Yinghai Lu wrote:
>>
>> I don't see any patches that resolve the regression (bug 85491) yet.  If we
>> don't figure something out, I'm going to have to revert 5b28541552ef.
>
> As you don't like idea to clear the MEM64 bit in resource ...
>
> After this merging window, I would like to post 5 patches in
>
> https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/log/?h=for-pci-allocate-fit-3.18
> that will make those two systems works with "pci=realloc".

It's fine with me if you post things during the merge window.  But a
fix that depends on adding "pci=realloc" to the kernel parameters is
only a workaround, not sufficient to fix a regression.

> We could have another patch that enable pci=realloc when VGA bar get
> rejected at the first point.

That sounds pretty hacky, but I haven't seen your patch.

> The point is there is no performance difference between two solutions according
> to Marek's test.

I don't believe that.  There might not be a difference in Marek's
case, but this problem could happen with any device, and a
prefetchable window clearly performs better when we do significant
amounts of MMIO.  I'm not interested in fixes targeted at individual
cases.  We have to come up with designs that are good in general.

Marek's case is a little easier because his system is using _CRS.  We
should be able to notice that the Root Port window overlaps the host
bridge window, but isn't contained by it.  In that case, if we merely
trim the Root Port window so it fits, everything will just work.

Zermond's case is similar, but his system isn't using _CRS.  If we
turned on _CRS across the board instead of just for 2008 and newer,
his system would be fixed, too.  That's too risky for v3.19, but worth
considering.

I think we need to think about a different way of resolving the
PowerPC issue (https://bugzilla.kernel.org/show_bug.cgi?id=74151).
5b28541552ef was one way, but certainly not the only possible
approach.

SeaBIOS uses a different PCI configuration strategy.  It doesn't
handle some of the things we need, e.g., SR-IOV, but it's worth
reading for some new ideas:
http://code.coreboot.org/p/seabios/source/tree/master/src/fw/pciinit.c

Bjorn

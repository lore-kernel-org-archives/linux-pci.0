Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:53251 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbaLTAXK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Dec 2014 19:23:10 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so1646852ier.6
        for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2014 16:23:09 -0800 (PST)
Date: Fri, 19 Dec 2014 17:23:06 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	Marek =?iso-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
Message-ID: <20141220002306.GB30834@google.com>
References: <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
 <20141204173411.GA5949@google.com>
 <CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
 <1417777177.4741.69.camel@kernel.crashing.org>
 <20141208004735.GA15508@shangw>
 <CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
 <1418074683.13358.1.camel@kernel.crashing.org>
 <CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
 <20141208233855.GA15713@shangw>
 <CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 08, 2014 at 04:21:34PM -0800, Yinghai Lu wrote:
> On Mon, Dec 8, 2014 at 3:38 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> > On Mon, Dec 08, 2014 at 02:46:00PM -0700, Bjorn Helgaas wrote:
> >>Yeah, I didn't word that very clearly.  I meant that after
> >>5b28541552ef, that 64-bit window is wasted unless there's a 64-bit BAR
> >>below it; we can't even place the window below 4GB and use it for
> >>32-bit prefetchable BARs.
> >
> > Yes, I agree. It's why I suggested to return error from pbus_size_mem()
> > to indicate the case: 64-bits prefetchable window isn't used and it's
> > still available to be used by child 32-bits prefetchable BARs. Please
> > take a look on the attached draft patch, which helps to explain the idea
> > only.
> 
> That would not help. The 00:01.0 on Zermond's system support hotplug. so mem
> pref will be used for 64bit pref.

Maybe it doesn't work as-is, but I think the idea is worth pursuing.  We
can tell whether there are existing children, and we can tell whether there
are any 64-bit prefetchable BARs.

If there is already a device below a hotplug bridge, and it has no 64-bit
BARs, I think we should use the prefetchable window for that device.

It seems silly to reserve the prefetchable window for a possible future
hot-added device.  That means we penalize the device we already know about
because it can't have any prefetchable space.  And we've consumed some
64-bit space that is unused.  We only benefit if we hot-remove the existing
device and hot-add a new device with 64-bit BARs that happen to fit inside
the 2MB (DEFAULT_HOTPLUG_MEM_SIZE) we allocated for it.  That seems pretty
unlikely.

I don't see any patches that resolve the regression (bug 85491) yet.  If we
don't figure something out, I'm going to have to revert 5b28541552ef.

Bjorn

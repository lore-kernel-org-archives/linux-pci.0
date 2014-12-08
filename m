Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:63249 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbaLHVFM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Dec 2014 16:05:12 -0500
Received: by mail-qa0-f46.google.com with SMTP id n8so3892181qaq.5
        for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2014 13:05:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141208004735.GA15508@shangw>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
 <CAErSpo63uZeo1feoPjjXpdH43nsbcWh63kpBmxCnckPd0t9yrg@mail.gmail.com>
 <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
 <20141204173411.GA5949@google.com> <CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
 <1417777177.4741.69.camel@kernel.crashing.org> <20141208004735.GA15508@shangw>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 8 Dec 2014 14:04:51 -0700
Message-ID: <CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Saifi Khan <saifi.khan@datasynergy.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 7, 2014 at 5:47 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Fri, Dec 05, 2014 at 09:59:37PM +1100, Benjamin Herrenschmidt wrote:
>>On Thu, 2014-12-04 at 14:06 -0800, Yinghai Lu wrote:
>>> > I'm considering reverting 5b28541552ef (assuming that would fix this radeon
>>> > regression) because I think the radeon problem is worse than the 74151
>>> > problem and I think we can solve 74151 in a different way.
>>> >
>
> Commit 5b28541552ef affects PowerPC PCI greatly. Without the commit, those
> adapters requesting large BAR would fail and can't work properly. Another
> related thing is SRIOV support. Currently, VF BARs are covered by 64-bits
> prefetch windows and we expect VF BARs allocated from 64-bits prefetchable
> windows. If we're going to revert commit 5b28541552ef, too much things are
> affected. I think it's more reasonable to find a solution for bug#85491 if
> that's not too hard.

Well, these systems with Radeons used to work, but were broken by
5b28541552ef.  Of course, this has nothing to do with Radeon per se;
the same problem could occur with other devices.

Some PowerPC systems didn't work, but were made to work by
5b28541552ef.  This change isn't PowerPC-specific either; it may have
made other systems start working as well.

>From a regression point of view, it is more important to keep the
previously-working Radeon systems working than it is to make
previously-broken systems work.  That's one argument for reverting
5b28541552ef.

It would be ideal to have a fix that makes both the Radeon systems and
the PowerPC systems work.  Yinghai has posted patches that seem to do
that, but they don't have changelogs and I don't understand them yet,
so it's not clear (yet) that they are the answer.

However, I think 5b28541552ef is taking the wrong approach.  Consider
a device that, like this Radeon, has a 32-bit prefetchable BAR.  If
the upstream bridge has a 32-bit prefetchable window, things work as
expected -- we put the prefetchable BAR in the prefetchable window.
But if the bridge has a 64-bit prefetchable window, we put that same
BAR in a 32-bit non-prefetchable window.

So we upgraded the system with a better bridge, i.e., it supports a
full 64-bit window instead of just a 32-bit window, and the system
performs WORSE.  That's what I think is fundamentally broken.

> Looking at bug#85491 and the logs from Marek, BIOS didn't configure windows
> and BARs for PCI bridge and adapters properly, which forces the kernel to
> reassign those BARs/windows failing to be claimed previously. If I'm correct,
> we need a way to reassign the bridge's non-prefetchable window and with it,
> find_free_bus_resource() needn't check on "!r->parent".

It's true that the BIOS didn't configure things correctly.  But we
can't use that as an excuse; the kernel should be able to configure
things correctly itself because there are plenty of machines where the
BIOS never configures things.

Bjorn

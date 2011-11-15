Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:36734 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab1KOW1D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 17:27:03 -0500
Date: Tue, 15 Nov 2011 17:27:01 -0500 (EST)
From: James Paradis <jparadis@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, matthew wilcox <matthew.wilcox@linux.intel.com>,
	jbarnes@virtuousgeek.org, Matthew Wilcox <matthew@wil.cx>,
	Don Dutile <ddutile@redhat.com>
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
Message-ID: <7913c5e8-ea95-4f6f-aa21-33b84e8b931f@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


BTW - for everyone's edification, here is a report on fedoraforum.org
that looks suspiciously like the same problem we're dealing with:

http://forums.fedoraforum.org/showthread.php?t=255025

The mobo worked with F13, broke with F14, nothing he did seemed to
bring the keyboard back, ended up fixing it by getting another
brand of motherboard.  I'm going to see if I can find a copy of
that motherboard for testing...

--jim

----- Original Message -----
> On Fri, Nov 11, 2011 at 12:13 PM, Don Dutile <ddutile@redhat.com>
> wrote:
> > On 11/11/2011 12:41 PM, James Paradis wrote:
> >>
> >> Hmmm... would it be better to do this as a quirk or as a boot
> >> parameter?  I've heard reports that other systems may be running
> >
> > Hearsay?  if you have definite cases, then please share them,
> > so folks know when to flip the boot parameter on.  note: it would
> > have to be
> > an early boot param as well.
> 
> It'd definitely be good to know all the specific cases.
> 
> But merely sharing them so folks will know when to use the parameter
> is a broken model.  We should make it work automatically, either with
> some sort of machine-dependent quirk, or (preferably) with a change
> to
> the generic algorithm so it can handle these "broken" topologies
> along
> with all the correct ones.
> 
> Bjorn
> 

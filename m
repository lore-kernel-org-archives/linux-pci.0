Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f172.google.com ([209.85.213.172]:61806 "EHLO
	mail-ye0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3IFXcM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 19:32:12 -0400
Received: by mail-ye0-f172.google.com with SMTP id m12so1179520yen.3
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 16:32:11 -0700 (PDT)
Date: Fri, 6 Sep 2013 17:32:05 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: Alexander Gordeev <agordeev@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jan Beulich <JBeulich@suse.com>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Message-ID: <20130906233205.GF12956@google.com>
References: <c5ff8fbf905a3df2b75369da725ab5ebf31544ff.1378383792.git.agordeev@redhat.com>
 <20130905130902.GA26314@htj.dyndns.org>
 <20130905150259.GA30984@dhcp-26-207.brq.redhat.com>
 <20130905150442.GA24148@htj.dyndns.org>
 <20130905154041.GD30984@dhcp-26-207.brq.redhat.com>
 <20130905154436.GC24148@htj.dyndns.org>
 <20130905185440.GA13175@dhcp-26-207.brq.redhat.com>
 <20130905200608.GA3846@htj.dyndns.org>
 <CAErSpo4TU2geqzY3AYsL08KimBqtfwa4iUoFHgcFt0zMTBJkHw@mail.gmail.com>
 <20130906160621.GF22763@mtj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130906160621.GF22763@mtj.dyndns.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 06, 2013 at 12:06:21PM -0400, Tejun Heo wrote:
> Hello, Bjorn.
> 
> On Fri, Sep 06, 2013 at 10:01:38AM -0600, Bjorn Helgaas wrote:
> > Sorry, I haven't jumped in here yet because I saw your discussion and
> > was hoping you guys would figure something out without my help.  It
> > will take me a few hours to look into this and come up with anything
> > constructive to say.
> > 
> > I do remember disliking the complicated interface of
> > pci_enable_msi_block() (return negative errno, return positive "we
> > might be able to do this" values, or zero), but I'll have to do some
> > more research before I can say much more than that.
> 
> According to Alexander, it doesn't even seem like we have any actual
> use case for the positive return numbers.  I say just rip it out and
> do the regular 0/-errno all the way through.

I agree, that would be much simpler.

I propose that you rework it that way, and at least find out what
(if anything) would break if we do that.  Or maybe we just give up
some optimization; it would be nice to quantify that, too.

Bjorn

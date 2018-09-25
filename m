Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C781C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC3A20833
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 19:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC3A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeIZBiM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:38:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:35686 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbeIZBiM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 21:38:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8PJSHm5006122;
        Tue, 25 Sep 2018 14:28:23 -0500
Message-ID: <3166a7a3ad85c561fe685885c9465d4746a22be6.camel@kernel.crashing.org>
Subject: Re: [PATCHv3 09/10] PCI: Unify device inaccessible
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Wed, 26 Sep 2018 05:28:17 +1000
In-Reply-To: <20180925153512.GC11657@localhost.localdomain>
References: <20180918235702.26573-1-keith.busch@intel.com>
         <20180918235702.26573-10-keith.busch@intel.com>
         <e0606dfcf8780bf994432dc373581fdf0af18f8e.camel@kernel.crashing.org>
         <20180925153512.GC11657@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2018-09-25 at 09:35 -0600, Keith Busch wrote:
> On Mon, Sep 24, 2018 at 06:10:01PM -0700, Benjamin Herrenschmidt wrote:
> > On Tue, 2018-09-18 at 17:57 -0600, Keith Busch wrote:
> > 
> >  .../...
> > 
> > Any reason why you don't do cmpxchg as I originally suggested (sorry
> > I've been away and may have missed some previous emails)
> 
> That was to block a device hot removal on error_detected and error_resume,
> or vice versa.
>  
> > > -/* pci_dev priv_flags */
> > > -#define PCI_DEV_DISCONNECTED 0
> > > -#define PCI_DEV_ADDED 1
> > > +/**
> > > + * pci_dev_set_io_state - Set the new error state if possible.
> > > + *
> > > + * @dev - pci device to set new error_state
> > > + * @new - the state we want dev to be in
> > > + *
> > > + * Must be called with device_lock held.
> > 
> > This won't work for PowerPC EEH. We will change the state from a
> > readl() so at interrupt time or any other context.
> > 
> > We really need the cmpxchg variant.
> 
> These are private interfaces. EEH can't call them from any context.

That means EEH will have to re-implement that logic to change the IO
state, which doesn't make sense.

There should be a single interface for use by everybody who can set the
IO state and enforces the various state transition rules. That
interface should use a cmpxchg.

It doesn't make sense to require the device_lock in that low level
state setter. That you may want to do it in the higher level code to
prevent device removal vs. calling the error callbacks is fine, but
it's orthogonal to changing the IO state variable.

Cheers,
Ben.



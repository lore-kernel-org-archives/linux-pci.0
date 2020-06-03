Return-Path: <SRS0=sUav=7Q=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D9C433E0
	for <linux-pci@archiver.kernel.org>; Wed,  3 Jun 2020 13:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEDB206A2
	for <linux-pci@archiver.kernel.org>; Wed,  3 Jun 2020 13:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591190959;
	bh=xp8S5uRdLpHTssSel0DvZQsI7IRlTP5pP3UlhihHxkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NKliw14BsDuH1CorJr61a3mDOhFEaQz5VSnCJ02nCPPesSIlylUnBGVRjgg0sWhWV
	 uMSomIhXKoAFJ/sewmwWnX0qlJo6VWcuZwF9NzozxTwL4uWxxVtBOTQ0VFyneJbH3m
	 Vuhl5ntBBQktB2josdr/WNrJmKZ9Gspk+urlvHx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgFCN3S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCN3S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 09:29:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A22020679;
        Wed,  3 Jun 2020 13:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591190958;
        bh=xp8S5uRdLpHTssSel0DvZQsI7IRlTP5pP3UlhihHxkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5gXOOyg9zFDn5uQLf3I5QYs0e7Y5q38gkxDjvrAVk/SqXTV/2XaWPrDZpAvcSDWr
         ii6fkTLI+uftI1ORJFo5lN7CfFeLGRMfZ00GNfAn2F1xWGn+8OGsiksqLQ2Y3AH1bM
         /TzIHYQWMmpaN9fXL03NtGgj/otRH6tLUhwoykVM=
Date:   Wed, 3 Jun 2020 15:29:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200603132915.GA1584791@kroah.com>
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520>
 <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com>
 <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
 <CACK8Z6EzYxh8WS8h8y6WdF8PnwUixQvFy6JASuzJ_tRsVfu5Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6EzYxh8WS8h8y6WdF8PnwUixQvFy6JASuzJ_tRsVfu5Fw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 03, 2020 at 05:57:02AM -0700, Rajat Jain wrote:
> > So please, in summary:
> >         - don't think this is some new type of thing, it's an old issue
> >           transferred to yet-another-hardware-bus.  Not to say this is
> >           not important, just please look at the work that others have
> >           done in the past to help mitigate and solve this (reading the
> >           Wireless USB spec should help you out here too, as they
> >           detailed all of this.)
> >         - do copy what USB did, by moving that logic into the driver
> >           core so that all busses who want to take advantage of this
> >           type of functionality, easily can do so.
> 
> Understood, will keep that in mind. I may first present a "PCI
> subsystem only" draft just to get a feel for it, since that is more
> familiar to me and also already has some bits and pieces we need for
> this.

Why?  Do it right the first time.  To waste reviewer's time on something
that you know you have to throw away and do it "correctly" again, is not
very nice.  I know I would put you on the bottom of my "patches to
review" list if you did that to me :)

thanks,

greg k-h

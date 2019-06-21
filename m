Return-Path: <SRS0=K8vK=UU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E26EC43613
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 17:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158192083B
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 17:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFURhQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:37:16 -0400
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:32849 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbfFURhQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 13:37:16 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2019 13:37:15 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id BCAE9180144A3
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2019 17:27:46 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 3F510100E806B;
        Fri, 21 Jun 2019 17:27:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cream64_93b04b7d1048
X-Filterd-Recvd-Size: 3436
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Jun 2019 17:27:43 +0000 (UTC)
Message-ID: <698d3e3614ae903ae9582547d64c6a9846629e57.camel@perches.com>
Subject: Re: [PATCH 0/3] net: ethernet: atheros: atlx: Use PCI generic
 definitions instead of private duplicates
From:   Joe Perches <joe@perches.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux PCI <linux-pci@vger.kernel.org>
Date:   Fri, 21 Jun 2019 10:27:41 -0700
In-Reply-To: <CAErSpo5TMPokae7BMY8ZcOXtW=GeGsWXX_bqS8SrZnh0pEQYxw@mail.gmail.com>
References: <20190621163921.26188-1-puranjay12@gmail.com>
         <CAErSpo5TMPokae7BMY8ZcOXtW=GeGsWXX_bqS8SrZnh0pEQYxw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

(adding the atlx maintainers to cc)

On Fri, 2019-06-21 at 12:11 -0500, Bjorn Helgaas wrote:
> On Fri, Jun 21, 2019 at 11:39 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> > This patch series removes the private duplicates of PCI definitions in
> > favour of generic definitions defined in pci_regs.h.
> > 
> > Puranjay Mohan (3):
> >   net: ethernet: atheros: atlx: Rename local PCI defines to generic
> >     names
> >   net: ethernet: atheros: atlx: Include generic PCI definitions
> >   net: ethernet: atheros: atlx: Remove unused and private PCI
> >     definitions
> > 
> >  drivers/net/ethernet/atheros/atlx/atl2.c | 5 +++--
> >  drivers/net/ethernet/atheros/atlx/atl2.h | 2 --
> >  drivers/net/ethernet/atheros/atlx/atlx.h | 1 -
> >  3 files changed, 3 insertions(+), 5 deletions(-)
> 
> Let's slow this down a little bit; I'm afraid we're going to overwhelm folks.

I generally disagree.

Consolidation of these sorts of changes are generally
better done treewide all at once, posted as a series to
a list and maintainers allowing time (weeks to months)
for the specific maintainers to accept them and then
whatever remainder exists reposted and possibly applied
by an overall maintainer (e.g.: Dave M)

> Before posting more to LKML/netdev, how about we first complete a
> sweep of all the drivers to see what we're getting into.  It could be
> that this will end up being more churn than it's worth.

Also doubtful.

Subsystem specific local PCI #defines without generic
naming is poor style and makes treewide grep and
refactoring much more difficult.

The atlx maintainers should definitely have been cc'd
on these patches.

Jay Cliburn <jcliburn@gmail.com> (maintainer:ATLX ETHERNET DRIVERS)
Chris Snook <chris.snook@gmail.com> (maintainer:ATLX ETHERNET DRIVERS)

Puranjay, can you please do a few things more here:

1: Make sure you use scripts/get_maintainer.pl to cc the
   appropriate people.

2: Show that you compiled the object files and verified
   where possible that there are no object file changes.

3: State that there are no object changes in the proposed
   commit log.

thanks.


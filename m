Return-Path: <SRS0=K8vK=UU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BB1C43613
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 17:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99CC2070B
	for <linux-pci@archiver.kernel.org>; Fri, 21 Jun 2019 17:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUR70 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:59:26 -0400
Received: from smtprelay0062.hostedemail.com ([216.40.44.62]:39534 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbfFUR7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 13:59:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2CFC9837F24D;
        Fri, 21 Jun 2019 17:59:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paint61_8c15a38e8ef39
X-Filterd-Recvd-Size: 2525
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Jun 2019 17:59:22 +0000 (UTC)
Message-ID: <5025da034080c6653b23d7362e06cf211d2cec3c.camel@perches.com>
Subject: Re: [PATCH v3 0/3] net: fddi: skfp: Use PCI generic definitions
 instead of private duplicates
From:   Joe Perches <joe@perches.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org
Date:   Fri, 21 Jun 2019 10:59:21 -0700
In-Reply-To: <20190621164429.GA187016@google.com>
References: <20190621094607.15011-1-puranjay12@gmail.com>
         <20190621162024.53620dd9@alans-desktop>
         <20190621164429.GA187016@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-06-21 at 11:44 -0500, Bjorn Helgaas wrote:
> On Fri, Jun 21, 2019 at 04:20:24PM +0100, Alan Cox wrote:
> > On Fri, 21 Jun 2019 15:16:04 +0530
> > Puranjay Mohan <puranjay12@gmail.com> wrote:
> > 
> > > This patch series removes the private duplicates of PCI definitions in
> > > favour of generic definitions defined in pci_regs.h.
> > 
> > Why bother ? It's an ancient obsolete card ?
> 
> That's a fair question.
> 
> Is there anything that would indicate that "this file is obsolete and
> problems shouldn't be fixed"?  Nobody wants to waste time on things
> that don't need to be fixed, but I don't know how to tell if something
> is obsolete.
> 
> My naive assumption is that if something is in the tree, it's fair
> game for fixes and cleanups.

I'd prefer to move the old, crufty, obsolete and generally
unsupported drivers to new directory trees and possibly
symlink those drivers to their current locations.

I suggested on the kernel summit list:
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-June/006482.html

---

Perhaps a mechanism to move these old, generally unsupported
by an actual maintainer, and rarely tested drivers out of the
mainline drivers directory into a separate obsolete directory
would help isolate the whitespace and trivial api changes.



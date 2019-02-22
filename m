Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B73C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 09:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5490420823
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 09:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfBVJjF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:39:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61755 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBVJjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 04:39:05 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id b35d8d77039a2d19; Fri, 22 Feb 2019 10:39:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        RussianNeuroMancer <russianneuromancer@ya.ru>,
        David Ward <david.ward@ll.mit.edu>,
        Frederick Lawler <fred@fredlawl.com>,
        Patrick Talbert <ptalbert@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] PCI/ASPM: Fix LTR issues
Date:   Fri, 22 Feb 2019 10:37:34 +0100
Message-ID: <4865264.tNTiON9z6m@aspire.rjw.lan>
In-Reply-To: <20190222045824.GD219879@google.com>
References: <154992561743.7864.14353823538864422094.stgit@bhelgaas-glaptop.roam.corp.google.com> <20190222045824.GD219879@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, February 22, 2019 5:58:24 AM CET Bjorn Helgaas wrote:
> On Mon, Feb 11, 2019 at 04:55:33PM -0600, Bjorn Helgaas wrote:
> > These are to fix a couple LTR-related issues found while investigating
> > https://bugzilla.kernel.org/show_bug.cgi?id=201469
> > 
> > I don't claim that these fix the whole problem of that bugzilla, but I
> > think it's pretty clear that these are problems we need to fix, so I want
> > to give these a little more exposure.
> > 
> > Feedback welcome!
> > 
> > ---
> > 
> > Bjorn Helgaas (2):
> >       PCI/ASPM: Use LTR if already enabled by platform
> >       PCI/ASPM: Save LTR Capability for suspend/resume
> > 
> > 
> >  drivers/pci/pci.c   |   53 +++++++++++++++++++++++++++++++++++++++++++++++++--
> >  drivers/pci/probe.c |   36 ++++++++++++++++++++++-------------
> >  2 files changed, 74 insertions(+), 15 deletions(-)
> 
> I applied these to pci/aspm for v5.1.
> 
> I think Vidya is absolutely right that we also need to save/restore
> the ASPM L1 Substates capability.  But I haven't had a chance to
> write that up yet, and I think these two patches by themselves
> are an improvement even without ASPM L1 SS.

Agreed.

Cheers,
Rafael


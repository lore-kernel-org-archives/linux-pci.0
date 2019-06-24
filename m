Return-Path: <SRS0=Q0Wt=UX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB56C43613
	for <linux-pci@archiver.kernel.org>; Mon, 24 Jun 2019 09:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B32920665
	for <linux-pci@archiver.kernel.org>; Mon, 24 Jun 2019 09:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfFXJPi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:15:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:44065 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfFXJPi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 05:15:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5O9FWaW024123;
        Mon, 24 Jun 2019 04:15:33 -0500
Message-ID: <b873931988c7e6ccf61010e8ad03cf2d7f3e4b09.camel@kernel.crashing.org>
Subject: Re: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Mon, 24 Jun 2019 19:15:32 +1000
In-Reply-To: <f4cb8429-a32d-d3af-dee0-0bae1935cb47@amd.com>
References: <ed3d3e4e87b54fa4d0d8e68abeebb7be6711b82a.camel@kernel.crashing.org>
         <71904c98-be86-2807-d5c9-4b90c7387f6f@amd.com>
         <ea9f770c373ad9c6a998edbd603972014e4b7fea.camel@kernel.crashing.org>
         <f4cb8429-a32d-d3af-dee0-0bae1935cb47@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-06-24 at 09:08 +0000, Koenig, Christian wrote:
> 
> Yeah, can't agree more :) It was one of the main challenges implementing 
> the resizing support.
> 
> If you want to clean this up feel free to CC me and I can take a look as 
> well. But honestly I was scared of touching it when I worked on this, 
> because of all the little corner cases you have in PCI.
> 
> > Question: Do you ever need to assign anything other than that one
> > device though ? In my branch, I've added this typically for the case
> > where a single device needs to be reassigned:
> > 
> > +void pci_dev_assign_resources(struct pci_dev *dev)
> > +{
> > +	LIST_HEAD(head);
> > +
> > +	/* Assign non-fixed resources */
> > +	__dev_sort_resources(dev, &head);
> > +	__assign_resources_sorted(&head, NULL, NULL);
> > +
> > +	/* Assign fixed ones if any */
> > +	pdev_assign_fixed_resources(dev);
> > +}
> > +EXPORT_SYMBOL(pci_dev_assign_resources);
> > 
> > Would that work for you ?
> 
> That should work perfectly fine.

Ok, Ill plumb it that way in my branch, I'll let you know when it's
worth testing. BTW. Which GPUs typically are affected ? I'm pretty sure
my old R9 290 isn't :-) But I was thinking of upgrading so...

Cheers,
Ben.



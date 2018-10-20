Return-Path: <SRS0=Xsl3=NA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3B8C67863
	for <linux-pci@archiver.kernel.org>; Sat, 20 Oct 2018 15:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC18121529
	for <linux-pci@archiver.kernel.org>; Sat, 20 Oct 2018 15:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvpWl6ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC18121529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeJTXOm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Oct 2018 19:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbeJTXOm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Oct 2018 19:14:42 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9487420652;
        Sat, 20 Oct 2018 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540047834;
        bh=wK8QCVE0x9Bps0qm/iKvyzaoytAmDk7gUxysGH8qy7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvpWl6ihP7UPvfir9+CL+nWV2IPCCTQ6PAB13nwQ080tc8GK9qu26WZNva66zGHLO
         1hrXRne9udSfqT0uYwGbZkAYxMWV8RWCILjPcCQJWWQPNU6X+w49hVldrmh551b16n
         lMLdv314ztAmR104lmGfR8hpbVnNLVsiV72fr3JE=
Date:   Sat, 20 Oct 2018 10:03:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH v6 1/7] PCI: Expose reset_type to users of
 __pci_reset_function_locked()
Message-ID: <20181020150353.GR5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181019021132.14743-1-okaya@kernel.org>
 <20181020020908.GQ5906@bhelgaas-glaptop.roam.corp.google.com>
 <8f368f0b-b9b9-54ab-bd46-88635b9a43e5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f368f0b-b9b9-54ab-bd46-88635b9a43e5@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 10:58:00PM -0400, Sinan Kaya wrote:
> On 10/19/2018 10:09 PM, Bjorn Helgaas wrote:
> > On Fri, Oct 19, 2018 at 02:11:21AM +0000, Sinan Kaya wrote:
> > > We need a contract between the reset API users and the PCI core about the
> > > types of reset that a user needs vs. what PCI core can do internally.
> > > If a platform supports hotplug, we need to do hotplug reset as an example.
> > 
> > Somewhere this needs a description of a bug that's being fixed or some
> > other justification, e.g., code simplification.  The above is a little
> > too abstract for me to grasp it.
> 
> This series was in response to a request from Alex to have external users
> some level of control on what PCI core can do internally.
> 
> On the other hand, I have been posting patches to remove direct access from
> external users to PCI core internals and hide all reset semantics like
> save/restore from the users. I like giving less power to the users :)

That's a good goal.  Along the way we might need to tweak the users to
align their usage to some common cases.

> > > Expose the reset types to the drivers and try different reset types based
> > > on the new reset_type parameter.
> > > 
> > > Most users are expected to use PCI_RESET_ANY, PCI_RESET_FUNC or
> > > PCI_RESET_LINK parameters.
> > 
> > There are fewer than a dozen callers of all these functions and the
> > complication of these interfaces doesn't seem commensurate with the
> > problem.  With six different interfaces and five independent bit
> > flags, the possibilities are way more than necessary.
> 
> True, I posted an RFC to reduce 5 function reset API flavors to 1 and
> rely on the flags.

I don't like the flags.  Even one API with five bit flags has 32
possible combinations, most of which are meaningless.

> Even these generic reset examples are not really generic today. Some of them
> call reset from probe path and use the locked reset API
> (pci_reset_function_locked()).
> 
> Others call the reset but prefer to not save/restore context.
> (__pci_reset_function_locked()). Some drivers even implemented their own
> context save/restore code themselves.
> 
> There are others that do obtain the lock as well as save/restore context.
> (pci_reset_function())
> 
> I really don't like having these many reset API flavors and I thought
> we could do something about that.

I agree we have too many flavors.  I'm not convinced all the variation
in save/restore is necessary; I suspect most of that is accidental and
drivers could probably all live with a single solution.

> We can also drop the series if we think that current API are good enough
> and nuances are well understood.

I don't think the current API is good enough :)  It's just a small
matter of sorting out a better one.

Bjorn

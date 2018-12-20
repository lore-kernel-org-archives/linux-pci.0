Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAF0C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 15:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0431B218D3
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545318749;
	bh=CAtPf7KLKwctiK8eg2V9Ys6N2gNaazbxLja4ZAlc0tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c9cWyL2cPj70o2RjjAOMZ/ZWc+CRSLTxQolBCPcopxwXZOURtDSO6Na6s5WymOuf9
	 MhU+tS68+4qQ5ODE21nCQXFIKl5PHQr/vXX76/I8tYaHw/nyO3ChvZtM3JS9Cju3ys
	 tQXOck0YYtpVGr9iPNYy+4Gp+A3TrgsKAqV1y0A8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbeLTPM2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:12:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbeLTPM2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 10:12:28 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A868D21852;
        Thu, 20 Dec 2018 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545318746;
        bh=CAtPf7KLKwctiK8eg2V9Ys6N2gNaazbxLja4ZAlc0tE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xv+newShZdqnGGBIntOtygC9uCnr5h3pkJbtBRDedvr9Thz0xc9dXHJQD7GFjdRM6
         oND3sjcLYJr/ILGcsk80Ayee31RnK44vxBGWjw2FozLWdHmK3mgTgbQmwD78To69JM
         aERyRV5VFUrNmL/ZKBCU682UgN5gLZAK9EfFgAqs=
Date:   Thu, 20 Dec 2018 09:12:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linuxarm@huawei.com,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, martin@geanix.com
Subject: Re: [PATCH V2] x86: Fix an issue with invalid ACPI NUMA config
Message-ID: <20181220151225.GB183878@google.com>
References: <20181211094737.71554-1-Jonathan.Cameron@huawei.com>
 <a5a938d3-ecc9-028a-3b28-610feda8f3f8@intel.com>
 <20181212093914.00002aed@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212093914.00002aed@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 12, 2018 at 09:39:14AM +0000, Jonathan Cameron wrote:
> On Tue, 11 Dec 2018 10:19:49 -0800
> Dave Hansen <dave.hansen@intel.com> wrote:
> 
> > On 12/11/18 1:47 AM, Jonathan Cameron wrote:
> > > When the PCI code later comes along and calls acpi_get_node() for any PCI
> > > card below the root port, it navigates up the ACPI tree until it finds the
> > > _PXM value in the root port. This value is then passed to
> > > acpi_map_pxm_to_node().
> > > 
> > > As numa_off has not been set on x86 it tries to allocate a NUMA node, from
> > > the unused set, without setting up all the infrastructure that would
> > > normally accompany such a call.   
> > 
> > FWIW, this _sounds_ like the real problem here.  We're allowing an
> > allocation to proceed without some infrastructure that we require.
> > Shouldn't we be detecting that this infrastructure is not in place and
> > warn about *it* at least?
> > 
> > I'm a bit worried that this is just papering over an unknown error to
> > make a hang go away.  It seems a bit too far away from the root cause.
> 
> I'm not totally convinced.  We are warning about it on the two lines just off the
> top of this patch.
> 
> "No NUMA configuration found"
> "Faking a node at [mem....]"
> 
> We are falling back to the exact same code paths as if you had deliberately
> turned off NUMA at the command line with messages stating that is the case.
> That approach seems to be safe and is consistent.
> 
> Now there is a potential corner here where I agree with you that it may
> make sense to 'also' add protections in the acpi_map_pxm_to_node() path
> which is that where we do have a valid NUMA configuration and along comes
> a new device with a node outside of those that are defined,
> (note there is a change coming in next ACPI precisely to work around a case
> that causes this to validly happen when the OS sees some new features and
> doesn't know what to do with them - it still relies on the ACPI tables
> having the right magic in them though for the fallback to work - more
> on that when the spec is out...).
> 
> One option would be to (in addition to this patch) add a new version of
> acpi_get_node that will only give you a node that actually exists
> and an error otherwise allowing code to fallback to to NO_NODE.
> 
> Other than the error we might be able to use acpi_map_pxm_to_online_node
> for this, or call both acpi_map_pxm_to_node and acpi_map_pxm_to_online_node
> and compare the answers to verify we are getting the node we want?

Where are we at with this?  It'd be nice to resolve it for v4.21, but
it's a little out of my comfort zone, so I don't want to apply it
unless there's clear consensus that this is the right fix.

Bjorn

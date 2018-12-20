Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8092C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 19:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6846621901
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 19:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545335837;
	bh=7pG6TAj/AzIf3A+xAqvvaDsdYDkro5cW52tehw4Phko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZJFYZWmcEyk0LvbtnBR3wvv3JqPzhemHeq/0Wj7d4ihDyMnonZZT7N3/Z/iPrlmtv
	 pIbJMDOrPV2SOw5rVqIdxJndwt4E6AnixLRJASVz6o2VaVPQdTUo/MDdWdFKcQiMHA
	 0tnxi5vzRnyKCqkm+DEuGuDrFKQYcYujrMyzb1Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbeLTT5Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbeLTT5Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 14:57:16 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AABFD21773;
        Thu, 20 Dec 2018 19:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545335836;
        bh=7pG6TAj/AzIf3A+xAqvvaDsdYDkro5cW52tehw4Phko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AU9rgW29BWE/rhOhr87N808AcL0678HftamCQSCzVdE1XyoVIe0R7fUjPIV7HLgY0
         kDNk8EJiVkZV3yQk6PjqjBCsKOcs9yE0uK9gJuP/ucN18Az1+5kARHeJH+NQO3YAy2
         ZAwsZveJeG1KjBtjfYBLyZE/nsbmGVqNTK8Bikzk=
Date:   Thu, 20 Dec 2018 13:57:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-pci@vger.kernel.org, x86@kernel.org, linuxarm@huawei.com,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, martin@geanix.com
Subject: Re: [PATCH V2] x86: Fix an issue with invalid ACPI NUMA config
Message-ID: <20181220195714.GE183878@google.com>
References: <20181211094737.71554-1-Jonathan.Cameron@huawei.com>
 <a5a938d3-ecc9-028a-3b28-610feda8f3f8@intel.com>
 <20181212093914.00002aed@huawei.com>
 <20181220151225.GB183878@google.com>
 <65f5bb93-b6be-d6dd-6976-e2761f6f2a7b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f5bb93-b6be-d6dd-6976-e2761f6f2a7b@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 20, 2018 at 09:13:12AM -0800, Dave Hansen wrote:
> On 12/20/18 7:12 AM, Bjorn Helgaas wrote:
> >> Other than the error we might be able to use acpi_map_pxm_to_online_node
> >> for this, or call both acpi_map_pxm_to_node and acpi_map_pxm_to_online_node
> >> and compare the answers to verify we are getting the node we want?
> > Where are we at with this?  It'd be nice to resolve it for v4.21, but
> > it's a little out of my comfort zone, so I don't want to apply it
> > unless there's clear consensus that this is the right fix.
> 
> I still think the fix in this patch sweeps the problem under the rug too
> much.  But, it just might be the best single fix for backports, for
> instance.

Sounds like we should first find the best fix, then worry about how to
backport it.  So I think we have a little more noodling to do, and
I'll defer this for now.

Bjorn

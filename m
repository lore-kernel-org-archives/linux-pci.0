Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25823C00449
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 23:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E707E213A2
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 23:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E707E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJFGcX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:32:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeJFGcW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Oct 2018 02:32:22 -0400
Received: from localhost (unknown [104.153.224.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 144A66729;
        Fri,  5 Oct 2018 23:31:23 +0000 (UTC)
Date:   Fri, 5 Oct 2018 16:31:00 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Drake <drake@endlessm.com>,
        Peter Wu <peter@lekensteyn.nl>
Subject: Re: [GIT PULL] PCI fixes for v4.19
Message-ID: <20181005233100.GE25152@kroah.com>
References: <20181005204730.GA136037@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005204730.GA136037@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 05, 2018 at 03:47:30PM -0500, Bjorn Helgaas wrote:
> PCI fixes:
> 
>   - Reprogram bridge prefetch registers to fix NVIDIA and Radeon issues
>     after suspend/resume (Daniel Drake)
> 
>   - Fix mvebu I/O mapping creation sequence (Thomas Petazzoni)
> 
>   - Fix minor MAINTAINERS file match issue (Bjorn Helgaas)
> 

Now merged, thanks.

greg k-h

Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356B5C677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 19:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88C32075C
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 19:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPjv5FHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88C32075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeJLDKa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeJLDKa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 23:10:30 -0400
Received: from localhost (32.sub-174-234-152.myvzw.com [174.234.152.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E73B2075C;
        Thu, 11 Oct 2018 19:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539286907;
        bh=8TBvY16YEZmo3mA57K5veO7mh/4UAWzckwYogRcDQNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPjv5FHd/WEPGJ8C3YR10S05eYukAgnzqfm11eRxhQuQ4QyRoyQXHcOuGfvkJpDUl
         GtK+98FkR8NEbHgZTpd3zjjIPdLhqeYK+n5uI0lok5P0ev3e3BmgQmZNslVJvUn54f
         4+Z8dP1/56QCr3vjmE+3irgijn64t6yIrBsXuBmY=
Date:   Thu, 11 Oct 2018 14:41:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 4/4] PCI/AER: Covertly inject errors with ftrace hooks
Message-ID: <20181011194146.GU5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181011183413.13183-1-keith.busch@intel.com>
 <20181011183413.13183-5-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011183413.13183-5-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 12:34:13PM -0600, Keith Busch wrote:
> The aer_inject module had been intercepting config requests by overwriting
> the config accessor operations in the pci_bus ops.  This has several
> issues.
> 
> First, the module was tracking kernel objects unbeknownst to the drivers
> that own them.  The kernel may free those devices, leaving the AER inject
> module holding stale references and no way to know that happened.
> 
> Second, the PCI enumeration has child devices inherit pci_bus ops from
> the parent bus.  Since errors may lead to link resets that trigger
> re-enumeration, the child devices would inherit operations that don't
> know about the devices using them, causing kernel crashes.
> 
> Finally, CONFIG_PCI_LOCKLESS_CONFIG doesn't block accessing the pci_bus
> ops, so it's racing with potential in-flight config requests.
> 
> This patch uses a different error injection approach leveraging ftrace
> to thunk the config space functions.  If the kernel and architecture
> are capable, the ftrace hook will overwrite the processor's function
> call address with the error injection function. This discreet error
> injection doesn't modify or track driver structures, fixing the issues
> with the current method.
> 
> If either the kernel config or platform arch do not support the necessary
> ftrace capabilities, the aer_inject module will fallback to the older
> way so that it may continue to be used as before.

I dropped this patch for now because the 0-day robot found something wrong.

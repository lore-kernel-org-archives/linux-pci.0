Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEBEC677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 19:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5DD2077C
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 19:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5DD2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeJLDQE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:16:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:7068 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeJLDQE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 23:16:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 12:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="96735120"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2018 12:45:14 -0700
Date:   Thu, 11 Oct 2018 13:42:14 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 4/4] PCI/AER: Covertly inject errors with ftrace hooks
Message-ID: <20181011194214.GF11034@localhost.localdomain>
References: <20181011183413.13183-1-keith.busch@intel.com>
 <20181011183413.13183-5-keith.busch@intel.com>
 <20181011194146.GU5906@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011194146.GU5906@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 02:41:46PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 11, 2018 at 12:34:13PM -0600, Keith Busch wrote:
> > The aer_inject module had been intercepting config requests by overwriting
> > the config accessor operations in the pci_bus ops.  This has several
> > issues.
> > 
> > First, the module was tracking kernel objects unbeknownst to the drivers
> > that own them.  The kernel may free those devices, leaving the AER inject
> > module holding stale references and no way to know that happened.
> > 
> > Second, the PCI enumeration has child devices inherit pci_bus ops from
> > the parent bus.  Since errors may lead to link resets that trigger
> > re-enumeration, the child devices would inherit operations that don't
> > know about the devices using them, causing kernel crashes.
> > 
> > Finally, CONFIG_PCI_LOCKLESS_CONFIG doesn't block accessing the pci_bus
> > ops, so it's racing with potential in-flight config requests.
> > 
> > This patch uses a different error injection approach leveraging ftrace
> > to thunk the config space functions.  If the kernel and architecture
> > are capable, the ftrace hook will overwrite the processor's function
> > call address with the error injection function. This discreet error
> > injection doesn't modify or track driver structures, fixing the issues
> > with the current method.
> > 
> > If either the kernel config or platform arch do not support the necessary
> > ftrace capabilities, the aer_inject module will fallback to the older
> > way so that it may continue to be used as before.
> 
> I dropped this patch for now because the 0-day robot found something wrong.

I just saw that. Sorry for the trouble. It fails a minimal kernel
config, so I missed checking appropriate config defines.


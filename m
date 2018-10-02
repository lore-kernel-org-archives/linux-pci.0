Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70866C64EB9
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 19:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCB32089C
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 19:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCB32089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJCChm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:37:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:40862 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbeJCChm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Oct 2018 22:37:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 12:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,333,1534834800"; 
   d="scan'208";a="94054376"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga004.fm.intel.com with ESMTP; 02 Oct 2018 12:52:40 -0700
Date:   Tue, 2 Oct 2018 13:55:00 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv4 08/12] PCI: ERR: Always use the first downstream port
Message-ID: <20181002195459.GA17539@localhost.localdomain>
References: <20180920162717.31066-9-keith.busch@intel.com>
 <20180926220116.GJ28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180926221924.GA17934@localhost.localdomain>
 <20180927225625.GB18434@bhelgaas-glaptop.roam.corp.google.com>
 <20180928154220.GA21996@localhost.localdomain>
 <20180928205034.GA119911@bhelgaas-glaptop.roam.corp.google.com>
 <20180928213523.GA22508@localhost.localdomain>
 <20180928232801.GB119911@bhelgaas-glaptop.roam.corp.google.com>
 <20181001151450.GB22508@localhost.localdomain>
 <20181002193522.GB120535@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002193522.GB120535@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 02, 2018 at 02:35:22PM -0500, Bjorn Helgaas wrote:
> Here's my proposal for the changelog.  Let me know what I screwed up.
> 
> commit 1f7d2967334433d885c0712b8ac3f073f20211ee
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Thu Sep 20 10:27:13 2018 -0600
> 
>     PCI/ERR: Run error recovery callbacks for all affected devices
>     
>     If an Endpoint reported an error with ERR_FATAL, we previously ran driver
>     error recovery callbacks only for the Endpoint's driver.  But if we reset a
>     Link to recover from the error, all downstream components are affected,
>     including the Endpoint, any multi-function peers, and children of those
>     peers.
>     
>     Initiate the Link reset from the deepest Downstream Port that is
>     reliable, and call the error recovery callbacks for all its children.
>     
>     If a Downstream Port (including a Root Port) reports an error, we assume
>     the Port itself is reliable and we need to reset its downstream Link.  In
>     all other cases (Switch Upstream Ports, Endpoints, Bridges, etc), we assume
>     the Link leading to the component needs to be reset, so we initiate the
>     reset at the parent Downstream Port.
>     
>     This allows two other clean-ups.  First, we currently only use a Link
>     reset, which can only be initiated using a Downstream Port, so we can
>     remove checks for Endpoints.  Second, the Downstream Port where we initiate
>     the Link reset is reliable (unlike the device that reported the error), so
>     the special cases for error detect and resume are no longer necessary.

A downstream port may have been the device that reports the error, but
we still consider that to be accessible. Maybe "unlike its subordinate
bus".

Otherwise this sounds good to me.

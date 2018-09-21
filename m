Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B7C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 17:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A4421569
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 17:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2gZyUqgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A4421569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbeIUXIz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeIUXIy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 19:08:54 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CF4E21568;
        Fri, 21 Sep 2018 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537550344;
        bh=lGKFciTSFC8Vg4evU0hXI0vYRK3hui+q2s7aws7/Ukk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2gZyUqgOzrAP9RIv41XSlsNVP0ZwGQ0cd77k0e7ia5Vyez3NXwGXMdCSaizKNrt/k
         +M6hE+gkMZ9Q6LnlEzNMLt4TcVpJnOFcSuud5+lpVSZUw4nT+5LPaQTDweREtYjb+/
         Y+mrlpCFOVTDYDSn54R8gfDMJ80Zm81DXKah6huc=
Date:   Fri, 21 Sep 2018 12:19:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix compile error with DPC disabled
Message-ID: <20180921171903.GL224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180921142210.1191-1-keith.busch@intel.com>
 <20180921165729.GK224714@bhelgaas-glaptop.roam.corp.google.com>
 <20180921170234.GA1496@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921170234.GA1496@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 21, 2018 at 11:02:34AM -0600, Keith Busch wrote:
> On Fri, Sep 21, 2018 at 11:57:29AM -0500, Bjorn Helgaas wrote:
> > On Fri, Sep 21, 2018 at 08:22:10AM -0600, Keith Busch wrote:
> > > The alternate functions when CONFIG_PCIE_DPC is not defined need to be
> > > static inline.
> > > 
> > > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > 
> > If you tell me which patch, I'll fold this into it so there's no bisection
> > hole.
> 
> Thanks, I like that plan.
> 
> Fixes: d17964c0d81fc38c7 ("PCI/DPC: Save and restore config state")
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/hotplug&id=d17964c0d81fc38c733fc5281436d2b262306a33

Done, sorry to bother you, I could have figured that out in 10 seconds
myself from the 0-day robot email.

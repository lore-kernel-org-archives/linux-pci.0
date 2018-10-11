Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB79C677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 19:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555F82087D
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 19:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTE1Bohj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555F82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeJLCbQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbeJLCbQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 22:31:16 -0400
Received: from localhost (32.sub-174-234-152.myvzw.com [174.234.152.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F202085B;
        Thu, 11 Oct 2018 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539284565;
        bh=xPLIYTIKS7POZogysNkhU+f1gDd51eVX90cAq1Da0CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTE1BohjqpYnSriOKk3iJ1M5L5je4M6abopMLSO3dIrXOSeJDWEZPx6chK5VFCpnV
         eTYn1t9nCcwuyfCclZ1JqjcK+XIDIhkP9yJr7ro2XZwRooqxCBmCUt1gAmLPWEw/EQ
         1F6R11YRrUQ8ftIwKCTPK4/zH2dwmRAAgnuiCU5g=
Date:   Thu, 11 Oct 2018 14:02:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 0/4] aer inject updates
Message-ID: <20181011190244.GS5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181011183413.13183-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011183413.13183-1-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 12:34:09PM -0600, Keith Busch wrote:
> This is the same as the previous version, except a refactoring was split
> out into its own patch rather than included in the final patch.
> 
> Keith Busch (4):
>   PCI/AER: Reuse existing pcie_port_find_device() interface
>   PCI/AER: Abstract AER interrupt handling
>   PCI/AER: Refactor error injection fallbacks
>   PCI/AER: Covertly inject errors with ftrace hooks
> 
>  drivers/pci/pcie/aer.c          |   3 +-
>  drivers/pci/pcie/aer_inject.c   | 248 +++++++++++++++++++++++++++++++---------
>  drivers/pci/pcie/portdrv.h      |   4 -
>  drivers/pci/pcie/portdrv_core.c |   1 +
>  4 files changed, 199 insertions(+), 57 deletions(-)

Applied to pci/hotplug for v4.20, thanks!

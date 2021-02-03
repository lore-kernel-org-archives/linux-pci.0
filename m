Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DD9C433DB
	for <linux-pci@archiver.kernel.org>; Wed,  3 Feb 2021 00:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7C664F69
	for <linux-pci@archiver.kernel.org>; Wed,  3 Feb 2021 00:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhBCAEN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Feb 2021 19:04:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhBCAEI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 19:04:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E4A864F68;
        Wed,  3 Feb 2021 00:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612310606;
        bh=6uJEpmJ9HefVfu/stJP+9VSt+cyLmdiqIuhjpbGEMl0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=cptHTRrwUkg+WDMzBzDWkCnYCJEJLuDb5AzJ/1UmJXCmfsLrPGwYq13WXOUOmd87F
         vZ28O1sPYM82poJkZdIHhgV3lKr8RawUoRi7U3FGGSXnZ9q19z2fwc5Sku4CB19/Dz
         DuMYYEKJzSiOKBA15Hv0FYVxEKWO3GBYOd9IM8enrcSYiyzByzjDOHYBTIKpUh3DAj
         uiJVi/by5dfYA4QXlNVNLrt3G5qXeh6OR+EJoSeXoPVQqCbXZmikyCLCDrO/FiC5mL
         h+BYf+FABxe3qUJpgs+rBrYUVv+6CZ+EoXLzJgEQRemS8rnzJLQ9Aon+YglIGzDI0y
         B2VgGIW7MObxQ==
Date:   Wed, 3 Feb 2021 09:03:20 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210203000320.GB22815@redsun51.ssa.fujisawa.hgst.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104230300.1277180-1-kbusch@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Any further concern? I beleive Hinko idenfitied his observations as
being solely due to his platform rather than this implementation, which
should fix some outstanding uncorrectable error handling. Please let me
know if there's anything additional you'd like to see with this series.

Thanks,
Keith

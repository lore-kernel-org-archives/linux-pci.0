Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9FEC43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 07:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8D6217FA
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 07:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545031414;
	bh=d7VKnYv0PXeWWeHHnlCQv4yMwnyLhJF+373ZsK+m5gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dpxh/P7E2Qa3CjysloijyHzUZUjf227K+EQ2b13qMrLt6zXj9nrhDI9vVCSbCdHef
	 F8fR2D0TPmeA6APKqghqAMnGKaAzIjzMQ/Wt3SjBq68vtvkaxZXGN5cDhCKTu3mEXK
	 ENbyb1/VirlkJTyUyABrtcDdnvj838mnuJ9SLMuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeLQHXd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:23:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeLQHXd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 02:23:33 -0500
Received: from localhost (unknown [171.61.92.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B615D217F4;
        Mon, 17 Dec 2018 07:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545031412;
        bh=d7VKnYv0PXeWWeHHnlCQv4yMwnyLhJF+373ZsK+m5gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsqiVYkg7/GWZstawJr+QFU/zzrDLK7SfW3QSx4C6SXeISBd3KeVIp1CljJxsNiwd
         z/rwzJE0J0VJMnJunQxBtvrtG0ISO/J22IRCeEkgwDD918N5FwfmF5QPmKoyCrF6ma
         aFKU8I8yxeSYmDFCwp8rATBRI8KlJRY/XVEeisfA=
Date:   Mon, 17 Dec 2018 12:53:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: Re: [RFC 1/6] dma: Add Synopsys eDMA IP core driver
Message-ID: <20181217072324.GI2472@vkoul-mobl>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
 <20181212230041.GM99796@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212230041.GM99796@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12-12-18, 17:00, Bjorn Helgaas wrote:
> On Wed, Dec 12, 2018 at 12:13:21PM +0100, Gustavo Pimentel wrote:
> > Add Synopsys eDMA IP core driver to kernel.
> > 
> > This core driver, initializes and configures the eDMA IP using vma-helpers
> > functions and dma-engine subsystem.
> > 
> > Also creates an abstration layer through callbacks allowing different
> > registers mappings in the future, organized in to versions.
> > 
> > This driver can be compile as built-in or external module in kernel.
> > 
> > To enable this driver just select DW_EDMA option in kernel configuration,
> > however it requires and selects automatically DMA_ENGINE and
> > DMA_VIRTUAL_CHANNELS option too.
> > 
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Eugeniy Paltsev <paltsev@synopsys.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Joao Pinto <jpinto@synopsys.com>
> 
> > --- /dev/null
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -0,0 +1,925 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> > +// Synopsys DesignWare eDMA core driver
> 
> The SPDX line in .c files needs the // comment for some obscure reason
> I can't remember, but based on the other drivers/dma/*.c files, it
> looks like the convention is the usual /* .. */ comments for the rest.
> 
> I think the SPDX line is /* */ in .h files though.  The rules are
> under Documentation/ somewhere.

Yes and documented in Documentation/process/license-rules.rst
"license identifier syntax" section

-- 
~Vinod

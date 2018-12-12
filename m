Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D2C65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 23:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53DC20873
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 23:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544655645;
	bh=xrD8KmUofl1jLPNMXTlUYZ7Vbm+d6prIy3JTB4wO8cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dgc6jTmpeFGmJcdzfNUjNMNwwA0FRpbe0v2BxZLA0xmORCkklQlkli7v6uvtAC68f
	 m+FoqJ3/I1590MBiPKstpperJSorMNGfdnVQbb/+Y7FF0M6TcKlMcLcfYcUynHL71/
	 vSpHeQdRmgmeWDfTLh02k/SIXSeGDC/aTKjghxf4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53DC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLLXAp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeLLXAo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 18:00:44 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC49F20851;
        Wed, 12 Dec 2018 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544655644;
        bh=xrD8KmUofl1jLPNMXTlUYZ7Vbm+d6prIy3JTB4wO8cE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHIimy8VNlxz7XJrV/Xk/IZc32Hioxlu5WjPkWi4h+7EtamzlaTcS0+simztp13Ba
         hdiHkRR4vg8imOk8DkZFB1DYi91VMZfEo3W6p0SqTXvbHsv5OKiwt4uyX73LWqBfSg
         +v2lXtmPNDL5lcBKush866X77F/um0GGKj4eaefQ=
Date:   Wed, 12 Dec 2018 17:00:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: Re: [RFC 1/6] dma: Add Synopsys eDMA IP core driver
Message-ID: <20181212230041.GM99796@google.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 12, 2018 at 12:13:21PM +0100, Gustavo Pimentel wrote:
> Add Synopsys eDMA IP core driver to kernel.
> 
> This core driver, initializes and configures the eDMA IP using vma-helpers
> functions and dma-engine subsystem.
> 
> Also creates an abstration layer through callbacks allowing different
> registers mappings in the future, organized in to versions.
> 
> This driver can be compile as built-in or external module in kernel.
> 
> To enable this driver just select DW_EDMA option in kernel configuration,
> however it requires and selects automatically DMA_ENGINE and
> DMA_VIRTUAL_CHANNELS option too.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Eugeniy Paltsev <paltsev@synopsys.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Joao Pinto <jpinto@synopsys.com>

> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -0,0 +1,925 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> +// Synopsys DesignWare eDMA core driver

The SPDX line in .c files needs the // comment for some obscure reason
I can't remember, but based on the other drivers/dma/*.c files, it
looks like the convention is the usual /* .. */ comments for the rest.

I think the SPDX line is /* */ in .h files though.  The rules are
under Documentation/ somewhere.


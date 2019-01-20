Return-Path: <SRS0=1Q+I=P4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A811EC61CE4
	for <linux-pci@archiver.kernel.org>; Sun, 20 Jan 2019 11:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747C020880
	for <linux-pci@archiver.kernel.org>; Sun, 20 Jan 2019 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547984939;
	bh=/P1rg1SGos7vtTvUhSaqOR7kQnK5CMnyWBPfnLX/ipw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kQ9McHKQvSP1IT1hNnb9FxZTOsZGhF/XaH/L7rK6U5Ps4rRJ6WTGYatfd+d7dLzII
	 PfZNnw1cfcgTki8dQQzbCwLFKi/N4GY347ojCnfrgTxCcjQ38GQdZCB1Vm491Hgyp1
	 ktUOhohASOlU4iM1FeLQfd2tokpkdDQDsCi/gtRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfATLs6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 20 Jan 2019 06:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbfATLs6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 20 Jan 2019 06:48:58 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 331992084F;
        Sun, 20 Jan 2019 11:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547984938;
        bh=/P1rg1SGos7vtTvUhSaqOR7kQnK5CMnyWBPfnLX/ipw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNcjXycHpckPAvbgep4YHPyp1Qf94p7mdaQo1A91gO53SbM1kJmDXUBDbtVZR2ScB
         pY0aPMhevvmTKAC1/yct2JvdmmRQ6mZq/e1qgc/uFdYRLDcz+L583Z6O1fYwYrCrbI
         CxLF/kS7MbqjUPd6PUZzkxe1+hOMiQYEI+s74NoM=
Date:   Sun, 20 Jan 2019 17:17:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Luis de Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: Re: [RFC v3 1/7] dmaengine: Add Synopsys eDMA IP core driver
Message-ID: <20190120114724.GW4635@vkoul-mobl>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <d2b6e8bed0c5077425b913e551794ed126d74fb2.1547230339.git.gustavo.pimentel@synopsys.com>
 <e374b2fe-23bd-0bc5-be17-abced19bb4f7@synopsys.com>
 <c28eb503-d17f-5551-a03d-55dad36d0494@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c28eb503-d17f-5551-a03d-55dad36d0494@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16-01-19, 11:53, Gustavo Pimentel wrote:

> >> +	/* Free irqs */
> > 
> > But devm will automatically free it, no ?
> 
> Yes, it shouldn't be there. I'll remove it.

Nope this is correct. we need to ensure irqs are freed and tasklets are
quiesced otherwise you can end up with a case when a spurious interrupt
and then tasklets spinning while core unrolls. devm for irq is not a
good idea unless you really know what you are doing!

-- 
~Vinod

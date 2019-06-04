Return-Path: <SRS0=Xta/=UD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFA3C28CC6
	for <linux-pci@archiver.kernel.org>; Tue,  4 Jun 2019 19:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19E320851
	for <linux-pci@archiver.kernel.org>; Tue,  4 Jun 2019 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559677213;
	bh=+cscAFWsOH7WHGhho7mDMmfcoadmTvFihqyo/p2GdEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OXk41QbrH2pxgQ/VJ8YUWFzO0xfuvkB58JSPa2gTUvA44Spm70uJt9idGOo9/8YCf
	 XKCkQizb/aviUAGJqJRxSZEzaVtbAM6PTNvQ1H/7G7Acg35AaNuCbDaIIQFoDo/xb5
	 BbtjMFmdX9KSYGIzip7a5JcYXQdZPJhxRQUdQM+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFDTkM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Jun 2019 15:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfFDTkM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 15:40:12 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81BB2075B;
        Tue,  4 Jun 2019 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559677211;
        bh=+cscAFWsOH7WHGhho7mDMmfcoadmTvFihqyo/p2GdEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOqBatnXcSTa/YKypYeRlpuhkVCfYhaNyYdPM/fdJzBfUKRMRU3H3wPioXZ+gwmyh
         WRxeMqKat3haFqJBzUmvPnixd9dBi+KW7l1QaHTs1eFzM3dy/vCWE8VYAZwEQcH1id
         k+gftk2wHpP5njYCrBtTZYLk7PfYff1f+cWVT3nk=
Date:   Tue, 4 Jun 2019 14:40:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 0/6] dmaengine: Add Synopsys eDMA IP driver (version 0)
Message-ID: <20190604194008.GA84290@google.com>
References: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 04, 2019 at 03:29:21PM +0200, Gustavo Pimentel wrote:
> Add Synopsys eDMA IP driver (version 0 and for EP side only) to Linux
> kernel. This IP is generally distributed with Synopsys PCIe EndPoint IP
> (depends of the use and licensing agreement), which supports:
>  - legacy and unroll modes
>  - 16 independent and concurrent channels (8 write + 8 read)
>  - supports linked list (scatter-gather) transfer
>  - each linked list descriptor can transfer from 1 byte to 4 Gbytes
>  - supports cyclic transfer
>  - PCIe EndPoint glue-logic
> 
> This patch series contains:
>  - eDMA core + eDMA core v0 driver (implements the interface with
>  DMAengine controller APIs and interfaces with eDMA HW block)
>  - eDMA PCIe glue-logic reference driver (attaches to Synopsys EP and
>  provides memory access to eDMA core driver)

What changed from v1?  (Just curious; I expect somebody else to merge
this since I've already acked the PCI parts.)

Bjorn

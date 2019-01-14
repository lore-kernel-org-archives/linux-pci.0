Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D6AC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 14:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C340A2087E
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547476900;
	bh=bVFDnWH4gpHBdH2pj9xBclrcRcvgXZsx6W6Bi7KYGfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zW6s2jQMIcjA2YJfCmAP5kaqcsvDDDpuoOVoClbYIKwW039mx/F1N8BBCy8X0byHI
	 1PqIHeOX+TP0HhMRWMsbNBcIOoy8KCl0tSbDi9SpJbA0lyH1DI93A9HdgjtUxb1x7X
	 1onJ9QZKQFMqPvfwA1cfiWm9X4mVPHZ53yPiDBXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfANOlk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfANOlk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 09:41:40 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1472086D;
        Mon, 14 Jan 2019 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547476899;
        bh=bVFDnWH4gpHBdH2pj9xBclrcRcvgXZsx6W6Bi7KYGfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iI8eywvEW+rQWSudBCqlq/Gj+a5PfT8PmlUfT8xHE9ex7HTonTZlMGscHBIHUu4Ur
         +zoe9TKjev0Sj7nQ4yalVV2KVEmSj0pOcsGXFnTpS1SgtDkb/MurThDRmb9/f5unpg
         aTaycZcGKsgXWW+VWcal8gSK+BzT4lZFT/zqIks4=
Date:   Mon, 14 Jan 2019 08:41:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: Re: [RFC v3 4/7] PCI: Add Synopsys endpoint EDDA Device id
Message-ID: <20190114144137.GA26781@google.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <55ddfd8c072f63c84c2ba7dd6f42ef8fa594632c.1547230339.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ddfd8c072f63c84c2ba7dd6f42ef8fa594632c.1547230339.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 11, 2019 at 07:33:40PM +0100, Gustavo Pimentel wrote:
> Create and add Synopsys Endpoint EDDA Device id to PCI id list, since
> this id is now being use on two different drivers (pci_endpoint_test.ko
> and dw-edma-pcie.ko).

Nit if you update this series for some other reason: s/id/ID/ in
subject and changelog.  "Id" is an English word, but it's not
applicable in this context, so using "ID" makes it clear that we don't
mean the psychoanalysis term.

Bjorn

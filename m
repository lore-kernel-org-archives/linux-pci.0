Return-Path: <SRS0=6QlD=AD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1696C433DF
	for <linux-pci@archiver.kernel.org>; Mon, 22 Jun 2020 22:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1BC2075A
	for <linux-pci@archiver.kernel.org>; Mon, 22 Jun 2020 22:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592866168;
	bh=qqt0rQSsRVUDKhB9Mlzq2CWIqQkBZ5f5x0VWU2TDQNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=noiz5jWs6Tod7595L6SCKVxvUlgt85CquPm4SE1NAy2tuJG1gy13V5C0AB7L5AAa+
	 mwxaqSt+0AwkkoK5ApPGAojdtBZXZOzMF3elfRkASUUkEqvScKHLqcsvbLyiWwZ6Zq
	 OItZ33pnf3fdVqmuu5PiZYaKA5HYSs1Te+fv1HVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgFVWt1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731022AbgFVWt1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 18:49:27 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081BE2073E;
        Mon, 22 Jun 2020 22:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592866167;
        bh=qqt0rQSsRVUDKhB9Mlzq2CWIqQkBZ5f5x0VWU2TDQNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lYLSSOUzKpqb7VK/L7WLW5uwyet9OTdqfR1PGyrYTg/Z4oVbrRJZxoMYz+17AGB0V
         WzfafWEoyuOB5sc8SC2LDwsj8oa9BIu7eubZUVTyoMs/ci27q56j33LrEHecFJYiAP
         UNdaHzPSvhqBiR7h8vPlJv0xUTJX8WnHAnWLZtbg=
Date:   Mon, 22 Jun 2020 17:49:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Shmuel Hazan <sh@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: setup BAR0 to internal-regs
Message-ID: <20200622224925.GA2332050@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622204033.72055de8@windsurf.home>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 22, 2020 at 08:40:33PM +0200, Thomas Petazzoni wrote:
> On Mon, 22 Jun 2020 12:25:16 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > > As a result of the requirement above, without this patch, MSI won't
> > > function and therefore some devices won't operate properly without
> > > pci=nomsi.  
> > 
> > Does that mean MSIs never worked at all with mvebu?
> 
> They definitely worked. I think what happens is that this register was
> normally setup by the vendor-specific bootloader, and thanks to
> firmware initialization, Linux had MSIs working properly.
> 
> With other bootloaders that initialize the PCIe block differently, or
> even not at all, it became clear this init was missing in Linux.

That would be very useful information to include in the commit log.

Are there any other similar bugs lurking?  Other registers where we
implicitly rely on the bootloader to do something?

Bjorn

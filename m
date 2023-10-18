Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF65CDB47E
	for <linux-pci@archiver.kernel.org>; Wed, 18 Oct 2023 19:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJRTFu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 18 Oct 2023 15:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJRTFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 15:05:49 -0400
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 12:05:46 PDT
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE75311B
        for <linux-pci@vger.kernel.org>; Wed, 18 Oct 2023 12:05:46 -0700 (PDT)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id D30DF285CBB; Wed, 18 Oct 2023 20:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1697655464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9yn0OXAnCmzY7lwJFXFn0AYA1B5/mgOyTt1zP0XDe1s=;
        b=atlX/S08wMu4qfLN9tzNTeUTckS79Ye3IgfKRXMHMe0f/5GsLxKkkHaHoYK/UbMhwhoJgq
        W9upKIITPTVrtI9S/mOG28mrmcNyeYPPlgYMcWMw1q0zsyKnL0IBRlul3n83DbHmo9MKNX
        /PYIBQU7B3DIds/F236qhaa+4yglgT8=
Date:   Wed, 18 Oct 2023 20:57:44 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Mateusz Nowicki <mateusz.nowicki@solidigm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/8] lspci: Decode more DevCtl2 fields
Message-ID: <mj+md-20231018.185736.16705.nikam@ucw.cz>
References: <20231018160836.1361510-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018160836.1361510-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

> Decode several more DevCtl2 fields and show Interrupt Message Numbers more
> consistently.
> 
> Bjorn Helgaas (8):
>   lspci: Reorder PCIe DevCtl2 fields to match spec
>   lspci: Decode PCIe DevCtl2 ID-Based Ordering Enables
>   lspci: Decode PCIe DevCtl2 Emergency Power Reduction Request
>   lspci: Decode PCIe DevCtl2 End-to-End TLP Prefix Blocking
>   lspci: Decode PCIe LnkCtl Link Disable as 'LnkDisable'
>   lspci: Print PCIe Interrupt Message Numbers consistently
>   lspci: Remove spurious colon (':') from PCIe PTM decoding
>   setpci: Fix man page typo

Thanks, applied.

				Martin

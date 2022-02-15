Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9842FC433EF
	for <linux-pci@archiver.kernel.org>; Tue, 15 Feb 2022 21:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244388AbiBOV3Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:29:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiBOV3Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 16:29:24 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BA38C24AD;
        Tue, 15 Feb 2022 13:29:13 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A1C8492009C; Tue, 15 Feb 2022 22:29:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9AC4F92009B;
        Tue, 15 Feb 2022 21:29:12 +0000 (GMT)
Date:   Tue, 15 Feb 2022 21:29:12 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING][PATCH v3] pci: Work around ASMedia ASM2824 PCIe link training
 failures
In-Reply-To: <alpine.DEB.2.21.2202010240190.58572@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2202152121580.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202010240190.58572@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Feb 2022, Maciej W. Rozycki wrote:

> Attempt to handle cases with a downstream port of the ASMedia ASM2824 
> PCIe switch where link training never completes and the link continues 
> switching between speeds indefinitely with the data link layer never 
> reaching the active state.

 Ping for:
<https://lore.kernel.org/all/alpine.DEB.2.21.2202010240190.58572@angie.orcam.me.uk/>

  Maciej

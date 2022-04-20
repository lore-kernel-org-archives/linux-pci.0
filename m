Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF0EC433EF
	for <linux-pci@archiver.kernel.org>; Wed, 20 Apr 2022 19:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381765AbiDTTZ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Apr 2022 15:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381756AbiDTTZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 15:25:56 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6903F45AE6;
        Wed, 20 Apr 2022 12:23:09 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2245092009D; Wed, 20 Apr 2022 21:23:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1BAFC92009C;
        Wed, 20 Apr 2022 20:23:08 +0100 (BST)
Date:   Wed, 20 Apr 2022 20:23:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING^2][PATCH v4] pci: Work around ASMedia ASM2824 PCIe link training
 failures
In-Reply-To: <alpine.DEB.2.21.2203310037480.44113@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204202021100.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203310037480.44113@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 31 Mar 2022, Maciej W. Rozycki wrote:

> Attempt to handle cases with a downstream port of the ASMedia ASM2824 
> PCIe switch where link training never completes and the link continues 
> switching between speeds indefinitely with the data link layer never 
> reaching the active state.

 Ping for:
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2203310037480.44113@angie.orcam.me.uk/>

  Maciej

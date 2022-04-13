Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C515C433F5
	for <linux-pci@archiver.kernel.org>; Wed, 13 Apr 2022 22:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbiDMWzt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiDMWzq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 18:55:46 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70EE55882D;
        Wed, 13 Apr 2022 15:53:23 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C07E692009D; Thu, 14 Apr 2022 00:53:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id BC4E692009C;
        Wed, 13 Apr 2022 23:53:22 +0100 (BST)
Date:   Wed, 13 Apr 2022 23:53:22 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING^2][PATCH] PCI: Avoid handing out address 0 to devices
In-Reply-To: <alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204132024220.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 26 Feb 2022, Maciej W. Rozycki wrote:

> We have numerous platforms that permit assigning addresses from 0 to PCI 
> devices, both in the memory and the I/O bus space, and we happily do so 
> if there is no conflict, e.g.:

 Ping for:
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk/>

  Maciej


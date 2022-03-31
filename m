Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B904C433EF
	for <linux-pci@archiver.kernel.org>; Thu, 31 Mar 2022 07:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiCaHNx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Mar 2022 03:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiCaHNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:13:33 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CA10BD2F0;
        Thu, 31 Mar 2022 00:11:25 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 91CB89200B3; Thu, 31 Mar 2022 09:11:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8FA5592009E;
        Thu, 31 Mar 2022 08:11:24 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:11:24 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PING][PATCH] PCI: Avoid handing out address 0 to devices
In-Reply-To: <alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203310133390.44113@angie.orcam.me.uk>
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

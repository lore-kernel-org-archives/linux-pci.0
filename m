Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82563C433FE
	for <linux-pci@archiver.kernel.org>; Wed, 13 Apr 2022 22:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiDMWzl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiDMWzl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 18:55:41 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 764DE483B3;
        Wed, 13 Apr 2022 15:53:18 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D4AE092009D; Thu, 14 Apr 2022 00:53:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D1BEA92009C;
        Wed, 13 Apr 2022 23:53:17 +0100 (BST)
Date:   Wed, 13 Apr 2022 23:53:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PING^4][PATCH v2] PCI: Sanitise firmware BAR assignments behind a
 PCI-PCI bridge
In-Reply-To: <alpine.DEB.2.21.2202010150100.58572@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204132021330.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202010150100.58572@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Feb 2022, Maciej W. Rozycki wrote:

> Fix an issue with the Tyan Tomcat IV S1564D system, the BIOS of which 
> does not assign PCI buses beyond #2, where our resource reallocation 
> code preserves the reset default of an I/O BAR assignment outside its 
> upstream PCI-to-PCI bridge's I/O forwarding range for device 06:08.0 in 
> this log:

 Ping for:
<https://lore.kernel.org/all/alpine.DEB.2.21.2202010150100.58572@angie.orcam.me.uk/>

  Maciej


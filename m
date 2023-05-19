Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE0C77B7A
	for <linux-pci@archiver.kernel.org>; Fri, 19 May 2023 11:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjESLVy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 May 2023 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjESLVx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 07:21:53 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFB13AD;
        Fri, 19 May 2023 04:21:51 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 62BB992009E; Fri, 19 May 2023 13:21:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5B8CC92009B;
        Fri, 19 May 2023 12:21:50 +0100 (BST)
Date:   Fri, 19 May 2023 12:21:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/PCI: Fix a sanity check in
 pirq_convert_irt_table()
In-Reply-To: <bc8422a8bf3ff99809413eb62dd12aacc85a9950.1683356951.git.christophe.jaillet@wanadoo.fr>
Message-ID: <alpine.DEB.2.21.2305190345331.50034@angie.orcam.me.uk>
References: <bc8422a8bf3ff99809413eb62dd12aacc85a9950.1683356951.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 6 May 2023, Christophe JAILLET wrote:

> We compare the size in bytes of a struct (and its ending flexible array)
> with the number of elements in a flexible array.

 Incorrect, see the inline documentation for the struct.

> This is wrong and "ir->size < ir->used" is likely to be always false.

 Hopefully, but we've seen all kinds of rubbish in PC BIOS data, and this 
data structure seems available for OEMs to program with a tool called BCP.  
Better safe than sorry.  Therefore, NAK.

  Maciej

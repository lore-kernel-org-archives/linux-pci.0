Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAF5C7EE2F
	for <linux-pci@archiver.kernel.org>; Fri, 19 May 2023 11:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjESLY1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 May 2023 07:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjESLYZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 07:24:25 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A16F11B7;
        Fri, 19 May 2023 04:24:18 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id CAE0892009E; Fri, 19 May 2023 13:24:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C3C2892009B;
        Fri, 19 May 2023 12:24:17 +0100 (BST)
Date:   Fri, 19 May 2023 12:24:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/PCI: Slightly simplify
 pirq_convert_irt_table()
In-Reply-To: <84bf047b01452a72642dbe355b02ef016c985a91.1683356951.git.christophe.jaillet@wanadoo.fr>
Message-ID: <alpine.DEB.2.21.2305190334330.50034@angie.orcam.me.uk>
References: <bc8422a8bf3ff99809413eb62dd12aacc85a9950.1683356951.git.christophe.jaillet@wanadoo.fr> <84bf047b01452a72642dbe355b02ef016c985a91.1683356951.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 6 May 2023, Christophe JAILLET wrote:

> 'size' if computed twice. *ir and *it being the same, the result is the
> same as well.

 There is no `it' data object in this function; I presume you meant `rt'. 
Then `*ir' and `*rt' are of a different type each, hence the calculations 
are not the same.  If they were the same, the function wouldn't be needed 
at all in the first place.  Therefore, NAK.

> While at it, also use struct_size() which is less verbose, more robust and
> more informative.

 This might be a valuable clean-up, thank you, please submit separately.

  Maciej

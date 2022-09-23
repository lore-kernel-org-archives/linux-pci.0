Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F80C6FA8B
	for <linux-pci@archiver.kernel.org>; Fri, 23 Sep 2022 03:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIWDDo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Sep 2022 23:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiIWDDO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 23:03:14 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26AF19412A;
        Thu, 22 Sep 2022 20:03:10 -0700 (PDT)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 28N2vYVY028156;
        Thu, 22 Sep 2022 21:57:35 -0500
Message-ID: <575f239205e8635add81c9f902b7d9db7beb83ea.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: Enable PCI domains in /proc when PCI bus
 numbers are not unique
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 23 Sep 2022 12:57:32 +1000
In-Reply-To: <87wnanu4vf.fsf@mpe.ellerman.id.au>
References: <20220820115113.30581-1-pali@kernel.org>
         <878rnclq47.fsf@mpe.ellerman.id.au> <20220825083713.4glfivegmodluiun@pali>
         <87wnanu4vf.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2022-09-01 at 13:53 +1000, Michael Ellerman wrote:
> > 
> > I sent two patches which do another steps to achieve it:
> > https://lore.kernel.org/linuxppc-dev/20220817163927.24453-1-pali@kernel.org/t/#u
> > 
> > Main blocker is pci-OF-bus-map which is in direct conflict with
> > CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT and which used on chrp and pmac.
> > And I have no idea if pci-OF-bus-map is still needed or not.
> 
> Yeah thanks, I saw those patches.
> 
> I can't find any code that refers to pci-OF-bus-map, so I'm inclined to
> remove it entirely.
> 
> But I'll do some more searching to see if I can find any references to
> it in old code.

Trying to remember ... :-)

So this is what I recall at this point:

 - Ancient X11 didn't understand domains in /proc and thus would barf,
which was the primary reason for not enabling them always iirc...

 - There might be something else with early PowerMacs (Grand Central
chipset) where we have effectively two domains (gc and chaos) but
overlapping bus numbers. There might still be pre-historical code in
there that assumes it's that way though I can't see anything obvious.
Paul might still have one of these :-) (PowerMac 7200/7500/8500/9500
afaik).

 - pci-OF-bus-map predates the PCI layer keeping track of the PCI/OF
relationship. I don't believe it's still used anywhere in the kernel,
though it's possible (unlikely ?) that some garbage remains in
userspace that does.

At this point, I wouldn't object to tearing this all out and just
having domains always (and see what the fallout is).

Cheers,
Ben.

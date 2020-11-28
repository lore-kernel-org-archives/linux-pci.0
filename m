Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAF8C83025
	for <linux-pci@archiver.kernel.org>; Sat, 28 Nov 2020 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B048E20706
	for <linux-pci@archiver.kernel.org>; Sat, 28 Nov 2020 22:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgK1VuP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:50:15 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54508 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbgK1S1V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Nov 2020 13:27:21 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kj4vY-009HAv-Mx; Sat, 28 Nov 2020 19:26:32 +0100
Date:   Sat, 28 Nov 2020 19:26:32 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, kernel-team@android.com,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: Move Jason Cooper to CREDITS
Message-ID: <20201128182632.GC2191767@lunn.ch>
References: <20201128103707.332874-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128103707.332874-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 28, 2020 at 10:37:07AM +0000, Marc Zyngier wrote:
> Jason's email address has now been bouncing for weeks, and no
> reply was received when trying to reach out on other addresses.
> 
> We really hope he is OK. But until we hear of his whereabouts,
> let's move him to the CREDITS file so that people stop Cc-ing
> him.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Thanks Marc.

Acked-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

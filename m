Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDC8C00140
	for <linux-pci@archiver.kernel.org>; Mon,  8 Aug 2022 12:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbiHHMcC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiHHMcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 08:32:02 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471CC654A
        for <linux-pci@vger.kernel.org>; Mon,  8 Aug 2022 05:32:00 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3DEBE2223A;
        Mon,  8 Aug 2022 14:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659961918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVdD5KyOlwDCY2ilNN7Xn+70cPmI5n/8xdBFVR6kJ7U=;
        b=fzp7GoxT/+0lmEBBZHrtbuAAzByw1imVy8GcrUpgidzxEalJ6SyBFT/wvC1erRoHp4C4ap
        dfUltaZBE7Jpa9bkIeLHrOcYE20NuuewlxW99V6f2QeEal0MG7RVXQJsFDBeXEH4UCyJQ4
        qZIRNmwiclVksv9mhgvr6WbMhIpVHEU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Aug 2022 14:31:57 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>, heiko.thiery@gmail.com
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on
 kontron-pitx-imx8m
In-Reply-To: <YvEAF1ZvFwkNDs01@sirena.org.uk>
References: <62eed399.170a0220.2503a.1c64@mx.google.com>
 <YvEAF1ZvFwkNDs01@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c00aceb04d4c743282015564b68bcd0b@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+ Heiko as the owner of that board]

Am 2022-08-08 14:22, schrieb Mark Brown:
> On Sat, Aug 06, 2022 at 01:48:25PM -0700, KernelCI bot wrote:
> 
> The KernelCI bisection bot found that 5a46079a96451 "PM: domains: 
> Delete
> usage of driver_deferred_probe_check_state()" triggered a failure to
> probe the PCI controller or attached ethernet on kontron-pitx-imx8m.
> There's no obvious errors in the boot log when things fail, we simply
> don't see any of the announcements from the PCI controller probe like 
> we
> do on a working boot:

I guess that is the same as:
https://lore.kernel.org/lkml/Yr3vEDDulZj1Dplv@sirena.org.uk/

-michael

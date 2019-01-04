Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF946C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 11:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2FA2173B
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 11:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfADLR2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:17:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40360 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfADLR2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 06:17:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62A4D15AD;
        Fri,  4 Jan 2019 03:17:28 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06AA33F5D4;
        Fri,  4 Jan 2019 03:17:26 -0800 (PST)
Date:   Fri, 4 Jan 2019 11:17:21 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     bhelgaas@google.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: amlogic: fix build failure due to missing
 linux/gpio/consumer.h header
Message-ID: <20190104111721.GA23713@e107981-ln.cambridge.arm.com>
References: <1546592917-27846-1-git-send-email-clabbe@baylibre.com>
 <20190104103015.GA3738@red-moon>
 <20190104103626.GA8448@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104103626.GA8448@Red>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 04, 2019 at 11:36:26AM +0100, LABBE Corentin wrote:
> On Fri, Jan 04, 2019 at 10:30:25AM +0000, Lorenzo Pieralisi wrote:
> > On Fri, Jan 04, 2019 at 09:08:37AM +0000, Corentin Labbe wrote:
> > > When building on x86, I got the following build failure:
> > 
> > Hi,
> > 
> > what tree are you testing on and which config ?
> 
> I use the next-20190102 tree
> The config can be found at http://kernel.montjoie.ovh/configs/x86

Ok, right, it is a config that unfortunately the bots failed to test, I
will pick this up and send it to Bjorn for -rc2 (given that the PCI tree
is not in mainline yet).

Thanks,
Lorenzo

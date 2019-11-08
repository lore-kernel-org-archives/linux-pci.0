Return-Path: <SRS0=Zps5=ZA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA004FA372C
	for <linux-pci@archiver.kernel.org>; Fri,  8 Nov 2019 11:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B99222CE
	for <linux-pci@archiver.kernel.org>; Fri,  8 Nov 2019 11:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390927AbfKHLuD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:50:03 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63750 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388183AbfKHLuC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Nov 2019 06:50:02 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 1a3ae1af6712ba25; Fri, 8 Nov 2019 12:49:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/5] PCI: PM: Cleanups related to power state changes
Date:   Fri, 08 Nov 2019 12:49:59 +0100
Message-ID: <10030157.3aYrIYsZTJ@kreacher>
In-Reply-To: <20191106190250.GA238633@google.com>
References: <20191106190250.GA238633@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, November 6, 2019 8:02:50 PM CET Bjorn Helgaas wrote:
> On Tue, Nov 05, 2019 at 11:11:57AM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > This series rearranges some PCI power management code to make it somewhat
> > easier to follow and explicitly consolidate the power-up (transitions to
> > D0) code path.
> > 
> > It is not intended to change the functionality of the code.
> 
> Applied with Mika's reviewed-by to pci/pm for v5.5, thanks!

Any chance to push this out, though?  That would help with integration/testing
a bit ...




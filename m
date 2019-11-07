Return-Path: <SRS0=9PB/=Y7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E5BFC6194
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 01:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F75221D79
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 01:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKGBHI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:07:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:39135 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfKGBHI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 20:07:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xA715jlv031273;
        Wed, 6 Nov 2019 19:05:46 -0600
Message-ID: <50469ff0f7f7fb8513bf4daed018c2d96503e27a.camel@kernel.crashing.org>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Allocate resources directly under
 the non-hotplug bridge
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Valerio Passini <passini.valerio@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Wed, 06 Nov 2019 17:05:45 -0800
In-Reply-To: <20191106232405.GA242013@google.com>
References: <20191106232405.GA242013@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-11-06 at 17:24 -0600, Bjorn Helgaas wrote:
> [+cc Ben]

Note: I'm travelling this week, I'll try to have a look in the next few
days but can't promise.

Cheers,
Ben.


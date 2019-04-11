Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C027BC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 09:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905F020850
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 09:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDKJ2f (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:28:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38710 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfDKJ2f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 05:28:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 355B280D;
        Thu, 11 Apr 2019 02:28:35 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A0D23F718;
        Thu, 11 Apr 2019 02:28:34 -0700 (PDT)
Date:   Thu, 11 Apr 2019 10:28:31 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools: Fixes for pcitest
Message-ID: <20190411092831.GB6227@red-moon>
References: <20190404110609.26158-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404110609.26158-1-kishon@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 04, 2019 at 04:36:07PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> This series includes a couple of patches, one which fixes
> inadvertent removal of pcitest.sh from kernel repo when
> doing a "clean" and other lets the user use 'h' option to
> display the list of options supported by pcitest.
> 
> Thanks
> Kishon
> 
> Kishon Vijay Abraham I (2):
>   tools: PCI: Add 'h' in optstring of getopt()
>   tools: PCI: Handle pcitest.sh independently from pcitest
> 
>  tools/pci/Makefile  | 8 +++++++-
>  tools/pci/pcitest.c | 4 ++--
>  2 files changed, 9 insertions(+), 3 deletions(-)

Applied to pci/misc for v5.2, thanks.

Lorenzo

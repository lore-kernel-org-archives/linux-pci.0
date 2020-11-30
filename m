Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59F4C64E90
	for <linux-pci@archiver.kernel.org>; Mon, 30 Nov 2020 12:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D00A206D8
	for <linux-pci@archiver.kernel.org>; Mon, 30 Nov 2020 12:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgK3MUh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 30 Nov 2020 07:20:37 -0500
Received: from foss.arm.com ([217.140.110.172]:53684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgK3MUg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 07:20:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E79630E;
        Mon, 30 Nov 2020 04:19:51 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 213963F66B;
        Mon, 30 Nov 2020 04:19:50 -0800 (PST)
Date:   Mon, 30 Nov 2020 12:19:47 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] PCI: iproc: Add fixes to pcie iproc
Message-ID: <20201130121947.GD16758@e121166-lin.cambridge.arm.com>
References: <20201001060054.6616-1-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001060054.6616-1-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 01, 2020 at 11:30:51AM +0530, Srinath Mannam wrote:
> This patch series contains fixes and improvements to pcie iproc driver.
> 
> This patch set is based on Linux-5.9.0-rc2.
> 
> Changes from v2:
>   - Addressed Bjorn's review comments
>      - Corrected subject line and commit message of Patches 1 and 2.
>      
> Changes from v1:
>   - Addressed Bjorn's review comments
>      - pcie_print_link_status is used to print Link information.
>      - Added IARR1/IMAP1 window map definition.
> 
> Bharat Gooty (1):
>   PCI: iproc: Fix out-of-bound array accesses
> 
> Roman Bacik (1):
>   PCI: iproc: Invalidate correct PAXB inbound windows
> 
> Srinath Mannam (1):
>   PCI: iproc: Display PCIe Link information
> 
>  drivers/pci/controller/pcie-iproc.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)

I need Ray a/o Scott ACK to proceed.

Thanks,
Lorenzo

Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF07C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E263D218D0
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfC2Qvu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:51:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35710 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbfC2Qvu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 12:51:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF0C480D;
        Fri, 29 Mar 2019 09:51:49 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 349533F68F;
        Fri, 29 Mar 2019 09:51:48 -0700 (PDT)
Date:   Fri, 29 Mar 2019 16:51:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add IPROC PCIe new features
Message-ID: <20190329165145.GC8768@e107981-ln.cambridge.arm.com>
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 01, 2019 at 10:22:14AM +0530, Srinath Mannam wrote:
> This patch set extends support of new IPROC PCIe host controller features
>  - Add CRS check using controller register status flags
>  - Add outbound window mapping configuration for 32-bit I/O region
> 
> This patch set is based on Linux-5.0-rc2.
> 
> Changes from v3:
>   - Addressed Lorenzo Pieralisi comments.
> 
> Changes from v2:
>   - Based on Lorenzo Pieralisi comments, commit logs are expanded.
> 
> Changes from v1:
>   - Addressed Bjorn Helgaas comments.
>   - Removed set order mode patch from patchset.
> 
> Srinath Mannam (2):
>   PCI: iproc: Add CRS check in config read
>   PCI: iproc: Add outbound configuration for 32-bit I/O region
> 
>  drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----

I need Ray a/o Scott ACK to merge this series, thanks.

Lorenzo

Return-Path: <SRS0=GTBH=ZD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364D7C17441
	for <linux-pci@archiver.kernel.org>; Mon, 11 Nov 2019 14:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0675021D7F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Nov 2019 14:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKKO7i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:59:38 -0500
Received: from foss.arm.com ([217.140.110.172]:46832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfKKO7i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 09:59:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD53031B;
        Mon, 11 Nov 2019 06:59:37 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06D583F534;
        Mon, 11 Nov 2019 06:59:36 -0800 (PST)
Date:   Mon, 11 Nov 2019 14:59:34 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tom Joseph <tjoseph@cadence.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2]PCI: cadence: Convert drivers to core library
Message-ID: <20191111145934.GC9653@e121166-lin.cambridge.arm.com>
References: <1573475444-17903-1-git-send-email-tjoseph@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573475444-17903-1-git-send-email-tjoseph@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 11, 2019 at 12:30:42PM +0000, Tom Joseph wrote:
> This patch series intend to refactor the cadence pcie host and endpoint
> driver files as a library, such that this can be used by other platform
> drivers. A new directory 'cadence' is created to group all the cadence
> derivatives.
> 
> v4:
> - Updated commit title for [PATCH 2/2] as adviced by Andrew
> 
> v3:
> - Commit logs rephrased and corrected as suggested by Andrew and Kishon
> - Created a new folder 'cadence', as suggested by Kishon.
> - Removed few unwanted codes, as pointed out by review comments
> 
> Tom Joseph (2):
>   PCI: cadence: Refactor driver to use as a core library
>   PCI: cadence: Move all files to per-device cadence directory
> 
>  drivers/pci/controller/Kconfig                     |  29 +---
>  drivers/pci/controller/Makefile                    |   4 +-
>  drivers/pci/controller/cadence/Kconfig             |  45 ++++++
>  drivers/pci/controller/cadence/Makefile            |   5 +
>  .../pci/controller/{ => cadence}/pcie-cadence-ep.c |  96 +-----------
>  .../controller/{ => cadence}/pcie-cadence-host.c   |  95 +----------
>  drivers/pci/controller/cadence/pcie-cadence-plat.c | 174 +++++++++++++++++++++
>  .../pci/controller/{ => cadence}/pcie-cadence.c    |   0
>  .../pci/controller/{ => cadence}/pcie-cadence.h    |  77 +++++++++
>  9 files changed, 315 insertions(+), 210 deletions(-)
>  create mode 100644 drivers/pci/controller/cadence/Kconfig
>  create mode 100644 drivers/pci/controller/cadence/Makefile
>  rename drivers/pci/controller/{ => cadence}/pcie-cadence-ep.c (83%)
>  rename drivers/pci/controller/{ => cadence}/pcie-cadence-host.c (76%)
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-plat.c
>  rename drivers/pci/controller/{ => cadence}/pcie-cadence.c (100%)
>  rename drivers/pci/controller/{ => cadence}/pcie-cadence.h (82%)
> 

Applied to pci/cadence, thanks.

Lorenzo

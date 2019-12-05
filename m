Return-Path: <SRS0=yElJ=Z3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450D0C43603
	for <linux-pci@archiver.kernel.org>; Thu,  5 Dec 2019 16:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1450124648
	for <linux-pci@archiver.kernel.org>; Thu,  5 Dec 2019 16:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfLEQYD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:24:03 -0500
Received: from foss.arm.com ([217.140.110.172]:39610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbfLEQYD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Dec 2019 11:24:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA68E31B;
        Thu,  5 Dec 2019 08:24:02 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7660C3F52E;
        Thu,  5 Dec 2019 08:24:01 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:23:56 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, rdunlap@infradead.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1 0/1]Fix build warning and errors
Message-ID: <20191205162356.GA19365@e121166-lin.cambridge.arm.com>
References: <cover.1574929426.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574929426.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 28, 2019 at 04:31:12PM +0800, Dilip Kota wrote:
> Mark Intel PCIe driver depends on MSI IRQ Domain to fix
> the below warnings and respective build errors.
> 
> WARNING: unmet direct dependencies detected for PCIE_DW_HOST
>   Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>   Selected by [y]:
>   - PCIE_INTEL_GW [=y] && PCI [=y] && OF [=y] && (X86 [=y] || COMPILE_TEST [=n])
> 
> Dilip Kota (1):
>   PCI: dwc: Kconfig: Mark intel PCIe driver depends on MSI IRQ Domain
> 
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Hi Dilip,

would you mind squashing this patch into the initial series and repost
it (rebase it against current mainline) straight away ? I will
rebase it to -rc1 and push it out next week (I am asking since then
I am afk for a month so I would like to get your code queued asap,
it is ready).

Thanks,
Lorenzo

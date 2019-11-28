Return-Path: <SRS0=N5mx=ZU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69FCC432C0
	for <linux-pci@archiver.kernel.org>; Thu, 28 Nov 2019 10:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C230B21741
	for <linux-pci@archiver.kernel.org>; Thu, 28 Nov 2019 10:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfK1KUC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:20:02 -0500
Received: from foss.arm.com ([217.140.110.172]:33292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfK1KUC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Nov 2019 05:20:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 941831FB;
        Thu, 28 Nov 2019 02:20:01 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 299793F6C4;
        Thu, 28 Nov 2019 02:20:00 -0800 (PST)
Date:   Thu, 28 Nov 2019 10:19:55 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, rdunlap@infradead.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, bhelgaas@google.com
Subject: Re: [PATCH v1 0/1]Fix build warning and errors
Message-ID: <20191128101954.GA30478@e121166-lin.cambridge.arm.com>
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

[+Bjorn]

On Thu, Nov 28, 2019 at 04:31:12PM +0800, Dilip Kota wrote:
> Mark Intel PCIe driver depends on MSI IRQ Domain to fix
> the below warnings and respective build errors.
> 
> WARNING: unmet direct dependencies detected for PCIE_DW_HOST
>   Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>   Selected by [y]:
>   - PCIE_INTEL_GW [=y] && PCI [=y] && OF [=y] && (X86 [=y] || COMPILE_TEST [=n])

I don't know yet if we fix it up or I drop the series, given how
late this is in the release cycle and very short time this code
has been in -next.

Lorenzo

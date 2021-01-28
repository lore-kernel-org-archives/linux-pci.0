Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0173AC433E0
	for <linux-pci@archiver.kernel.org>; Thu, 28 Jan 2021 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC27A64DCC
	for <linux-pci@archiver.kernel.org>; Thu, 28 Jan 2021 10:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhA1Ks5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Jan 2021 05:48:57 -0500
Received: from foss.arm.com ([217.140.110.172]:56418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhA1Ksy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 05:48:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D5091FB;
        Thu, 28 Jan 2021 02:48:09 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.46.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3A8A3F68F;
        Thu, 28 Jan 2021 02:48:06 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
        Toan Le <toan@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: Fix CRS SV comment
Date:   Thu, 28 Jan 2021 10:47:59 +0000
Message-Id: <161183083785.8020.12831888278176058281.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210126213503.2922848-1-helgaas@kernel.org>
References: <20210126213503.2922848-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 Jan 2021 15:35:03 -0600, Bjorn Helgaas wrote:
> Configuration Request Retry Status ("CRS") must be supported by all PCIe
> devices.  CRS Software Visibility is an optional feature that enables a
> Root Port to make CRS visible to software by returning a special data value
> to complete a config read.
> 
> Clarify a comment to say that it is "CRS SV", not "CRS", that can be
> enabled.

Applied to pci/misc, thanks!

[1/1] PCI: xgene: Fix CRS SV comment
      https://git.kernel.org/lpieralisi/pci/c/cc4a08cd09

Thanks,
Lorenzo

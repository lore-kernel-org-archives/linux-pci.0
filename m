Return-Path: <SRS0=isgL=56=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA12C2BB86
	for <linux-pci@archiver.kernel.org>; Tue, 14 Apr 2020 10:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBAE2075E
	for <linux-pci@archiver.kernel.org>; Tue, 14 Apr 2020 10:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438695AbgDNKzQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:55:16 -0400
Received: from foss.arm.com ([217.140.110.172]:52706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438412AbgDNKe2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 06:34:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0D1C31B;
        Tue, 14 Apr 2020 03:22:45 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B236C3F6C4;
        Tue, 14 Apr 2020 03:22:43 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:22:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mans Rullgard <mans@mansr.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Robert Richter <rrichter@marvell.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Toan Le <toan@os.amperecomputing.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Constify struct pci_ecam_ops
Message-ID: <20200414102240.GB22140@gaia>
References: <20200409234923.21598-1-robh@kernel.org>
 <20200409234923.21598-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409234923.21598-2-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 09, 2020 at 05:49:21PM -0600, Rob Herring wrote:
> struct pci_ecam_ops is typically DT match table data which is defined to
> be const. It's also best practice for ops structs to be const. Ideally,
> we'd make struct pci_ops const as well, but that becomes pretty
> invasive, so for now we just cast it where needed.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Jonathan Chocron <jonnyc@amazon.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Robert Richter <rrichter@marvell.com>
> Cc: Toan Le <toan@os.amperecomputing.com>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Mans Rullgard <mans@mansr.com>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/kernel/pci.c                   |  4 ++--

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

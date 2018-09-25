Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F86BC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4168020C0A
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 09:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4168020C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeIYQFi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:05:38 -0400
Received: from foss.arm.com ([217.140.101.70]:48126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeIYQFh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 12:05:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0635080D;
        Tue, 25 Sep 2018 02:58:52 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82D293F5B3;
        Tue, 25 Sep 2018 02:58:50 -0700 (PDT)
Date:   Tue, 25 Sep 2018 10:59:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] pci-dra7xx: Enable errata i870 workaround for RC
 mode
Message-ID: <20180925095929.GA29304@red-moon>
References: <20180925083024.6960-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925083024.6960-1-vigneshr@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 02:00:22PM +0530, Vignesh R wrote:
> Make workaround for errata i870 applicable in Host mode as
> well(previously it was enabled only for EP mode) as per errata
> documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
> Driver will continue to work with w/o applying errata in host mode when
> using older DT, to maintain backward compatibility.
> 
> Tested on DRA72 EVM
> 
> Changes since v4:
> Fail driver probe if DT binding is absent for EP(as it is in current
> code)
> 
> Changes since v3:
> Rebase onto latest next
> Drop DT patches from this series. They will be sent separately once
> driver changes in this series is merged.
> 
> Changes since v2:
> Reorder patch 2 to appear at the last.
> Collect all the ACKs
> 
> Changes since v1:
> Drop IRQ handling rework (will be sent out separately)
> 
> 
> Vignesh R (2):
>   dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
>     mode
>   pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
> 
>  Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
>  drivers/pci/controller/dwc/pci-dra7xx.c          | 11 ++++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)

Applied to pci/dwc for v4.20, thanks.

Lorenzo

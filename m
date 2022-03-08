Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295AAC433F5
	for <linux-pci@archiver.kernel.org>; Tue,  8 Mar 2022 11:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346141AbiCHLje (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Mar 2022 06:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346008AbiCHLje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2022 06:39:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7172B1BB;
        Tue,  8 Mar 2022 03:38:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17B34B81870;
        Tue,  8 Mar 2022 11:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AB9C340EB;
        Tue,  8 Mar 2022 11:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646739514;
        bh=unU7sKw0Lo59/i+/tOdAJE2plmJdYuKWXq0df6aSLRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+FXaz6ktac2HCxf10wUzOxNsOFwgnlZSX/iarNklsN+T6KoZLhL0Av/b+5ZQHmzX
         W2szQoUMb5vnEsP0ikd6d4rd6hORyX44S+cQ4sDjgwCSg3/dQiNcO77ye2fbRKu+oV
         R+PiaA0CAKFLOv6Z0C3S5YUFHg19L9R80YIvJ/SPadNBVLXgqB8uFyIK5cDiIxV77C
         +3uGn1UTKm8FMnxJ5/Ex0VeUiPUlxnOYhTgDWziAT6/bZc5efbuRcVSlZDi5D/ffj0
         h6y2VsvCLQfp8exqJFFfVqKzWod7Auzw0E//fqPrHjTvrBlAHq8Rgt7tPI5N4LFsG5
         arEuICEPE0b5g==
Received: by pali.im (Postfix)
        id 7B4F37D5; Tue,  8 Mar 2022 12:38:31 +0100 (CET)
Date:   Tue, 8 Mar 2022 12:38:31 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: mvebu: Slot support
Message-ID: <20220308113831.pmq4apsxjwzfbesk@pali>
References: <20220302145733.12606-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302145733.12606-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn! Could you look if v2 changes are now fine?

On Wednesday 02 March 2022 15:57:29 Pali Rohár wrote:
> This patch series add slot support to pci-mvebu.c driver.
> 
> It is based on branch pci/mvebu of git repository:
> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> 
> Changes in v2:
> * Dropped patch with PCI_EXP_SLTCAP_*_SHIFT macros as it is not needed anymore
> * Dropped patch "ARM: dts: turris-omnia: Set PCIe slot-power-limit-milliwatt properties" which was applied
> * Added support for PCIe 6.0 slot power limit encodings
> * Round down slot power limit value
> * Fix handling of slot power limit with scale x1.0 (0x00 value)
> * Use FIELD_PREP instead of _SHIFT macros
> * Changed commit message to Bjorn's suggestion
> * Changed comments in the code to match PCIe spec
> * Preserve user settings of PCI_EXP_SLTCTL_ASPL_DISABLE bit
> 
> Pali Rohár (4):
>   PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
>   dt-bindings: Add 'slot-power-limit-milliwatt' PCIe port property
>   PCI: Add function for parsing 'slot-power-limit-milliwatt' DT property
>   PCI: mvebu: Add support for sending Set_Slot_Power_Limit message
> 
>  Documentation/devicetree/bindings/pci/pci.txt |  6 ++
>  drivers/pci/controller/pci-mvebu.c            | 96 ++++++++++++++++++-
>  drivers/pci/of.c                              | 64 +++++++++++++
>  drivers/pci/pci.h                             | 15 +++
>  include/uapi/linux/pci_regs.h                 |  1 +
>  5 files changed, 177 insertions(+), 5 deletions(-)
> 
> -- 
> 2.20.1
> 

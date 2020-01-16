Return-Path: <SRS0=0+aG=3F=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992EEC33CAF
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jan 2020 17:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7A6246C8
	for <linux-pci@archiver.kernel.org>; Thu, 16 Jan 2020 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RnFh97nX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391421AbgAPRSR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:18:17 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8812 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391384AbgAPRSR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 12:18:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e209a9f0001>; Thu, 16 Jan 2020 09:17:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jan 2020 09:18:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 Jan 2020 09:18:15 -0800
Received: from [10.24.37.48] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jan
 2020 17:18:11 +0000
Subject: Re: [PATCH V3 0/2] PCI: Add MCFG quirks for Tegra194 host controllers
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <andrew.murray@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200106082709.14370-1-vidyas@nvidia.com>
 <20200110191500.9538-1-vidyas@nvidia.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e264ae37-f3b3-96d1-9294-3ea9f78b78fc@nvidia.com>
Date:   Thu, 16 Jan 2020 22:48:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110191500.9538-1-vidyas@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579195039; bh=hfxzNASfjnng1sY6kKvhYD/Q1iFNO8maPXvGYEY4Eqo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RnFh97nXGo9YJI9RPveweovTrQ/kf8VhPfkrpPo/P7W/Gig3mlah1NDuwcLh2iENH
         oxoDM+xo0MBdor2PbuvfgM9pEKkP9KX7JO59RRC5A9Cum7ySTTNpMTrZO1Wg7ZMIhp
         giRP5G1kuCIihLvVs3TaPqIriL5EJXI96iXShpzddAh20X23RC/vW3rP4fOmKWY32G
         KGYgMAa7tPWxqXVzBW+YkP1k++Ih+45CBAwJZywtCa64oYRJu6vRd71Pif29yksOXm
         S8il3C2RX4pLr30B0eKOg/9sXJdSpBzt8zEUmqxZOdeiQYpsdk5ItnPWg6j9+Kh8/z
         ZbJAsKG5TEvMQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
Could you please review this series?

Thanks in advance,
Vidya Sagar

On 1/11/20 12:44 AM, Vidya Sagar wrote:
> The PCIe controller in Tegra194 SoC is not completely ECAM-compliant.
> With the current hardware design limitations in place, ECAM can be enabled
> only for one controller (C5 controller to be precise) with bus numbers
> starting from 160 instead of 0. A different approach is taken to avoid this
> abnormal way of enabling ECAM for just one controller but to enable
> configuration space access for all the other controllers. In this approach,
> ops are added through MCFG quirk mechanism which access the configuration
> spaces by dynamically programming iATU (internal AddressTranslation Unit)
> to generate respective configuration accesses just like the way it is
> done in DesignWare core sub-system.
> To increase the size of ECAM, a device-tree change is pushed in this series
> to move the IO window from 32-bit PCIe aperture to 64-bit PCIe aperture leaving
> the entire 32MB of 32-bit aperture for configuration space access.
> 
> V3:
> * Pushed a device-tree change in the series to enable more space for ECAM
> 
> Vidya Sagar (2):
>    arm64: tegra: Re-order PCIe aperture mappings to support ACPI boot
>    PCI: Add MCFG quirks for Tegra194 host controllers
> 
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi   |  36 ++++----
>   drivers/acpi/pci_mcfg.c                    |   7 ++
>   drivers/pci/controller/dwc/Kconfig         |   3 +-
>   drivers/pci/controller/dwc/Makefile        |   2 +-
>   drivers/pci/controller/dwc/pcie-tegra194.c | 102 +++++++++++++++++++++
>   include/linux/pci-ecam.h                   |   1 +
>   6 files changed, 131 insertions(+), 20 deletions(-)
> 

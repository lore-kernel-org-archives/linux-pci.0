Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82C2C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 16:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE4820661
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 16:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE4820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeLCQbh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:31:37 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:32994 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCQbh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Dec 2018 11:31:37 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 2D0671C0152;
        Mon,  3 Dec 2018 09:31:33 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH V2] PCI: dwc ep: cache config until DBI regs available
From:   Stephen Warren <swarren@wwwdotorg.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181126230958.8175-1-swarren@wwwdotorg.org>
Message-ID: <74930ad2-b312-cdf4-a184-383655e4e072@wwwdotorg.org>
Date:   Mon, 3 Dec 2018 09:31:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126230958.8175-1-swarren@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/26/18 4:09 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Some implementations of the DWC PCIe endpoint controller do not allow
> access to DBI registers until the attached host has started REFCLK,
> released PERST, and the endpoint driver has initialized clocking of the
> DBI registers based on that. One such system is NVIDIA's T194 SoC. The
> PCIe endpoint subsystem and DWC driver currently don't work on such
> hardware, since they assume that all endpoint configuration can happen
> at any arbitrary time.
> 
> Enhance the DWC endpoint driver to support such systems by caching all
> endpoint configuration in software, and only writing the configuration
> to hardware once it's been initialized. This is implemented by splitting
> all endpoint controller ops into two functions; the first which simply
> records/caches the desired configuration whenever called by the
> associated function driver and optionally calls the second, and the
> second which actually programs the configuration into hardware, which
> may be called either by the first function, or later when it's known
> that the DBI registers are available.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2:
> Replace hw_regs_available with hw_regs_not_available. A 0 value in this
> field is now equivalent to the existing behaviour, so that drivers that
> allocate struct dw_pcie_ep with kzalloc or equivalent do not need to
> explicitly set this new field in order to maintain existing behaviour.
> 
> Note: I have only compiled-tested this patch in the context of the
> mainline kernel since NVIDIA Tegra PCIe EP support is not yet present.
> However, I've built and tested an equivalent patch in our downstream
> kernel. I did have to manually port it to mainline due to conflicts
> though.

Any thoughts on this? Thanks.

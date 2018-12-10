Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251EFC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB76E2086D
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 18:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB76E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeLJSFC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:05:02 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:38018 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbeLJSFC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2018 13:05:02 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 777851C00EF;
        Mon, 10 Dec 2018 11:04:58 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH V2] PCI: dwc ep: cache config until DBI regs available
To:     "kishon@ti.com" <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Trent Piepho <tpiepho@impinj.com>
References: <20181126230958.8175-1-swarren@wwwdotorg.org>
 <5586f6c0-4305-5d7e-d0ff-90f7eb8fd363@synopsys.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <5718ccf4-95ba-7823-7d19-5c9888f0077a@wwwdotorg.org>
Date:   Mon, 10 Dec 2018 11:04:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5586f6c0-4305-5d7e-d0ff-90f7eb8fd363@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/4/18 4:02 AM, Gustavo Pimentel wrote:
> [CC Kishon]
> 
> On 26/11/2018 23:09, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Some implementations of the DWC PCIe endpoint controller do not allow
>> access to DBI registers until the attached host has started REFCLK,
>> released PERST, and the endpoint driver has initialized clocking of the
>> DBI registers based on that. One such system is NVIDIA's T194 SoC. The
>> PCIe endpoint subsystem and DWC driver currently don't work on such
>> hardware, since they assume that all endpoint configuration can happen
>> at any arbitrary time.
>>
>> Enhance the DWC endpoint driver to support such systems by caching all
>> endpoint configuration in software, and only writing the configuration
>> to hardware once it's been initialized. This is implemented by splitting
>> all endpoint controller ops into two functions; the first which simply
>> records/caches the desired configuration whenever called by the
>> associated function driver and optionally calls the second, and the
>> second which actually programs the configuration into hardware, which
>> may be called either by the first function, or later when it's known
>> that the DBI registers are available.

Kishon, any thoughts on this? Thanks.


Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E290DECDE39
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 18:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BAF21473
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 18:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BAF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeJRCUk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:20:40 -0400
Received: from avon.wwwdotorg.org ([104.237.132.123]:37658 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJRCUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 22:20:40 -0400
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id AE4A71C0150;
        Wed, 17 Oct 2018 12:23:45 -0600 (MDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.1 at avon.wwwdotorg.org
From:   Stephen Warren <swarren@wwwdotorg.org>
Subject: PCIe endpoint boot/enumeration order requirements
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e1d18eab-47aa-eb68-8ab0-d2550d203ba9@wwwdotorg.org>
Date:   Wed, 17 Oct 2018 12:23:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All,

I'm curious what is the expected order of boot/configuration/enumeration 
for Linux's PCIe endpoint support. I had assumed it was the following:

1) Boot the PCIe endpoint system fully.

2) Use configfs to create a PCIe endpoint function, configure it, and 
bind it to the relevant endpoint controller. The endpoint is now fully 
configured/enabled to respond to configuration/... accesses.

3) Boot the PCIe root port system.

4) At some point during boot of the root port system, it will perform 
PCIe enumeration, and hence detect the "SW-defined" endpoint.

However, with our hardware (an implementation of the Synopsis DWC PCIe 
controller), this order of events does not work. That's because in step 
2 above, the configuration is written directly to the endpoint 
controller as it is performed (e.g. device/vendor ID, BAR size, etc.). 
At least in our hardware, the relevant registers are not accessible 
until PEXCLK is provided by the root port, which only happens in step 3. 
Do other implementations of DWC (or indeed other endpoint controllers) 
not have this restriction? Or, are we expected to boot the two systems 
in one of the following manners:

Option A:

1) Power on the root port system so that PEXCLK is available. The root 
port software can boot in parallel with the steps below, but must not 
perform PCIe enumeration (or if it does, it won't find anything).

2) Fully configure all aspects of the PCIe endpoint (PCIe header info 
like vendor, device ID, BAR size/enable, iATU entries, SMMU, etc.), and 
enable the endpoint controller to respond to link-up and enumeration events.

3) Signal PCIe hotplug from the endpoint to the root port system.

4) The root port responds to hotplug, and performs PCIe enumeration; the 
endpoint will respond fully since it’s pre-programmed.

Option B:

1) Power on the root port system so that PEXCLK is available. The root 
port software must not boot at all, to prevent getting to the boot stage 
where PCIe enumeration is performed.

2) Fully configure all aspects of the PCIe endpoint (PCIe header info 
like vendor, device ID, BAR size/enable, iATU entries, SMMU, etc.) , and 
enable the endpoint controller to respond to link-up and enumeration events.

3) Signal to the root port system (or some kind of system-level 
management controller) that root port system boot can proceed.

4) The root system actually boots, and whenever the root port performs 
PCIe enumeration as part of the standard initial boot sequence, the 
endpoint will respond fully since it’s pre-programmed.

Thanks for any insight re: how this subsystem integrates with existing 
supported hardware. Is there any publicly available hardware that is 
supported by mainline Linux's PCIe endpoint support?

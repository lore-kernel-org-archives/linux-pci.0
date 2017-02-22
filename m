Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46286 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932566AbdBVSDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2017 13:03:35 -0500
Received: from [10.38.67.103] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82CC5607BD
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2017 18:03:33 +0000 (UTC)
To: Linux PCI <linux-pci@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Subject: Partial BAR Address Allocation
Message-ID: <35c6bec9-58e8-a1f7-5a85-d80c23480d32@codeaurora.org>
Date: Wed, 22 Feb 2017 13:03:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are carrying a big burden on our firmware to accommodate 32 bit non-prefetchable memory
for supporting all BAR types. 

Endpoint drivers usually try to allocate both a 64 bit and a 32 bit BAR address
for different platforms but they don't usually need both of them. 

I think the behavior changes from card to card. 

I'm looking for a way to get rid of 32 bit BAR addresses and support 64 bit BAR addresses
only. 

I want to see the current state of the kernel. Do we know if all resources need to be assigned
before a driver can become functional. I have seen some patches to relax this but I don't
know the current status.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

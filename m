Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B74C67839
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 13:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CDB21104
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 13:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CDB21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbeLNNQC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:16:02 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:48960 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeLNNQC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Dec 2018 08:16:02 -0500
X-IronPort-AV: E=Sophos;i="5.56,353,1539648000"; 
   d="scan'208";a="73365262"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>
Subject: Regression caused by "PCI: Probe for device reset support during
 enumeration"
Message-ID: <b859f604-17bc-243c-5d0f-65b02c5cd24d@citrix.com>
Date:   Fri, 14 Dec 2018 13:15:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Your commit 5b0764cac9f1 ("PCI: Probe for device reset support during 
enumeration") moved checking whether a device could be reset much 
earlier to when the device is first probed. When the device is first 
probed, the other devices on the bus may not have been discovered yet. 
This means that we will claim to support SBR as a reset mechanism 
because it is the only device behind the bus at that pointer meanwhile 
the others simply haven't been discovered yet. This results in 
dev->reset_fn being incorrectly set to true and a reset file being 
created. When userspace actually tries to use the reset file it fails 
because now there are other sibling devices preventing the use of an SBR.

How can this best be fixed? I was considering moving the check to the 
end of pci_bus_add_devices(), but I'm not at all familiar with the code 
so perhaps there is a better way.

Thanks,
-- 
Ross Lagerwall

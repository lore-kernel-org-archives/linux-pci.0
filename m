Return-Path: <SRS0=ptcC=4V=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B7C3F2D1
	for <linux-pci@archiver.kernel.org>; Wed,  4 Mar 2020 01:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E62C20728
	for <linux-pci@archiver.kernel.org>; Wed,  4 Mar 2020 01:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbgCDBB7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:01:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:51486 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgCDBB7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 20:01:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 17:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="287173724"
Received: from skuppusw-mobl5.amr.corp.intel.com (HELO [10.24.9.56]) ([10.24.9.56])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2020 17:01:57 -0800
Subject: Re: [PATCH v16 5/9] PCI/DPC: Cache DPC capabilities in
 pci_init_capabilities()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200304004705.GA184443@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <80b6d7f4-3cdd-edb6-d4b9-e36ead9df26f@linux.intel.com>
Date:   Tue, 3 Mar 2020 17:01:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304004705.GA184443@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/3/2020 4:47 PM, Bjorn Helgaas wrote:
> I think you forgot to call this?

Sorry about it. It looks like I missed adding probe.c 
pci_init_capabilities() changes. Let me fix it and send a new version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

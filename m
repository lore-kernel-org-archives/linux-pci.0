Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E44C282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 17:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C288320811
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 17:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAYRSK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:18:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:63703 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfAYRSK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jan 2019 12:18:10 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 09:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,522,1539673200"; 
   d="scan'208";a="269910566"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2019 09:18:09 -0800
Date:   Fri, 25 Jan 2019 10:17:13 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     Sinan Kaya <okaya@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: Re: [PATCH] PCI/ERR: Fix run error recovery callbacks for all
 affected devices
Message-ID: <20190125171713.GB11210@localhost.localdomain>
References: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
 <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
 <20190124213701.GA9882@localhost.localdomain>
 <5d58ea17-115f-139d-93db-fe6e9ce573cb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d58ea17-115f-139d-93db-fe6e9ce573cb@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 25, 2019 at 06:28:03AM -0800, Dongdong Liu wrote:
> I want to fix 2 points by the patch.
> 
> 1. For EP devices (such as multi-function EP device) under the same bus,
> when one of the EP devices met non-fatal error, should report non-fatal
> error only to the error endpoint device, no need to broadcast all of them.
> That is the patch (PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15)
> have done, but current code PATCH [1] broken this.

How do you know a non-fatal affects only the reporting end point? These can
certainly be bus errors, and it's not the first to detect may be affected.

In any case, what harm does the broadcast cause?

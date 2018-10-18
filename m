Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D15DC67863
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 23:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161CC2145D
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 23:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161CC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeJSHeI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:34:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:24731 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbeJSHeI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 03:34:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 16:30:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,397,1534834800"; 
   d="scan'208";a="79142631"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 18 Oct 2018 16:30:50 -0700
Date:   Thu, 18 Oct 2018 17:28:04 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [pci:pci/hotplug 45/50] drivers/pci/pcie/aer.c:1387:26: error:
 initialization from incompatible pointer type
Message-ID: <20181018232804.GA23571@localhost.localdomain>
References: <201810190748.HGswAA5P%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810190748.HGswAA5P%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 07:18:52AM +0800, kbuild test robot wrote:
>    drivers/pci/pcie/aer.c: In function 'aer_probe':
> >> drivers/pci/pcie/aer.c:1387:26: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>      struct device *device = &dev->port->device;
>                              ^
>    cc1: some warnings being treated as errors
> 
> vim +1387 drivers/pci/pcie/aer.c
> 
>   1376	
>   1377	/**
>   1378	 * aer_probe - initialize resources
>   1379	 * @dev: pointer to the pcie_dev data structure
>   1380	 *
>   1381	 * Invoked when PCI Express bus loads AER service driver.
>   1382	 */
>   1383	static int aer_probe(struct pcie_device *dev)
>   1384	{
>   1385		int status;
>   1386		struct aer_rpc *rpc;
> > 1387		struct device *device = &dev->port->device;

You must be building patches incrementally since this was (inadvertently)
fixed by the following commit 09d260ca3ad04d9b4c4d5e8b0fa1e3501b3e3793
("PCI/AER: Use managed resource allocations").

Bjorn,
If you want to replay the history, I quickly rebase the two affected
patches so this intermediate compile breakage doesn't happen. Up to you.

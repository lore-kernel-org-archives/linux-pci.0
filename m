Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B19C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 21:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CA6218D3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 21:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfAXViA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:38:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:11651 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfAXViA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 16:38:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 13:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="269677342"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2019 13:37:58 -0800
Date:   Thu, 24 Jan 2019 14:37:01 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Dongdong Liu <liudongdong3@huawei.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ERR: Fix run error recovery callbacks for all
 affected devices
Message-ID: <20190124213701.GA9882@localhost.localdomain>
References: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
 <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 10:18:26AM -0800, Sinan Kaya wrote:
> On 1/24/2019 8:50 AM, Dongdong Liu wrote:
> > The patch [1] PCI/ERR: Run error recovery callbacks for all affected
> > devices have broken the non-fatal error handling logic in patch [2].
> > For non-fatal error, link is reliable, so no need to reset link,
> > handle non-fatal error for all subordinates seems incorrect.
> > Restore the non-fatal errors process logic.
> > 
> > [1] PCI/ERR: Run error recovery callbacks for all affected devices   #4.20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfcb79fca19d267712e425af1dd48812c40dec0c
> > 
> > [2] PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc2&id=86acc790717fb60fb51ea3095084e331d8711c74
> > 
> > Fixes: bfcb79fca19d ("PCI/ERR: Run error recovery callbacks for all affected devices")
> > Reported-by: Xiaofei Tan<tanxiaofei@huawei.com>
> > Signed-off-by: Dongdong Liu<liudongdong3@huawei.com>
> > Cc: Keith Busch<keith.busch@intel.com>
> > Cc: Bjorn Helgaas<bhelgaas@google.com>
> 
> 
> According to what I see in the code, link will be reset only if the AER
> severity is AER_FATAL.
> 
> 	} else if (info->severity == AER_NONFATAL)
> 		pcie_do_recovery(dev, pci_channel_io_normal,
> 				 PCIE_PORT_SERVICE_AER);
> 	else if (info->severity == AER_FATAL)
> 		pcie_do_recovery(dev, pci_channel_io_frozen,
> 				 PCIE_PORT_SERVICE_AER);
> 
> Can you show the path where it leads to link reset and severity is AER_NONFATAL?

Yes, I don't follow what this patch is saying either, and it actually
looks quite broken: it assigns 'bridge' to 'dev', which may not even be a
bridge, and then dereferences 'bridge->subordinate' which be NULL.

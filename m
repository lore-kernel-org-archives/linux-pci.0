Return-Path: <SRS0=zNOM=TJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A3BC04AB2
	for <linux-pci@archiver.kernel.org>; Thu,  9 May 2019 15:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40902173B
	for <linux-pci@archiver.kernel.org>; Thu,  9 May 2019 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557414797;
	bh=bef0hXwCebwtVP1LpIXOT7nEbRpYegt8DOwn5VToXxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NjZTY5ipdj8HggJ6ZcolcJuzv0TXvaPP9k3wnkjfW0+vLsbPz3ae9xmm6eGo+UitZ
	 NuxsoFsvDt4Hov+wUmZ1+/mvXV3id4PYuRrE0KwuAKexr2BonoJz0+78b80ti0Mg5X
	 0/Iw6jxQTSQe7t2hIll/qUgPqs5+AYI5jUnTMV54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfEIPNR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 May 2019 11:13:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:34199 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfEIPNR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 11:13:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 08:13:16 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 09 May 2019 08:13:16 -0700
Date:   Thu, 9 May 2019 09:07:46 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 00/10] PCI: Log with pci_dev, not pcie_device
Message-ID: <20190509150745.GA9548@localhost.localdomain>
References: <20190509141456.223614-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509141456.223614-1-helgaas@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 09, 2019 at 09:14:46AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is a collection of updates to Fred's v2 patches from:
> 
>   https://lore.kernel.org/lkml/20190503035946.23608-1-fred@fredlawl.com
> 
> and some follow-on discussion.

For the series:

Reviewed-by: Keith Busch <keith.busch@intel.com>

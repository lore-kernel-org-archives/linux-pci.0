Return-Path: <SRS0=JAmU=TD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0AC43219
	for <linux-pci@archiver.kernel.org>; Fri,  3 May 2019 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96EB2075E
	for <linux-pci@archiver.kernel.org>; Fri,  3 May 2019 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556902230;
	bh=2+s0bTibuORYAqBiFfI2d9J94Yd6RcBiUb5f1ctTG3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1U5VeGNBNy3bpbwLG+nGM7AC1/meLAqwqZsAgC4vqL5QLKk2CSEIfxawIHEZJt7/n
	 qUT40Kx2kpKZdZKbUf7lfeF0e4/UtySAwTaMtZB6sEQ/Lra0NowAKgpLHCUBbJm3f8
	 pQno9e6bCNr986t5GgfUwH44X0DvODOJ1qWHvggc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfECQua (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 3 May 2019 12:50:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:43658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfECQua (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 May 2019 12:50:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 09:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,426,1549958400"; 
   d="scan'208";a="343151618"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2019 09:50:28 -0700
Date:   Fri, 3 May 2019 10:44:46 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
        "thesven73@gmail.com" <thesven73@gmail.com>
Subject: Re: [PATCH v2 2/9] PCI/DPC: Prefix dmesg logs with PCIe service name
Message-ID: <20190503164446.GD30291@localhost.localdomain>
References: <20190503035946.23608-1-fred@fredlawl.com>
 <20190503035946.23608-3-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503035946.23608-3-fred@fredlawl.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 02, 2019 at 08:59:39PM -0700, Frederick Lawler wrote:
> +#define dev_fmt(fmt) "DPC: " fmt
> +

> @@ -110,7 +111,7 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
> +		pci_warn(pdev, "DPC root port still busy\n");

> @@ -229,18 +229,17 @@ static irqreturn_t dpc_handler(int irq, void *context)
> +	pci_warn(pdev, "DPC %s detected\n",

> @@ -328,11 +327,11 @@ static int dpc_probe(struct pcie_device *dev)
> +	pci_info(pdev, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",

Since you've already prefixed each print with "DPC: ", the extra "DPC"
in the above prints is redundant.

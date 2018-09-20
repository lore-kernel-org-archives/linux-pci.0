Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D164DECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 19:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCA321525
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 19:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCA321525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIUBhV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:37:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:28642 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeIUBhV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 21:37:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 12:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="91887308"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2018 12:52:14 -0700
Date:   Thu, 20 Sep 2018 13:54:11 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv4 03/12] PCI: DPC: Save and restore control state
Message-ID: <20180920195410.GA31599@localhost.localdomain>
References: <20180920162717.31066-1-keith.busch@intel.com>
 <20180920162717.31066-4-keith.busch@intel.com>
 <2f473676-d53e-08bb-97f5-3e3bf9841b61@kernel.org>
 <d02c4961-a6a2-6778-bab3-df6db1f1393e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d02c4961-a6a2-6778-bab3-df6db1f1393e@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 20, 2018 at 03:47:36PM -0400, Sinan Kaya wrote:
> On 9/20/2018 3:46 PM, Sinan Kaya wrote:
> > On 9/20/2018 12:27 PM, Keith Busch wrote:
> > >       /*
> > >        * DPC disables the Link automatically in hardware, so it has
> > >        * already been reset by the time we get here.
> > >        */
> > > -    devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
> > > -    pciedev = to_pcie_device(devdpc);
> > > -    dpc = get_service_data(pciedev);
> > > +    dpc = to_dpc_dev(pdev);
> > 
> > I thought that the struct pci_dev sent here is the bridge and we
> > need to locate the struct device of the DPC object here.
> > 
> > Isn't this change wrong now?
> 
> Gosh, I should have looked 30 lines above. Nevermind.

Yeah, this part should be equivalent to before. This patch just created
the opportunity to move this to a common helper, otherwise it would have
been duplicated two more times.

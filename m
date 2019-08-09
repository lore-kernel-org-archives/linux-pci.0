Return-Path: <SRS0=qC1o=WF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F07EC433FF
	for <linux-pci@archiver.kernel.org>; Fri,  9 Aug 2019 14:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3891F2085B
	for <linux-pci@archiver.kernel.org>; Fri,  9 Aug 2019 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565362499;
	bh=EuYq5LJ2cBH2kxGxe+LUZHNqf2vfjh4LIxwZBPYfICg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NIYPrKF4AQzwf/FisnuxNtWzFJmkQ9Uy5TZRgkO7W14rCQT3yFiShN13n1r1Zi29h
	 JCb7Vai8mSytN1X61xIj+d7rHi3iXRE/+3DK+Jp+Z2IOXxh2ThCIsNjG9VZZ88rZgw
	 QEeuVbigkCwnULFTneJsmXQ3G11z/GDZuo+MFXag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406518AbfHIOy6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:54:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:26918 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfHIOy6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Aug 2019 10:54:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 07:54:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="375224439"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 09 Aug 2019 07:54:56 -0700
Date:   Fri, 9 Aug 2019 08:52:33 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 0/2] nvme-pci: Allow PCI bus-level PM to be used if
 ASPM is disabled
Message-ID: <20190809145233.GB28515@localhost.localdomain>
References: <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain>
 <2184247.yL3mcj2FRQ@kreacher>
 <20190808221353.GA27570@localhost.localdomain>
 <CAJZ5v0hh3Yfx0Kbt11NEXV9q5RtApuvvg5JZ2O_rZLvixOWSOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hh3Yfx0Kbt11NEXV9q5RtApuvvg5JZ2O_rZLvixOWSOA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 09, 2019 at 01:05:42AM -0700, Rafael J. Wysocki wrote:
> On Fri, Aug 9, 2019 at 12:16 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > The v3 series looks good to me.
> >
> > Reviewed-by: Keith Busch <keith.busch@intel.com>
> >
> > Bjorn,
> >
> > If you're okay with the series, we can either take it through nvme,
> > or you can feel free to apply through pci, whichever you prefer.
> 
> Actually, I can apply it too with your R-by along with the PCIe patch
> ACKed by Bjorn.  Please let me know if that works for you.

Thanks, that sounds good to me.

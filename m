Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619A0C67863
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 00:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D6821476
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 00:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F69PdSxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D6821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeJSIwz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeJSIwz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 04:52:55 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930DD20C0E;
        Fri, 19 Oct 2018 00:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539910156;
        bh=wK5lstCyKWBpqHsQiX/Z4kTy0hBcU4XskacyS2o6dFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F69PdSxVzRk8C9xhvAGZ6ZNptNScSLQzk1sIV+Dbhj9QawOD690MxBlmiHrhOs/ta
         7ST69ndFtYTssukfytq+H3rXeuZ6DDW5u9Ze4S/HhyYXtr0cCmmFFlg3HsfMakKY3x
         RkqVxNLVzfGB1MJaURwS1PijIzEfScXi7+SvTz7A=
Date:   Thu, 18 Oct 2018 19:49:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/hotplug 45/50] drivers/pci/pcie/aer.c:1387:26: error:
 initialization from incompatible pointer type
Message-ID: <20181019004913.GO5906@bhelgaas-glaptop.roam.corp.google.com>
References: <201810190748.HGswAA5P%fengguang.wu@intel.com>
 <20181018232804.GA23571@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018232804.GA23571@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 18, 2018 at 05:28:04PM -0600, Keith Busch wrote:
> On Fri, Oct 19, 2018 at 07:18:52AM +0800, kbuild test robot wrote:
> >    drivers/pci/pcie/aer.c: In function 'aer_probe':
> > >> drivers/pci/pcie/aer.c:1387:26: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> >      struct device *device = &dev->port->device;
> >                              ^
> >    cc1: some warnings being treated as errors
> > 
> > vim +1387 drivers/pci/pcie/aer.c
> > 
> >   1376	
> >   1377	/**
> >   1378	 * aer_probe - initialize resources
> >   1379	 * @dev: pointer to the pcie_dev data structure
> >   1380	 *
> >   1381	 * Invoked when PCI Express bus loads AER service driver.
> >   1382	 */
> >   1383	static int aer_probe(struct pcie_device *dev)
> >   1384	{
> >   1385		int status;
> >   1386		struct aer_rpc *rpc;
> > > 1387		struct device *device = &dev->port->device;
> 
> You must be building patches incrementally since this was (inadvertently)
> fixed by the following commit 09d260ca3ad04d9b4c4d5e8b0fa1e3501b3e3793
> ("PCI/AER: Use managed resource allocations").

Yes, I think the 0-day service builds each incremental patch.

> Bjorn,
> If you want to replay the history, I quickly rebase the two affected
> patches so this intermediate compile breakage doesn't happen. Up to you.

I fixed this up by removing this from 0459ba0b0d50 ("PCI/AER: Use threaded
IRQ for bottom half"), since I don't think it's relevant to that patch:

  @@ -1418,18 +1384,20 @@ static int aer_probe(struct pcie_device *dev)
   {
	  int status;
	  struct aer_rpc *rpc;
  -       struct device *device = &dev->port->dev;
  +       struct device *device = &dev->port->device;

and making 09d260ca3ad0 ("PCI/AER: Use managed resource allocations") look
like this:

  @@ -1384,10 +1380,9 @@ static int aer_probe(struct pcie_device *dev)
   {
	  int status;
	  struct aer_rpc *rpc;
  -       struct device *device = &dev->port->dev;
  +       struct device *device = &dev->device;

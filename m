Return-Path: <SRS0=Bif1=BA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28794C4346A
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jul 2020 16:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F408621702
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jul 2020 16:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595348989;
	bh=cIGqOn0WA7ALJArdVOD0OuEu7ORTZ62TBCOxbZLwetw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mW5xnVSyzrNhNuPSStrwjM6tf8A87bakCyosdljO9hZsYJlpsfFm5WB15NQAwAQnN
	 hONfW4n1KAbr5SyUqeFB9067cJgeMtK7KBl/53LtHcuqdk7+y1jNH6W721bJWpbn/Q
	 MnXxPzerZnZVUl2Khp8oUYIK2jyb4Y0Y7seztIM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbgGUQ3l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730447AbgGUQ2u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2CD20792;
        Tue, 21 Jul 2020 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595348930;
        bh=cIGqOn0WA7ALJArdVOD0OuEu7ORTZ62TBCOxbZLwetw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zRwZR5x94i3Ylz2mDc5jIvSSNtjKBgl4cE6dt8/M42Tx2771FYimfDUtPCI912xom
         u+Q/ka2cprOaeOZ2tqafYC5IJVU+LYztthwCmalqgbvjGvrOBXwUVhFV3nRoqdOp1g
         WVLz377rQ9qV9gn6vTdVz9Jbs9xqpHZYBZc7Fzy4=
Date:   Tue, 21 Jul 2020 18:28:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, megha.dey@intel.com, maz@kernel.org,
        bhelgaas@google.com, rafael@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, alex.williamson@redhat.com, jacob.jun.pan@intel.com,
        ashok.raj@intel.com, jgg@mellanox.com, yi.l.liu@intel.com,
        baolu.lu@intel.com, kevin.tian@intel.com, sanjay.k.kumar@intel.com,
        tony.luck@intel.com, jing.lin@intel.com, dan.j.williams@intel.com,
        kwankhede@nvidia.com, eric.auger@redhat.com, parav@mellanox.com,
        dave.hansen@intel.com, netanelg@mellanox.com, shahafs@mellanox.com,
        yan.y.zhao@linux.intel.com, pbonzini@redhat.com,
        samuel.ortiz@intel.com, mona.hossain@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH RFC v2 00/18] Add VFIO mediated device support and
 DEV-MSI support for the idxd driver
Message-ID: <20200721162858.GA2139881@kroah.com>
References: <159534667974.28840.2045034360240786644.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159534667974.28840.2045034360240786644.stgit@djiang5-desk3.ch.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 09:02:15AM -0700, Dave Jiang wrote:
> v2:

"RFC" to me means "I don't really think this is mergable, so I'm
throwing it out there."  Which implies you know it needs more work
before others should review it as you are not comfortable with it :(

So, back-of-the-queue you go...

greg k-h

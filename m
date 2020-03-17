Return-Path: <SRS0=CoTa=5C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF8EC10F29
	for <linux-pci@archiver.kernel.org>; Tue, 17 Mar 2020 14:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A135206EC
	for <linux-pci@archiver.kernel.org>; Tue, 17 Mar 2020 14:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YUKvSREp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgCQOlo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:41:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgCQOlo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 10:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KEFTBxmf5jGnVjVfqmHOLcr2z6MlYLUz955Z56oW9ig=; b=YUKvSREpjaBbxpZwxPnHxcKgPC
        j7ncpnymRx0EgwpcA12mXqH5AyXAe/fWU41jd/DE5Gl1swutFj1eGIKAcFXu6kWWXCnjvhRnPbNF0
        FtqCsqiFD9iYmPxi4PEn1dRIoYyXvBKBThcxiHL1vnDp9vWwkpnWCR373ain44lXl6cuPTv1GPKNd
        /vCuBSrXoZXu7EG5+kuTiVt1aFV6eAottTefN6/5GDWc7157WpRDz0aY/hMO+qfO4lO3Yr6XYt5WD
        43146nt1ij7wpmJTqo4ggY+CgF3D9IWfA6fl/zVBV4jdStbYIT8YPvaYkpv+CHw5vOdA6HSn3wt6k
        VPONJ2eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEDPb-00067j-MY; Tue, 17 Mar 2020 14:41:43 +0000
Date:   Tue, 17 Mar 2020 07:41:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v17 05/12] PCI: portdrv: remove reset_link member from
 pcie_port_service_driver
Message-ID: <20200317144143.GD23471@infradead.org>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <13d4866abf46f034f706f255287258cda99fadb4.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d4866abf46f034f706f255287258cda99fadb4.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 03, 2020 at 06:36:28PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> reset_link member in struct pcie_port_service_driver was
> mainly added to let pcie_do_recovery() trigger the driver
> specific reset_link() on PCIe fatal errors. But after
> modifying the pcie_do_recovery() function to accept reset_link
> callback as function parameter, we no longer have need to use
> or set reset_link in struct pcie_port_service_driver. So remove
> it.

This should be folded into
"PCI/ERR: Remove service dependency in pcie_do_recovery()"

Return-Path: <SRS0=CLTA=YI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C344FECE588
	for <linux-pci@archiver.kernel.org>; Tue, 15 Oct 2019 11:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A425821848
	for <linux-pci@archiver.kernel.org>; Tue, 15 Oct 2019 11:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfJOLnw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:43:52 -0400
Received: from 8bytes.org ([81.169.241.247]:47496 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfJOLnw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 07:43:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5556F2D9; Tue, 15 Oct 2019 13:43:49 +0200 (CEST)
Date:   Tue, 15 Oct 2019 13:43:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/3] PCI/ATS: Clean up unnecessary stubs and exports
Message-ID: <20191015114347.GK14518@8bytes.org>
References: <20191009225354.181018-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009225354.181018-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, Oct 09, 2019 at 05:53:51PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Most of the ATS/PRI/PASID interfaces are only used by IOMMU drivers that
> can only be built statically, not as modules.  A couple are only used by
> the PCI core and don't need to be visible outside at all.
> 
> These are intended to be cleanup only, but let me know if they would break
> something.
> 
> Bjorn Helgaas (3):
>   PCI/ATS: Remove unused PRI and PASID stubs
>   PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()
>   PCI/ATS: Make pci_restore_pri_state(), pci_restore_pasid_state()
>     private

The series looks good to me, for the whole series:

Reviewed-by: Joerg Roedel <jroedel@suse.de>

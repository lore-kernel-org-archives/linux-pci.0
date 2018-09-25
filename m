Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D57C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADA12086E
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 13:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="CeKnHYCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADA12086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeIYTeD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:34:03 -0400
Received: from 8bytes.org ([81.169.241.247]:35622 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbeIYTeC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 15:34:02 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 084896FB; Tue, 25 Sep 2018 15:26:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537881988; bh=YQIZUE/SzSiRfpUb5frfxZE23sMAUbinWRRZMcJW5Q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CeKnHYCHD7foJ4KDGKlExD0LR2rDHRnpfSHrOvhFN/YdeaWtIqiAM8qUaRrxMeF2W
         yvpr9mQgd3+dHUfxNm9YlAy+Vm/c5xe64iEvT91zvys8S+36gyzJSiLZviX+7hADty
         4uoXebvGJ2cOh+aHGgyozT+uA5IGzuZIGv2DvnsuUXAZp2xb8h4fjSfxblNAV+x9A3
         fQ9taRvUxUO6cALO+apAeHx/mtEGmWojTqYaKbzc63ssFOoGye3gB5b9npGUCtbT+8
         6VPAPQAqFSG5OQTDhrumamZsv31qcmUqTr/VVKQv2vmVJM7Kp/JTHetCUltPaTiSAz
         R5NEPVEzSkIiQ==
Date:   Tue, 25 Sep 2018 15:26:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        jcrouse@codeaurora.org, alex.williamson@redhat.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, eric.auger@redhat.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, andrew.murray@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, ashok.raj@intel.com,
        xuzaibo@huawei.com, liguozhu@hisilicon.com, okaya@codeaurora.org,
        bharatku@xilinx.com, ilias.apalodimas@linaro.org,
        shunyong.yang@hxt-semitech.com
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Message-ID: <20180925132627.vbdotr23o7lqrmnd@8bytes.org>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-4-jean-philippe.brucker@arm.com>
 <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 11:15:40AM +0800, Lu Baolu wrote:
> This might be problematic for vt-d (and other possible arch's which use
> PASID other than SVA). When vt-d iommu works in scalable mode, a PASID
> might be allocated for:
> 
> (1) SVA
> (2) Device Assignable Interface (might be a mdev or directly managed
>     within a device driver).
> (3) SVA in VM guest
> (4) Device Assignable Interface in VM guest
> 
> So we can't expect that an io_mm pointer was associated with each PASID.
> And this code might run into problem if the pasid is allocated for
> usages other than SVA.

So all of these use-cases above should work in parallel on the same
device, just with different PASIDs? Or is a device always using only one
of the above modes at the same time?

Regards,

	Joerg


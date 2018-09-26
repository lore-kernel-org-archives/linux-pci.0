Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569F9C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 12:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC5E206B7
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 12:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="HIhUb9cH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC5E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeIZS6S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:58:18 -0400
Received: from 8bytes.org ([81.169.241.247]:55120 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeIZS6S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 14:58:18 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D6D646FB; Wed, 26 Sep 2018 14:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537965927; bh=Oc9OdBFncwGb0skX+Wire6fE9n48FKNjvogEgQoU7b8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIhUb9cHI4RYdWfexCnlf6beDji9l5Bl4DElLAKEvv/+UekGT/+93WXN+wQpKAhKe
         /OmrHaS7qR/vcvx1deaecKqttam0+uLyK7EnckvHV7c7OTcT1cfRstai29VoFxegpn
         EPW0PSrF6JW+qCW/wP20ZP/cvKBArq5WaceBDWwN7sGZIT5VWRqdn5j6T/mzZLWgB1
         QrImYjultUQVirAjojJGNzerxqG5jvRoD/XwAYyZPDdMJMs8VlZOtObJaxLov1yD3I
         L8C5U6okFxM8aGCfFV1cAuT25A7C4umjVbxdE6EzK/KCbeuVumFJrIwmFhAA47p7Nl
         r6ZvhKXIFtiJw==
Date:   Wed, 26 Sep 2018 14:45:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "bharatku@xilinx.com" <bharatku@xilinx.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Message-ID: <20180926124527.GD18287@8bytes.org>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-4-jean-philippe.brucker@arm.com>
 <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
 <20180925132627.vbdotr23o7lqrmnd@8bytes.org>
 <b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
 <754d495d-d016-f42f-5682-ba4a75a618e0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <754d495d-d016-f42f-5682-ba4a75a618e0@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 11:20:34AM +0100, Jean-Philippe Brucker wrote:
> Yes, at the moment it's difficult to guess what device drivers will
> want, but I can imagine some driver offering SVA to userspace, while
> keeping a few PASIDs for themselves to map kernel memory. Or create mdev
> devices for virtualization while also allowing bare-metal SVA. So I
> think we should aim at enabling these use-cases in parallel, even if it
> doesn't necessarily need to be possible right now.

Yeah okay, but allowing these use-cases in parallel basically disallows
giving any guest control over a device's pasid-table, no?

I am just asking because I want to make up my mind about the necessary
extensions to the IOMMU-API.


Regards,

	Joerg


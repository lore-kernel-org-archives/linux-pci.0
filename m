Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C67CC43334
	for <linux-pci@archiver.kernel.org>; Tue, 19 Jul 2022 16:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiGSQi1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGSQiZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 12:38:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E510C326F8;
        Tue, 19 Jul 2022 09:38:24 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnPc81Cm5z67Q0K;
        Wed, 20 Jul 2022 00:36:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 19 Jul 2022 18:38:22 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 17:38:21 +0100
Date:   Tue, 19 Jul 2022 17:38:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V14 4/7] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <20220719173820.00004e6e@Huawei.com>
In-Reply-To: <20220715030424.462963-5-ira.weiny@intel.com>
References: <20220715030424.462963-1-ira.weiny@intel.com>
        <20220715030424.462963-5-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jul 2022 20:04:21 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> DOE mailbox objects will be needed for various mailbox communications
> with each memory device.
> 
> Iterate each DOE mailbox capability and create PCI DOE mailbox objects
> as found.
> 
> It is not anticipated that this is the final resting place for the
> iteration of the DOE devices.  The support of switch ports will drive
> this code into the PCIe side.  In this imagined architecture the CXL
> port driver would then query into the PCI device for the DOE mailbox
> array.
> 
> For now creating the mailboxes in the CXL port is good enough for the
> endpoints.  Later PCIe ports will need to support this to support switch
> ports more generically.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

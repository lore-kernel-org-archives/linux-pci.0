Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF5BCCA482
	for <linux-pci@archiver.kernel.org>; Wed, 20 Jul 2022 16:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiGTQ4u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiGTQ4r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 12:56:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2196717A;
        Wed, 20 Jul 2022 09:56:45 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lp1yp2Bl4z67FSP;
        Thu, 21 Jul 2022 00:54:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 20 Jul 2022 18:56:43 +0200
Received: from localhost (10.81.205.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 17:56:42 +0100
Date:   Wed, 20 Jul 2022 17:56:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@lst.de>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 13/28] cxl/port: Move dport tracking to an xarray
Message-ID: <20220720175641.00002665@Huawei.com>
In-Reply-To: <165784331647.1758207.6345820282285119339.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
        <165784331647.1758207.6345820282285119339.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.121]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jul 2022 17:01:56 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Reduce the complexity and the overhead of walking the topology to
> determine endpoint connectivity to root decoder interleave
> configurations.
> 
> Note that cxl_detach_ep(), after it determines that the last @ep has
> departed and decides to delete the port, now needs to walk the dport
> array with the device_lock() held to remove entries. Previously
> list_splice_init() could be used atomically delete all dport entries at
> once and then perform entry tear down outside the lock. There is no
> list_splice_init() equivalent for the xarray.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

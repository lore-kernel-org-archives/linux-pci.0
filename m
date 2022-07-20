Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32603C43334
	for <linux-pci@archiver.kernel.org>; Wed, 20 Jul 2022 15:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiGTPj0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiGTPjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 11:39:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D8E33E27;
        Wed, 20 Jul 2022 08:39:22 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lp0BH3NHlz67VMG;
        Wed, 20 Jul 2022 23:34:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 17:39:20 +0200
Received: from localhost (10.81.205.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 16:39:19 +0100
Date:   Wed, 20 Jul 2022 16:39:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@lst.de>, <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 02/28] cxl/core: Define a 'struct cxl_switch_decoder'
Message-ID: <20220720163915.00004acb@Huawei.com>
In-Reply-To: <165784325340.1758207.5064717153608954960.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
        <165784325340.1758207.5064717153608954960.stgit@dwillia2-xfh.jf.intel.com>
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

On Thu, 14 Jul 2022 17:00:53 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Currently 'struct cxl_decoder' contains the superset of attributes
> needed for all decoder types. Before more type-specific attributes are
> added to the common definition, reorganize 'struct cxl_decoder' into type
> specific objects.
> 
> This patch, the first of three, factors out a cxl_switch_decoder type.
> See the new kdoc for what a 'struct cxl_switch_decoder' represents in a
> CXL topology.
> 
> Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

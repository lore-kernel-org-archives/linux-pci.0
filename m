Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8486EC433EF
	for <linux-pci@archiver.kernel.org>; Wed, 20 Jul 2022 10:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiGTKAE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Jul 2022 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGTKAE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 06:00:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4516C12A84;
        Wed, 20 Jul 2022 03:00:02 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lnrh201lXz67bf9;
        Wed, 20 Jul 2022 17:56:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 11:59:59 +0200
Received: from localhost (10.81.205.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 10:59:50 +0100
Date:   Wed, 20 Jul 2022 10:59:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 36/46] cxl/region: Add interleave ways attribute
Message-ID: <20220720105946.00007fc2@Huawei.com>
In-Reply-To: <62d72cf43c74_11a1662945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-11-dan.j.williams@intel.com>
        <20220630144420.000005b5@Huawei.com>
        <62cb6f9a74b33_3535162944e@dwillia2-xfh.notmuch>
        <20220719154718.000077ec@Huawei.com>
        <62d72cf43c74_11a1662945b@dwillia2-xfh.jf.intel.com.notmuch>
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

On Tue, 19 Jul 2022 15:15:16 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > > No, I would prefer that as far as the Linux implementation is concerned
> > > the software-guide does not exist. In the sense that the Linux
> > > implementation choices supersede and are otherwise a superset of what
> > > the guide recommends.  
> > 
> > ah. I phrased that badly. I just meant lift the argument as a comment rather
> > than a cross reference.  
> 
> Oh, you mean promote it to an actual rationale comment rather than just
> parrot what the code is doing? Yeah, that's a good idea.

yup

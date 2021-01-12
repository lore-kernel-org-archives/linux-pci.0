Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AC4C433DB
	for <linux-pci@archiver.kernel.org>; Tue, 12 Jan 2021 01:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6836B22DCC
	for <linux-pci@archiver.kernel.org>; Tue, 12 Jan 2021 01:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbhALBMz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Jan 2021 20:12:55 -0500
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:40324 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727236AbhALBMz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 20:12:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 03133181D330D;
        Tue, 12 Jan 2021 01:12:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: teeth14_590d64827511
X-Filterd-Recvd-Size: 2120
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Jan 2021 01:12:11 +0000 (UTC)
Message-ID: <284e3f48184af93e6826e53d8ec32b569a291c2c.camel@perches.com>
Subject: Re: [RFC PATCH v3 16/16] MAINTAINERS: Add maintainers of the CXL
 driver
From:   Joe Perches <joe@perches.com>
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Date:   Mon, 11 Jan 2021 17:12:10 -0800
In-Reply-To: <20210111225121.820014-18-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
         <20210111225121.820014-18-ben.widawsky@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2021-01-11 at 14:51 -0800, Ben Widawsky wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -4459,6 +4459,16 @@ F:	fs/configfs/
>  F:	include/linux/configfs.h
>  F:	samples/configfs/
>  
> +COMPUTE EXPRESS LINK (CXL)
> +M:	Vishal Verma <vishal.l.verma@intel.com>
> +M:	Ira Weiny <ira.weiny@intel.com>
> +M:	Ben Widawsky <ben.widawsky@intel.com>
> +M:	Dan Williams <dan.j.williams@intel.com>
> +L:	linux-cxl@vger.kernel.org
> +S:	Maintained
> +F:	drivers/cxl/
> +F:	include/uapi/linux/cxl_mem.h
> +
>  CONSOLE SUBSYSTEM
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  S:	Supported

Keep the MAINTAINERS entries in alphabetic order please.
Move this section between:

COMPILER ATTRIBUTES
CONEXANT ACCESSRUNNER USB DRIVER


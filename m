Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7C0C433F5
	for <linux-pci@archiver.kernel.org>; Sat, 26 Feb 2022 12:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiBZMHY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 26 Feb 2022 07:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiBZMHX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Feb 2022 07:07:23 -0500
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1912AAB
        for <linux-pci@vger.kernel.org>; Sat, 26 Feb 2022 04:06:48 -0800 (PST)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 1FA7E28048F; Sat, 26 Feb 2022 13:06:47 +0100 (CET)
Date:   Sat, 26 Feb 2022 13:06:47 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] pciutils: Add decode support for Data Object Exchange
 Extended Capability
Message-ID: <mj+md-20220226.120637.73958.nikam@ucw.cz>
References: <20220210161945.30131-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210161945.30131-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

> PCI Data Object Exchange [1] provides a mailbox interface used as the
> transport for various protocols defined by PCI-SIG and others. Make the
> limited information in config space available. Note the Read/Write
> Mailbox registers themselves are not currently parsed as the usefulness
> of accessing one dword of a protocol is probably limited.
[...]

Thanks, applied.

				Martin

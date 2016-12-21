Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58342 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757389AbcLUGMR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2016 01:12:17 -0500
Subject: Re: [1/4] PCI: exynos: replace to one register accessor from each
 accessors
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-pci@vger.kernel.org
Cc: helgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com
From: "pankaj.dubey" <pankaj.dubey@samsung.com>
Message-id: <0a2c20a6-f44c-3a2b-3115-0cc51e83a947@samsung.com>
Date: Wed, 21 Dec 2016 11:44:49 +0530
MIME-version: 1.0
In-reply-to: <20161219081740.5457-2-jh80.chung@samsung.com>
Content-type: text/plain; charset=utf-8
References: <20161219081740.5457-2-jh80.chung@samsung.com>
 <CGME20161221061214epcas3p3033a93bbda1c9f4247a676750a10cdb1@epcas3p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jaehoon,

On Monday 19 December 2016 01:47 PM, Jaehoon Chung wrote:
> There is no reason to maintain *_blk/phy/elbi_* as register accessors.
> It can be replaced to one register accessor.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---

Looks fine. Nice cleanup :)

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>

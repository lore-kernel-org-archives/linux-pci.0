Return-Path: <SRS0=Pe2C=XZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A9EC32792
	for <linux-pci@archiver.kernel.org>; Mon, 30 Sep 2019 22:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B5221906
	for <linux-pci@archiver.kernel.org>; Mon, 30 Sep 2019 22:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569884318;
	bh=tnKZOVuMQe40baXVAUS8CkfwTMU9lvjXSTk3v5kBmoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=tZKxiHwIlzl/YwHbsXasMP/S8Knzy4mH84Miv1auiA3Mjs79Avs7lNnMt1L+3gQ40
	 e62FSq54xuaOGpVjMFsK7TppJB89VR+RV38HOKkoXj+mceUo9ehW0L0Mma69MYmLeB
	 P/CYARFgK2BfSzQwmYHNSBtE6phYJc2aaldRrMaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfI3W6h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfI3W6h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 18:58:37 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 924EF2086A;
        Mon, 30 Sep 2019 22:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569884315;
        bh=tnKZOVuMQe40baXVAUS8CkfwTMU9lvjXSTk3v5kBmoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YxpWsvpYOxez0y/qzV9gGrdxL/PliBjkQGqghHBAL1wGCnsVROoO9Yi7eKTBq7hBS
         anu1fyxthC/osuEkN92r99Qw6pc9Ponkyzz8YN9/GCS9rWlJogA/WmWKZIrxogoGTX
         XWWGLlybA9N/S3ud3oXM9Rf3BrZvKJoJ7l7zamPU=
Date:   Mon, 30 Sep 2019 17:58:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel J Blueman <daniel@numascale.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Correct warnings about missing or incorrect
 SPDX license headers.
Message-ID: <20190930225827.GA220126@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828135322.10370-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 03:53:22PM +0200, Krzysztof Wilczynski wrote:
> Add the missing "SPDX-License-Identifier" license header
> to the arch/x86/pci/numachip.c (use the GPL-2.0 identifier
> derived using the comment mentioning license from the
> top of the file), and remove license boilerplate as per
> a similar commit 8cfab3cf63cf ("PCI: Add SPDX GPL-2.0 to
> replace GPL v2 boilerplate").
> 
> Correct existing SPDX license header in the files
> drivers/pci/controller/pcie-cadence.h and
> drivers/pci/controller/pcie-rockchip.h to use
> correct comment style as per the section 2 "Style"
> of the "Linux kernel licensing rules" (see:
> Documentation/process/license-rules.rst).
> 
> Both changes will resolve the following checkpatch.pl
> script warning:
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Applied to pci/misc for v5.5, thanks!

> ---
> Changes in v2:
>   Update wording and mention checkpatch.pl script warnings.
>   Add two C header files to which the fix also applies.
> 
>  arch/x86/pci/numachip.c                | 5 +----
>  drivers/pci/controller/pcie-cadence.h  | 2 +-
>  drivers/pci/controller/pcie-rockchip.h | 2 +-
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/pci/numachip.c b/arch/x86/pci/numachip.c
> index 2e565e65c893..01a085d9135a 100644
> --- a/arch/x86/pci/numachip.c
> +++ b/arch/x86/pci/numachip.c
> @@ -1,8 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - *
>   * Numascale NumaConnect-specific PCI code
>   *
>   * Copyright (C) 2012 Numascale AS. All rights reserved.
> diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
> index ae6bf2a2b3d3..f1cba3931b99 100644
> --- a/drivers/pci/controller/pcie-cadence.h
> +++ b/drivers/pci/controller/pcie-cadence.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  // Copyright (c) 2017 Cadence
>  // Cadence PCIe controller driver.
>  // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 8e87a059ce73..53e4f9e59624 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Rockchip AXI PCIe controller driver
>   *
> -- 
> 2.22.1
> 

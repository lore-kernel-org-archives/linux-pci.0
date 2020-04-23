Return-Path: <SRS0=NHSM=6H=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FCDC54FD0
	for <linux-pci@archiver.kernel.org>; Thu, 23 Apr 2020 19:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49C52076C
	for <linux-pci@archiver.kernel.org>; Thu, 23 Apr 2020 19:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587671745;
	bh=w+Gr4aL6+GUsaxk5mbOujICYqjP6mp6V8eJFr3DAi8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=p8+tl9tKH4WhljtAWLmLfa/0559KwMdd93LakVebO08b9DQSWB8SvOpH+RUQ3xju3
	 wDSl2IAoZs8fu22+fcTgwp0xWKCxGl0qvR+OCjcljj8CjubB4t9piWg3SjeVSAcuT7
	 VyTKN41lQKhB9ztRerzyi9nSXJhv88BOqWbtmgbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgDWTzp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgDWTzo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 15:55:44 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328C820728;
        Thu, 23 Apr 2020 19:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587671744;
        bh=w+Gr4aL6+GUsaxk5mbOujICYqjP6mp6V8eJFr3DAi8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LEFhNsqS9MWcxnRtf9yNHsQ8brs8pDRRjfbvUeMtzRYh5hT+kEjpXEFYHCWEFdTCa
         WdJYNrCj3BfwFml0StqTLBvA6e61MlN7delxIAvqNeJSbKE3EaPS8jJ6nuD5CogOhS
         5fV55bi1cCMac8S8781gvMPA77FwOg6FSe19QEJ0=
Date:   Thu, 23 Apr 2020 14:55:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add additional AMD ZEN root ports to the
 whitelist
Message-ID: <20200423195542.GA216882@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200406194201.846411-1-alexander.deucher@amd.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 06, 2020 at 03:42:01PM -0400, Alex Deucher wrote:
> According to the hw architect, pre-ZEN parts support
> p2p writes and ZEN parts support both p2p reads and writes.
> 
> Add entries for Zen parts Raven (0x15d0) and Renoir (0x1630).
> 
> Cc: Christian König <christian.koenig@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Applied with Huang's ack to pci/p2pdma for v5.8, thanks!

> ---
>  drivers/pci/p2pdma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9a8a38384121..91a4c987399d 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -282,6 +282,8 @@ static const struct pci_p2pdma_whitelist_entry {
>  } pci_p2pdma_whitelist[] = {
>  	/* AMD ZEN */
>  	{PCI_VENDOR_ID_AMD,	0x1450,	0},
> +	{PCI_VENDOR_ID_AMD,	0x15d0,	0},
> +	{PCI_VENDOR_ID_AMD,	0x1630,	0},
>  
>  	/* Intel Xeon E5/Core i7 */
>  	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
> -- 
> 2.25.1
> 

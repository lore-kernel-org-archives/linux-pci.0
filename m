Return-Path: <SRS0=PJbn=3T=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE52C2D0DB
	for <linux-pci@archiver.kernel.org>; Thu, 30 Jan 2020 20:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA4E214AF
	for <linux-pci@archiver.kernel.org>; Thu, 30 Jan 2020 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580417762;
	bh=x0l9zksZO/x6n1yGMkTxebE3Alqw68EoksjtXhi4Zl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=jBKdbF86L31IZ7C+hzLXluhqSkWh8rorwjMeOkRQlEf3WSLT3dCI3lStSTuBeUGz3
	 Abu9lRtQ8RRuzle0h6TTSJ37b8L/VVtuwQ5bmgIbnwVodomhUPSG/A+COMwTFVOxk4
	 SokYFTkpqNvscUsd9ct/pjGSQZxkAKTCY/gNFm/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgA3U4B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:56:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgA3U4B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 15:56:01 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2152083E;
        Thu, 30 Jan 2020 20:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580417761;
        bh=x0l9zksZO/x6n1yGMkTxebE3Alqw68EoksjtXhi4Zl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EcjvaqAPQAbA1paBJ2xmn8jqw1UQqNTMyy6IU1yhYS6BmaGbiFd8RDS2u3GwrJ5X0
         H8TGzun37awCDvUaWrh/tO6S1UoKqIzeA5UB3g5u0DG4a7+hdqTs3noV/n5xv2tqFd
         URRMpLDStB8pwuYFRE/PyQphlugBVfU/IyLHP73M=
Date:   Thu, 30 Jan 2020 14:55:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 0/3] PCI: Fix failure to assign BARs with alignment
 >1M with Thunderbolt
Message-ID: <20200130205558.GA123734@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04387C41E6734CC4DEA9846280370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 05:55:17PM +0000, Nicholas Johnson wrote:
> Tiny changes:
> 	- Add Mika Westerberg's Reviewed-by: tags which he gave.
> 	- Change commit description slightly in 2/3.
> 
> Nicholas Johnson (3):
>   PCI: Remove redundant brackets in
>     pci_bus_distribute_available_resources()
>   PCI: Change pci_bus_distribute_available_resources() args to struct
>     resource
>   PCI: Consider alignment of hot-added bridges when distributing
>     available resources
> 
>  drivers/pci/setup-bus.c | 106 +++++++++++++++++++++++-----------------
>  1 file changed, 61 insertions(+), 45 deletions(-)

Applied to pci/resource for v5.6, thanks!

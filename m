Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E11C4320A
	for <linux-pci@archiver.kernel.org>; Fri, 27 Aug 2021 09:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821AF60FF2
	for <linux-pci@archiver.kernel.org>; Fri, 27 Aug 2021 09:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbhH0JCT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 27 Aug 2021 05:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244622AbhH0JCS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 05:02:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9730960F44;
        Fri, 27 Aug 2021 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630054890;
        bh=oxC5ZTxehBWxGJ2olzRAgN2U6HU2A/PiUiC002GY2vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvPXKdHXYk23rkgh3y7jtOEzQYhOQl1oTICyYRYZVE4otQRTIi+sK+itKY3Iv6PtT
         yt/5O7eluxwiRmKqqU5MCNn9NAczhIjVogRd3B16wQ5l3Fq8iJZsTvnOOxg1FzejVT
         WZ4PQgUZX8G7vKLhWNpIOdQ0El1JUbFVHT6pXEbw=
Date:   Fri, 27 Aug 2021 11:01:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     tsbogend@alpha.franken.de, bhelgaas@google.com,
        matthias.bgg@gmail.com, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: mt7621-pci: set end limit for
 'ioport_resource'
Message-ID: <YSip4/kMNOG4uYC3@kroah.com>
References: <20210822161005.22467-1-sergio.paracuellos@gmail.com>
 <20210822161005.22467-4-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822161005.22467-4-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 22, 2021 at 06:10:05PM +0200, Sergio Paracuellos wrote:
> We have increase IO_SPACE_LIMIT for ralink platform to get PCI IO resources
> properly handled using PCI core APIs. To align those changes with driver
> code we have to set 'ioport_resource' end limit to IO_SPACE_LIMIT to avoid
> errors.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

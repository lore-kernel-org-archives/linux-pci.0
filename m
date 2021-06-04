Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E419C4708F
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jun 2021 13:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1578B61242
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jun 2021 13:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFDNKO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jun 2021 09:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhFDNKN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 09:10:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89B3561242;
        Fri,  4 Jun 2021 13:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622812092;
        bh=oNNimxSgqlPEsNTwy/gzZkPhSLP95wk4lixKNq/Qjaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G12tOVDootUwZVZFjnqhCOUWLqf4YS124OrMyAiDDiwJ4FWfPerx7Iv4gbSGpfiAa
         Xh/ewmBMzd8xKMkM32D6SrAw7Od8DGZv+XI0oUZ90YZSM1muRNwaKevJBqWugD30cj
         2ZSLL/yrKyVyJlgp68sUVJVmt2i3l7ydd8b3RMTk=
Date:   Fri, 4 Jun 2021 15:08:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        john@phrozen.org, bhelgaas@google.com, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        ilya.lipnitskiy@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: mt7621-pci: remove driver from staging
Message-ID: <YLoltDsU8ZbD2bQ6@kroah.com>
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210515124055.22225-4-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515124055.22225-4-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 15, 2021 at 02:40:54PM +0200, Sergio Paracuellos wrote:
> Driver has been moved into its proper place in the
> kernel 'arch/mips/pci'. Hence, remove it from staging.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

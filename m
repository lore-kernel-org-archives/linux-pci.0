Return-Path: <SRS0=8M4G=EJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597C6C2D0A3
	for <linux-pci@archiver.kernel.org>; Tue,  3 Nov 2020 06:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1286C222B9
	for <linux-pci@archiver.kernel.org>; Tue,  3 Nov 2020 06:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604386116;
	bh=J6ULH5b4QZtm8WLIVr5QDXUfIIbcXfKJG0iuUwPIq50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dPsV//NvwpXw/i1Nc8OKjywFMTQTsPEsVAfXa5VFugqjCKswK1LwMEaZXFZhU/aCS
	 GUrCmUnqDtHpoC96NNksYabkWjj6OzEK08Q1HGfKZUcwDcdCYo5jftGNq1H01w9b0g
	 KR0EGXVEvC27tEk5z28LNOmFW3fpKbZx61TaWFnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgKCGsf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Nov 2020 01:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgKCGse (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 01:48:34 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 932D422277;
        Tue,  3 Nov 2020 06:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604386114;
        bh=J6ULH5b4QZtm8WLIVr5QDXUfIIbcXfKJG0iuUwPIq50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUhAAQzbq5V8ClH5FZMNx4+49z0Ehhu9trpc9TTF+F2cHfLF5N3jlTCacPF90ftU6
         U0G76aQsnxmw9F9HxQJ1ibUYhrfwCuzhPCMjTdhk2kE9kr8VGewZ22UqzwoGimpoBO
         kImtIU+46NWGrraTCAn/ePU1VCZAVpEt0Pcpf0Ss=
Date:   Tue, 3 Nov 2020 07:48:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/6] resource: introduce union(), intersection() API
Message-ID: <20201103064829.GB75930@kroah.com>
References: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 02, 2020 at 11:00:19PM +0200, Andy Shevchenko wrote:
> Some users may want to use resource library to manage their own resources,
> besides existing users that open code union() and intersection()
> implementations.
> 
> Provide a generic API for wider use.
> 
> Changelog v4:
> - added Rb tag (Rafael)
> - Cc'ed to LKML and Greg (Rafael)

Didn't we have some tests for this code somewhere?  Have you added tests
for the new functions you have added?  If not, can you do that so that
we "know" these work properly?

thanks,

greg k-h

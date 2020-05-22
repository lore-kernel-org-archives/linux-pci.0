Return-Path: <SRS0=d3wJ=7E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45322C433E0
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 07:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D0120812
	for <linux-pci@archiver.kernel.org>; Fri, 22 May 2020 07:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590133142;
	bh=kOTVJN33RbLq+dCiyPpPOkyEfVodS3Xtrj9FKnn322g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rt4ZY7l2xLx9Ap0Qs1JHFjxHRCT+H4uxqGXWHK+MPBiRYAl/FEPRbA5ujuoqXE4eH
	 WOH0daqy54vQiCd8lJ9yaJfjPwk3ChDJHIkkCl6LW8XFTq2+9znzttERexhYKnCv8v
	 wNT8iWfMo23q9K7aYyEkjxX278ayRHPV4c8jtk/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgEVHjB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 May 2020 03:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgEVHjB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 03:39:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662F7207FB;
        Fri, 22 May 2020 07:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590133140;
        bh=kOTVJN33RbLq+dCiyPpPOkyEfVodS3Xtrj9FKnn322g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uha+7iMKNRKO6FeHjhe7z4druchqqq4fhd3fh7IQ5HavzXmpc0Vr6x+mQCskCNOdz
         vOqb2nvThO21TRRXzWgwEIiCPxpg3rUJ0CsmuLeqIxcHjl86cjVbqYcmhtl3qVASwC
         yRZNHlE7Acg7ylxItE5SZPs4iKEz08l8UHIeZI5M=
Date:   Fri, 22 May 2020 09:38:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Klaus Doth <kdlnx@doth.eu>,
        Rui Feng <rui_feng@realsil.com.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/6] misc: rtsx: Clean up Realtek card reader driver
Message-ID: <20200522073858.GA981016@kroah.com>
References: <20200521180545.1159896-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521180545.1159896-1-helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 01:05:39PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> These are minor cleanups of the Realtek card reader driver.  They shouldn't
> fix or break anything by themselves; they're just to make it slightly more
> readable and maintainable.

Thanks for these, they all look sane and I've queued them up in my tree
now.

greg k-h

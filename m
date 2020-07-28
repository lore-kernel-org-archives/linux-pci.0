Return-Path: <SRS0=zOpN=BH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C55C433E1
	for <linux-pci@archiver.kernel.org>; Tue, 28 Jul 2020 20:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D6C207F5
	for <linux-pci@archiver.kernel.org>; Tue, 28 Jul 2020 20:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595967692;
	bh=Mv9Q/ZxNjpKppfW+jS2TBifRUUf8oS+v6oZyhx/+6LU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=A2MKvNIOwZSPNZC+cHsXuTugKNxDNh238wU2tMkvhjaz8IqYA56xiXqC2fZl5xZid
	 ZkbP98BVtpBdPWFByQihFzX1OYdRIM3D1NrworekDgho+i9fPbjwFobHxXx8rJpvcG
	 tjXNmcYWEQuoJfpQGcdQfC2b/Pplla0ZXQW7lDp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgG1UVb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgG1UVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 16:21:31 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A2B2065E;
        Tue, 28 Jul 2020 20:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595967691;
        bh=Mv9Q/ZxNjpKppfW+jS2TBifRUUf8oS+v6oZyhx/+6LU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=v48l7RS/PvnEqagkVZ7R25MIsJ0qq5yf+RxM501ykxo3+zrPDlxrxpC870Ci4qccA
         S/zHu7qi67xUUakwnKofQB3lOlASr1OIHqOo2haAKIHp1yW/PfH+xdAVdRj7RNkueb
         KbJ8gDf+XMLeSUj54/MvD8e/H85uedec0rTBSsXA=
Date:   Tue, 28 Jul 2020 15:21:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_lost_interrupt still needed?
Message-ID: <20200728202126.GA1859314@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5eba931-6e27-8f50-d018-7d51a983bfb8@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 09:20:34PM +0200, Heiner Kallweit wrote:
> Seems that pci_lost_interrupt() has no user. Do we still need this function?
> Same applies for related enum pci_lost_interrupt_reason.

If there's no user, remove it.  Bonus points if you look up the
removal of the last use.

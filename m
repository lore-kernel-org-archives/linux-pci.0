Return-Path: <SRS0=skfR=YV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A957BCA9EC0
	for <linux-pci@archiver.kernel.org>; Mon, 28 Oct 2019 16:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C102208C0
	for <linux-pci@archiver.kernel.org>; Mon, 28 Oct 2019 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572281276;
	bh=U/VdLABaNAO/Q6W5hNM4pvgx9a5/yM5EU+zAcA6EyBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=CXFjITRFOQAjTZegTT0Jf//05TcpJzBZ8TOJasx/xrZuPm6x3tWaoxOBcH7kHk6/m
	 eyy+KlLSctsiaJrNEExzEGK4KYc/YEyCHaYUqmU0/hOizfCVVAZA5FjiD81ci5mUyW
	 7PKUSgAB4MkrovZr0aaAkDuPUCSSUm1pWDN4gPCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403864AbfJ1Qr4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733000AbfJ1Qrz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Oct 2019 12:47:55 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4CF208C0;
        Mon, 28 Oct 2019 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572281275;
        bh=U/VdLABaNAO/Q6W5hNM4pvgx9a5/yM5EU+zAcA6EyBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EFHPD7dgTB2RKvFrVtaTx2Aukje9l1QV0Xkt7+xDogjjB0C1mgMfjMqLOU1115Fhm
         RAIjENr4zZMg7fpr3eMFZv6uBVJGF8RrSAdM+fmQMn1V+pWw1J4FiX28GX7nVHCRsz
         uhwApeXnDHxVQjNN9SWml5mW/3T3xE3rTRD2Ccgg=
Date:   Mon, 28 Oct 2019 11:47:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Drop Kconfig option PCIEASPM?
Message-ID: <20191028164753.GA103542@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f784101-fe7a-becf-d855-ddc6d03a3f92@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 25, 2019 at 11:42:06PM +0200, Heiner Kallweit wrote:
> I wonder whether anybody actually wants to disable ASPM support.
> In an old Kconfig commit message is mentioned that it may help
> to reduce kernel size of embedded systems. However I would
> think that on embedded systems ASPM is quite useful as it
> saves significant power and may result in a lower system
> temperature therefore.
> W/o ASPM support we have to live with devices coming up
> in whatever mode boot loader or firmware configure.

What would be the advantage of dropping CONFIG_PCIEASPM?  I don't
think it really costs us much to keep it.  I do agree most systems
probably want it.

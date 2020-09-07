Return-Path: <SRS0=zisR=CQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A756C433E2
	for <linux-pci@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A243208C7
	for <linux-pci@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599501400;
	bh=6U/80e8LU1mpbByyTzXd7oS7WNrnFSM+UR2OTMqH9Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2F/UsGrxBH3A+TAuK34bSuk2YArdE43W16AnPzOq+o79Ao0O4ffukdqoxpyv1yCr4
	 V2fJmWIomm1LXRZHMnhBdWwDV/0hkImvNYqBr0SaoxdxYVJUji7T755SjRrpERg0Gx
	 2ZtRrwB/TTjOQNsJ7xoSJTKhBPBLNR0vjR/7GRjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgIGR4i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbgIGLUg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 07:20:36 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DA321897;
        Mon,  7 Sep 2020 11:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599477122;
        bh=6U/80e8LU1mpbByyTzXd7oS7WNrnFSM+UR2OTMqH9Os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMqaSWACidOn/yIZG1LPPhO3EUHqjHUNcaHORo4DMtaI6qS5v1jVnsNCTy4QMqt/O
         uD1uFtTsC25Y8mGDAlYePB48l4+egQr9PH2H98LUQCnN7kNqekVBJeY1i9+fB6zU50
         WlOSKSAE0zBhUuYvxkYhPGBb1X1nwXG0Rz5kjfAk=
Received: by pali.im (Postfix)
        id 0E907814; Mon,  7 Sep 2020 13:12:00 +0200 (CEST)
Date:   Mon, 7 Sep 2020 13:11:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: Re: [PATCH v2 0/5] PCIe aardvark controller improvements
Message-ID: <20200907111159.p4jlpcen5urf22vq@pali>
References: <20200804115747.7078-1-pali@kernel.org>
 <20200907094032.GD6428@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907094032.GD6428@e121166-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 07 September 2020 10:40:32 Lorenzo Pieralisi wrote:
> can you rebase it on top of v5.9-rc1 and resend, thanks.

Done!

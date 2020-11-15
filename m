Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D59C2D0E4
	for <linux-pci@archiver.kernel.org>; Sun, 15 Nov 2020 12:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C006122370
	for <linux-pci@archiver.kernel.org>; Sun, 15 Nov 2020 12:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="02NSveCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKOMKE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 15 Nov 2020 07:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgKOMKD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Nov 2020 07:10:03 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D359222EC;
        Sun, 15 Nov 2020 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605442203;
        bh=QsIrZBuvI5xBIr0SPWqsD8yJWMDcUtttLcZHvx9qZy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=02NSveCnpM4A+nkdk5R52mOxVqOo51QeFJD9RznhoT2Kg6P55rtO09fgKkPknFkLi
         Xg66SteinLfGdn1/A5dBUjv6uXcvCHMesa1Wt3jgwm0hddVXdj5gfMER9LYReLP8wC
         8wyrsGwmXaWqqnqDPzyLMQmMpio2qtADGDu9eK5Y=
Received: by pali.im (Postfix)
        id 2FA38745; Sun, 15 Nov 2020 13:10:01 +0100 (CET)
Date:   Sun, 15 Nov 2020 13:10:01 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20201115121001.s23hpgeu4r5bbswt@pali>
References: <20201007161434.GA3247067@bjorn-Precision-5520>
 <20201008195907.GA3359851@bjorn-Precision-5520>
 <20201009080853.bxzyirmaja6detk4@pali>
 <20201104162931.zplhflhvz53odkux@pali>
 <X7DIeE2tPqnDoYXP@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X7DIeE2tPqnDoYXP@rocinante>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 15 November 2020 07:19:36 Krzysztof Wilczyński wrote:
> Hello Pali!
> 
> Sincere apologies for taking a long time to get back to you.
> 
> On 20-11-04 17:29:31, Pali Rohár wrote:
> 
> [...]
> > 
> > Krzysztof, as Bjorn wrote, do you want to take this issue?
> > 
> [...]
> 
> Yes.  I already talked to Bjorn about this briefly, and thus I am more
> than happy to take care about this.  Most definitely.
> 
> Krzysztof

Hello Krzysztof!

Thank you very much. I have there some patches for pci aardvard driver
which decrease boot time but trigger this race condition more often. So
they are not suitable for upstreaming yet.

Once you you have a fix for it, let me know and I could test it with my
aardvark patches.

Return-Path: <SRS0=YZnm=6L=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA4C54FD0
	for <linux-pci@archiver.kernel.org>; Mon, 27 Apr 2020 09:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8057E206B6
	for <linux-pci@archiver.kernel.org>; Mon, 27 Apr 2020 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587979844;
	bh=/mzCepWyLB4aLXDokvt9uQNKR95X5MKHZBJsMOD7j9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wZRHVIkkNBbXuEao8bM+skm+8pOti0v35NDp1Z3sTdNJqpb6o4PF5Up3LTWa+FKVg
	 pjwttmmUnSCMBgpGzH0A/xnjmEEsokYUHLB6r9v7ZzYt2oeIaq5WaIULEAxWuCchW8
	 L+rn6tR/K0YvRUtoAxhsFUPvdAaxoC6RkFLmH9xI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgD0Jao (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgD0Jan (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 05:30:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 184F5206A4;
        Mon, 27 Apr 2020 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587979841;
        bh=/mzCepWyLB4aLXDokvt9uQNKR95X5MKHZBJsMOD7j9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/kiMwPaY/VDX1wOhxgkkk9MDteHelOOcxFTtdFLzUk7tVJxefVRDmIenCmudlX88
         K5Z+I1riKyos3gQaZOBawr7ZNuKHYBdPvL3T60r9v+hzn9XNQFBbsQBc6BiXZgjW9I
         5xvSb5AGCoNgmSJdCS7hbsfiTfs7boiF03W13sxc=
Received: by pali.im (Postfix)
        id 254178A8; Mon, 27 Apr 2020 11:30:39 +0200 (CEST)
Date:   Mon, 27 Apr 2020 11:30:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 04/12] PCI: aardvark: Improve link training
Message-ID: <20200427093038.rns2xj4cwk4l5emn@pali>
References: <20200424153858.29744-1-pali@kernel.org>
 <20200424153858.29744-5-pali@kernel.org>
 <CAL_JsqLTXGE4SAmbzkPJ-omusMiSoBwgF0j8HhAq7F+9w7g1wg@mail.gmail.com>
 <20200424185523.hevihypwklly6vrs@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200424185523.hevihypwklly6vrs@pali>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 24 April 2020 20:55:23 Pali Rohár wrote:
> On Friday 24 April 2020 12:00:54 Rob Herring wrote:
> > On Fri, Apr 24, 2020 at 10:39 AM Pali Rohár <pali@kernel.org> wrote:
> > > @@ -988,6 +1046,11 @@ static int advk_pcie_probe(struct platform_device *pdev)
> > >         }
> > >         pcie->root_bus_nr = bus->start;
> > >
> > > +       ret = of_pci_get_max_link_speed(dev->of_node);
> > > +       if (ret < 0)
> > > +               return ret;
> > 
> > Why just give up simply on DT error? Just start at gen 3 since you now
> > retry at lower speeds.
> 
> Ou, I forgot there a special check for ret == -ENOENT.
> 
> > > +       pcie->link_gen = (ret > 3) ? 3 : ret;
> > > +

This code should have been something like this:

+	ret = of_pci_get_max_link_speed(dev->of_node);
+	if (ret == -ENOENT || ret > 3)
+		pcie->link_gen = 3;
+	else if (ret >= 0)
+		pcie->link_gen = ret;
+	else {
+		dev_err(dev, "Failed to parse max-link-speed\n");
+		return ret;
+	}

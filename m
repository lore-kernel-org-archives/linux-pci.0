Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D99EC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 07:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180A520659
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 07:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfANHTP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:19:15 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:52956 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfANHTO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 02:19:14 -0500
Received: from sapphire.tkos.co.il (unknown [10.0.4.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 14ED44405BD;
        Mon, 14 Jan 2019 09:19:11 +0200 (IST)
Date:   Mon, 14 Jan 2019 09:19:09 +0200
From:   Baruch Siach <baruch@tkos.co.il>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-pwm@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Message-ID: <20190114071909.5cz4pg4bsdo7htob@sapphire.tkos.co.il>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch>
 <8736q0irwy.fsf@tarshish>
 <20190110131912.GB29612@lunn.ch>
 <87zhs8h5ej.fsf@tarshish>
 <87pnt0vil3.fsf@tarshish>
 <20190113154028.GB4635@lunn.ch>
 <CACRpkdY6UPcWds3swtRM_OMu3hCJcdicbo29b5JEcRBNC4L+vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY6UPcWds3swtRM_OMu3hCJcdicbo29b5JEcRBNC4L+vg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

On Mon, Jan 14, 2019 at 12:35:01AM +0100, Linus Walleij wrote:
> On Sun, Jan 13, 2019 at 4:40 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > Another look at this comment made me realize that we need comphy
> > > initialization support in the kernel for PCIe reset to work correctly.
> > >
> > > The workaround that this patch proposes will not solve the problem for
> > > v5.0, since the GPIO get_direction patch will only appear in v5.1.
> >
> > You could ask for it to be applied to v5.0 since a real fix depends on
> > it.
> 
> If it makes a piece of hardware work that was working before and
> now is not working as a result of other kernel changes I would
> definately apply it because that is a clear cut regression.
> 
> I am under the impression that this is the case?

The gpio-mvebu get_direction support enables a workaround for a regression 
introduced in commit 3d71746c420c1 on the Macchiatobin platform. An 
alternative solution is to revert the offending commit. The revert will not 
break any known platform that has been previously supported in mainline 
kernel. I tend to think that revert is a better course of action.

It is up to the PCI maintainers to decide.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

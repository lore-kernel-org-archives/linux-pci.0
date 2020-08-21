Return-Path: <SRS0=IRj4=B7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF8CC433E1
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 19:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6B2075E
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598036619;
	bh=mobFhjUuZBrTxeSb27VlPLsjpmZe6i7fkoS3n8QFR34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=htTwYnx/lRtpXeWhDP85lqm/wjDW/rYTkMGrzjdX4pLsYePwwroRhqft/g9mt1EIb
	 eXYLBtFDmjW+IaZewZbTubh1TNj6RBXfhXiAcSrYVDePW92G0JoP1tDRoIkKArQV6L
	 wZQBAOw78Lae/Nrk7S5vlCsKh+Ph7chJ2RQAA3eI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHUTDc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHUTDc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Aug 2020 15:03:32 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 666CF2075E;
        Fri, 21 Aug 2020 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598036610;
        bh=mobFhjUuZBrTxeSb27VlPLsjpmZe6i7fkoS3n8QFR34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d47nr9y1hi0vy9vzISm94HRnub0xDqtMTKqZq3FQRWtN3RtNgsm5Y+hvQPVhvjKcN
         VP44tFF83D1l8gGqVk8IdT5tIbB6wpOMc1e7m8wBZ/72Pky2mD+XALP7aa11AqDDI/
         3gLt6TZRyninR4Jf758I9jj9Icy2kKN39Qm3URcQ=
Date:   Fri, 21 Aug 2020 14:03:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daire McNamara <Daire.McNamara@microchip.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com
Subject: Re: [PATCH v15 2/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200821190328.GA1689493@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL1FiQ1CxTeOcEV8Y=p1yZKkXLq5Zz3qZ+xiJqkvH+RxA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 21, 2020 at 11:57:47AM -0600, Rob Herring wrote:
> On Thu, Aug 20, 2020 at 12:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Aug 19, 2020 at 04:33:10PM +0000, Daire.McNamara@microchip.com wrote:
> >
> > > +static struct mc_port *port;
> >
> > This file scope item is not ideal.  It might work in your situation if
> > you can never have more than one device, but it's not a pattern we
> > want other people to copy.
> 
> Indeed.
> 
> > I think I sort of see how it works:
> >
> >   mc_pci_host_probe
> >     pci_host_common_probe
> >       ops = of_device_get_match_data()              # mc_ecam_ops
> >       gen_pci_init(..., ops)
> >         pci_ecam_create(..., ops)
> >           ops->init                                 # mc_ecam_ops.init
> >             mc_platform_init(pci_config_window *)
> >               port = devm_kzalloc(...)              # initialized
> >     mc_setup_windows
> >       bridge_base_addr = port->axi_base_addr + ...  # used
> >
> > And you're using the file scope "port" because mc_platform_init()
> > doesn't have a pointer to the platform_device.
> 
> This is a simple fix. Move platform_set_drvdata to just after
> devm_pci_alloc_host_bridge() in pci_host_common_probe(). (Don't fall
> into the 'platform problem'[1] and work-around the core code.)
> 
> Then pci_host_common_probe can be called directly and mc_setup_windows
> can be moved to mc_platform_init().
> 
> > But I think this
> > abuses the pci_ecam_ops design to do host bridge initialization that
> > it is not intended for.
> 
> What init should be done then? IMO, given this driver is using ECAM
> support already and it's all one time init that fits into init(), it
> seems like a fit to me.

Oh, OK.  If you can solve this as you outlined above, that's fine with
me.  It didn't look like a common pattern yet, but maybe it will be.

Thanks for chiming in.  I didn't have a good idea for how to fix the
file-scope variable problem.

Bjorn

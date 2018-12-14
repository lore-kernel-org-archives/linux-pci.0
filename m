Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24A3C43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 20:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158EC2080F
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 20:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544819913;
	bh=hzltAayUK9lLKge3kpsO0GSbw5lLTpE2an01zAcOuRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RxJGDQgFpvVaqdKV3CcSNDO/McvcRRMAWtlDVl1jMydZ8+GzZ3dnLXzXESR4fqrkz
	 IiykBCgFlBmynj00zWIzjrxsxqN2woKsMaUlQmTYDC1MsZ+Pjtc0I7Nw1jPj+qQqa4
	 W8Cui+9s+9EIo3JMS60hFlpiI1GAJVbdRH9K0MpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbeLNUib (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730860AbeLNUib (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 15:38:31 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1B75208C1;
        Fri, 14 Dec 2018 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544819911;
        bh=hzltAayUK9lLKge3kpsO0GSbw5lLTpE2an01zAcOuRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJkkvqBVLfGKn4C8bDA7hgwgcPJzf07Sw6FPMPhBDPjc9BjTfPHPeF2EM2S/YzPIO
         GDLwMSJpz2q5ri/wKySWnrpZOi9tf1tuoEmz1I6seurZgVgseWVeRc87lsf1EKRSIR
         f94hVWtyPYw0tPzW6m79gqNAjGq/vL8haNZwystg=
Date:   Fri, 14 Dec 2018 14:38:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-imx@nxp.com,
        Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH v2 0/3] PCIE support for i.MX8MQ
Message-ID: <20181214203828.GD20725@google.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Trent]

On Thu, Dec 06, 2018 at 12:15:50PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Dec 05, 2018 at 11:35:42PM -0800, Andrey Smirnov wrote:
> > Everyone:
> > 
> > This series contains changes I made in order to enable support of PCIE
> > IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).
> > 
> > NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-kconfig].
> > 
> > Changes since [v1]:
> > 
> >  - Driver changed to use single "fsl,controller-id" property to
> >    distinguish between two intances of PCIE IP block
> > 
> >  - All code pertaining to L1SS was dropped to simplify the patch
> > 
> >  - Documented additions to DT bindings
> > 
> > Feedback is welcome!
> > 
> > Thanks,
> > Andrey Smirnov
> 
> Andrey,
> 
> I have applied the patches, ...

When I merged your pci/dwc branch, I noticed what looks like a merge
conflict between these commits:

  d123765b58ee ("PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on IMX7")
  1a059d994189 ("PCI: imx: Add support for i.MX8MQ")

d123765b58ee added SOC_IMX7D:

  -       depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
  +       depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)

and 1a059d994189 added SOC_IMX8MQ but dropped SOC_IMX7D again, which looks
like a mistake:

  -       depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
  +       depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)

So my "next" branch[1] (current head 7053eeb009e0) is:

  config PCI_IMX6
        bool "Freescale i.MX6/7 PCIe controller"
        depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
        depends on PCI_MSI_IRQ_DOMAIN
        select PCIE_DW_HOST

which I think is wrong.  Lorenzo, if you update your pci/dwc branch,
I'll rebuild my "next" branch.

If you want to tweak the switch statements and/or IMX8 checks, you
could do that at the same time.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=next

Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0409AC2F420
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 14:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0882089F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548081439;
	bh=Y/g2iDkfkIrQOfww0ByuoTOYvkPpUMrXjww2OJLERa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fvBgpoBesNGSklQT73XPLd9bFXUX3pgKJ9FcmaaORAyqkRpMR17isRV9cutkxDxZP
	 6fybU2PrWCzYVcGOIwRsQfZSDVG2EtnVTK1Llo53kEtMfhg6TmdVmM85d73ZvkzmFT
	 cm2yIFm+62QBH1DKMLwm+N3btr6dXsDo+3Rq1XQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfAUOhO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:37:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45744 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbfAUOhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 09:37:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so20652321ota.12;
        Mon, 21 Jan 2019 06:37:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yCZE0qmHTsavb3lVKD5eIngzqW5FGtladyA6/TKyrl0=;
        b=Wn9d1KfPaN4rT/o+ISxVyt/Hvx4vcrlizOe2ivntof2oIwE1Jix3oVGxN4HcWS054j
         iS0jGGKEzR1d0syBVuYZnQzUwOmAPr97BbitzaWvdOr7LpQ16DawbiVotX2O+jb5ttj2
         q1Cv5oLdAouDQoMgklKDnLHugHjxGDwm5PfsFGmK5pG5UaCDrYtuFxylOTLJ6kt7Ak9I
         ojk4m+4nk63q1vVDcxmAgi2ECqU0mNT74POzGanJz7wadThc/mizcqKM/UZ1TT0IEfnb
         UvuXDmw9oifZ+I2JS0eRGwSvnd+8XoxlelTw3E/pk1H/6NvM8W5epJ3WeTIvKF7VzS2A
         PvcQ==
X-Gm-Message-State: AJcUukdsk83+QEBKlpre6BEqgrcqLrGhkUxA8rKupeDSXd2MnYPffNnT
        c20ukpHJukQBQZBftTeFVg==
X-Google-Smtp-Source: ALg8bN70Q4ksOHrrmPpNmJxNmO3jRYxHaViWwUELu9sncCjtnH94eEs9zdYbjYPjPBO5KUeNXVTrgw==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr19070332otl.196.1548081431955;
        Mon, 21 Jan 2019 06:37:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y25sm5426170otk.50.2019.01.21.06.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 06:37:11 -0800 (PST)
Date:   Mon, 21 Jan 2019 08:37:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        cyrille.pitchen@free-electrons.com, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, niklas.cassel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv5 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Message-ID: <20190121143710.GA10941@bogus>
References: <20190121094500.10657-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121094500.10657-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 21, 2019 at 05:44:57PM +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding for the layerscape PCIe
> controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Reviewed-by: Minghuan Lian <minghuan.lian@nxp.com>
> Reviewed-by: Zhiqiang Hou <zhiqiang.hou@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> v3:
>  - modify the commit message.
> v4:
>  - no change.
> v5:
>  - no change.

Still missing my R-by tag from v3.

> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

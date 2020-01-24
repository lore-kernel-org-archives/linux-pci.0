Return-Path: <SRS0=FXHr=3N=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA0DC2D0DB
	for <linux-pci@archiver.kernel.org>; Fri, 24 Jan 2020 13:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDBD2072C
	for <linux-pci@archiver.kernel.org>; Fri, 24 Jan 2020 13:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579873588;
	bh=KLpwb0cHRV4sk/IwW2TXJDIyT3N4XsENIvU1qFoTRGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jw+5f0KQiOmL6rmuA7cYtZwmLbR9Kv/Z05FLxol54bSnV3AzES7znBPKutNSKl1Wv
	 hPTn0P/XLYErOB3qERARACXuKBGQVO3oj/v95qRETgvLr7yjRL2QoYGGEuUvn/bnQK
	 NfaED+VRsRE6J1J53WhJOgfHlTryWP4eh0T/xsDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390010AbgAXNqY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:46:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389902AbgAXNqY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jan 2020 08:46:24 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2950B2075D;
        Fri, 24 Jan 2020 13:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579873583;
        bh=KLpwb0cHRV4sk/IwW2TXJDIyT3N4XsENIvU1qFoTRGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O1GP1BxYpp54Nt4liVaZlOhUCxE1pUlClmM9USCIqTxIs6hNVf6yDv8GKFRCEiRuT
         PbdR5GUv0FTRsRtK4c0n6DPyYii2D1tF0PP16lmEKyNKjWwZNqg7zZLxqQuAS4oBcE
         Wnpb/9QSMaRNH8sYe0k4H8ptXj+hbeYhyJfoo/U8=
Received: by mail-qt1-f172.google.com with SMTP id e12so1528427qto.2;
        Fri, 24 Jan 2020 05:46:23 -0800 (PST)
X-Gm-Message-State: APjAAAXmjo6/OjDuy1i8lMPYEAEbUrgzbBGL8rk3tVPhd8aR3RFGcKBb
        zqG2oO5Y6IKeBN5roHP4bV5j9GDZTK31RSQcfw==
X-Google-Smtp-Source: APXvYqzExpwnerHFJD/jD56xNTg8eiIGvUGUJMrpuZsJaUoRombACvXxhWGjj1SnA0rab+5N4LfdFrK/dCILGlrjhGE=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr2159563qtp.224.1579873582277;
 Fri, 24 Jan 2020 05:46:22 -0800 (PST)
MIME-Version: 1.0
References: <3319036bb29e0b25fc3b85293301e32aee0540dc.1576833842.git.eswara.kota@linux.intel.com>
 <20200108142242.GA8585@bogus>
In-Reply-To: <20200108142242.GA8585@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 Jan 2020 07:46:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKvMvTAtwR73ookz-_F72j-Q9j5s1uDipka+bQ3CL7Hsw@mail.gmail.com>
Message-ID: <CAL_JsqKvMvTAtwR73ookz-_F72j-Q9j5s1uDipka+bQ3CL7Hsw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: PCI: intel: Fix dt_binding_check
 compilation failure
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 8, 2020 at 8:22 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 20 Dec 2019 17:53:24 +0800, Dilip Kota wrote:
> > Remove <dt-bindings/clock/intel,lgm-clk.h> dependency as
> > it is not present in the mainline tree. Use numeric value
> > instead of LGM_GCLK_PCIE10 macro.
> >
> > Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> > ---
> >  Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Ping.

Bjorn or Lorenzo, can you please apply this. linux-next has be broken
for some time now.

Rob

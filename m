Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA42C43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C70620874
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218968;
	bh=xxlTdTds1EgVnz1D9wGgpHBcLFHxWcHUx2+evsCrUIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XRS+QMrU3nly4UHzF0U7qraDNC4oq0q/vLl+CxmUxxoj2W2BaWI2mSNGaPLPZuaXR
	 +6n1aj7K2s8Vj5maVJn0JekeMHy51buXHqdPlUigdvimJ3KV91aWWXBbzfgPqvObrJ
	 W7343o8l5YoXZvid8yiwGUIDY318BaHiLus0VRok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbfAKPCk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:02:40 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36463 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389171AbfAKOb0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2019 09:31:26 -0500
Received: by mail-oi1-f170.google.com with SMTP id x23so12337297oix.3;
        Fri, 11 Jan 2019 06:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVy93fNR+ZKX3Oyx2564C6JZXIF8X9/cPZx9J8v4si4=;
        b=sVaP7BhqZ6E6VAjRTyMvSW5AO1rQYH9M55KhesCGyZuGCeruiQDuDQDSTSFPmqX2Eu
         gfwpSA2lGmd+dALGBj6R7OZUlFMqUH3Lg1fsFDJInkNKlqFetTHrzl26K2+I6+dxgJkW
         VMvd0zPmjMxYt4miSuwPVpwgHFSMtmkRP5gD0UEFb9+ZfUHElUvcrVY6Qb0fxcFCRfST
         Y7loifIrNyPadzqyti5nyvyBWmz/zclCcYnY10RyzgmtTj8RGtdkrcvbvUHX6SPzWum1
         w8i1/ajs65FnjIzaQYNRtKOwu5gXBoITWYoLTej7Nm8APf87oIxOdeYHlRhrHVqYfdiY
         NUjQ==
X-Gm-Message-State: AJcUukf6qNaaIil7qlDLcYTKFmcb3ztQAU5oJi2esJVAdYFOBEBXToAW
        rkTeKsBJqWgqFSsgRLcZ7g==
X-Google-Smtp-Source: ALg8bN4WsQm0l3CE4srtcBiKuMuAevRTcBgPlfPUqntmq9IuC1T6tqgtGT5vBulJsp2Blm2mGs2dsg==
X-Received: by 2002:aca:bf06:: with SMTP id p6mr8778071oif.269.1547217084941;
        Fri, 11 Jan 2019 06:31:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x9sm32990078otq.73.2019.01.11.06.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:31:24 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:31:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        cyrille.pitchen@free-electrons.com, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, niklas.cassel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv4 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Message-ID: <20190111143123.GA6960@bogus>
References: <20190108030922.24031-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108030922.24031-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue,  8 Jan 2019 11:09:19 +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding for the layerscape PCIe
> controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> v3:
>  - modify the commit message.
> v4:
>  - no change.
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

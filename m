Return-Path: <SRS0=mHad=7K=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295CFC433E0
	for <linux-pci@archiver.kernel.org>; Thu, 28 May 2020 23:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EE72075F
	for <linux-pci@archiver.kernel.org>; Thu, 28 May 2020 23:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590709457;
	bh=84f6MglxX1l3P+Wr606QYHW65Ai7NUsBZALi2r/+pw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=14MLYc0tB18j3xpqMXtMvwdG3SQEMO/Ummw4Kn8bnzlTU0snC8yH4KUDoXKNLTC5k
	 Xc9QXd9r6Pri8vbSm0VPMNUG+bbuJWIOzO17aASt4C8y84Otc0BjcJcor5yF58OA7y
	 3XeFzqs8Shi7eR/m+xCBkO7LvZsenH9Gt0coXo3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437641AbgE1XoJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 May 2020 19:44:09 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46808 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437602AbgE1XoH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 19:44:07 -0400
Received: by mail-il1-f193.google.com with SMTP id h3so685312ilh.13;
        Thu, 28 May 2020 16:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SJt64wuHNXMPjKZrlv+beaYGcRj4IkMh+4Yf8nn+Tsg=;
        b=WvPKAmNLSnsXJ4s3he6dPhJnIGGmDHoz7v9BX+NyR6ahzn7130JlBWjUZQ5oaz/o/m
         bahD4XLJZnE3qYMxraY47ho6505eHW+YovGJ1oLlRAQ3r0ZeQVrsxQKYhtIPeAV5WVIe
         mq4cfpa7RcbzypoPEkzSTNmPRaaLHMFRjFhybeHwydcOaBvcRpcJu4BsyNMAGazCuLoE
         8YSigWfYE9+0c1hZpaka62y0ryggfV1TVkLPky8YdFw5QDReBKyv5EM1deHjxQyW11ZT
         NDSt2wbyxOHCaAipU+oGKKagJk/MPdcNn0LEV/wfwwQrXjJg0QaKMoU6ofISMms2UQFX
         JjXg==
X-Gm-Message-State: AOAM533X0cIQ9nyxTOeaYMxuHv0kwPzyUvl7CyLWbV+NsPQspt9SImF/
        Ek9h+MlhVr2gV6+Sa3XqoA==
X-Google-Smtp-Source: ABdhPJySyB9ElcmWHrZDW925kYG1RRxzhilZZTQitcdtgozb2BQGIclUHZwPlliObO6xj+p8NVmWGQ==
X-Received: by 2002:a92:5fda:: with SMTP id i87mr2822930ill.292.1590709446044;
        Thu, 28 May 2020 16:44:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t189sm3109029iod.16.2020.05.28.16.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:44:05 -0700 (PDT)
Received: (nullmailer pid 902804 invoked by uid 1000);
        Thu, 28 May 2020 23:44:02 -0000
Date:   Thu, 28 May 2020 17:44:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        dmaengine@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: usb: renesas,usbhs: Add support for
 r8a7742
Message-ID: <20200528234402.GA902594@bogus>
References: <1590356277-19993-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590356277-19993-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590356277-19993-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 24 May 2020 22:37:52 +0100, Lad Prabhakar wrote:
> Document support for RZ/G1H (R8A7742) SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

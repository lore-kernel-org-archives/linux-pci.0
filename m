Return-Path: <SRS0=S6xX=TR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B57C04E87
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 22:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EAD2133D
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 22:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558130831;
	bh=NGfDVpnHGlZSPBv3BpoihAF+0N7E7o+m14ZovnpkobE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=svlOJrDUosauy7YyfsrZA5zSQTkvbluP9PIJHza8stmjEjBKnxekg6W7WEMBN1HS6
	 zBMaKdcZaMhOjz+VrgAaLYg3pIoezp6GS9+ldWTHAaq/CVWomkEzD+A31ctfGDyQ7F
	 GNbO4RtZ/v2X9+7vP4rqBgue1afgTT+u/gPVN5rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfEQWHC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 May 2019 18:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfEQWHC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 May 2019 18:07:02 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFF3B2177B;
        Fri, 17 May 2019 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558130821;
        bh=NGfDVpnHGlZSPBv3BpoihAF+0N7E7o+m14ZovnpkobE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y9fdFpl39fMid+8MsAA/hPpFb3TrE6k7jLGR+qBODvjBpasdPNATrAFSnanBPYEuo
         KtPp2TC60I+dC2MynZazihAVFCl0jWkxQa8eV2Y4QOiEO/fEEvbGhmecLADiaLmnbA
         1r+a7Fd/E/FeD0aKgq2gMx7ncK4i8B2OPhhCrMMs=
Received: by mail-qt1-f179.google.com with SMTP id o7so9815332qtp.4;
        Fri, 17 May 2019 15:07:01 -0700 (PDT)
X-Gm-Message-State: APjAAAXh41oQu0tZ/VP3+MIH+ZA/ce9y1KqvwYWEor3h5+kEodji9UOz
        bCVWqUxM+P+0WnUA9TNQb2T+cZUPfHOGSZNpWQ==
X-Google-Smtp-Source: APXvYqzgnPSjbNZB21jfdHyrVRvTQpjTFduXMTCC2dRcGxkUBTV0K1qQ8CT5M1gXcRQgkiXQx+OFoK0kRL1cf4DpnAo=
X-Received: by 2002:ac8:2d48:: with SMTP id o8mr51145213qta.136.1558130820928;
 Fri, 17 May 2019 15:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org> <1558118857-16912-2-git-send-email-isaacm@codeaurora.org>
In-Reply-To: <1558118857-16912-2-git-send-email-isaacm@codeaurora.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 May 2019 17:06:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKcZaQCZuodCiaTKV1ZyQQcufL4P4jpcDcKCDwR0B+6EA@mail.gmail.com>
Message-ID: <CAL_JsqKcZaQCZuodCiaTKV1ZyQQcufL4P4jpcDcKCDwR0B+6EA@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/4] of: Export of_phandle_iterator_args() to modules
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        Pratik Patel <pratikp@codeaurora.org>, lmark@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 17, 2019 at 1:48 PM Isaac J. Manjarres
<isaacm@codeaurora.org> wrote:
>
> Kernel modules may want to use of_phandle_iterator_args(),
> so export it.
>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>  drivers/of/base.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

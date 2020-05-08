Return-Path: <SRS0=2kU9=6W=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610E8C35280
	for <linux-pci@archiver.kernel.org>; Fri,  8 May 2020 01:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D2520CC7
	for <linux-pci@archiver.kernel.org>; Fri,  8 May 2020 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588900283;
	bh=SRyTRR0ofpehB0QrbI1UPDJ/+BG7MqfbSadDor9zC3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vV/PFsWtf1c/PpYuevic/FCRHH19yWvUvgPhRyYemhBxe+aZIXhvsQzYxHDQF5MUE
	 uk2UWpmCVbQWwhT8oyn3xBtrgpbmVCYePnftoYvOjaV1WDNweP5zR2+/oLqLsxBPIX
	 s81BWZ5FVNGQhafWjqcSOd0E8ejX8srCwRylsh3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEHBLW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 May 2020 21:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgEHBLW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 21:11:22 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4C02208E4;
        Fri,  8 May 2020 01:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588900281;
        bh=SRyTRR0ofpehB0QrbI1UPDJ/+BG7MqfbSadDor9zC3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c+rw2UGsXPBNRL+un0z9oA50sOLj8SneEQspZzKSvbGztUfr+/1WYCD+fN55XLNrh
         SSeV5UbAoAypBDJpzcSJ+Vlr69yFrYW74mm2u/AdTKMxbeHt17dk4sQ3Hb9bOXVIaf
         dEKSa0AascySxTZYqkhkGbDWI6UhwFqHvkRuuZtw=
Received: by mail-oo1-f54.google.com with SMTP id p67so1794891ooa.11;
        Thu, 07 May 2020 18:11:21 -0700 (PDT)
X-Gm-Message-State: AGi0PuaObNVo0O55GUPI772Pif6wkOGQ/ixoz4cVSutGYMJsghTuj3w8
        7PmfBc4FqKnyV5EmwR7koy44sM9L8II7fDRydA==
X-Google-Smtp-Source: APiQypIJrtYxVWl5r+pD/EJOcnRBaXUluMS28Zu3xjxB8gNg2GGajVyDihdMtWJJ8AOfidD0XwNySGRNmFShbAmj8z0=
X-Received: by 2002:a4a:9c55:: with SMTP id c21mr345333ook.25.1588900280975;
 Thu, 07 May 2020 18:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200507201544.43432-1-james.quinlan@broadcom.com> <20200507201544.43432-4-james.quinlan@broadcom.com>
In-Reply-To: <20200507201544.43432-4-james.quinlan@broadcom.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 7 May 2020 20:11:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK6mHhw=9gCyyS7nP35WcqQLQdKhgNXYPSXwkhVe_8t0g@mail.gmail.com>
Message-ID: <CAL_JsqK6mHhw=9gCyyS7nP35WcqQLQdKhgNXYPSXwkhVe_8t0g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: brcmstb: New prop 'aspm-no-l0s'
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 7, 2020 at 3:16 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> From: Jim Quinlan <jquinlan@broadcom.com>
>
> For various reasons, one may want to disable the ASPM L0s
> capability.
>
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

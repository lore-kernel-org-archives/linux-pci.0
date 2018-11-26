Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F01C43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 14:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D405C20862
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OORiYMsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D405C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeK0BpZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:45:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37841 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeK0BpZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Nov 2018 20:45:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so5319770wmd.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Nov 2018 06:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kFMebdd3rVDX4F6Wrh7uYRhO+8QF8tMUU/jfte+pZG4=;
        b=OORiYMsI47DjN8FRvdpYvwaaDHYcAYetF9/8pgwWigafI284I4oMtPNY5Yb+bfSc7j
         ZAhNRzdwsWvFhBzzUUAj5yH46W/rGulFcf6r5z/zMGxvQYCEVWa9hDbWlAtxpYCgqVtd
         UcxbLakWWthfiDkfwP6dkqUa9sM3eD7Yba2wu148qiXxpHy0lT45Cwf8EoxH8PXZkSEt
         1tE6RCUaaBwSheHdQ8LVvouNLM6q6xr2voFSjI18GAtA3lgezqgZNWb+pkUi8M9z4vOH
         mK1ooIcWPy+I71Nmw38yLsMUhAXs1rzF29p2Kz5YF/fpjoCJDEBPgRlBOwYl2sj+HJRb
         DvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kFMebdd3rVDX4F6Wrh7uYRhO+8QF8tMUU/jfte+pZG4=;
        b=Xty6teKiBImELZ1YPMVbuWla0dLVjzmmx3pP3U3dV0G5dm4oOhC+Mv2xh9QclaAYc2
         uK39hJrjRaWDpyZrJy6MqMAJw4Qe0S2g4wDRwQOl6jCYeuEootZSsc3v4KWv8fwrNdiG
         GpVS3JsBr4C0woFljzIIu4RR3LfJ1Zl0foNByh53otdHzLQ6vNJBeaL/6XNRIRses7YU
         Bl2aH2V4QMquWBGKBWlikilUf/hFotUR4zIc/vwTuFPkhM2SlJeZT/tKmOInbNSYB+V6
         jVOxQYVmYodOjGxcsMcwfybh6DGsitJQd3F+oIyyJZYh0uMRi8ZwYaVZx+Ep/NjoCpLt
         +m2g==
X-Gm-Message-State: AGRZ1gIYj4wXijUC7k8eT0ALgxHSx4Su14G/0S0+lfczwkPIVzhvAoPQ
        VRnT17Gcv1CjcrsWsKMfL46yYJOQb7lB+m0fhUYq
X-Google-Smtp-Source: AJdET5eLN3Ygw662ck0Gn3zC+eXaxK5/GRvOjNU/JhBJ48nU7m3unMyBNGYwjkQWhXVIdcrggZGPI/imO9bDf66VpPo=
X-Received: by 2002:a1c:4046:: with SMTP id n67mr23174655wma.123.1543243862859;
 Mon, 26 Nov 2018 06:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
In-Reply-To: <20181123141831.8214-1-miquel.raynal@bootlin.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 26 Nov 2018 08:50:51 -0600
Message-ID: <CAErSpo6WLc-OHGgGJdxVTrKwnPud+Kqpuswiz1zo7Yd8ruihEg@mail.gmail.com>
Subject: Re: [PATCH 00/12] Bring suspend to RAM support to PCIe Aardvark driver
To:     miquel.raynal@bootlin.com
Cc:     gregory.clement@bootlin.com, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        thomas.petazzoni@bootlin.com, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        Nadav Haklai <nadavh@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 23, 2018 at 8:18 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hello,
>
> As part of an effort to bring suspend to RAM support to Armada 3700
> SoCs (main target: ESPRESSObin), this series handles the work around
> the PCIe IP.
>
> First, more configuration is done in the 'setup' helper as inspired
> from the U-Boot driver. This is needed to entirely initialize the IP
> during future resume operation (patch 1).
>
> Then, reset GPIO, PHY and clock support are introduced (patch 2-4). As
> current device trees do not provide the corresponding properties, not
> finding one of these properties is not an error and just produces a
> warning. However, if the property is present, an error during PHY
> initialization will fail the probe of the driver.
>
> Note: To be sure the clock will be resumed before this driver, a first
> series adding links between clocks and consumers has been submitted,
> see [1].
>
> Patch 5 adds suspend/resume hooks, re-using all the above.
>
> Finally, bindings and device trees are updated to reflect the hardware
> (patch 6-12). While the clock depends on the SoC, the reset GPIO and
> the PHY depends on the board so the clock is added in the
> armada-37xx.dtsi file while the two other properties are added in
> armada-3720-espressobin.dts.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/6=
14527.html
>
> Thanks,
> Miqu=C3=A8l
>
>
> Miquel Raynal (12):
>   PCI: aardvark: configure more registers in the configuration helper
>   PCI: aardvark: add reset GPIO support
>   PCI: aardvark: add PHY support
>   PCI: aardvark: add clock support
>   PCI: aardvark: add suspend to RAM support
>   dt-bindings: PCI: aardvark: describe the reset-gpios property
>   dt-bindings: PCI: aardvark: describe the clocks property
>   dt-bindings: PCI: aardvark: describe the PHY property
>   ARM64: dts: marvell: armada-37xx: declare PCIe reset pin
>   ARM64: dts: marvell: armada-3720-espressobin: declare PCIe reset GPIO
>   ARM64: dts: marvell: armada-37xx: declare PCIe clock
>   ARM64: dts: marvell: armada-3720-espressobin: declare PCIe PHY

Hi Miqu=C3=A8l,

Thanks for your work!  If/when you post a v2, please run "git log
--oneline" and adjust your subject lines to match the capitalization
conventions, i.e., for PCI, start the description with a capital
letter: "PCI: aardvark: Add suspend to RAM support".

BTW, I notice you closed your email with "Miqu=C3=A8l", but the patches
contain "Miquel".  you *should* be able to use the correctly accented
version of your name in the Signed-off-by lines.  I have tripped over
some tool issues, but if we pay attention, we should be able to get it
to work.

>  .../devicetree/bindings/pci/aardvark-pci.txt  |   9 +
>  .../dts/marvell/armada-3720-espressobin.dts   |   4 +
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   5 +
>  drivers/pci/controller/pci-aardvark.c         | 214 ++++++++++++++++++
>  4 files changed, 232 insertions(+)
>
> --
> 2.19.1
>

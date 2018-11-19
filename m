Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA9C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52826208E3
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 20:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oXMSCEVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52826208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbeKTGhx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:37:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39039 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbeKTGhx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 01:37:53 -0500
Received: by mail-oi1-f195.google.com with SMTP id 192-v6so26336921oii.6;
        Mon, 19 Nov 2018 12:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWqRt1hx9afwx1pA4ot31NcExm8qubHQTBZSMfxxSbg=;
        b=oXMSCEVix3pfFdd5P0Bu+TZFKlIUwEZnsgHEJmFKM7r4vHAUvqXOmMWjl1i5JsiJik
         9vlqosggm0VEraOwSRFAhkMdg0QjsAmSMyf/uZaQyn/ebQ3Lq9Jul4PXh0ZzCSBDih1k
         DuWKVICETPTsO3RUHIlJsSchT7OrB92ax8+OPXBEVuGt3WotN3CWxQvORG4UPc/5qfnr
         MvEE/naWr4RQrvBguJjSUrlEDriIV6/xMM6X132548dZIGP0WUIacrPkl8P95x6l+jZC
         Nw29lvri+CvW9pgZok0LNd6Y/FGvHtvYsSa8GPh3ZvGstgi9eDzOOa1RUwSmylIqxXtD
         P7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWqRt1hx9afwx1pA4ot31NcExm8qubHQTBZSMfxxSbg=;
        b=ecHc23z1iUstqRbCui74t7UciLsUTBAlv/ErjYV0FKBju9CI0bZ9VwDeWPtIK/w+C/
         mJaaU2sBYvrKigVgEMhvGbe1M8nOm5DG5GaiEe/a/ulWXun2HT3dTUpQKvNH24aGrGg2
         LWv6xf6zNQ/B/epmSApuiQq6O+0qKr8xfVveZa/wHZo8Bf9a8K5ekcs1wHXHdwer5YsU
         LrlrCI5NOCuR0g5+nyf1XwIL4cTDQnzc3B425/bBfUuzN0GIeZ1gA9zeeKq4i69D0JyM
         l9nk+XPyQtTbDxQMhDYY0oBuQ5XpfagVDzbpm+V3bziYgM5kyyBJ20M41kj5OA+bKuP8
         qzAg==
X-Gm-Message-State: AGRZ1gL8jpY2fcKiYmZ4I5sCOWq8HzizsTS4zb6CF2jjja3sMxS1rjQf
        DQOfjxlrlYQ0MKw/2L5H0gB0OW236AEhgx268xA=
X-Google-Smtp-Source: AJdET5cLlagfTIEWhSq/UYFQGT8iVWdauWNcWAku3JG9VS5LDnbFgRYo+2yrbEZRKwG+w8UVPzAnaqagE50JoFTpLwU=
X-Received: by 2002:aca:f0f:: with SMTP id 15mr8162552oip.47.1542658357928;
 Mon, 19 Nov 2018 12:12:37 -0800 (PST)
MIME-Version: 1.0
References: <1539049990-30810-1-git-send-email-hanjie.lin@amlogic.com> <1539049990-30810-2-git-send-email-hanjie.lin@amlogic.com>
In-Reply-To: <1539049990-30810-2-git-send-email-hanjie.lin@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 19 Nov 2018 21:12:26 +0100
Message-ID: <CAFBinCCChD-phwyb3hSzAjBmy09g35ijQa_chJX5HufuVnPjaw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
To:     hanjie.lin@amlogic.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        yixun.lan@amlogic.com, robh@kernel.org, jianxin.pan@amlogic.com,
        devicetree@vger.kernel.org, khilman@baylibre.com,
        shawn.lin@rock-chips.com, pombredanne@nexb.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        qiufang.dai@amlogic.com, jian.hu@amlogic.com,
        liang.yang@amlogic.com, cyrille.pitchen@free-electrons.com,
        gustavo.pimentel@synopsys.com, carlo@caione.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com,
        yue.wang@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Hanjie, Hello Yue,

sorry for being late with my comment

On Tue, Oct 9, 2018 at 3:53 AM Hanjie Lin <hanjie.lin@amlogic.com> wrote:
>
> From: Yue Wang <yue.wang@amlogic.com>
>
> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> controller.
>
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> new file mode 100644
> index 0000000..12b18f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> @@ -0,0 +1,70 @@
> +Amlogic Meson AXG DWC PCIE SoC controller
> +
> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
> +It shares common functions with the PCIe DesignWare core driver and
> +inherits common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> +
> +Additional properties are described here:
> +
> +Required properties:
> +- compatible:
> +       should contain "amlogic,axg-pcie" to identify the core.
> +- reg:
> +       should contain the configuration address space.
> +- reg-names: Must be
> +       - "elbi"        External local bus interface registers
> +       - "cfg"         Meson specific registers
> +       - "phy"         Meson PCIE PHY registers
is this only the PCIe PHY registers or is it the registers of the PHY
which supports USB3.0 and PCIe?
buildroot_openlinux_kernel_4.9_fbdev_20180706 uses the following
registers in the pcie_A node for the "phy" registers:
0x0 0xff646000 0x0 0x2000
while the usb3_phy_v2 node uses:
phy-reg = <0xff646000>;

> +       - "config"      PCIe configuration space
> +- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Must include the following entries:
> +       - "pclk"       PCIe GEN 100M PLL clock
> +       - "port"       PCIe_x(A or B) RC clock gate
> +       - "general"    PCIe Phy clock
> +       - "mipi"       PCIe_x(A or B) 100M ref clock gate
> +- resets: phandle to the reset lines.
> +- reset-names: must contain "phy" "port" and "apb"
> +       - "phy"         Share PHY reset
> +       - "port"        Port A or B reset
> +       - "apb"         Share APB reset
> +- device_type:
> +       should be "pci". As specified in designware-pcie.txt
> +
> +
> +Example configuration:
> +
> +       pcie: pcie@f9800000 {
> +                       compatible = "amlogic,axg-pcie", "snps,dw-pcie";
> +                       reg = <0x0 0xf9800000 0x0 0x400000
> +                                       0x0 0xff646000 0x0 0x2000
> +                                       0x0 0xff644000 0x0 0x2000
> +                                       0x0 0xf9f00000 0x0 0x100000>;
> +                       reg-names = "elbi", "cfg", "phy", "config";
is the order of the reg-names correct?
buildroot_openlinux_kernel_4.9_fbdev_20180706 uses 0xff646000 for the
PHY (instead of 0xff646000) in mesong12a.dtsi and mesong12b.dtsi


Regards
Martin

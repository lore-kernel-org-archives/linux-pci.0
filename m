Return-Path: <SRS0=XYt1=NG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3F4ECDE44
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 20:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93912085B
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 20:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93912085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeJ0FHO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:07:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46324 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbeJ0FHO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Oct 2018 01:07:14 -0400
Received: by mail-oi1-f193.google.com with SMTP id k64-v6so2116324oia.13;
        Fri, 26 Oct 2018 13:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o1J+Vua8+v3VyCFKW1e5R0do6+wn43nklh3RHSZ8CoI=;
        b=LjBfjK7+LNLkHo8ACHKzrD9Krl1bzRtCBGdmA1/blttG1wg1uqUjhl0wIOmM0HX/MK
         vdNBhiyx37w91mm61c2BrbNV4zE2VXvsRb0zo4W+n58wDW0BiQTShPqelwPlgeCAs2N1
         4TrgARbJ44B5yeEZljIVQe4ZwiZcmNJjM6p56Madw8quKlSRvDvc1WI088lC30EBbvrj
         sO+Jg8BMbAPj31rlaB6MHBSD6K5ircFbXzppJ/bkz/2Tav56Vao5xatb7VM3ShiqKkvC
         aNCxZmiXB6cQSLo5ZZbjCtUfLiSdTK3XQvoCU+9J1NEtWeCMX/Ib9PsgBT7eA/cT/tFu
         56rg==
X-Gm-Message-State: AGRZ1gJYnMyWtozc94Ui6zwKLe2ykP9VEllnoRP3VjabBGMLFjJPRx5U
        IhUK9cta1pHORih7iimqsSp/U9L5/wE=
X-Google-Smtp-Source: AJdET5cKqa2jkF2dUA/+2bNDBg/AA/YzxANYprUFuJDQZNo8pb+sW7/eAamw137HiZc1FN767OKwFg==
X-Received: by 2002:aca:ce47:: with SMTP id e68-v6mr3184317oig.83.1540585726877;
        Fri, 26 Oct 2018 13:28:46 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id f5-v6sm4448491oih.51.2018.10.26.13.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 13:28:46 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id c32so2255182otb.8;
        Fri, 26 Oct 2018 13:28:45 -0700 (PDT)
X-Received: by 2002:a9d:3cd0:: with SMTP id t16mr3143200otf.158.1540585724826;
 Fri, 26 Oct 2018 13:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181025110901.5680-1-xiaowei.bao@nxp.com> <20181025110901.5680-3-xiaowei.bao@nxp.com>
 <20181025215246.GA14861@bogus> <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <CAK8P3a3Ty4bRuHiVHY6dh55b1ms8z7RpG2sALM0Dn_8Yd39-xQ@mail.gmail.com> <HE1PR04MB14972C9176E68EEDBD3AD64BF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR04MB14972C9176E68EEDBD3AD64BF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 26 Oct 2018 15:28:33 -0500
X-Gmail-Original-Message-ID: <CADRPPNRP5RORVr0O59=O-PhRRerirFkPeOmAcKq3pNumf4Mriw@mail.gmail.com>
Message-ID: <CADRPPNRP5RORVr0O59=O-PhRRerirFkPeOmAcKq3pNumf4Mriw@mail.gmail.com>
Subject: Re: [PATCH 3/6] PCI: layerscape: Add the EP mode support
To:     xiaowei.bao@nxp.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, kishon@ti.com,
        lorenzo.pieralisi@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minghuan Lian <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        cyrille.pitchen@free-electrons.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        shawn.lin@rock-chips.com, niklas.cassel@axis.com,
        linux-pci@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 26, 2018 at 2:43 AM Xiaowei Bao <xiaowei.bao@nxp.com> wrote:
>
>
>
> -----Original Message-----
> From: arndbergmann@gmail.com <arndbergmann@gmail.com> On Behalf Of Arnd Bergmann
> Sent: 2018年10月26日 15:01
> To: Xiaowei Bao <xiaowei.bao@nxp.com>
> Cc: Rob Herring <robh@kernel.org>; bhelgaas@google.com; mark.rutland@arm.com; shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com; gregkh@linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; kstewart@linuxfoundation.org; cyrille.pitchen@free-electrons.com; pombredanne@nexb.com; shawn.lin@rock-chips.com; niklas.cassel@axis.com; linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 3/6] PCI: layerscape: Add the EP mode support
>
> On 10/26/18, Xiaowei Bao <xiaowei.bao@nxp.com> wrote:
> > From: Rob Herring <robh@kernel.org>
> >> On Thu, Oct 25, 2018 at 07:08:58PM +0800, Xiaowei Bao wrote:
> >>>          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
> >>>          "fsl,ls2088a-pcie"
> >>>          "fsl,ls1088a-pcie"
> >>>          "fsl,ls1046a-pcie"
> >>>          "fsl,ls1012a-pcie
> >>> +  EP mode:
> >>> +        "fsl,ls-pcie-ep"
> >>
> > > You need SoC specific compatibles for the same reasons as the RC.
> >
> > [Xiaowei Bao] I want to contains all layerscape platform use one
> > compatible if the PCIe controller work in EP mode.
>
> Do you mean only one of the SoCs that support RC mode has EP mode?
> I think you still need a SoC specific compatible as Rob explained, in case there will be a second one in the future.
>
> If you want to ensure that you don't have to update the device driver for each new chip that comes in when the EP mode is compatible, the way this is handled is to list multiple values in the compatible property, listing the first SoC that introduced the specific version of that IP block as the most generic type, e.g.
>
>   copatible = "fsl,ls2088a-pcie-ep", "fsl,ls1012a-pcie-ep", "snps,dw-pcie-ep";
>
> For consistency, it probably is best to match each RC mode value with the corresponding EP mode string for each device that can support both (if there is more than one).
>
>       Arnd
> [Xiaowei Bao] My mean is that the ls-pcie-ep compatibles will contain all layerscape SOCs of NXP, e.g: ls1046a-pcie-ep, fsl,ls2088a-pcie-ep, ls2088a-pcie-ep and so on, other layerscape SOCs have not test except the ls1046a, I think it is compatible if the new chip or other SOCs use the DW core, OK, I will discuss this issue internally, and reply to you later.

You can define a generic compatible string for the EP mode of all
these platforms.  But like Rob and Arnd mentioned, it is good to also
define the SoC specific compatible strings just in case that we need
special treatment for certain SoCs in the future.

Regards,
Leo

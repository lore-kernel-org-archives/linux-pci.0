Return-Path: <SRS0=XYt1=NG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28941C6786E
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 07:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61C120824
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 07:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew9UJZX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61C120824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbeJZPhH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:37:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40919 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeJZPhH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Oct 2018 11:37:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id f18-v6so64195qkm.7;
        Fri, 26 Oct 2018 00:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ygtCwwNpN9rX8xntHSLNe3Y94i+g9J6A4JU6Fak5aok=;
        b=Ew9UJZX+o7hzahXLJ/Qxd829ksNmWDMrBzMXCfWaW1qOgxP2HDNsJMH9ok+FMthYBz
         AtQtOscM4B4nymGyfUVa/uhTM7C488pdrptULDJuqLh1LUXrk2zsq/7Xn1SzrNbWF5eO
         xbL5GAmV/kJOWghSVRMWwLld3E7pcjIoQ8WCXxsTYNYGFzpwZIkxJJybjAn0vvtT3kav
         BwmX3h+Pi89O5q2jTEY/bA04IC5+n8hyhn9YgCm3jurn9O908EGhfTRcpaUeK0EqwhZZ
         cKk2GPPHmddvDtE8eFotr59fZqXdSw7OuuPWFeuMKqD9jkDr0TzBtL+B3uazWvwdcyJg
         L0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ygtCwwNpN9rX8xntHSLNe3Y94i+g9J6A4JU6Fak5aok=;
        b=P3eN7XkD+oa/md4ocVFDjNMtr7kD9NQgo3gozBSuuSNMkzyZoz8gRsvSaW13VkTNzm
         F48dWLB+iwv9Mub72Qn6jnD2wxktgtQ+6sa17MaYCqLHhGvMwEUdR7Sma2FNS/M/BUo0
         Cs0AFUjZe93sY3pvCCE+ab73iQ60XOosFXylA8YdSjDtyll/OzzqY144Z8YBOmmNuK8N
         8CNGrZfhaDqpRJWhwXGTrdpeMOZO9tAE8l4uDIS77qab9rQiKt3DMVPKYQbVlB7QRfHP
         VvgP7uBWXIQS8wbLHTurz/r3mvfryeguI4F48TLV13yNuKr71xyYe7H+UvXW1H+2HjKS
         nqFA==
X-Gm-Message-State: AGRZ1gI8BmDxwYAAXnNUFAj0aZeXTMVX9RcEmK0pGBi+tkkUdwWKHD9f
        K9aOcezawTkM1blkxcLialHi5UwybEKZfBmM1s4=
X-Google-Smtp-Source: AJdET5cJM9iepXUIUSudaP/W2MSSmSgmT2lmwUjeVpNFoerI4E3MkgdT3IUA4SXKfAW6xwoXCf13ce7ckh/ast9vFK8=
X-Received: by 2002:a37:4116:: with SMTP id o22-v6mr1907286qka.107.1540537279997;
 Fri, 26 Oct 2018 00:01:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 00:01:19
 -0700 (PDT)
In-Reply-To: <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com> <20181025110901.5680-3-xiaowei.bao@nxp.com>
 <20181025215246.GA14861@bogus> <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Oct 2018 09:01:19 +0200
X-Google-Sender-Auth: 13NSssZsIICiZBH18QZjyKXH8-I
Message-ID: <CAK8P3a3Ty4bRuHiVHY6dh55b1ms8z7RpG2sALM0Dn_8Yd39-xQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] PCI: layerscape: Add the EP mode support
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "cyrille.pitchen@free-electrons.com" 
        <cyrille.pitchen@free-electrons.com>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/26/18, Xiaowei Bao <xiaowei.bao@nxp.com> wrote:
> From: Rob Herring <robh@kernel.org>
>> On Thu, Oct 25, 2018 at 07:08:58PM +0800, Xiaowei Bao wrote:
>>>          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
>>>          "fsl,ls2088a-pcie"
>>>          "fsl,ls1088a-pcie"
>>>          "fsl,ls1046a-pcie"
>>>          "fsl,ls1012a-pcie"
>>> +  EP mode:
>>> +        "fsl,ls-pcie-ep"
>>
> > You need SoC specific compatibles for the same reasons as the RC.
>
> [Xiaowei Bao] I want to contains all layerscape platform use one compatible
> if the PCIe controller work in EP mode.

Do you mean only one of the SoCs that support RC mode has EP mode?
I think you still need a SoC specific compatible as Rob explained, in case
there will be a second one in the future.

If you want to ensure that you don't have to update the device driver
for each new chip that comes in when the EP mode is compatible,
the way this is handled is to list multiple values in the compatible
property, listing the first SoC that introduced the specific version of
that IP block as the most generic type, e.g.

  copatible = "fsl,ls2088a-pcie-ep", "fsl,ls1012a-pcie-ep", "snps,dw-pcie-ep";

For consistency, it probably is best to match each RC mode value with
the corresponding EP mode string for each device that can support both
(if there is more than one).

      Arnd

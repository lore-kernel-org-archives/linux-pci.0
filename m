Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDEEC433FE
	for <linux-pci@archiver.kernel.org>; Fri, 18 Feb 2022 11:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiBRLcQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Feb 2022 06:32:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiBRLcP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 06:32:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C76E1F68CC;
        Fri, 18 Feb 2022 03:31:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2C302CE3148;
        Fri, 18 Feb 2022 11:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4984EC340E9;
        Fri, 18 Feb 2022 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645183915;
        bh=Oboki3rXVUkFSDXVQJRt2HfWkd93rIeLixy94j8Qmoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXixrVYN2sBoWe83uUCzBE435aGOgGqnk6uRBRSaZRNzXvB3QnkmUz1pLOj3yaFUh
         XYJfidMl68McsFwpj+IcZ6ngl2tIgz+9VqSxQrL+aGcgqvRANrucgKynTeW7ScMIjk
         tNQyaQw8bO80fSnYMtfxelnUBZ9Rb7ofXx8blhAnpmS4KbkR9btHpkaJtz5YDLmDiL
         O6ofY76aQqF4GTVj8sFrpBe8fOSCyi9AMPDBfGQWyJdpi1zu+5D18uB2HJSsj26SSd
         15TRaWW2JP3M+qHQECodt5atrB6nIQQd1w8kp9QZfwsyPV4ZbILVtng0w7CdKc0afc
         0Wgj3Wn2o8kKg==
Received: by pali.im (Postfix)
        id D945C2BAE; Fri, 18 Feb 2022 12:31:52 +0100 (CET)
Date:   Fri, 18 Feb 2022 12:31:52 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add
 'slot-power-limit-milliwatt' PCIe port property
Message-ID: <20220218113152.ttoebrmhlwdvzqxe@pali>
References: <20211031150706.27873-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211031150706.27873-1-kabel@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 31 October 2021 16:07:05 Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> This property specifies slot power limit in mW unit. It is a form-factor
> and board specific value and must be initialized by hardware.
> 
> Some PCIe controllers delegate this work to software to allow hardware
> flexibility and therefore this property basically specifies what should
> host bridge program into PCIe Slot Capabilities registers.
> 
> The property needs to be specified in mW unit instead of the special format
> defined by Slot Capabilities (which encodes scaling factor or different
> unit). Host drivers should convert the value from mW to needed format.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..7296d599c5ac 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -32,6 +32,12 @@ driver implementation may support the following properties:
>     root port to downstream device and host bridge drivers can do programming
>     which depends on CLKREQ signal existence. For example, programming root port
>     not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> +- slot-power-limit-miliwatt:

                      ^^^^^^^^
                typo: milliwatt

> +   If present, this property specifies slot power limit in milliwatts. Host
> +   drivers can parse this property and use it for programming Root Port or host
> +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit messages
> +   through the Root Port or host bridge when transitioning PCIe link from a
> +   non-DL_Up Status to a DL_Up Status.
>  
>  PCI-PCI Bridge properties
>  -------------------------
> -- 
> 2.32.0
> 

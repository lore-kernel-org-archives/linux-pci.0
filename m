Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:46891 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbeDIPdG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 11:33:06 -0400
Received: by mail-lf0-f43.google.com with SMTP id j68-v6so7196762lfg.13
        for <linux-pci@vger.kernel.org>; Mon, 09 Apr 2018 08:33:05 -0700 (PDT)
Subject: Re: [PATCH 2/4] pcie-rcar: remove PHYRDY polling from
 rcar_pcie_hw_init_h1()
To: Simon Horman <horms@verge.net.au>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
 <5322b1c2-109d-bd0c-7785-697ca6a5324a@cogentembedded.com>
 <20180409105622.cl2joe6yoaozlvpz@verge.net.au>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <ee266a0c-94a1-8f02-64d7-4ee77dde096d@cogentembedded.com>
Date: Mon, 9 Apr 2018 18:33:02 +0300
MIME-Version: 1.0
In-Reply-To: <20180409105622.cl2joe6yoaozlvpz@verge.net.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/09/2018 01:56 PM, Simon Horman wrote:

>> Now that we've added PCIEPHYSR.PHYRDY polling to rcar_pcie_hw_init(),
>> there is no need anymore  for polling the PHY specific register in
>> rcar_pcie_hw_init_h1() -- remove it.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> This looks good, but has it been tested?

   Unfortunately, no. Yet it fully matches the R-Car H1 manual v1.00.

MBR, Sergei

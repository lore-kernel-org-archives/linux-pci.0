Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:37518 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeECTv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 15:51:57 -0400
Received: by mail-lf0-f54.google.com with SMTP id b23-v6so27721932lfg.4
        for <linux-pci@vger.kernel.org>; Thu, 03 May 2018 12:51:56 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] DT: pci: rcar-pci: document R8A77980 bindings
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
References: <b98130a7-b128-9fc3-aee1-1a5a2590b320@cogentembedded.com>
 <eb928983-475a-c238-5a44-505c07472b93@cogentembedded.com>
Message-ID: <db2a0324-d4c9-93d5-c027-1fa52cf96588@cogentembedded.com>
Date: Thu, 3 May 2018 22:51:54 +0300
MIME-Version: 1.0
In-Reply-To: <eb928983-475a-c238-5a44-505c07472b93@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/03/2018 10:44 PM, Sergei Shtylyov wrote:
> Document the R-Car V3H (R8A77980) SoC in the R-Car PCIe bindings.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

   Oops, forgot to add Simon's and Rob's tags:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>

MBR, Sergei

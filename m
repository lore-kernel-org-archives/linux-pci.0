Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:51558 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbcKGNir (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2016 08:38:47 -0500
Date: Mon, 7 Nov 2016 14:38:40 +0100
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH/RFC] PCI: rcar: Restrict pci_fixup_irqs to the same PCI
 domain
Message-ID: <20161107133840.GE29721@verge.net.au>
References: <1478520048-25430-1-git-send-email-horms+renesas@verge.net.au>
 <HK2PR0601MB1393486793C40576FB24106CF5A70@HK2PR0601MB1393.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <HK2PR0601MB1393486793C40576FB24106CF5A70@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 07, 2016 at 01:32:28PM +0000, Phil Edworthy wrote:
> Hi Simon,
> 
> On 07 November 2016 12:01, Simon Horman wrote:
> > From: Phil Edworthy <phil.edworthy@renesas.com>
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > 
> > Phil, this is from the 3.3.2 BSP.
> > Is it appropriate for mainline?
> No, this is not for upstream. The pci_fixup_irqs_local function was an RFC
> that should be solved in a more generic way.
> See https://patchwork.kernel.org/patch/9220653

Thanks, got it.

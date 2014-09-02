Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52315 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaIBGcW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Sep 2014 02:32:22 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so13901599pad.35
        for <linux-pci@vger.kernel.org>; Mon, 01 Sep 2014 23:32:21 -0700 (PDT)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <20140902040346.18691.58345.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20140902040346.18691.58345.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Mon, 1 Sep 2014 23:32:20 -0700
Message-ID: <CAA93t1qQaH=CYP_6MmN8Wr7gyzTcBSkUZ2r_PEoyHB6qxzUS5Q@mail.gmail.com>
Subject: Re: [PATCH] lspci: Correct Root Capabilities "CRS Software
 Visibility" bit
From: Rajat Jain <rajatxjain@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Martin Mares <mj@ucw.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks, this will help.

Best Regards,

Rajat

On Mon, Sep 1, 2014 at 9:03 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> lspci incorrectly tests bit 4, not bit 0, for "CRS Software Visibility" in
> the Root Capabilities register, so it shows "RootCap: CRSVisible-" even for
> devices that do support Software Visibility.
>
> Use the correct definition for PCI_EXP_RTCAP_CRSVIS.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  lib/header.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/header.h b/lib/header.h
> index db85df1..8ee7565 100644
> --- a/lib/header.h
> +++ b/lib/header.h
> @@ -842,7 +842,7 @@
>  #define  PCI_EXP_RTCTL_PMEIE   0x0008  /* PME Interrupt Enable */
>  #define  PCI_EXP_RTCTL_CRSVIS  0x0010  /* Configuration Request Retry Status Visible to SW */
>  #define PCI_EXP_RTCAP          0x1e    /* Root Capabilities */
> -#define  PCI_EXP_RTCAP_CRSVIS  0x0010  /* Configuration Request Retry Status Visible to SW */
> +#define  PCI_EXP_RTCAP_CRSVIS  0x0001  /* Configuration Request Retry Status Visible to SW */
>  #define PCI_EXP_RTSTA          0x20    /* Root Status */
>  #define  PCI_EXP_RTSTA_PME_REQID   0x0000ffff /* PME Requester ID */
>  #define  PCI_EXP_RTSTA_PME_STATUS  0x00010000 /* PME Status */
>

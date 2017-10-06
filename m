Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbdJFSRo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Oct 2017 14:17:44 -0400
Date: Fri, 6 Oct 2017 13:17:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: John W Walthour <jwalthour@us.ibm.com>
Cc: linux-pci@vger.kernel.org, mj@ucw.cz
Subject: Re: [PATCH] pciutils: change vpd keyword MN to text
Message-ID: <20171006181742.GE25517@bhelgaas-glaptop.roam.corp.google.com>
References: <OF11986481.9DE311D9-ON002581B1.005E606E-862581B1.005FAD2B@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF11986481.9DE311D9-ON002581B1.005E606E-862581B1.005FAD2B@notes.na.collabserv.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 06, 2017 at 12:25:03PM -0500, John W Walthour wrote:
> The PCI spec defines all keyword data fields as ASCII unless otherwise 
> noted.
> The MN keyword is not otherwise noted. To make this field human readable 
> in
> lspci verbose outputs, this patch changes the MN keyword definition from
> F_BINARY to F_TEXT.

I don't apply these (Martin, who's already cc'd) would do that, but
can you please reformat the changelog so it doesn't have the unusual
line breaks that make it hard to read?  I use a maximum text width of
75, which means it fits in 80 columns even when "git log" indents it
by 4 spaces.

> Signed-off-by: John Walthour <return.0@me.com>
> ---
>  ls-vpd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ls-vpd.c b/ls-vpd.c
> index 35c2bfa..b79abfc 100644
> --- a/ls-vpd.c
> +++ b/ls-vpd.c
> @@ -33,7 +33,7 @@ static const struct vpd_item {
>  } vpd_items[] = {
>    { 'C','P', F_BINARY, "Extended capability" },
>    { 'E','C', F_TEXT,   "Engineering changes" },
> -  { 'M','N', F_BINARY, "Manufacture ID" },
> +  { 'M','N', F_TEXT,   "Manufacture ID" },
>    { 'P','N', F_TEXT,   "Part number" },
>    { 'R','V', F_RESVD,  "Reserved" },
>    { 'R','W', F_RDWR,   "Read-write area" },
> --
> 2.11.0 (Apple Git-81)
> 
> 

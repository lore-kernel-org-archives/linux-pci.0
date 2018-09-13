Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44138 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbeIMVPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Sep 2018 17:15:12 -0400
To: Wesley.Sheng@microchip.com, kurt.schwemmer@microsemi.com,
        Kurt.Schwemmer@microchip.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <DM2PR11MB0105E2CA7030B336AC140B26951A0@DM2PR11MB0105.namprd11.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8ad178e5-5444-681a-1eae-5f9aa0c66bfa@deltatee.com>
Date: Thu, 13 Sep 2018 10:05:01 -0600
MIME-Version: 1.0
In-Reply-To: <DM2PR11MB0105E2CA7030B336AC140B26951A0@DM2PR11MB0105.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH] switchtec: add customer events and comments PAX specific
 GFMS event
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/09/18 01:34 AM, Wesley.Sheng@microchip.com wrote:
> From: Wesley Sheng <_Wesley.Sheng@microchip.com_
> <mailto:Wesley.Sheng@microchip.com>>

Similar to your previous patches, these are mangled by your email
client. It also would have also been better to send a small patch series
instead of these three individual patches.

  
> reserved for customers to implement up to 6 vendor-specific events, 24
> bytes per event
> comments on PAX specific GFMS event

Why do we need to merge this? You didn't present any code using these
new fields so this seems useless.

> Signed-off-by: Wesley Sheng <Wesley.Sheng@microchip.com>
> ---
> include/linux/switchtec.h | 19 ++++++++++++++++---
> 1 file changed, 16 insertions(+), 3 deletions(-)
>  
> diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
> index ec93e93..e3cb8b8 100644
> --- a/include/linux/switchtec.h
> +++ b/include/linux/switchtec.h
> @@ -59,6 +59,12 @@ enum mrpc_status {
>          SWITCHTEC_MRPC_STATUS_INTERRUPTED = 0x100,
> };
>  
> +struct event {
> +       u32 hdr;
> +       u32 data[5];
> +};

This doesn't follow the way the other events are doing things, and you
didn't convert all the other events, so it just looks inconsistent.


Logan

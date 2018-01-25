Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38768 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeAYKsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jan 2018 05:48:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id 141so13967253wme.3
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2018 02:48:40 -0800 (PST)
Subject: Re: [PATCH v2 1/2] pci: Add vendor id of Ubiquiti Networks
To: Tobias Schramm <tobleminer@gmail.com>, kvalo@qca.qualcomm.com,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20180125074131.30622-1-tobleminer@gmail.com>
 <20180125074131.30622-2-tobleminer@gmail.com>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5A69B605.60503@broadcom.com>
Date: Thu, 25 Jan 2018 11:48:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180125074131.30622-2-tobleminer@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/25/2018 8:41 AM, Tobias Schramm wrote:
> Signed-off-by: Tobias Schramm <tobleminer@gmail.com>
> ---
>   include/linux/pci_ids.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index ab20dc5db423..6b01ac1e9bce 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -149,6 +149,8 @@
>   #define PCI_VENDOR_ID_DYNALINK		0x0675
>   #define PCI_DEVICE_ID_DYNALINK_IS64PH	0x1702
>
> +#define PCI_VENDOR_ID_UBNT		0x0777

Guess this is the stock symbol, but that does not seem a common approach 
here. Why not just PCI_VENDOR_ID_UBIQUITI?

Regards,
Arend

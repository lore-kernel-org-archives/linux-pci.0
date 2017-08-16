Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:45907 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdHPOWg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2017 10:22:36 -0400
Subject: Re: [PATCH] tools/pci: Add a missing option help line
To: Stan Drozd <drozdziak1@gmail.com>, <linux-pci@vger.kernel.org>
References: <20170816101702.GA22874@gmail.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5fb4580a-ef27-1732-769d-9c34745d9e09@ti.com>
Date: Wed, 16 Aug 2017 19:52:33 +0530
MIME-Version: 1.0
In-Reply-To: <20170816101702.GA22874@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 16 August 2017 03:47 PM, Stan Drozd wrote:
> Signed-off-by: Stan Drozd <drozdziak1@gmail.com>

Thank you for the patch. I'll let you know once I queue it.

Thanks
Kishon

> ---
>  tools/pci/pcitest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index ad54a58d7dda..eece9d1124b6 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -173,6 +173,7 @@ int main(int argc, char **argv)
>  			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
>  			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
>  			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
> +			"\t-l 			Legacy irq test\n"
>  			"\t-r			Read buffer test\n"
>  			"\t-w			Write buffer test\n"
>  			"\t-c			Copy buffer test\n"
> 

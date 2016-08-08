Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34820 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbcHHHUf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2016 03:20:35 -0400
MIME-Version: 1.0
In-Reply-To: <2854e6672ea67bdbbf0edb3a6418ea4c013fb91c.1470213106.git.lukas@wunner.de>
References: <20160726164038.1481-1-andreas.noever@gmail.com> <2854e6672ea67bdbbf0edb3a6418ea4c013fb91c.1470213106.git.lukas@wunner.de>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Mon, 8 Aug 2016 09:20:13 +0200
Message-ID: <CAMxnaaV24NZkBCPT3c2oprMrTd+U4XoWx6qRw-w_PMaZoceUtw@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Don't declare Falcon Ridge unsupported
To: Lukas Wunner <lukas@wunner.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Xavier Gnata <xavier.gnata@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 3, 2016 at 10:44 AM, Lukas Wunner <lukas@wunner.de> wrote:
> Falcon Ridge 4C has been supported by the driver from the beginning,
> Falcon Ridge 2C support was just added. Don't irritate users with a
> warning declaring the opposite.
>
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Andreas Noever <andreas.noever@gmail.com>

> ---
>  drivers/thunderbolt/switch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 1e116f5..9840fde 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -372,7 +372,9 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, u64 route)
>
>         if (sw->config.device_id != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
>             sw->config.device_id != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
> -           sw->config.device_id != PCI_DEVICE_ID_INTEL_PORT_RIDGE)
> +           sw->config.device_id != PCI_DEVICE_ID_INTEL_PORT_RIDGE &&
> +           sw->config.device_id != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE &&
> +           sw->config.device_id != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE)
>                 tb_sw_warn(sw, "unsupported switch device id %#x\n",
>                            sw->config.device_id);
>
> --
> 2.8.1
>

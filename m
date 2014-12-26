Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:51716 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbaLZVBF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Dec 2014 16:01:05 -0500
MIME-Version: 1.0
In-Reply-To: <1419237127-21763-3-git-send-email-xobs@kosagi.com>
References: <1419237127-21763-1-git-send-email-xobs@kosagi.com> <1419237127-21763-3-git-send-email-xobs@kosagi.com>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 26 Dec 2014 15:00:42 -0600
Message-ID: <CAL_Jsq+xAsCHJNmYq-FnB2Noi25vuH8qQQN7PZH0gesh62yXXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] devicetree: bindings: Add vendor prefix for Kosagi
To: Sean Cross <xobs@kosagi.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Grant Likely <grant.likely@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	bunnie@kosagi.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 22, 2014 at 2:32 AM, Sean Cross <xobs@kosagi.com> wrote:
> Add a vendor prefix for Sutajio Ko-Usagi PTE Ltd., which goes by the
> more common name of Kosagi.
>
> Signed-off-by: Sean Cross <xobs@kosagi.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index a344ec2..491c61b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -81,6 +81,7 @@ isee  ISEE 2007 S.L.
>  isl    Intersil
>  karo   Ka-Ro electronics GmbH
>  keymile        Keymile GmbH
> +kosagi Sutajio Ko-Usagi PTE Ltd.
>  lacie  LaCie
>  lantiq Lantiq Semiconductor
>  lenovo Lenovo Group Ltd.
> --
> 2.1.3
>

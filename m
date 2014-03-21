Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:43599 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755982AbaCUO3o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 10:29:44 -0400
Received: by mail-la0-f53.google.com with SMTP id b8so1735981lan.12
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2014 07:29:43 -0700 (PDT)
Message-ID: <532C5ADE.4030708@cogentembedded.com>
Date: Fri, 21 Mar 2014 18:29:34 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>,
	linux-pci@vger.kernel.org
CC: linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com> <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 03/21/2014 01:32 PM, Phil Edworthy wrote:

> This patch adds the device tree nodes for R8A7790

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>   arch/arm/boot/dts/r8a7790.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index df9ec61..e7d498a 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -821,4 +821,23 @@
>   		#size-cells = <0>;
>   		status = "disabled";
>   	};
> +
> +	pcie: pcie@fe000000 {
> +		compatible = "renesas,r8a7790-pcie";

    The convention adopted on this list is to put the "pcie" first, and SoC 
name the last.

> +		reg = <0 0xfe000000 0 0x80000>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";

    This legacy property is only meaningful for the true OF firmware and thus 
have been phased out (it's only actively used for the memory nodes).

WBR, Sergei


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:63145 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbbBKDfL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Feb 2015 22:35:11 -0500
Received: by mail-ob0-f182.google.com with SMTP id nt9so911810obb.13
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2015 19:35:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1423585882-5464-1-git-send-email-matwey@sai.msu.ru>
References: <1423585882-5464-1-git-send-email-matwey@sai.msu.ru>
Date: Wed, 11 Feb 2015 11:35:10 +0800
Message-ID: <CAKohpoknDBJpDAfAGCGb2V_Uq6j3vL=CYOWLzsEn7p35Bi6oEg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] pci: spear: Use platform_driver_probe instead of platform_driver_register
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Mohit KUMAR <mohit.kumar@st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11 February 2015 at 00:31, Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
> Use platform_driver_probe instead of platform_driver_register
> because the former allows us to use probe function placed into __init section
> and the driver itself is not support hotplugging (yet?).
>
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
> Changes from v1:
>  - Use platform_driver_probe instead of platform_driver_register to make linker happy.
>
>  drivers/pci/host/pcie-spear13xx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 866465f..51e1344 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -371,7 +371,6 @@ static const struct of_device_id spear13xx_pcie_of_match[] = {
>  MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
>
>  static struct platform_driver spear13xx_pcie_driver __initdata = {
> -       .probe          = spear13xx_pcie_probe,
>         .driver = {
>                 .name   = "spear-pcie",
>                 .of_match_table = of_match_ptr(spear13xx_pcie_of_match),
> @@ -382,7 +381,7 @@ static struct platform_driver spear13xx_pcie_driver __initdata = {
>
>  static int __init spear13xx_pcie_init(void)
>  {
> -       return platform_driver_register(&spear13xx_pcie_driver);
> +       return platform_driver_probe(&spear13xx_pcie_driver, spear13xx_pcie_probe);
>  }
>  module_init(spear13xx_pcie_init);

The problem here is that the driver is never registered. And we might never
see it in sysfs. Probably a better solution would be to just remove all __init
parts from this driver. Let it take space even after it is used. And don't care
about it.

Sorry was busy in a conference and couldn't reply to your earlier mail on this.

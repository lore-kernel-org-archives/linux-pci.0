Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:36305 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbaGNFBy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jul 2014 01:01:54 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so3640311oag.21
        for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2014 22:01:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140710213937.GB15190@google.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
	<9430e4b284928e4919297de5602e803d03f82d7b.1404976058.git.viresh.kumar@linaro.org>
	<20140710213937.GB15190@google.com>
Date: Mon, 14 Jul 2014 10:31:53 +0530
Message-ID: <CAKohpokzzaTRJfyU2viB3cr6SJqeMSNEffXrN2VLY_n+umt9TQ@mail.gmail.com>
Subject: Re: [PATCH V9 1/7] pcie: Add designware wrapper driver for SPEAr13xx
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@linaro.org>, "olof@lixom.net" <olof@lixom.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	spear-devel <spear-devel@list.st.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Mark Nicholson <mark@nicholnet.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11 July 2014 03:09, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I guess I'm obsessive, but I think it's nice when people run
> "git log --oneline" on the file or directory they're changing,
> and then follow the existing style.
>
> In this case, that would lead to a subject line like:
>
>     PCI: spear: Add PCIe driver for ST Microelectronics SPEAr13xx
>

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 702ca10..443dd05 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6820,6 +6820,12 @@ S:     Maintained
>>  F:   Documentation/devicetree/bindings/pci/host-generic-pci.txt
>>  F:   drivers/pci/host/pci-host-generic.c
>>
>> +PCIE DRIVER FOR ST SPEAR13XX
>> +M:   Mohit Kumar <mohit.kumar@st.com>
>> +L:   linux-pci@vger.kernel.org
>> +S:   Maintained
>> +F:   drivers/pci/host/pcie-spear13xx.c
>
> Wildcards work here, so you could follow the lead of IMX6, MVEBU, RCAR,
> and DESIGNWARE and use:
>
>     F:  drivers/pci/host/*spear*
>
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-spear13xx.c
>> ...
>> +#define PCI_CAP_ID_EXP_OFFSET                        0x70
>
> A nit, but I'd use a name like EXP_CAP_ID_OFFSET to make it
> more clear that this is specific to SPEAr, not something from
> the PCI specs.

Hi Bjorn,

So this is how the diff looks like over this patch:

diff --git a/MAINTAINERS b/MAINTAINERS
index 443dd05..766948e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6824,7 +6824,7 @@ PCIE DRIVER FOR ST SPEAR13XX
 M:     Mohit Kumar <mohit.kumar@st.com>
 L:     linux-pci@vger.kernel.org
 S:     Maintained
-F:     drivers/pci/host/pcie-spear13xx.c
+F:     drivers/pci/host/*spear*

 PCMCIA SUBSYSTEM
 P:     Linux PCMCIA Team
diff --git a/drivers/pci/host/pcie-spear13xx.c
b/drivers/pci/host/pcie-spear13xx.c
index a6fc332..99738e4 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -139,7 +139,7 @@ struct pcie_app_reg {
 #define VEN_MSI_TC_MASK                ((u32)0x7 << VEN_MSI_TC_ID)
 #define VEN_MSI_VECTOR_MASK    ((u32)0x1F << VEN_MSI_VECTOR_ID)

-#define PCI_CAP_ID_EXP_OFFSET                  0x70
+#define EXP_CAP_ID_OFFSET                      0x70

 #define to_spear13xx_pcie(x)   container_of(x, struct spear13xx_pcie, pp)

@@ -149,7 +149,7 @@ static int spear13xx_pcie_establish_link(struct
pcie_port *pp)
        int count = 0;
        struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
        struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
-       u32 exp_cap_off = PCI_CAP_ID_EXP_OFFSET;
+       u32 exp_cap_off = EXP_CAP_ID_OFFSET;

        if (dw_pcie_link_up(pp)) {
                dev_err(pp->dev, "link already up\n");



And the subject looks like this now:
PCI: spear: Add PCIe driver for ST Microelectronics SPEAr13xx

I may skip sending a V10 for this and directly send a pull request as
there aren't any significant changes suggested in V9.

Thanks.

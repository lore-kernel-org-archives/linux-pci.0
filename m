Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170421050500.13957-9-yinghai@kernel.org>
References: <20170421050500.13957-1-yinghai@kernel.org> <20170421050500.13957-9-yinghai@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 24 Apr 2017 09:12:15 -0500
Message-ID: <CAL_JsqKecsC30EdBb-3ULUTPpROLs+mtt7ua5T315cSsbLKjoQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] OF/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 21, 2017 at 12:04 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> For device resource PREF bit setting under bridge 64-bit pref resource,
> we need to make sure only set PREF for 64bit resource.
>
> This patch set IORESOUCE_MEM_64 for 64bit resource during OF device
> resource flags parsing.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  drivers/of/address.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

Rob

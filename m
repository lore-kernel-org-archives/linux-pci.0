Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5506C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 03:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681282148D
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 03:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpglyMx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfDXDm4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:42:56 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35085 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfDXDm4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 23:42:56 -0400
Received: by mail-it1-f195.google.com with SMTP id w15so3924525itc.0;
        Tue, 23 Apr 2019 20:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1f4bN/dTOspS8HdN/r49J+WORAZUSN60oP2hQdEZsk=;
        b=jpglyMx+pc488+vcVFyRGymEX91n6hwgogEyLWz6mzihfzvF3/zJ32JeuYBVqx+Kkv
         MRKzqOa81+VcAYDrS09+VoYGCz4vRDRmFLvU1y9G7A0CLVxPmgPQ8W1fuXSBbBBGXDBA
         2ivCwdeBE9sk4AB0qaP/bWRm3cn1BmNJHLnh5gswXntUKVgi+OtOTJn1XNgDUnBpjugd
         ExPPoa+cTJDQec1aXjCtADyOxi0O2uIiw5EV1Tm4mKuB17KrzLH9EXS32f2Nd4WDhAg9
         +2mv2GRJ9q9VNTSJyR8CYXzjaZesfSmldN0mZTk/5Z8O8Dyyx+idP88yg6i8wxAtFpYr
         obyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1f4bN/dTOspS8HdN/r49J+WORAZUSN60oP2hQdEZsk=;
        b=tUK4iCv0LAnyG/iYbqYRLismNj6ge5dzSlW0zCgVmzVj4q9W2YVS5WfxuSRciyr+0U
         z2FtNdHI07Xd3lUrZCYvfJvlE2LIk+kRs9jkEL6QnJaz+RwX2z6jSVCmjNd+224RfZuI
         OqBgs9F2l9jBh4eF3eSdO9QZ1GBIEr8n9PznQ3OpG5uOsujLUSfVoNvcL00y1KjEhWg0
         oWnRWKzsIZ2Ipz4KDsVI4CUQPwfTqb1HaGps/TqXvk6Esb/2hz9/21cOZXbH63M01AE3
         1BWvZtXKYhIgh52vIqCep8PQm5rh2LIWJIEbzI1cgBJcV8vOnUhfMll6ZX12qDZhzk5q
         fudg==
X-Gm-Message-State: APjAAAU+SD3PVDI/fDuqZqUs1BrzlJNZYLaCxr4IcjyeccRPzTerEsnB
        9LBPzLBF9ULgEG7ajmh5NyZcg5cam5feDEMXw1c=
X-Google-Smtp-Source: APXvYqzwvilzkIxRUFeIfxhSSNKbefy+TUu4IoYufc15Tqd7nqw/sokxjq0RaEPlm1cB6H+Lyh/eHMtxYhCFmVOky44=
X-Received: by 2002:a24:d45:: with SMTP id 66mr5284343itx.9.1556077374803;
 Tue, 23 Apr 2019 20:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190423082730.370-1-vidyas@nvidia.com> <20190423082730.370-6-vidyas@nvidia.com>
 <20190423203244.GD14616@google.com> <22c7a99b-2d6c-e49b-43b0-219c60f7e5e9@nvidia.com>
In-Reply-To: <22c7a99b-2d6c-e49b-43b0-219c60f7e5e9@nvidia.com>
From:   Oliver <oohall@gmail.com>
Date:   Wed, 24 Apr 2019 13:42:43 +1000
Message-ID: <CAOSf1CF9oBwt+hy3Q=G2Bj0ku5iak=pnLYq4Hi7QgpBC5sBfPA@mail.gmail.com>
Subject: Re: [PATCH V4 05/16] PCI: dwc: Move config space capability search API
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, lorenzo.pieralisi@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org,
        Device Tree <devicetree@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 1:12 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> On 4/24/2019 2:02 AM, Bjorn Helgaas wrote:
> > On Tue, Apr 23, 2019 at 01:57:19PM +0530, Vidya Sagar wrote:
> >> Move PCIe config space capability search API to common DesignWare file
> >> as this can be used by both host and ep mode codes.
> >>
> >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> >> ---
> >> Changes from [v3]:
> >> * Rebased to linux-next top of the tree
> >>
> >> Changes from [v2]:
> >> * None
> >>
> >> Changes from [v1]:
> >> * Removed dw_pcie_find_next_ext_capability() API from here and made a
> >>    separate patch for that
> >>
> >>   drivers/pci/controller/dwc/pcie-designware.c | 33 ++++++++++++++++++++
> >>   drivers/pci/controller/dwc/pcie-designware.h |  2 ++
> >
> > You claim this is a "move", but I only see adds.  Where did it move
> > *from*?
> These are supposed to be moved from pcie-designware-ep.c file. That was the case
> with my old patches but when I rebased them onto ToT, I missed the change that
> removes them from pcie-designware-ep.c file. Thanks for catching this. I'll
> address it in the next patch.
>
> >
> > While you're at it, can you add a comment in the code about why we
> > can't use the regular pci_find_capability() interface?  It's really a
> > shame to have to reimplement that.
> Regular pci_find_capability() uses 'struct pci_dev *dev' pointer and can be used
> only after device enumeration is done. Whereas, these APIs are used particularly
> before link up and use 'struct dw_pcie *pci' pointer.

pci_bus_find_capability() can be used without enumerating the devices
if you have a pci_bus. It's probably not worth using here though since
you need this code anyway for endpoint mode.

>
> >
> >>   2 files changed, 35 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> >> index 8e0081ccf83b..6a98135244d6 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> >> @@ -20,6 +20,39 @@
> >>   #define PCIE_PHY_DEBUG_R1_LINK_UP  (0x1 << 4)
> >>   #define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING (0x1 << 29)
> >>
> >> +static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
> >> +                              u8 cap)
> >> +{
> >> +    u8 cap_id, next_cap_ptr;
> >> +    u16 reg;
> >> +
> >> +    reg = dw_pcie_readw_dbi(pci, cap_ptr);
> >> +    next_cap_ptr = (reg & 0xff00) >> 8;
> >> +    cap_id = (reg & 0x00ff);
> >> +
> >> +    if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
> >> +            return 0;
> >> +
> >> +    if (cap_id == cap)
> >> +            return cap_ptr;
> >> +
> >> +    return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
> >> +}
> >> +
> >> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
> >> +{
> >> +    u8 next_cap_ptr;
> >> +    u16 reg;
> >> +
> >> +    reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
> >> +    next_cap_ptr = (reg & 0x00ff);
> >> +
> >> +    if (!next_cap_ptr)
> >> +            return 0;
> >> +
> >> +    return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
> >> +}
> >> +
> >>   int dw_pcie_read(void __iomem *addr, int size, u32 *val)
> >>   {
> >>      if (!IS_ALIGNED((uintptr_t)addr, size)) {
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> >> index 9ee98ced1ef6..35160b4ce929 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.h
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> >> @@ -248,6 +248,8 @@ struct dw_pcie {
> >>   #define to_dw_pcie_from_ep(endpoint)   \
> >>              container_of((endpoint), struct dw_pcie, ep)
> >>
> >> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> >> +
> >>   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
> >>   int dw_pcie_write(void __iomem *addr, int size, u32 val);
> >>
> >> --
> >> 2.17.1
> >>
>

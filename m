Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08347368291
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000147; cv=pass; b=fwFYOpYIAgV+OXrEH2zSEy0TBFrUvh9R+l2bGkwk4Hly9jGA6Z1xgAuc7Bjxpj+ZF3T91i1K+k/ugGXkqByjzQRkjIY0T1d2aWP9L8kwPa8eCqQfUV9dE89/ImJIy29JHsVZL1t/GEWJUZ4w0IXjp3LNDrF4Pf9G40itaxWz+dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000147; c=relaxed/simple;
	bh=QLsW3OZgiOoo2/OqYWoiGLDpHxDhmxkLwSkqyStuBVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xans+VK6x6ut2L3/MVfXwqCHB4QmwX2DpFIF/ZeaOtCjosZy9WIdG1AXB5qlvaMkxxwfuA2/lSUSJdn9js4jU3JypWBLksfUZisQyc0TzBDrp9oYQWpuCccE5Uo2PWEp1YvlXGmWs4+jjvaTmL7VfrfwRJdL8SrjyTiMZ1S6kmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEweTyfZ; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEweTyfZ"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-67109935888so2839902d50.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 07:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790000144; cv=none;
        d=google.com; s=arc-20260327;
        b=kaNefQw0xYYXVE0gLFLZn4w6pNW9WbfKSMkLq5nnHU+aVNGxsagbkRxRtDMdhLa1jj
         YkDTcs9/Scmj7bHaqetL9DOpsSN2o/K2QIlvlBu9HnIYeVAjVvQGpkd5ZnmslAWmD8+f
         hVt7VyE8wK+Mm9XylVk0doLDtr9TrlaTGSQUJOuMGItWA+ouxwLkgW7BWMJ/qPcLtJ1W
         s6B5TIPGLV1bspf6sCYuyLMLVZdnKX0IGB4nMFVifkirWuqihYqZ/y0v7pmw30QEpGJ1
         5bSlWADZmCWSeQNTdfcDXx36swahKhAuBbtHAm9NYOidtbSMlonHEOic1cVpvmPe8l3R
         eq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HvT37my9dta34DYQuaVV9y1xeoKj9pu6IBKBeJIjvCE=;
        fh=BNMfHYu8wanw9MCoKuIuiB5fGfUyUYYQH1wvs2v/tY0=;
        b=kCIJrter7oduuh0hlCnVF2tFOaUmzIgbOjMLrJhx/jHhD8qu6SagPjjv+1gdR/b3AD
         jQ4RuKlEPpcprtHVrPtKb7TaW6xJOVPCVgWS9crcx6uu5WVd/rZN1EmwFxI/pv3kNFmk
         Htt6D/CE19qu3vszW+S9vIL/wsvcHhZN/Gsa3ari+thA9bEs4GW2WGGuwIq/BqIHWucL
         f0k1s5qlTWETC1ouiRGCb3myiBaasoO1jR5yLXMA82yKdqcAkX7rJulDKKYNAPLW/WgY
         TOkjgEvIBVZwSOEV4wDJsH1HpjdhIuQdiBML4pRtNm4Aj7As15Hee05Z607w83PzDoHw
         R8PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790000144; x=1790604944; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvT37my9dta34DYQuaVV9y1xeoKj9pu6IBKBeJIjvCE=;
        b=EEweTyfZQ32qQ9tfWdmJMOqOWI7AILIpu9vOY1QhgDM1z0jNsl3NaqD8BxMP76CV3X
         vazogd2n7BGMx03d4WphSIthj8PbzJAmIFTHFE4q/9WXf/9Y0rv+6iIHvL+OoKkvZuTI
         ATEZ1iaUDLohZfIlJ3IiB0X1RVYj5KYya/kNOLb7Hyz33z5HkR24bKpDwtlzHAusqxYa
         X0J/xaQiFF/iZiyVNfutjwid+lJUzPYZLpAPj5TiBr4u1rrp8wVAiwFxhAk1mKTNj8hU
         pTC/T6w+7+3QmE72IBEjgDd1i+kiwUdb2XevKQWnGuI+AA848mgtW5A44B7PXMWe1cua
         15IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000144; x=1790604944;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HvT37my9dta34DYQuaVV9y1xeoKj9pu6IBKBeJIjvCE=;
        b=1707Qftr9X9P2nVlSLWlq6yyaB/U1BdZSeyIHVC7+QdcBSGBguHETyXJA+YZrLmo/u
         8OY4UDZ0fS0P0kOjLLAW1QRuXiKu8EDQOEuB5Y8da8eT5SDVatBTl1jMlxbqkoupV/TL
         e7WG82yVVIqqxGk0puLVphqj2Qd4iGECAyUp7xqtevAu9Hqmrt1dche2ReuCds40shAD
         aTzjxCIbWfieq8NZPcHyrndPdiyF2SUDNJ6PSnVsgCmjlJRUHgZlVFTY7Bv22NbaYnOV
         z+gELWGpIyqKUEfQHkFLQqdNu2USdiMyZR1HM/pftp4C2i3IcPuxoUX4L/8UfkVi8CDm
         c3IQ==
X-Forwarded-Encrypted: i=1; AKwUvBxaAAZT4X3krL/FL7TWxBLBdUAO9DLDZE5qBGfhnQM+cFjSuxokbP50RLco/Tm5ZcvcME2aJrawnvE=@vger.kernel.org
X-Gm-Message-State: AFuF++kNtYFFXtReLX+y6PDUrr+03DBvHgV2yluJnsGAvq6f3abq0tel
	cWRRudq1ApCH6I2shi3jGakW55WwWuD/voSDk2JpFM3qcsxAJZBC9nBXv8KAZy0Ljq+GJYW1C23
	hUl8ZbZXmz7uCNAMqAOw45Pi7IRSoYAM=
X-Gm-Gg: AYBFou0N6S4zBSeA/2sknmFyywVYEGBlZz4wDJKSTABadnos5ha8YsOqsW12digv5+u
	Ig6ok25vU4YpHtGZQgBYdi1bZT/Ch4Es9sxz9gUsMfLKnZik3FNV/9VqbKcUY448JCRNXyjYlZ9
	OebGZ1UThnElYbvt5zXrv4ElrpgdovfRyH31gpwXdY9K3OGrUHYMDsP4Xnt4xfPJxufApdcEPrB
	YkG22585FXIHbEIQtPN8Y/rK5V7NM6/F0Ak5HXZ621lzXbT5HqIhdlbWYhOX/wROraMkah0mcRq
	5fzL/k6AZFWVT4m7T8RsNGDwUwYzAxMtdGZYbrwkqxv7eBlPFqaFRm/5tA==
X-Received: by 2002:a05:690e:e81:b0:66f:9564:7827 with SMTP id
 956f58d0204a3-6717fc61321mr3128893d50.22.1790000142000; Mon, 21 Sep 2026
 07:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916080030.2960608-1-lgs201920130244@gmail.com> <736ff398-98fa-43bc-9771-1b0d4c2a591c@mailbox.org>
In-Reply-To: <736ff398-98fa-43bc-9771-1b0d4c2a591c@mailbox.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 22:15:29 +0800
X-Gm-Features: AcwNN1XP7xc4w6JUo1lwgUr1iIYbKG3Cq0l_NU90yLcFM11w-KyBFtXZVHMUFrQ
Message-ID: <CANUHTR_AAKH13fRAwLY5wzMjhWuzwET=-359ZMNh0VU4tULrKg@mail.gmail.com>
Subject: Re: [PATCH] PCI: keystone: deinitialize endpoint on remove
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Yuho Choi <dbgh9129@gmail.com>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Koichiro Den <den@valinux.co.jp>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

Thanks for the review.

On Thu, 17 Sept 2026 at 06:56, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 9/16/26 10:00 AM, Guangshuo Li wrote:
> > ks_pcie_probe() initializes the DesignWare PCIe endpoint with
> > dw_pcie_ep_init(). The probe failure path calls dw_pcie_ep_deinit()
> > when endpoint register initialization fails, but the remove path does
> > not perform the corresponding endpoint teardown after a successful
> > probe.
> >
> > The successful endpoint initialization also calls pci_epc_init_notify().
> > Without the matching teardown on removal, the EPC initialization state
> > and resources allocated by the DesignWare endpoint core are left
> > active after the driver is removed.
> >
> > Notify the endpoint framework about deinitialization and call
> > dw_pcie_ep_deinit() before disabling runtime PM and the PHYs.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/pci/controller/dwc/pci-keystone.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index 602516239a57..35787e727c5c 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -1349,9 +1349,17 @@ static void ks_pcie_remove(struct platform_device *pdev)
> >   {
> >       struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> >       struct device_link **link = ks_pcie->link;
> > +     struct dw_pcie *pci = ks_pcie->pci;
> > +     const struct ks_pcie_of_data *data;
> >       int num_lanes = ks_pcie->num_lanes;
> >       struct device *dev = &pdev->dev;
> >
> > +     data = of_device_get_match_data(dev);
>
> Could you maybe cache the mode in struct keystone_pcie {} instead ?
>
> > +     if (data->mode == DW_PCIE_EP_TYPE) {
> > +             pci_epc_deinit_notify(pci->ep.epc);
> > +             dw_pcie_ep_deinit(&pci->ep);
>
> Would it make sense to make dw_pcie_ep_deinit() call
> pci_epc_deinit_notify() , to avoid duplication in controller drivers ?
>
> > +     }
> > +
> >       pm_runtime_put(dev);
> >       pm_runtime_disable(dev);
> >       ks_pcie_disable_phy(ks_pcie);
>
> --
> Best regards,
> Marek Vasut

Agreed. I'll cache the mode in struct keystone_pcie and move
pci_epc_deinit_notify() into dw_pcie_ep_deinit() so controller drivers
do not need to duplicate it. I'll send a v2 with those changes.

Thanks,
Guangshuo

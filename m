Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35854 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeDONJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Apr 2018 09:09:47 -0400
MIME-Version: 1.0
In-Reply-To: <c295bc5b-e67a-290c-3316-56a1cc001538@synopsys.com>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
 <5181f7ffbb9d2889974c49d84e72042251adf8b6.1523266508.git.gustavo.pimentel@synopsys.com>
 <003001d3d128$39f3eaa0$addbbfe0$@gmail.com> <c295bc5b-e67a-290c-3316-56a1cc001538@synopsys.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 15 Apr 2018 10:09:46 -0300
Message-ID: <CAOMZO5Acd-5ed_FivBf=GMmKLxipnossDtG4ptzq5-LzcNBhjA@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] PCI: dwc: Small computation improvement
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On Wed, Apr 11, 2018 at 4:40 AM, Gustavo Pimentel
<gustavo.pimentel@synopsys.com> wrote:

> Can be this one?
>
> Probably any recent and decent compiler does this kind of substitution
> in order to improve code performance. Nevertheless it's a coding good
> practice whenever there is a division / multiplication by multiple of 2
> to replace it by the equivalent operation in this case, the shift
> rotation.

Subject says that this patch provides a computation improvement, but
as you said above the compiler
will perform the shift, so it doesn't seem we will get any benefit.

IMHO the original code has better readability as it makes easier to
understand that pp->cfg0_size will get the half of
resource_size(pp->cfg) size.

I would say it is better to drop this patch from the series.

Thanks

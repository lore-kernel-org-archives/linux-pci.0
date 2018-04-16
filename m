Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] PCI: dwc: Small computation improvement
To: Fabio Estevam <festevam@gmail.com>
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
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
 <5181f7ffbb9d2889974c49d84e72042251adf8b6.1523266508.git.gustavo.pimentel@synopsys.com>
 <003001d3d128$39f3eaa0$addbbfe0$@gmail.com>
 <c295bc5b-e67a-290c-3316-56a1cc001538@synopsys.com>
 <CAOMZO5Acd-5ed_FivBf=GMmKLxipnossDtG4ptzq5-LzcNBhjA@mail.gmail.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <b8f10ee2-b580-9d49-247f-6c65804816c4@synopsys.com>
Date: Mon, 16 Apr 2018 09:35:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAOMZO5Acd-5ed_FivBf=GMmKLxipnossDtG4ptzq5-LzcNBhjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio,

On 15/04/2018 14:09, Fabio Estevam wrote:
> Hi Gustavo,
> 
> On Wed, Apr 11, 2018 at 4:40 AM, Gustavo Pimentel
> <gustavo.pimentel@synopsys.com> wrote:
> 
>> Can be this one?
>>
>> Probably any recent and decent compiler does this kind of substitution
>> in order to improve code performance. Nevertheless it's a coding good
>> practice whenever there is a division / multiplication by multiple of 2
>> to replace it by the equivalent operation in this case, the shift
>> rotation.
> 
> Subject says that this patch provides a computation improvement, but
> as you said above the compiler
> will perform the shift, so it doesn't seem we will get any benefit.

In the worth case there is no performance, so it will not hurt having it.
However depending the compiler and the platform this can bring some improvement.
For instance like Jingoo said: "The most platforms using 'dwc' are based on ARM
CPUs. So, the shift rotation can be better."

It's just a attempt to improve the code that doesn't bring any harm.

> 
> IMHO the original code has better readability as it makes easier to
> understand that pp->cfg0_size will get the half of
> resource_size(pp->cfg) size.

Personally I prefer the shift rotation rather the division by 2. But in my case
I'm used to use/see this type of operation, but it's like I said it's my
personal opinion.

> 
> I would say it is better to drop this patch from the series.

Let's see this patch inflicts pain on someone else, in that case I'll remove
from the series.

> 
> Thanks
> 

Regards,
Gustavo

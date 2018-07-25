Return-Path: <SRS0=uC+D=KJ=embeddedor.com=gustavo@kernel.org>
Return-Path: <SRS0=uC+D=KJ=embeddedor.com=gustavo@kernel.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Linux
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Honghui Zhang <honghui.zhang@mediatek.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
References: <5b5555e19b5af_5e922b08291e2f60744cb@node1.mail>
 <CAErSpo7wy1CZvozUX+vnj0W_-m85M=TBUYp3N=W1wB57=_8kXw@mail.gmail.com>
 <20180723205403.GA167818@bhelgaas-glaptop.roam.corp.google.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <0fee62a1-adbe-477d-ed58-35b582573c08@embeddedor.com>
Date: Wed, 25 Jul 2018 09:21:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180723205403.GA167818@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>



On 07/23/2018 03:54 PM, Bjorn Helgaas wrote:
> [+cc Gustavo]
> 
> On Mon, Jul 23, 2018 at 02:12:49PM -0500, Bjorn Helgaas wrote:
>> Hi Honghui,
>>
>> Would you consider doing a minor patch to fix the issue Coverity
>> reported below (not checking the return value from
>> devm_pci_remap_iospace())?
> 
> Never mind, I see Gustavo has already posted such a patch:
> 
> https://lkml.kernel.org/r/20180720150158.GA10922@embeddedor.com
> 
> Thanks, Gustavo!
> 

Glad to help. :)

Thanks
--
Gustavo

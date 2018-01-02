Return-Path: <SRS0=7UQv=D5=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=7UQv=D5=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v2 0/4] Address error and recovery for AER and DPC
To: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Timur Tabi <timur@codeaurora.org>
References: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
 <20180102190215.GC6211@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <3b819352-3efc-002c-897b-2d8536c92d94@codeaurora.org>
Date: Tue, 2 Jan 2018 14:09:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180102190215.GC6211@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 1/2/2018 2:02 PM, Bjorn Helgaas wrote:
> I read that as suggesting that we should enable DPC support in Linux
> if and only if we also enable AER.  But I don't see anything in DPC
> that looks like that.  Should there be something there?  Should DPC be
> restructured so it's enabled and handled inside the AER driver instead
> of being a separate driver?

I think Keith posted a patch to do this. If firmware first is enabled, DPC
init is skipped after his patch.

Oza was able to plumb the DPC handling into error recovery callbacks of
the portdrv since the portdrv layer already provides this facilities such
as reset_link and resume.

The way DPC and AER works is almost identical from AER portdrv perspective.

I really like his plumbing. Putting DPC code into AER makes it more
convoluted in my opinion.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

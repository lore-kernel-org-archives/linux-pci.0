Return-Path: <SRS0=d13r=BL=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=d13r=BL=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH 1/5] PCI: protect restore with device lock to be
 consistent
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
 <20171011220819.GW25517@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8696d4cf-144d-dbc0-1950-93d42529971a@codeaurora.org>
Date: Thu, 12 Oct 2017 12:39:50 -0400
MIME-Version: 1.0
In-Reply-To: <20171011220819.GW25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 10/11/2017 6:08 PM, Bjorn Helgaas wrote:
> I think this series makes a lot of sense overall; thanks for doing
> this work!  I had a few comments on the individual patches.
> 
> (This response would ordinarily be to the cover letter, but there
> isn't one, so I'm just responding to the first patch.)

Thanks, I was too lazy to type it up. I'll do it on the next one.
Since this was an RFC even though the subject doesn't say so, I didn't
want to invest too much time on documentation.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

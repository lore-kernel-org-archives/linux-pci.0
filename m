Return-Path: <SRS0=H88W=7E=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=H88W=7E=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V7 1/3] PCI: limit FLR wait time to 100ms maximum
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org
References: <1501701317-32249-1-git-send-email-okaya@codeaurora.org>
 <20170802202735.GE20308@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <51e4468b-1c58-b95a-f5a0-07dec5825483@codeaurora.org>
Date: Wed, 2 Aug 2017 16:32:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170802202735.GE20308@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/2/2017 4:27 PM, Bjorn Helgaas wrote:
> I haven't worked through all the details of what 6.6.2 says, but I
> think it uses 100ms in the context of the *minimum* time software must
> wait between initiating an FLR and initializing the function

Here is what spec says in 6.6.2

"After an FLR has been initiated by writing a 1b to the Initiate Function Level Reset bit,
the Function must complete the FLR within 100 ms."

I interpret this as maximum.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

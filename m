Return-Path: <SRS0=TCfM=6R=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=TCfM=6R=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V4] PCI: handle CRS returned by device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, vikrams@codeaurora.org,
 Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
References: <1499375234-23928-1-git-send-email-okaya@codeaurora.org>
 <20170713121758.GL4486@bhelgaas-glaptop.roam.corp.google.com>
 <0bcc0b00-1ad3-6866-32ab-15da8ea1821e@codeaurora.org>
 <20170713233859.GA5944@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <46d89272-e962-d26a-6816-4f7a4615773c@codeaurora.org>
Date: Fri, 14 Jul 2017 10:10:08 -0400
MIME-Version: 1.0
In-Reply-To: <20170713233859.GA5944@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 7/13/2017 7:38 PM, Bjorn Helgaas wrote:
>> This does not specify a hard limit above on how long SW need to wait. 
> I wouldn't expect a *maximum* time we can wait.  I'm looking for the
> minimum times the spec requires.

My understanding is FLR needs to finish in 100ms max under normal circumstances.
If an endpoint needs more, it needs to issue CRS.

	"After an FLR has been initiated by writing a 1b to the Initiate Function Level Reset bit, 
	the Function must complete the FLR within 100 ms. 

	...

	it is recommended that software allow as much time as provided by the pre-FLR value for Completion 
	Timeout on the device. If Completion Timeouts were disabled on the Function when FLR was issued, 
	then the delay is system dependent but must be no less than 100 ms."

The only minimum I found is in the last paragraph where somebody actually disables
completion timeout. I don't know why anyone would do that.

> 
> If you're claiming "the spec is calling to wait up to 1 second", I
> just want to know where in the spec it says that.  That helps in the
> future when we need to maintain code like this.
> 

Keith and I discussed this here. 

https://www.spinics.net/lists/arm-kernel/msg593493.html

We have a spec language problem. My interpretation of this is 1 seconds
max for CRS.

	"When used, DRS and FRS allow an improved behavior over the CRS mechanism, 
	and eliminate its associated periodic polling time of up to 1 second
	following a reset."

The ECN is referring to conventional reset as 1 second max rather than CRS.
	https://www.spinics.net/lists/arm-kernel/msg593500.html

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

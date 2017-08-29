Return-Path: <SRS0=iCH/=77=sieb.net=samuel@kernel.org>
Return-Path: <SRS0=iCH/=77=sieb.net=samuel@kernel.org>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
To: Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170713025608.GC4486@bhelgaas-glaptop.roam.corp.google.com>
From: Samuel Sieb <samuel@sieb.net>
Message-ID: <b1570450-1c83-1f76-ab1e-c94bd34f9b84@sieb.net>
Date: Tue, 29 Aug 2017 13:02:41 -0700
MIME-Version: 1.0
In-Reply-To: <20170713025608.GC4486@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 07/12/2017 07:56 PM, Bjorn Helgaas wrote:
> On Fri, Apr 07, 2017 at 04:32:18PM +0200, Joerg Roedel wrote:
>> From: Joerg Roedel <jroedel@suse.de>
>>
>> ATS is broken on this hardware and causes IOMMU stalls and
>> system failure. Disable ATS on these devices to make them
>> usable again with IOMMU enabled.
>>
>> Note that the commit in the Fixes-tag is not buggy, it
>> just uncovers the problem in the hardware by increasing
>> the ATS-flush rate.
>>
>> Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> Applied with Alex's ack to pci/virtualization for v4.14, thanks!

Is there any chance of getting this into an earlier kernel?  This is a 
pretty devastating bug for users!  I'm currently providing patched 
kernels, but if they run upgrades and get a new kernel without noticing 
it, any filesystem they access will get completely mangled.

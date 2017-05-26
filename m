Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        'Joerg Roedel' <jroedel@suse.de>
Cc: 'David Woodhouse' <dwmw2@infradead.org>,
        'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <BN6PR12MB1652634583ADBB2C93E1414DF70C0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <1493893297.4904.71.camel@infradead.org>
 <BN6PR12MB1652A0F240C19F2CF3304300F7F90@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170524084450.GB12353@suse.de>
 <BN6PR12MB1652DBB703ED7B98F5C17FC5F7FE0@BN6PR12MB1652.namprd12.prod.outlook.com>
From: Samuel Sieb <samuel@sieb.net>
Message-ID: <12fe83a5-23ec-3a29-5ed6-ff02175f818a@sieb.net>
Date: Thu, 25 May 2017 23:48:14 -0700
MIME-Version: 1.0
In-Reply-To: <BN6PR12MB1652DBB703ED7B98F5C17FC5F7FE0@BN6PR12MB1652.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/24/2017 05:56 AM, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: Joerg Roedel [mailto:jroedel@suse.de]
>> Sent: Wednesday, May 24, 2017 4:45 AM
>> To: Deucher, Alexander
>> Cc: 'David Woodhouse'; 'Joerg Roedel'; Bjorn Helgaas; linux-
>> pci@vger.kernel.org; linux-kernel@vger.kernel.org; Daniel Drake; Samuel
>> Sieb
>> Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
>>
>> Hi Alexander,
>>
>> On Tue, May 23, 2017 at 07:54:12PM +0000, Deucher, Alexander wrote:
>>> I finally got an answer from the hw team and we validated ATS on
>>> stoney as well so in theory this patch shouldn’t actually be needed.
>>> I think we may actually be papering over some other issue.  The
>>> following patch seems to also fix this issue (and other issues):
>>> https://www.spinics.net/lists/stable/msg172631.html
>>
>> Yeah, but it still looks to me like that the hardware got into some
>> weird state with the storm of ATS invalidations sent to it.
>>
>> The Completion-Wait loop timeouts seen in the original bug report
>> indicate that the IOMMU is waiting for a response that never comes. And
>> this is probably the ATS flush completion response from the GPU, as
>> disabling ATS on the GPU makes the issue disappear.
> 
> Yeah, it's weird.  My ack on the patch still stands.  Just adding some additional data.
> 

I just tested this patch without the previous ATS disabling patch (I 
verified that ATS was enabled).  Doing a stress-test kernel build while 
running a 3D graphical application caused no disk corruption.  That was 
running for several hours.  If it's not the solution, it sure hides the 
problem really well.

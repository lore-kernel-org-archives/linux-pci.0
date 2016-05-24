Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI/ASPM: fix reverse ASPM L0s assignment of upstream and
 downstream
To: Bjorn Helgaas <helgaas@kernel.org>, Ocean HY1 He <hehy1@lenovo.com>
References: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
 <20160524115333.GA19140@localhost>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "wangyijing@huawei.com" <wangyijing@huawei.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "prarit@redhat.com" <prarit@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>,
 Nagananda Chumbalkar <nchumbalkar@lenovo.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <57446857.8000000@codeaurora.org>
Date: Tue, 24 May 2016 10:42:31 -0400
MIME-Version: 1.0
In-Reply-To: <20160524115333.GA19140@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 5/24/2016 7:53 AM, Bjorn Helgaas wrote:
> On Tue, May 24, 2016 at 06:29:44AM +0000, Ocean HY1 He wrote:
>> > In pcie_config_aspm_link(), when convert ASPM state to
>> > upstream/downstream ASPM register state, the upstream variable and
>> > dwsream variable are reversed. This causes PCI/E link enter ASPM L0s
>> > even it should be disabled and PCI/E endpoint may reset randomly.
> Random resets of an endpoint sounds like a pretty bad problem.  Do you
> have a bug report?  We've had lots of issues with ASPM; I wonder if
> this could account for some of them.
> 

I'm seeing this problem on Linux's ASPM code using powersave option where
each side of the link is having ASPM L0s enabled without coordination with
the other side. I'm wondering if you are hitting this too.

Legacy software (either operating system or firmware) that encounters 
the previously reserved value 00b (No ASPM Support), will most likely
refrain from enabling L1, which is intended behavior. 10 Legacy software
will also most likely refrain from enabling L0s for that component’s 
Transmitter (also intended behavior), but it is unclear if such software
will also refrain from enabling L0s for the component on the other side 
of the Link. 

If software enables L0s on one side when the component on 
the other side does not indicate that it supports L0s, the result is 
undefined. 

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

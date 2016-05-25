Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI/ASPM: fix reverse ASPM L0s assignment of upstream and
 downstream
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
 <20160525165726.GB3208@localhost> <5745DF08.9040409@codeaurora.org>
 <20160525175039.GC3208@localhost>
Cc: Ocean HY1 He <hehy1@lenovo.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "prarit@redhat.com" <prarit@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>,
 Nagananda Chumbalkar <nchumbalkar@lenovo.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5745EC95.1020506@codeaurora.org>
Date: Wed, 25 May 2016 14:19:01 -0400
MIME-Version: 1.0
In-Reply-To: <20160525175039.GC3208@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 5/25/2016 1:50 PM, Bjorn Helgaas wrote:
>> > You are saying that it is OK to enable L0s on just one side of the
>> > link as long as both sides support L0s. 
> I'm not sure what you mean by the link parameters not being
> compatible, but I think it is legal to enable L0s on only one
> direction.

I'm talking about L0s acceptable and entry latency times used to
determine when L0s can be enabled.

> 
>> > This part is a little bit misleading. I had HW people telling me
>> > that both sides need to enable L0s at about the same time.
> I don't remember seeing anything like that in the spec.  Do they have
> a pointer?  "At about the same time" is too hand-wavey to be useful to
> software.
> 

OK. Let me do some more push back. I wanted to understand the OS
behavior and its reasoning.

Your answers are sufficient.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

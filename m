Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI/ASPM: fix reverse ASPM L0s assignment of upstream and
 downstream
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
 <20160525165726.GB3208@localhost> <5745DF08.9040409@codeaurora.org>
 <20160525175039.GC3208@localhost> <5745EC95.1020506@codeaurora.org>
 <20160525183316.GD3208@localhost>
Cc: Ocean HY1 He <hehy1@lenovo.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "prarit@redhat.com" <prarit@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>,
 Nagananda Chumbalkar <nchumbalkar@lenovo.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <57460EAA.9040705@codeaurora.org>
Date: Wed, 25 May 2016 16:44:26 -0400
MIME-Version: 1.0
In-Reply-To: <20160525183316.GD3208@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 5/25/2016 2:33 PM, Bjorn Helgaas wrote:
> It looks like the code enforces this by clearing bits in
> link->aspm_capable (effectively pretending L0s or L1 are unsupported)
> if the latency is too high.

Yes, this is what I was referring to. I think what Linux does is
the right thing.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

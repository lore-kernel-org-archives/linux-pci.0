Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI/ASPM: fix reverse ASPM L0s assignment of upstream and
 downstream
To: Bjorn Helgaas <helgaas@kernel.org>, Ocean HY1 He <hehy1@lenovo.com>
References: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
 <20160525165726.GB3208@localhost>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "wangyijing@huawei.com" <wangyijing@huawei.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "prarit@redhat.com" <prarit@redhat.com>, "jcm@redhat.com" <jcm@redhat.com>,
 Nagananda Chumbalkar <nchumbalkar@lenovo.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5745DF08.9040409@codeaurora.org>
Date: Wed, 25 May 2016 13:21:12 -0400
MIME-Version: 1.0
In-Reply-To: <20160525165726.GB3208@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

OK. I see that we are dealing with two different questions.

> I thought you were talking about booting with
> "pcie_aspm.policy=powersave", where pcie_aspm_set_policy() sets
> aspm_policy = POLICY_POWERSAVE, then configures each link with
> ASPM_STATE_ALL.  But pcie_config_aspm_link() does AND the desired
> state (ASPM_STATE_ALL) with link->aspm_capable, which only has
> ASPM_STATE_L0S set if both the upstream and downstream components
> advertised PCIE_LINK_STATE_L0S.
> This path is very complicated, but I don't *think* it will enable L0s
> if the other end of the link doesn't support it.

Thanks for clarifying this. You are saying that if one side of the
link doesn't support L0s, Linux doesn't enable L0s on the other side.
This makes sense.

I think there is a confusion between what supported means vs. when
L0s can be enabled on which side of the link.

You clarified the supported case above that code will not enable
L0s if the other side doesn't support L0s.


> Now we enable the downstream component's transmitter to enter L0s.
> Per PCIe spec r3.0, sec 7.8.7, the receiver, i.e., the upstream
> component, must be capable of entering L0s even when its transmitter
> is disabled from entering L0s.

Let's assume that both sides actually support L0s but the link parameters
on one side is not compatible.

You are saying that it is OK to enable L0s on just one side of the
link as long as both sides support L0s. 

This part is a little bit misleading. I had HW people telling me
that both sides need to enable L0s at about the same time.

I'm actually seeing Linux enabling L0s on one side only as you
described and both supports L0s.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

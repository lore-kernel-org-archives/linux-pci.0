Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51345 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294AbcEYQgQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 May 2016 12:36:16 -0400
Date: Wed, 25 May 2016 11:36:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Ocean HY1 He <hehy1@lenovo.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"prarit@redhat.com" <prarit@redhat.com>,
	"jcm@redhat.com" <jcm@redhat.com>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>
Subject: Re: [PATCH] PCI/ASPM: fix reverse ASPM L0s assignment of upstream
 and downstream
Message-ID: <20160525163610.GA3208@localhost>
References: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
 <20160524115333.GA19140@localhost>
 <57446857.8000000@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <57446857.8000000@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 24, 2016 at 10:42:31AM -0400, Sinan Kaya wrote:
> On 5/24/2016 7:53 AM, Bjorn Helgaas wrote:
> > On Tue, May 24, 2016 at 06:29:44AM +0000, Ocean HY1 He wrote:
> >> > In pcie_config_aspm_link(), when convert ASPM state to
> >> > upstream/downstream ASPM register state, the upstream variable and
> >> > dwsream variable are reversed. This causes PCI/E link enter ASPM L0s
> >> > even it should be disabled and PCI/E endpoint may reset randomly.
> > Random resets of an endpoint sounds like a pretty bad problem.  Do you
> > have a bug report?  We've had lots of issues with ASPM; I wonder if
> > this could account for some of them.
> 
> I'm seeing this problem on Linux's ASPM code using powersave option where
> each side of the link is having ASPM L0s enabled without coordination with
> the other side. I'm wondering if you are hitting this too.

This would be really bad.  Can you fill in a few more details about
how this happens?

I thought you were talking about booting with
"pcie_aspm.policy=powersave", where pcie_aspm_set_policy() sets
aspm_policy = POLICY_POWERSAVE, then configures each link with
ASPM_STATE_ALL.  But pcie_config_aspm_link() does AND the desired
state (ASPM_STATE_ALL) with link->aspm_capable, which only has
ASPM_STATE_L0S set if both the upstream and downstream components
advertised PCIE_LINK_STATE_L0S.

This path is very complicated, but I don't *think* it will enable L0s
if the other end of the link doesn't support it.

> Legacy software (either operating system or firmware) that encounters 
> the previously reserved value 00b (No ASPM Support), will most likely
> refrain from enabling L1, which is intended behavior. 10 Legacy software
> will also most likely refrain from enabling L0s for that component’s 
> Transmitter (also intended behavior), but it is unclear if such software
> will also refrain from enabling L0s for the component on the other side 
> of the Link. 
> 
> If software enables L0s on one side when the component on 
> the other side does not indicate that it supports L0s, the result is 
> undefined. 

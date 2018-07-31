Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH V5 0/3] PCI: separate hotplug handling from fatal error
 handling
To: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <20180731184457.GN45322@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <4dd903ec-3e4c-d2fb-8216-95d60bba4e55@kernel.org>
Date: Tue, 31 Jul 2018 11:54:58 -0700
MIME-Version: 1.0
In-Reply-To: <20180731184457.GN45322@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 7/31/2018 11:44 AM, Bjorn Helgaas wrote:
> There's been a ton of discussion about this, and I didn't see a clear
> consensus emerge, so I'm going to drop it for now.  If it's still
> needed, please repost it and I'll watch for reviewers.

I apologize, let me summarize the conversation for you.
I proposed this [1]. Oza seems to be onboard [2].

Later, I posted v6 with this change last weekend.

[patch v6 1/1] pci: pciehp: ignore link events when there is a fatal 
error pending

Lukas and I discussed the patch last weekend under this v6 thread.
AFAIK, we agreed on the direction.

I'll post V7 with Lukas' comments and capture the detail from email
into the commit message.

Let us know what you think about it.

Sinan


[1] https://lkml.org/lkml/2018/7/21/13.
[2] https://lkml.org/lkml/2018/7/25/183

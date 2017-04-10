Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <466dcd2b-a781-2fe7-6ef0-5a3767c793e0@codeaurora.org>
 <CAKv+Gu9LbwpnJNi1OL25MWvYPxEOfKRHcs2jA2121BPaQWPzow@mail.gmail.com>
 <27f50de3-721e-e8ec-00c8-b7a9d3cff0d6@codeaurora.org>
 <CAKv+Gu-qRg8-YRCairppKrEfeLcW+OwVF8qZHp7vxXJA_AwPOw@mail.gmail.com>
 <20170330100524.GA22801@red-moon>
 <CAKv+Gu-ff98HrPK3f+E8soGJUXaaMxPLs2AuJ+rvXd0HWX-jXw@mail.gmail.com>
 <CAKv+Gu8YjySTDMgsrtGqEPMOtVhHc8gvTHZ4C5Ga8OTYdC9R3A@mail.gmail.com>
 <ae87ae28-f50d-095f-576e-f3fd7f96dea2@codeaurora.org>
 <CAKv+Gu8x0rQUnTUorknW-mW9LFgrxFYsXyy4LU_w9JbA-m_sjA@mail.gmail.com>
 <CAKv+Gu9Su0F9CSRe=sxomuDDH7c2szO6Z8dpqOQ=t_1Vn3JD3g@mail.gmail.com>
 <20170410165328.GA5248@red-moon>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a92d4d6a-0d94-350e-a0dd-55516fbc8ab7@codeaurora.org>
Date: Mon, 10 Apr 2017 13:06:40 -0400
MIME-Version: 1.0
In-Reply-To: <20170410165328.GA5248@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 Matt Fleming <matt@codeblueprint.co.uk>, linux-pci <linux-pci@vger.kernel.org>,
 Peter Jones <pjones@redhat.com>, Heyi Guo <heyi.guo@linaro.org>,
 Lukas Wunner <lukas@wunner.de>, Hanjun Guo <hanjun.guo@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 4/10/2017 12:53 PM, Lorenzo Pieralisi wrote:
> Do we want to enforce it on ARM ? I do not know to be honest (and it
> still would not solve the DT firmware case).
> 

Yes for ACPI on ARM. Probably no for DT. 

> Whatever we do, it is not going to be clean cut IMO. I think that
> what x86 does is sensible (well, minus the link ordering dependency we
> discovered), I can do it for ARM64 but get ready for regressions and
> I still think we have no real FW binding support that would make this
> behaviour robust.

Is it possible to move the code from arch/x86 into drivers/acpi directory
so that the code is shared across multiple ACPI based archs. We get more
coverage this way.

Can we fallback to the allocate everything behavior if we can't use the
stuff from FW or would it be too late to recover?

We can prevent regressions this way and issue a lot of warnings. We can
sit down and fix those warnings over time whether the issue is in 
UEFI BIOS or the code itself.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

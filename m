Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V4 3/3] Revert "ACPI, PCI, IRQ: separate ISA penalty
 calculation"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-4-git-send-email-okaya@codeaurora.org>
 <20161021023109.GD31044@localhost>
 <8dcd59ac-815b-da71-a3f2-ba533c4182c9@codeaurora.org>
 <20161022235918.GJ9007@localhost>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
 agross@codeaurora.org, Robert Moore <robert.moore@intel.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Lv Zheng <lv.zheng@intel.com>, linux-arm-msm@vger.kernel.org,
 wim@djo.tudelft.nl, devel@acpica.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <6908f8ba-c1d9-ab40-6ebb-3e6f239c3b66@codeaurora.org>
Date: Mon, 24 Oct 2016 00:16:16 -0400
MIME-Version: 1.0
In-Reply-To: <20161022235918.GJ9007@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/22/2016 7:59 PM, Bjorn Helgaas wrote:
> Since V4 3/3 is so much bigger and makes this quite subtle change in
> how _CRS is handled, I like V3 1/3 better.
> 

OK

> Are we all set to go now?  I think I've acked the patches you
> mentioned.

Yes, I'll post a follow up with your recommendations. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V3 2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize
 function"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-3-git-send-email-okaya@codeaurora.org>
 <20161018140543.GE18903@localhost>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
 Len Brown <len.brown@intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, agross@codeaurora.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Pavel Machek <pavel@ucw.cz>, linux-arm-msm@vger.kernel.org,
 wim@djo.tudelft.nl, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <84372578-eb80-249f-01ef-b16f4a18a0fb@codeaurora.org>
Date: Tue, 18 Oct 2016 08:05:05 -0700
MIME-Version: 1.0
In-Reply-To: <20161018140543.GE18903@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/18/2016 7:05 AM, Bjorn Helgaas wrote:
> I think you should squash patches 2 & 3 and not bother with trying to
> make this a revert followed by a fix.  Squashing them makes the git
> history much easier to follow, plus you don't have to deal with the
> headache of ensuring the intermediate state is correct and bisectable.

OK. I can do that.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

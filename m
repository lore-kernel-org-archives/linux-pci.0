Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Sep 2014 09:54:02 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: rdunlap@infradead.org, bp@alien8.de, tony.luck@intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heather Brown <hbrown@hp.com>
Subject: Re: [RESEND 0/5] PCIe, AER: Misc cleanup
Message-ID: <20140925155402.GB12200@google.com>
References: <1407910961-7798-1-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407910961-7798-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Heather]

On Wed, Aug 13, 2014 at 02:22:36AM -0400, Chen, Gong wrote:
> 
> No response since last commit so spread it to a bigger range.
> 
> This patch series is for AER related cleanup & update based on PCIe
> SPEC r3.0.

I applied patches 1, 2 (modified as described in my response to it), 3, and
4 to pci/aer for v3.19, thanks!

I didn't apply patch 5 because it apparently doesn't fix a reported bug,
and it has the potential to break hardware that used the PCIe r1.0
definition of the "Training Error" bit.

Bjorn

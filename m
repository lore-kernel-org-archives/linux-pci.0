Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 May 2016 13:33:16 -0500
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
Message-ID: <20160525183316.GD3208@localhost>
References: <1464071269-79954-1-git-send-email-hehy1@lenovo.com>
 <20160525165726.GB3208@localhost>
 <5745DF08.9040409@codeaurora.org>
 <20160525175039.GC3208@localhost>
 <5745EC95.1020506@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5745EC95.1020506@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 25, 2016 at 02:19:01PM -0400, Sinan Kaya wrote:
> On 5/25/2016 1:50 PM, Bjorn Helgaas wrote:
> >> > You are saying that it is OK to enable L0s on just one side of the
> >> > link as long as both sides support L0s. 
> > I'm not sure what you mean by the link parameters not being
> > compatible, but I think it is legal to enable L0s on only one
> > direction.
> 
> I'm talking about L0s acceptable and entry latency times used to
> determine when L0s can be enabled.

Oh, I see.  My understanding (again, I'm not a hardware person or a
PCIe spec expert) is that the latency numbers are an internal device
issue, not a PCIe link issue.

>From a PCIe point of view, I think we *could* enable L0s even if the
device's latency requirements wouldn't be met.  The PCIe link itself
should work fine, but the device may have internal issues like FIFO
overflows.

Of course, we want the device to work correctly, so we *shouldn't*
enable L0s if it would cause us to exceed the device's latency
tolerance.

It looks like the code enforces this by clearing bits in
link->aspm_capable (effectively pretending L0s or L1 are unsupported)
if the latency is too high.

Bjorn

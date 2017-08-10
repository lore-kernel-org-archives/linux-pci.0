Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 10 Aug 2017 16:59:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V9 1/2] PCI: handle CRS returned by device after FLR
Message-ID: <20170810215937.GR16580@bhelgaas-glaptop.roam.corp.google.com>
References: <1502240245-11714-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1502240245-11714-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 08, 2017 at 08:57:24PM -0400, Sinan Kaya wrote:
> Sporadic reset issues have been observed with Intel 750 NVMe drive by
> writing to the reset file in sysfs in a loop. The sequence of events
> observed is as follows:
> 
> - perform a Function Level Reset (FLR)
> - sleep up to 1000ms total
> - read ~0 from PCI_COMMAND
> - warn that the device didn't return from FLR
> - touch the device before it's ready
> 
> An endpoint is allowed to issue Configuration Request Retry Status (CRS)
> following a FLR request to indicate that it is not ready to accept new
> requests. CRS is defined in PCIe r3.1, sec 2.3.1. Request Handling Rules
> and CRS usage in FLR context is mentioned in PCIe r3.1a, sec 6.6.2.
> Function-Level Reset.

Don't we have a similar issue for other types of reset?  I would think
conventional reset, e.g., using secondary bus reset, hotplug slot
power, power management, etc., would have the same situation where a
device might return CRS status.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

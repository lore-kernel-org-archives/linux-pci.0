Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Feb 2017 15:55:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Mason <jon.mason@broadcom.com>
Subject: Re: [PATCH 0/2] PCI: iproc: MPS fix and quirks
Message-ID: <20170208215508.GA4800@bhelgaas-glaptop.roam.corp.google.com>
References: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 27, 2017 at 04:44:07PM -0500, Jon Mason wrote:
> A patch that corrects an issue where the MPS could not be set, and
> another that fixes some quirks in the PAXC
> 
> Jon Mason (2):
>   PCI: iproc: allow the MPS to be set
>   PCI: Add quirk entry for NS2 PAXC PCI
> 
>  drivers/pci/host/pcie-iproc.c |  5 ++++-
>  drivers/pci/quirks.c          | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)

Applied with Ray's ack to pci/host-iproc for v4.11, thanks!

It looks to me like several other drivers need a similar MPS fix.
I'll CC you on the patches.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

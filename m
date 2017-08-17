Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 17 Aug 2017 15:58:08 -0500
From: Rob Herring <robh@kernel.org>
To: Oza Pawandeep <oza.oza@broadcom.com>
Subject: Re: [PATCH v2 2/3] Documentation/devicetree: Add PCIe hotplug property
Message-ID: <20170817205808.arndlcvhw3ydjh4v@rob-hp-laptop>
References: <1502776547-30542-1-git-send-email-oza.oza@broadcom.com>
 <1502776547-30542-3-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1502776547-30542-3-git-send-email-oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Scott Branden <sbranden@broadcom.com>, Oza Pawandeep <oza.pawandeep@gmail.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Andy Gospodarek <gospo@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 15, 2017 at 11:25:46AM +0530, Oza Pawandeep wrote:
> Host drivers have the requirement of implementing PCI hotplug
> based on the how their SOC supports PCI hotplug.
> 
> Couple of properties have been added. the one to enable
> the hotplug feature itself, and the other caters to
> the PCI hotplug implementation with the use of gpios.
> 
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

Acked-by: Rob Herring <robh@kernel.org>

"dt-bindings: PCI: ..." preferred for the subject if you respin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

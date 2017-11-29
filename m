Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 29 Nov 2017 09:38:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V2 5/7] PCI: add a return type for
 pci_reset_bridge_secondary_bus()
Message-ID: <20171129173851.GF27742@infradead.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-6-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1511763628-11856-6-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 open list <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 27, 2017 at 01:20:26AM -0500, Sinan Kaya wrote:
> Getting ready to return an error from pci_reset_bridge_secondary_bus() when
> device is unreachable.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Looks ok, but I would just merge it into the next patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

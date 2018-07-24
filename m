Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] PCI: NVMe device specific reset quirk
To: Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org
References: <20180724000944.7671.64284.stgit@gimli.home>
 <20180724001310.7671.41243.stgit@gimli.home>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <abc86e6b-7df5-a84c-7e98-107c605812c6@kernel.org>
Date: Mon, 23 Jul 2018 17:40:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180724001310.7671.41243.stgit@gimli.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 7/23/2018 5:13 PM, Alex Williamson wrote:
> + * The NVMe specification requires that controllers support PCIe FLR, but
> + * but some Samsung SM961/PM961 controllers fail to recover after FLR (-1
> + * config space) unless the device is quiesced prior to FLR.

Does disabling the memory bit in PCI config space as part of the FLR 
reset function help? (like the very first thing)

Can we do that in the pcie_flr() function to cover other endpoint types
that might be pushing traffic while code is trying to do a reset?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

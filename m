Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20180420163109.46077.60334.stgit@ahduyck-green-test.jf.intel.com>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
 <20180420163109.46077.60334.stgit@ahduyck-green-test.jf.intel.com>
From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date: Thu, 19 Jul 2018 16:22:07 +0530
Message-ID: <CA+sq2CdDuimDCYK+9arO7-oRpNxdynX+rqYwpeBi9C_R+4pQNw@mail.gmail.com>
Subject: Re: [pci PATCH v8 4/4] pci-pf-stub: Add PF driver stub for PFs that
 function only to enable VFs
To: Alexander Duyck <alexander.h.duyck@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
 linux-pci <linux-pci@vger.kernel.org>, dan.daly@intel.com,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
 mheyne@amazon.de, liang-min.wang@intel.com,
 Linux Netdev List <netdev@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, mark.d.rustad@intel.com,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
 dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

> +static struct pci_driver pf_stub_driver = {
> +       .name                   = "pci-pf-stub",
> +       .id_table               = pci_pf_stub_white_list,
> +       .probe                  = pci_pf_stub_probe,
> +       .sriov_configure        = pci_sriov_configure_simple,
> +};
> +

Is there any specific reason for not disabling SRIOV upon driver unload/remove ?

i.e if a user sets numVFs to a non-zero value and unloads this driver
then we have a
situation where there is no PF driver in kernel but VFs still exist.

Thanks,
Sunil.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

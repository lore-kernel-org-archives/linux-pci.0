Return-Path: <SRS0=i4un=GY=gmail.com=jacob.keller@kernel.org>
Return-Path: <SRS0=i4un=GY=gmail.com=jacob.keller@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180402140501.GA244675@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244390359.135666.14890735614456271032.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <31e66048-e8b8-47ba-baf5-023560b4c124@mellanox.com> <20180402004049.GA131023@bhelgaas-glaptop.roam.corp.google.com>
 <50346f44-de3f-b226-69ad-6de45e94e261@mellanox.com> <20180402140501.GA244675@bhelgaas-glaptop.roam.corp.google.com>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Mon, 2 Apr 2018 17:30:54 -0700
Message-ID: <CA+P7+xr1N+X5DyPwNpWUtfqr9U4pLL9bMoB1wkBdf2K9n6cxKw@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to compute max
 supported link bandwidth
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tal Gilboa <talgi@mellanox.com>, Tariq Toukan <tariqt@mellanox.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Ariel Elior <ariel.elior@cavium.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 2, 2018 at 7:05 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> +/* PCIe speed to Mb/s reduced by encoding overhead */
> +#define PCIE_SPEED2MBS_ENC(speed) \
> +       ((speed) == PCIE_SPEED_16_0GT ? (16000*(128/130)) : \
> +        (speed) == PCIE_SPEED_8_0GT  ?  (8000*(128/130)) : \
> +        (speed) == PCIE_SPEED_5_0GT  ?  (5000*(8/10)) : \
> +        (speed) == PCIE_SPEED_2_5GT  ?  (2500*(8/10)) : \
> +        0)
> +

Should this be "(speed * x ) / y" instead? wouldn't they calculate
128/130 and truncate that to zero before multiplying by the speed? Or
are compilers smart enough to do this the other way to avoid the
losses?

Thanks,
Jake

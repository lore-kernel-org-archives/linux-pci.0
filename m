Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Apr 2014 14:09:22 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/MSI: Phase out pci_enable_msi_block()
Message-ID: <20140414120921.GA32132@dhcp-26-207.brq.redhat.com>
References: <cover.1397458024.git.agordeev@redhat.com>
 <0b08613dc17cd608c1babc1f42b8919f60e1093f.1397458024.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0b08613dc17cd608c1babc1f42b8919f60e1093f.1397458024.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 14, 2014 at 09:14:07AM +0200, Alexander Gordeev wrote:
> @@ -1244,7 +1241,7 @@ static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
>  static inline void pcie_ecrc_get_policy(char *str) { }
>  #endif
>  
> -#define pci_enable_msi(pdev)	pci_enable_msi_block(pdev, 1)
> +#define pci_enable_msi(pdev)	pci_enable_msi_range(pdev, 1, 1)

Self-Nack, it should have been pci_enable_msi_exact(pdev, 1) ^^^

>  #ifdef CONFIG_HT_IRQ
>  /* The functions a driver should call */

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com

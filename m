Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 Sep 2013 09:32:38 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jan Beulich <JBeulich@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/4] MSI/x86: Support pci_enable_msi_block_part()
 interface
Message-ID: <20130903133238.GA10522@htj.dyndns.org>
References: <cover.1378111919.git.agordeev@redhat.com>
 <9a0ae6ff3d116109d9f61230936a5c6a057637e0.1378111919.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9a0ae6ff3d116109d9f61230936a5c6a057637e0.1378111919.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 02, 2013 at 11:00:01AM +0200, Alexander Gordeev wrote:
> @@ -60,18 +60,18 @@ static int do_setup_msi_irqs(struct pci_dev *dev, int nvec)
>  	WARN_ON(msidesc->irq);
>  	WARN_ON(msidesc->msi_attrib.multiple);
>  	WARN_ON(msidesc->nvec_used);
> +	BUG_ON(nvec_mme != __roundup_pow_of_two(nvec_mme));

Wouldn't !is_power_of_2() be better?

Thanks.

-- 
tejun

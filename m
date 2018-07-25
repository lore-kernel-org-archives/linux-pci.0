Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH v1 0/4] PCI: Remove unnecessary includes of
 <linux/pci-aspm.h>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>,
 Johannes Berg <johannes.berg@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Luca Coelho <luciano.coelho@intel.com>, ath9k-devel@qca.qualcomm.com,
 linuxwifi@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <43748afd-712a-48e5-97a9-0b6046f575b3@kernel.org>
Date: Wed, 25 Jul 2018 13:33:23 -0700
MIME-Version: 1.0
In-Reply-To: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 7/25/2018 12:52 PM, Bjorn Helgaas wrote:
> emove includes of <linux/pci-aspm.h> from files that don't need
> it.  I'll apply all these via the PCI tree unless there's objection.
> 
> ---
> 
> Bjorn Helgaas (4):
>        igb: Remove unnecessary include of <linux/pci-aspm.h>
>        ath9k: Remove unnecessary include of <linux/pci-aspm.h>
>        iwlwifi: Remove unnecessary include of <linux/pci-aspm.h>
>        PCI: Remove unnecessary include of <linux/pci-aspm.h>

Thanks.

Reviewed-by: Sinan Kaya <okaya@kernel.org>

Is it possible to kill that file altogether? I haven't looked who is
using outside of pci directory.

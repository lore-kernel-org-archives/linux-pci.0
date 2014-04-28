Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20140427.193027.1833767089712636627.davem@davemloft.net>
References: <cover.1398412015.git.agordeev@redhat.com>
	<110dd7806f49f62272bd960ae8101c9da81a3f01.1398412015.git.agordeev@redhat.com>
	<20140427.193027.1833767089712636627.davem@davemloft.net>
Date: Mon, 28 Apr 2014 02:50:29 -0700
Message-ID: <CAL3LdT7tFhkvBOH0fEWCJd7qTp+8yD6v78+FOPXudH4Deby5hQ@mail.gmail.com>
Subject: Re: [E1000-devel] [PATCH net-next 1/2] i40evf: Use
 pci_enable_msix_range() instead of pci_enable_msix()
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: David Miller <davem@davemloft.net>
Cc: agordeev@redhat.com, linux.nics@intel.com,
	"e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>,
	netdev <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 27, 2014 at 4:30 PM, David Miller <davem@davemloft.net> wrote:
> From: Alexander Gordeev <agordeev@redhat.com>
> Date: Fri, 25 Apr 2014 10:06:24 +0200
>
>> As result of deprecation of MSI-X/MSI enablement functions
>> pci_enable_msix() and pci_enable_msi_block() all drivers
>> using these two interfaces need to be updated to use the
>> new pci_enable_msi_range()  or pci_enable_msi_exact()
>> and pci_enable_msix_range() or pci_enable_msix_exact()
>> interfaces.
>>
>> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
>
> Jeff, I assume you will take this in via your tree.
>

Yes, I have picked this up.

-- 
Cheers,
Jeff

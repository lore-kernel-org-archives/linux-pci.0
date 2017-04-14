Return-Path: <SRS0=Wmv6=3W=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=Wmv6=3W=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170414144108.GB29349@bhelgaas-glaptop.roam.corp.google.com>
References: <20170413145339.20186-1-hch@lst.de> <20170414144108.GB29349@bhelgaas-glaptop.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 14 Apr 2017 09:51:48 -0500
Message-ID: <CAErSpo4HBhG5cLZMMt4NtswjQ1yNvW9x39DsxFWtBPOVwG7JpA@mail.gmail.com>
Subject: Re: export pcie_flr and remove copies of it in drivers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Salvatore Benedetto <salvatore.benedetto@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Derek Chickles <derek.chickles@caviumnetworks.com>,
	Satanand Burla <satananda.burla@caviumnetworks.com>,
	Felix Manlunas <felix.manlunas@caviumnetworks.com>,
	Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 14, 2017 at 9:41 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Apr 13, 2017 at 04:53:32PM +0200, Christoph Hellwig wrote:
>> Hi all,
>>
>> this exports the PCI layer pcie_flr helper, and removes various opencoded
>> copies of it.
>
> Looks good to me (except the comment on probe).  If you want to apply
> the whole series via netdev or some non-PCI tree, here's my ack for
> the drivers/pci parts, assuming the probe thing is resolved:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Otherwise, I'd be glad to take the series given acks for the non-PCI
> parts.  Just let me know.

I do already have a patch (c5e4f0192ad2 ("PCI: Avoid FLR for Intel
82579 NICs")) on my pci/virtualization branch that touches pcie_flr()
and will conflict with this one.

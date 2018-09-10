Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
To: =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>,
 Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, jgross@suse.com,
 Sinan Kaya <okaya@codeaurora.org>, Govinda Tatti <Govinda.Tatti@Oracle.COM>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Satanand Burla <satananda.burla@caviumnetworks.com>,
 linux-pci@vger.kernel.org, Felix Manlunas
 <felix.manlunas@caviumnetworks.com>, linux-kernel@vger.kernel.org,
 Derek Chickles <derek.chickles@caviumnetworks.com>,
 Srikanth Jampala <Jampala.Srikanth@cavium.com>, JBeulich@suse.com,
 Russell Currey <ruscur@russell.cc>, bhelgaas@google.com,
 xen-devel@lists.xenproject.org, boris.ostrovsky@Oracle.COM,
 Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>, roger.pau@citrix.com
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
 <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
 <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
 <fea075cf-fe6f-0d0b-11e4-4279fbfc280a@Oracle.COM>
 <20171215181801.GU30595@bhelgaas-glaptop.roam.corp.google.com>
 <20171218122629.GA18423@infradead.org> <20180909185944.GC18222@reaktio.net>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <9ffe43d2-a44b-974c-85c9-9923d71c5dba@kernel.org>
Date: Sun, 9 Sep 2018 22:33:02 -0400
MIME-Version: 1.0
In-Reply-To: <20180909185944.GC18222@reaktio.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 9/9/2018 2:59 PM, Pasi Kärkkäinen wrote:
> I noticed pcie_has_flr() has been recently exported in upstream Linux:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d2917f7747805a1f4188672f308d82a8ba01700
> 
> Are there more changes / cleanups planned to these interfaces, as mentioned last year?
> 
> (context: xen-pciback reset/do_flr features upstreaming, which kind of stalled last year when pcie_has_flr() wasn't exported at the time)

Exporting pcie_has_flr() is a very simple change which could have been done
by the XEN porting effort.

Maybe, the right question is what is so special about XEN reset?

What feature PCI core is missing to support XEN FLR reset that caused
the effort to stall?
